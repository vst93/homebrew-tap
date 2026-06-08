class Ttm < Formula
  desc "Tiny Terminal Manager"
  homepage "https://github.com/vst93/ttm"
  version "0.3.10"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+(\.\d+)?)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-darwin-arm64.zip"
      sha256 "83a7c1735746ba0c486619a0f65374ff09bc1f78faad3bae6224cca003ff10ef"
    else
      url homepage + "/releases/download/#{version}/ttm-darwin-amd64.zip"
      sha256 "63279b31d962f8298f61d909ea6ffa278d18776ba54a114812498366a27779ca"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-linux-arm64.zip"
      sha256 "574c415c83c4db035f4ed9302de374f931f5c9998da45ece940d1fffb23c3f84"
    else
      url homepage + "/releases/download/#{version}/ttm-linux-amd64.zip"
      sha256 "20ea23b21efe07106b7b1e72600065695b625a703d0caa7c5bf3f6732d023121"
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
