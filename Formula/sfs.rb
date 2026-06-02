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
      sha256 "36fd9665cc8d5b0737ba5ee7f362ed5f76065d0e3470049a60f571bb89cd6ecf"
    else
      url homepage + "/releases/download/#{version}/sfs-darwin-amd64.zip"
      sha256 "f2c85d55dc49faa69853ae0fbfdb3ee04b689a80d0e93080d062ae9c8b7b225b"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/sfs-linux-arm64.zip"
      sha256 "fb2811872d05daeef6aa986993178534f1cd4a58808d0f4680e1e6e24c858ea7"
    else
      url homepage + "/releases/download/#{version}/sfs-linux-amd64.zip"
      sha256 "b83690ac7efdc8ba507928cc44e499fe0a692f47a8135ecaee31732adfc55948"
    end
  end

  def install
    bin.install "sfs"
  end

  test do
    system "#{bin}/sfs", "--version"
  end
end
