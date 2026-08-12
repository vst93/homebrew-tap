class Sfs < Formula
  desc "SmallFileSync - A WebDAV-based terminal file sync tool"
  homepage "https://github.com/vst93/sfs"
  version "0.1.12"

  livecheck do
    url :stable
    regex(/(\d+\.\d+(\.\d+)?)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/sfs-darwin-arm64.zip"
      sha256 "50e2c7ced6005c499be582aff8e5e0b698caafb35f0ce28771870a7b6ce36de1"
    else
      url homepage + "/releases/download/#{version}/sfs-darwin-amd64.zip"
      sha256 "34bac21e12f6cdbfb30b85a41a2f9774deed62b93ae9fbd6d41c633b8e525a49"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/sfs-linux-arm64.zip"
      sha256 "55c5ae8da08116c20b4e2a680ddb08927c3965a8db8f794d1e036796566425c4"
    else
      url homepage + "/releases/download/#{version}/sfs-linux-amd64.zip"
      sha256 "8273d51a59aed4688957e6779b2288b212acd66eeb3e53430abfbb5b5bf8fddf"
    end
  end

  def install
    bin.install "sfs"
  end

  test do
    system "#{bin}/sfs", "--version"
  end
end
