class Sfs < Formula
  desc "SmallFileSync - A WebDAV-based terminal file sync tool"
  homepage "https://github.com/vst93/sfs"
  version "0.1.3"

  livecheck do
    url :stable
    regex(/(\d+\.\d+(\.\d+)?)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/sfs-darwin-arm64.zip"
      sha256 "179f67b6a5a67f0f3d26927209b1fc32c95a2eee87630115a0dbab8f280af823"
    else
      url homepage + "/releases/download/#{version}/sfs-darwin-amd64.zip"
      sha256 "3325a2d0c447c17a5294e115f6c3410454f08db9f79be0536a9c6c448b703575"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/sfs-linux-arm64.zip"
      sha256 "8d95351d87d3d67ca2cf895c31cc07b0d4fdf0dd0933bf6f241d3301a98bfe0b"
    else
      url homepage + "/releases/download/#{version}/sfs-linux-amd64.zip"
      sha256 "164024e35fcb80b0388d8284bb2a77b5460bdb854c881c4e2f969972f727fe5e"
    end
  end

  def install
    bin.install "sfs"
  end

  test do
    system "#{bin}/sfs", "--version"
  end
end
