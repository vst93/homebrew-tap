class Sfs < Formula
  desc "SmallFileSync - A WebDAV-based terminal file sync tool"
  homepage "https://github.com/vst93/sfs"
  version "0.2.0"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vst93/sfs/releases/download/0.2.0/sfs-darwin-arm64.zip"
      sha256 "0c3b2990fe5355b45ee2f2b4768e444505f0dedf70ca33c18bd634183539ecf2"
    else
      url "https://github.com/vst93/sfs/releases/download/0.2.0/sfs-darwin-amd64.zip"
      sha256 "cbb6009818141bef8bc5b40944770cda1ba438a05d18ac5dcc3af2f0f9b4cad9"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vst93/sfs/releases/download/0.2.0/sfs-linux-arm64.zip"
      sha256 "5fe3d4647cc6a90360f116a57dc3c7f65eea47430245104d88079586c7e6647a"
    else
      url "https://github.com/vst93/sfs/releases/download/0.2.0/sfs-linux-amd64.zip"
      sha256 "717487b3002e48546123b101116e70dab21a7cf72251d383f82153b2a739a702"
    end
  end

  def install
    bin.install "sfs"
  end

  test do
    system "#{bin}/sfs", "--version"
  end
end
