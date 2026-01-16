class Ttm < Formula
  desc "TUI Terminal Manager"
  homepage "https://github.com/vst93/ttm"
  version "0.2.0"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+(\.\d+)?)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-darwin-arm64.zip"
      sha256 "1a62619e7629ab4f29f60a1ca8fa76f736e08a07b1fab0e83d86ea1dd0d488ff"
    else
      url homepage + "/releases/download/#{version}/ttm-darwin-amd64.zip"
      sha256 "81074addfc85f1dc2d51ba52577ab64fbc5311e63a49123db053d27649920069"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-linux-arm64.zip"
      sha256 "7f6669d76820243c3253fe9aeaab3ad1981aa7232ee24580c5b07848656e5c76"
    else
      url homepage + "/releases/download/#{version}/ttm-linux-amd64.zip"
      sha256 "b3f1d20b3ad786b2e37f1d7239d6fc45cf247234c4d19d2b650018bfd6a8da90"
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
