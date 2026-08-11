#!/usr/bin/env ruby
# frozen_string_literal: true

# Update Homebrew cask with latest version and SHA256 checksums
# Usage: ruby scripts/update-cask.rb <cask_name>
#
# Supports two asset naming patterns:
# - Tauri: AppName-VERSION-macos-ARCH.dmg
# - Legacy Wails: AppName-darwin-ARCH.zip
# The pattern is auto-detected from the cask file's URL line.

require "json"
require "net/http"
require "open3"
require "rubygems"

REPO_PREFIX = "vst93"

def github_token
  ENV["GITHUB_TOKEN"] || ENV["GH_TOKEN"]
end

def normalize_tag(tag)
  tag.start_with?("v") ? tag[1..] : tag
end

def run_cmd(cmd)
  stdout, stderr, status = Open3.capture3(cmd)
  raise "Command failed: #{cmd}\n#{stderr}" unless status.success?
  stdout.strip
end

def fetch_latest_version(repo)
  # Try gh CLI first (handles auth/rate limiting better in CI)
  stdout, _stderr, status = Open3.capture3("gh release view --repo #{repo} --json tagName -q '.tagName' 2>/dev/null")
  if status.success? && !stdout.strip.empty?
    raw_tag = stdout.strip
    return { version: normalize_tag(raw_tag), tag: raw_tag }
  end

  # Fallback to API with token if available
  uri = URI("https://api.github.com/repos/#{repo}/releases/latest")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.open_timeout = 10
  http.read_timeout = 10

  # Add authorization header if GITHUB_TOKEN is available
  headers = {}
  if github_token
    headers["Authorization"] = "token #{github_token}"
  end

  response = http.get(uri.request_uri, headers)
  case response.code
  when "200"
    raw_tag = JSON.parse(response.body)["tag_name"]
    return { version: normalize_tag(raw_tag), tag: raw_tag } if raw_tag
  when "403"
    warn "GitHub API rate limited for #{repo}, skipping..."
    return nil
  when "404"
    warn "Repository not found: #{repo}, skipping..."
    return nil
  else
    warn "GitHub API returned HTTP #{response.code} for #{repo}, skipping..."
    return nil
  end

  nil
end

def fetch_current_version(cask_path)
  content = File.read(cask_path)
  match = content.match(/version "(\d+\.\d+(\.\d+)?)"/)
  raise "Could not parse current version from #{cask_path}" unless match
  match[1]
end

def version_gt?(v1, v2)
  Gem::Version.new(v1) > Gem::Version.new(v2)
end

def fetch_sha256(url)
  puts "  Downloading: #{url}"
  stdout, _stderr, status = Open3.capture3("curl -fsSL -o /dev/null \"#{url}\" && curl -fsSL \"#{url}\" | shasum -a 256 | cut -d' ' -f1")
  raise "Download failed: #{url}" unless status.success?
  sha = stdout.strip
  raise "Empty SHA256 for: #{url}" if sha.empty?
  sha
end

