class V < Formula
  desc "Gadgets under the terminal"
  homepage "https://github.com/vst93/v"
  version "0.0.10"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+\.\d+)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/v-darwin-arm64.zip"
      sha256 "f5512c33e1cc0eb0da124f1c99f1ecf56112a6fe029b3381f9273efdfa6698b3"
    else
      url homepage + "/releases/download/#{version}/v-darwin-amd64.zip"
      sha256 "9dc1ba9dc11e88a62df5dd51a54209c6f5e6bda9a498965d4f67b016457f7ab3"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/v-linux-arm64.zip"
      sha256 "96eb72717a33f7db2a7210e0e6196d3a2256e4df785d13a7a123caf376690881"
    else
      url homepage + "/releases/download/#{version}/v-linux-amd64.zip"
      sha256 "76215cf444894ff5aa78c2ae365c3bcc82998299ea07ec1232f66a22494e7b80"
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
