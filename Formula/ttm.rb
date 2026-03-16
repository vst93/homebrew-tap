class Ttm < Formula
  desc "Tiny Terminal Manager"
  homepage "https://github.com/vst93/ttm"
  version "0.3.2"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+(\.\d+)?)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-darwin-arm64.zip"
      sha256 "54aa4be15198f849c8f5f63aceaee3c398a855161e796ab514ebccece051ffd4"
    else
      url homepage + "/releases/download/#{version}/ttm-darwin-amd64.zip"
      sha256 "fad47b75a4266afc9c2d9a2592775d0a1d5e1f4cba207dac27fdf942395a61b7"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-linux-arm64.zip"
      sha256 "8da8ed1b57bfbed0588dfc32a5d81c189af00c51de2fb9add5653758ec9696e3"
    else
      url homepage + "/releases/download/#{version}/ttm-linux-amd64.zip"
      sha256 "b32c2f52e580ff27aabd07171781d2f7498266e6a139c4b21b36f121ebac46b6"
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