# Detect asset naming pattern from the cask file's URL line.
# Returns :tauri (dmg with version) or :legacy (zip without version).
def detect_asset_pattern(cask_path)
  content = File.read(cask_path)
  # Tauri pattern: bili-FM-#{version}-macos-#{arch}.dmg
  if content.match?(/#{Regex.escape("macos")}.*\.dmg/)
    :tauri
  # Legacy Wails pattern: AppName-darwin-#{arch}.zip
  elsif content.match?(/#{Regex.escape("darwin")}.*\.zip/)
    :legacy
  else
    # Default to tauri for new casks
    :tauri
  end
end

# Build the download URL for a given architecture.
# Tauri:   https://github.com/REPO/releases/download/TAG/AppName-TAG-macos-ARCH.dmg
# Legacy:  https://github.com/REPO/releases/download/TAG/AppName-darwin-ARCH.zip
def build_asset_url(repo, tag, app_name, arch, pattern)
  case pattern
  when :tauri
    "https://github.com/#{repo}/releases/download/#{tag}/#{app_name}-#{tag}-macos-#{arch}.dmg"
  when :legacy
    "https://github.com/#{repo}/releases/download/#{tag}/#{app_name}-darwin-#{arch}.zip"
  end
end

def update_cask(cask_name)
  repo = "#{REPO_PREFIX}/#{cask_name}"
  cask_path = "Casks/#{cask_name}.rb"

  # Fetch latest version
  result = fetch_latest_version(repo)

  # Skip if could not fetch version (rate limit, not found, etc.)
  if result.nil?
    puts "\n⚠ Cask #{cask_name}: Could not fetch latest version, skipping"
    return
  end

  latest_version = result[:version]
  tag = result[:tag]

  current_version = fetch_current_version(cask_path)

  puts "Current version: #{current_version}"
  puts "Latest version:  #{latest_version}"

  # Skip if already up to date or newer
  unless version_gt?(latest_version, current_version)
    puts "\n✓ Cask #{cask_name} is up to date (current: #{current_version}, latest: #{latest_version})"
    return
  end

  puts "\n-> New version detected: #{current_version} -> #{latest_version}"

  # Detect asset naming pattern
  pattern = detect_asset_pattern(cask_path)
  puts "  Asset pattern: #{pattern}"

  # Determine app name from repo (e.g., "bili-fm" -> "bili-FM")
  # Read the app name from the cask file's url or app line
  cask_content = File.read(cask_path)
  app_name_match = cask_content.match(%r{releases/download/[^/]+/([A-Za-z]+-?[A-Za-z]*)-})
  app_name = app_name_match ? app_name_match[1] : cask_name.capitalize

  # Map arch keys: cask uses arm/intel, assets use apple-silicon/intel (Tauri) or arm64/amd64 (legacy)
  case pattern
  when :tauri
    archs = { arm: "apple-silicon", intel: "intel" }
  when :legacy
    archs = { arm: "arm64", intel: "amd64" }
  end

  sha256s = {}
  archs.each do |key, arch_suffix|
    url = build_asset_url(repo, tag, app_name, arch_suffix, pattern)
    sha256s[key] = fetch_sha256(url)
    puts "  #{key} (#{arch_suffix}): #{sha256s[key]}"
  end

  # Read current cask
  content = File.read(cask_path)

  # Update version
  content.sub!(/version "(\d+\.\d+(\.\d+)?)"/, %(version "#{latest_version}"))

  # Update SHA256s - match the exact pattern and preserve formatting
  content.gsub!(/sha256 arm:\s+"[a-f0-9]+",\s+intel:\s+"[a-f0-9]+"/) do |_match|
    %(sha256 arm:   "#{sha256s[:arm]}",
         intel: "#{sha256s[:intel]}")
  end

  # Update URL - handle both Tauri and legacy patterns
  case pattern
  when :tauri
    # Tauri: AppName-TAG-macos-ARCH.dmg (tag may differ from version if v-prefixed)
    content.gsub!(%r{releases/download/v?\d+\.\d+(\.\d+)?/}) do |_match|
      "releases/download/#{tag}/"
    end
  when :legacy
    # Legacy: AppName-darwin-ARCH.zip
    content.gsub!(%r{releases/download/v?\d+\.\d+(\.\d+)?/}) do |_match|
      "releases/download/#{tag}/"
    end
  end

  File.write(cask_path, content)
  puts "\n✓ Updated #{cask_path} to version #{latest_version}"

  # Verify with brew audit (skip known RuboCop bugs)
  puts "\nRunning brew audit..."
  system("brew audit --cask --except FormulaAudit/Urls,FormulaAudit/PyPiUrls #{cask_name}") || true
end

if ARGV.empty?
  puts "Usage: ruby scripts/update-cask.rb <cask_name> [cask_name2] ..."
  puts "Example: ruby scripts/update-cask.rb bili-fm"
  exit 1
end

# Process each cask argument
ARGV.each do |cask_name|
  update_cask(cask_name)
end

puts "\n=== ALL CASKS PROCESSED ==="
