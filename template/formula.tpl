class [tpl_class_name] < Formula
  desc "[tpl_desc]"
  homepage "[tpl_homepage]"
  version "[tpl_version]"
  url ""
  sha256 ""
  name "[tpl_name]"

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/#{name}-darwin-arm64.zip"
      sha256 "[tpl_sha256_darwin_arm64]"
    else
      url homepage + "/releases/download/#{version}/#{name}-darwin-amd64.zip"
      sha256 "[tpl_sha256_darwin_amd64]"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/#{name}-linux-arm64.zip"
      sha256 "[tpl_sha256_linux_arm64]"
    else
      url homepage + "/releases/download/#{version}/#{name}-linux-amd64.zip"
      sha256 "[tpl_sha256_linux_amd64]"
    end
  end

  if url == ""
    onoe "No release found for your platform"
    exit 1
  end

  def install
    bin.install "#{name}"
  end

  test do
    system "false"
  end
end
