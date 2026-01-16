#!/usr/bin/env ruby
# frozen_string_literal: true

# Update Homebrew cask with latest version and SHA256 checksums
# Usage: ruby scripts/update-cask.rb <cask_name>

require "json"
require "net/http"
require "open3"
require "rubygems"

REPO_PREFIX = "vst93"

def fetch_latest_version(repo)
  uri = URI("https://api.github.com/repos/#{repo}/releases/latest")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  response = http.get(uri.request_uri)
  tag = JSON.parse(response.body)["tag_name"]
  tag || raise("No release found for #{repo}")
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

def update_cask(cask_name)
  repo = "#{REPO_PREFIX}/#{cask_name}"
  cask_path = "Casks/#{cask_name}.rb"

  # Fetch versions
  latest_version = fetch_latest_version(repo)
  current_version = fetch_current_version(cask_path)

  puts "Current version: #{current_version}"
  puts "Latest version:  #{latest_version}"

  # Skip if already up to date or newer
  unless version_gt?(latest_version, current_version)
    puts "\n✓ Cask #{cask_name} is up to date (current: #{current_version}, latest: #{latest_version})"
    return
  end

  puts "\n→ New version detected: #{current_version} → #{latest_version}"

  # Fetch SHA256 for both architectures
  arm_url = "https://github.com/#{repo}/releases/download/#{latest_version}/#{cask_name}-darwin-arm64.zip"
  intel_url = "https://github.com/#{repo}/releases/download/#{latest_version}/#{cask_name}-darwin-amd64.zip"

  sha256_arm = fetch_sha256(arm_url)
  sha256_intel = fetch_sha256(intel_url)
  puts "  arm64:   #{sha256_arm}"
  puts "  amd64:   #{sha256_intel}"

  # Read current cask
  content = File.read(cask_path)

  # Update version
  content.sub!(/version "(\d+\.\d+(\.\d+)?)"/, %(version "#{latest_version}"))

  # Update SHA256s - match the exact pattern and preserve formatting
  content.gsub!(/sha256 arm:\s+"[a-f0-9]+",\s+intel:\s+"[a-f0-9]+"/) do |_match|
    %(sha256 arm:   "#{sha256_arm}",
         intel: "#{sha256_intel}")
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
