class V < Formula
  desc "Gadgets under the terminal"
  homepage "https://github.com/vst93/v"
  version "0.0.2"
  url ""
  sha256 ""

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/v-darwin-arm64.zip"
      sha256 "55845c4f7d52bdbdfa9e3ae5817844fbdce140d3319b1f3f17c2be713b096046"
    else
      url homepage + "/releases/download/#{version}/v-darwin-amd64.zip"
      sha256 "f7621f3661de1500aab3fd4efde9df292d4a705281a4d147017b5596405cfb48"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/v-linux-arm64.zip"
      sha256 "697d4fb9d17f6a55a5c50c6ed129d30e4dfae8cc56eece58cc1d22e5c17e2b1c"
    else
      url homepage + "/releases/download/#{version}/v-linux-amd64.zip"
      sha256 "1d33f0cede515912e2d5f2120b9976df0bb7fcb77ed2b1b53bb52319ba9c8063"
    end
  end

  if url == ""
    onoe "No release found for your platform"
    exit 1
  end

  def install
    bin.install "v"
  end

  test do
    system "false"
  end
end
