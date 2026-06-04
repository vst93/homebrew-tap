class Ttm < Formula
  desc "Tiny Terminal Manager"
  homepage "https://github.com/vst93/ttm"
  version "0.3.7"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+(\.\d+)?)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-darwin-arm64.zip"
      sha256 "99d49e3e2193549fc81d6b4134ebde217cc86a7432449c56d78eaf2a3de64d19"
    else
      url homepage + "/releases/download/#{version}/ttm-darwin-amd64.zip"
      sha256 "c2e0bd91fa7836c1c2a7a3e7c355e8037c8b4e08572d98556c9fc4d2ef25ac5f"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-linux-arm64.zip"
      sha256 "27bece78c6478c00a00934a6df326e26965579f5d158d020d811342fecc2373f"
    else
      url homepage + "/releases/download/#{version}/ttm-linux-amd64.zip"
      sha256 "4bbe62074b389c6001d61bbddc64dd63f2cfe84f2cd43a0061fc5bf8766af060"
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
