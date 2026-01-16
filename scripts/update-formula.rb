#!/usr/bin/env ruby
# frozen_string_literal: true

# Update Homebrew formula with latest version and SHA256 checksums
# Usage: ruby scripts/update-formula.rb <formula_name>

require "json"
require "net/http"
require "open3"
require "rubygems"

REPO_PREFIX = "vst93"

def run_cmd(cmd)
  stdout, stderr, status = Open3.capture3(cmd)
  raise "Command failed: #{cmd}\n#{stderr}" unless status.success?
  stdout.strip
end

def fetch_latest_version(repo)
  # Try gh CLI first (handles auth/rate limiting better)
  stdout, stderr, status = Open3.capture3("gh release view --repo #{repo} --json tagName -q '.tagName' 2>/dev/null")
  if status.success? && !stdout.strip.empty?
    return stdout.strip
  end

  # Fallback to API
  uri = URI("https://api.github.com/repos/#{repo}/releases/latest")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.open_timeout = 10
  http.read_timeout = 10

  response = http.get(uri.request_uri)
  case response.code
  when "200"
    tag = JSON.parse(response.body)["tag_name"]
    return tag if tag
  when "403", "404"
    raise "GitHub API error (rate limit or repo not found): #{repo}"
  else
    raise "GitHub API returned HTTP #{response.code} for #{repo}"
  end

  raise "No release found for #{repo}"
end

def fetch_current_version(formula_path)
  content = File.read(formula_path)
  match = content.match(/version "v?(\d+\.\d+(\.\d+)?)"/)
  raise "Could not parse current version from #{formula_path}" unless match
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

def update_formula(formula_name)
  repo = "#{REPO_PREFIX}/#{formula_name}"
  formula_path = "Formula/#{formula_name}.rb"

  # Fetch versions
  latest_version = fetch_latest_version(repo)
  current_version = fetch_current_version(formula_path)

  puts "Current version: #{current_version}"
  puts "Latest version:  #{latest_version}"

  # Skip if already up to date or newer
  unless version_gt?(latest_version, current_version)
    puts "\n✓ Formula #{formula_name} is up to date (current: #{current_version}, latest: #{latest_version})"
    return
  end

  puts "\n→ New version detected: #{current_version} → #{latest_version}"

  platforms = ["darwin-arm64", "darwin-amd64", "linux-arm64", "linux-amd64"]
  sha256s = {}

  platforms.each do |platform|
    url = "https://github.com/#{repo}/releases/download/#{latest_version}/#{formula_name}-#{platform}.zip"
    sha256s[platform] = fetch_sha256(url)
    puts "  #{platform}: #{sha256s[platform]}"
  end

  # Read current formula
  content = File.read(formula_path)

  # Update version (handles both x.y.z and vx.y.z formats)
  content.sub!(/version "v?\d+\.\d+(\.\d+)?"/, %(version "#{latest_version}"))

  # Update SHA256s - generic pattern for all sha256 assignments
  sha256_values = sha256s.values.to_a
  count = 0
  content.gsub!(/sha256 "[a-f0-9]{64}"/) do |match|
    break match if count >= sha256_values.length
    result = %(sha256 "#{sha256_values[count]}")
    count += 1
    result
  end

  File.write(formula_path, content)
  puts "\n✓ Updated #{formula_path} to version #{latest_version}"

  # Verify with brew audit (skip known RuboCop bugs with multi-platform formulas)
  puts "\nRunning brew audit..."
  system("brew audit --formula --except FormulaAudit/Urls,FormulaAudit/PyPiUrls #{formula_name}") || true
end

if ARGV.empty?
  puts "Usage: ruby scripts/update-formula.rb <formula_name> [formula_name2] ..."
  puts "Example: ruby scripts/update-formula.rb v"
  puts "Example: ruby scripts/update-formula.rb v ttm lazyrdm"
  exit 1
end

# Process each formula argument
ARGV.each do |formula_name|
  update_formula(formula_name)
end

puts "\n=== ALL FORMULAS PROCESSED ==="
