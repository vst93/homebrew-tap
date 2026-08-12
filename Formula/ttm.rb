class Ttm < Formula
  desc "Tiny Terminal Manager"
  homepage "https://github.com/vst93/ttm"
  version "0.3.16"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+(\.\d+)?)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-darwin-arm64.zip"
      sha256 "fba0d09e91b9904d12db1fe03d4194f3c2a7993dec10ab20a5354c62ff7aeb83"
    else
      url homepage + "/releases/download/#{version}/ttm-darwin-amd64.zip"
      sha256 "bcf4e697a90934a5ff10a5b8e08bd5285b4e6248175794eafc8423aff9888559"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-linux-arm64.zip"
      sha256 "bb04b75e3a4abfe96b2fbe9d36a4de3b4766a009de8318cdfa15ebd57cfde04e"
    else
      url homepage + "/releases/download/#{version}/ttm-linux-amd64.zip"
      sha256 "46379b47986bff5c09e0c49fc580aa609d0ca021df7772f29f121c51ff59a5ff"
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
