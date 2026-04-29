class Ttm < Formula
  desc "Tiny Terminal Manager"
  homepage "https://github.com/vst93/ttm"
  version "0.3.4"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+(\.\d+)?)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-darwin-arm64.zip"
      sha256 "5676f88da3e35cd97939d7df78ef20fbc12256a9ad11a3166ede058c3209309e"
    else
      url homepage + "/releases/download/#{version}/ttm-darwin-amd64.zip"
      sha256 "309853b8f0260d72c9cfe45b6d6dba1824789e34c3065971a718b4ff914f4864"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-linux-arm64.zip"
      sha256 "73209e383717a7988a1c1778ce756dfc9d0077380f7d4e5501884a2d7fd08764"
    else
      url homepage + "/releases/download/#{version}/ttm-linux-amd64.zip"
      sha256 "19ed3c5fd766220ae50541378825c4de6b0fa13eed5eccd89244d55ecf53c4b3"
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
