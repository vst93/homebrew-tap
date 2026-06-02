class Sfs < Formula
  desc "SmallFileSync - A WebDAV-based terminal file sync tool"
  homepage "https://github.com/vst93/sfs"
  version "0.1.0"

  livecheck do
    url :stable
    regex(/(\d+\.\d+(\.\d+)?)/i)
  end

  name "sfs"

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/#{name}-darwin-arm64.zip"
      sha256 "dce039c204bde0b19f192ec6589dbfd31f2aced3cf24870c3b7d20ff4b5b79c9"
    else
      url homepage + "/releases/download/#{version}/#{name}-darwin-amd64.zip"
      sha256 "fb16b5c5b1cad888dec894fc5c0f7c3408ed22972911445099b8108199d06a3a"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/#{name}-linux-arm64.zip"
      sha256 "35d16ab0d029d5e3f5b54b76e1d28d93a6520e3b3a7bad623765e7a1337169e3"
    else
      url homepage + "/releases/download/#{version}/#{name}-linux-amd64.zip"
      sha256 "ed7e10cefd14b04e8bddce3b9d4f76405b7f4cd3f64966ee93a7a59d71c742dc"
    end
  end

  def install
    bin.install "sfs"
  end

  test do
    system "#{bin}/sfs", "--version"
  end
end
