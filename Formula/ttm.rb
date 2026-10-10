class Ttm < Formula
  desc "Tiny Terminal Manager"
  homepage "https://github.com/vst93/ttm"
  version "0.3.19"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+(\.\d+)?)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-darwin-arm64.zip"
      sha256 "5e1d9122f1ea6c891448a2739983bec820c884569c21bb36d81ad81c62d916b8"
    else
      url homepage + "/releases/download/#{version}/ttm-darwin-amd64.zip"
      sha256 "7a81995e5b5644bff7e1a12473827c7261515cab3868866d7816fc0e17dd8e70"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-linux-arm64.zip"
      sha256 "b06b2decc5722f60be3fe34b227714b549dd1b5887d7274a21ea099d13a3dbf3"
    else
      url homepage + "/releases/download/#{version}/ttm-linux-amd64.zip"
      sha256 "51ac21b14dfde1b4007281bc586b6cc252d665c7bb6408253dc21a2ebc7fa976"
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
