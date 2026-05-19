class Ttm < Formula
  desc "Tiny Terminal Manager"
  homepage "https://github.com/vst93/ttm"
  version "0.3.5"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+(\.\d+)?)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-darwin-arm64.zip"
      sha256 "ddd0fbacd24fa6ef02c59801fcc18e0e3484bc3fa79cd36be0c445c15ad0e4d4"
    else
      url homepage + "/releases/download/#{version}/ttm-darwin-amd64.zip"
      sha256 "729e3c926947c9c13b4195174d24d257306458fec421366c8736e03f8aaa5fa1"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-linux-arm64.zip"
      sha256 "330af9759af874d0fccb0f6115a9a0dd29cbf52f6083fded4e45dcad41916fe2"
    else
      url homepage + "/releases/download/#{version}/ttm-linux-amd64.zip"
      sha256 "3c1d9e675a70c6d7d48e6ffcf4fde57f5ea314a16c1c4218b195d7870fe87a7a"
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
