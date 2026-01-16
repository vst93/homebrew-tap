class V < Formula
  desc "Gadgets under the terminal"
  homepage "https://github.com/vst93/v"
  version "0.0.4"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+\.\d+)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/v-darwin-arm64.zip"
      sha256 "6450b26cc0c44952eb91c744058031e740b489dd592d225c88e75a1288660c97"
    else
      url homepage + "/releases/download/#{version}/v-darwin-amd64.zip"
      sha256 "8a7e75f0ee06cd275ac8fc5bc8e6b9b255aa99994ae498bcc85807d5b4e49a07"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/v-linux-arm64.zip"
      sha256 "d269545f371f6cf10aefddf60f40a3bf1e90bb0a9e471337ef70b5373f8a66b6"
    else
      url homepage + "/releases/download/#{version}/v-linux-amd64.zip"
      sha256 "77b42e060ce4ba412b89fdc0b16f5f7b3cbe04a12818925c7e83eb859203dad7"
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
