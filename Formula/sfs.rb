class Sfs < Formula
  desc "SmallFileSync - A WebDAV-based terminal file sync tool"
  homepage "https://github.com/vst93/sfs"
  version "0.1.6"

  livecheck do
    url :stable
    regex(/(\d+\.\d+(\.\d+)?)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/sfs-darwin-arm64.zip"
      sha256 "113f4bef8c80add4c0df00de3284b0332c4a16e5b5f7f013819515511470f12b"
    else
      url homepage + "/releases/download/#{version}/sfs-darwin-amd64.zip"
      sha256 "8d146b2dce70b23ad5d4c8c9b4c94dfe1eb211184c1bc5d6f979bfd5d4406b88"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/sfs-linux-arm64.zip"
      sha256 "77f6ac787670d5c100731fc8f83748f85cfc48d37772f934c352d4df3d6df4cf"
    else
      url homepage + "/releases/download/#{version}/sfs-linux-amd64.zip"
      sha256 "7fbef5ca145255e2d3e8e6d9619ff6b15c45382485f4bb9b55f93f04a6a63753"
    end
  end

  def install
    bin.install "sfs"
  end

  test do
    system "#{bin}/sfs", "--version"
  end
end
