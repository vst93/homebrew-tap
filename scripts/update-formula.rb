#!/usr/bin/env ruby
# frozen_string_literal: true

# Update Homebrew formula with latest version and SHA256 checksums
# Usage: ruby scripts/update-formula.rb <formula_name>

require "json"
require "net/http"
require "open3"

REPO_PREFIX = "vst93"

def run_cmd(cmd)
  stdout, stderr, status = Open3.capture3(cmd)
  raise "Command failed: #{cmd}\n#{stderr}" unless status.success?
  stdout.strip
end

def fetch_latest_version(repo)
  uri = URI("https://api.github.com/repos/#{repo}/releases/latest")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  response = http.get(uri.request_uri)
  tag = JSON.parse(response.body)["tag_name"]
  # Return tag as-is (some repos use v prefix, some don't)
  tag || raise("No release found for #{repo}")
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

  puts "Fetching latest version for #{repo}..."
  version = fetch_latest_version(repo)
  puts "  Latest version: #{version}"

  platforms = ["darwin-arm64", "darwin-amd64", "linux-arm64", "linux-amd64"]
  sha256s = {}

  platforms.each do |platform|
    url = "https://github.com/#{repo}/releases/download/#{version}/#{formula_name}-#{platform}.zip"
    sha256s[platform] = fetch_sha256(url)
    puts "  #{platform}: #{sha256s[platform]}"
  end

  # Read current formula
  content = File.read(formula_path)

  # Update version
  content.sub!(/version "\d+\.\d+\.\d+"/, %(version "#{version}"))

  # Update SHA256s for each platform
  if content.include?("darwin-arm64")
    content.sub!(/sha256 "c0a1d614df93d900fdcf5b47c3f987fc3d4c60c52e2d91ff49b73a9d9a296b19"/,
                 %(sha256 "#{sha256s["darwin-arm64"]}"))
    content.sub!(/sha256 "106b763f069b408074a312402d4d62f8ef19210dc8b1348ee0bbde7cdaa1ff37"/,
                 %(sha256 "#{sha256s["darwin-amd64"]}"))
    content.sub!(/sha256 "de0971e8a8da9d31c85b43cf776f85df20b19257b6b14ca6c11de01b91b1d8cb"/,
                 %(sha256 "#{sha256s["linux-arm64"]}"))
    content.sub!(/sha256 "2f8340287407ce90e53b2da5372f481daf38b5c22044e4402534dafdeee602a2"/,
                 %(sha256 "#{sha256s["linux-amd64"]}"))
  else
    # Generic pattern - update first 4 sha256 assignments
    sha256_values = sha256s.values
    count = 0
    content.gsub!(/sha256 "[a-f0-9]{64}"/) do |match|
      break match if count >= sha256_values.length
      result = %(sha256 "#{sha256_values[count]}")
      count += 1
      result
    end
  end

  File.write(formula_path, content)
  puts "\nUpdated #{formula_path} to version #{version}"

  # Verify with brew audit
  puts "\nRunning brew audit..."
  system("brew audit --formula #{formula_name}")
end

if ARGV.empty?
  puts "Usage: ruby scripts/update-formula.rb <formula_name>"
  puts "Example: ruby scripts/update-formula.rb v"
  exit 1
end

update_formula(ARGV[0])
