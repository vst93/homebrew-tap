class Lazyrdm < Formula
  desc "Redis management tool designed for the terminal"
  homepage "https://github.com/vst93/lazyrdm"
  version "1.2.1"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+(\.\d+)?)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/lazyrdm-darwin-arm64.zip"
      sha256 "f422a0561859fa20d1a13f2a04aa97a5ab02f350ab26e265732e5e2bd81483e2"
    else
      url homepage + "/releases/download/#{version}/lazyrdm-darwin-amd64.zip"
      sha256 "db30445c42d53779c297cc07ca87318bc13e8f96d2f9414a354039cc075790a5"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/lazyrdm-linux-arm64.zip"
      sha256 "e3df3ebf75b5c89e0bb76255f2bc974b69281c4eacf09de7a88da6e48a435b28"
    else
      url homepage + "/releases/download/#{version}/lazyrdm-linux-amd64.zip"
      sha256 "a944f70ef98d6a9f576ad6e7a958e17965169fc230eb862cbb9a24c42de1e2b8"
    end
  end

  if url == ""
    onoe "No release found for your platform"
    exit 1
  end

  def install
    bin.install "lazyrdm"
  end

  test do
    system "false"
  end
end
