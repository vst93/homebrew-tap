class Sfs < Formula
  desc "SmallFileSync - A WebDAV-based terminal file sync tool"
  homepage "https://github.com/vst93/sfs"
  version "0.1.7"

  livecheck do
    url :stable
    regex(/(\d+\.\d+(\.\d+)?)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/sfs-darwin-arm64.zip"
      sha256 "6e8e8c523b81bf0f28047549dbdfa03e063c07b8a10c542265c5be5548492f57"
    else
      url homepage + "/releases/download/#{version}/sfs-darwin-amd64.zip"
      sha256 "dcb1ac49f4985a6e9dbe68c92422d646840943dd414b6689b1eac67bc3802231"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/sfs-linux-arm64.zip"
      sha256 "3fba6d7039631713b2fec9d5e6f91a91a4c1f61c35e4a5ed0779596c1ff55f82"
    else
      url homepage + "/releases/download/#{version}/sfs-linux-amd64.zip"
      sha256 "42c5a958fc588b036b12167c50102065fd04990d5cd59cd2858783cf41d7ebbd"
    end
  end

  def install
    bin.install "sfs"
  end

  test do
    system "#{bin}/sfs", "--version"
  end
end
