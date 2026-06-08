class Ttm < Formula
  desc "Tiny Terminal Manager"
  homepage "https://github.com/vst93/ttm"
  version "0.3.8"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+(\.\d+)?)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-darwin-arm64.zip"
      sha256 "2826d5e8984faf4193c9f75ca8a1574e63420a4c7fac986667b25bff294a97d2"
    else
      url homepage + "/releases/download/#{version}/ttm-darwin-amd64.zip"
      sha256 "99f0d58689dfb9ae18b535ab8647b19c0b23a64f238fa83bae82aead8e259691"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-linux-arm64.zip"
      sha256 "a93ad38d982d419a0cd69443b9f153f58085a92435f7250b2711cf9173da2940"
    else
      url homepage + "/releases/download/#{version}/ttm-linux-amd64.zip"
      sha256 "800644fc75cb5c83339696e8507994b45183922cf25e0025430c04a54fb67d2b"
    end
  end

  if url == ""
    onoe "No release found for your platform"
    exit 1
  end

  def install
    bin.install "ttm"
  end

  test do
    system "false"
  end
end
