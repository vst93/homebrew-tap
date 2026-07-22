class V < Formula
  desc "Gadgets under the terminal"
  homepage "https://github.com/vst93/v"
  version "0.0.6"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+\.\d+)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/v-darwin-arm64.zip"
      sha256 "71bc17a723ced0a5c9060f760160d4d635c359ae070e8f556940c88336fdd489"
    else
      url homepage + "/releases/download/#{version}/v-darwin-amd64.zip"
      sha256 "5751759bc3efa280a39696c9b1c7f8aed44b3cfafe2f27055efaa9f4593f5590"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/v-linux-arm64.zip"
      sha256 "0041968b71520162187e8fd4a36954e66540a49f6a412a8ccca917b1df8c8752"
    else
      url homepage + "/releases/download/#{version}/v-linux-amd64.zip"
      sha256 "f18ad12b16bef80a4ff07fad9f3fcc4bdf3f404a02eb5ee381d94a84ba38fb7b"
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
