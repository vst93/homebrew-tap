class Sfs < Formula
  desc "SmallFileSync - A WebDAV-based terminal file sync tool"
  homepage "https://github.com/vst93/sfs"
  version "0.1.8"

  livecheck do
    url :stable
    regex(/(\d+\.\d+(\.\d+)?)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/sfs-darwin-arm64.zip"
      sha256 "4e168864c35d1a376005999750d87fe0015ccd36ae61d8be61e3d853b90cba5a"
    else
      url homepage + "/releases/download/#{version}/sfs-darwin-amd64.zip"
      sha256 "5b541bfed3905fc0dade4374dc929be631d380360a08e1bfd5b7766d9c6eef07"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/sfs-linux-arm64.zip"
      sha256 "9f98a21ede389633467cebcfe9c50b0ec7d8e138830b6d6469d972ff84ae0938"
    else
      url homepage + "/releases/download/#{version}/sfs-linux-amd64.zip"
      sha256 "d001e8d3dce11499fa4d190b5edbe33546d9c907cebf164884b994c45ed402a6"
    end
  end

  def install
    bin.install "sfs"
  end

  test do
    system "#{bin}/sfs", "--version"
  end
end
