class V < Formula
  desc "Gadgets under the terminal"
  homepage "https://github.com/vst93/v"
  version "0.0.11"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+\.\d+)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/v-darwin-arm64.zip"
      sha256 "461f0c98e6be610804821fde2136bee73f7a69a76aa420a896984665f6f8ba38"
    else
      url homepage + "/releases/download/#{version}/v-darwin-amd64.zip"
      sha256 "f0e745e3ce47dc18f94e69c8aa8e3cbf54780bac2847eb73520d75b9f66f708a"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/v-linux-arm64.zip"
      sha256 "72b66b2753f4e682f517feda331f4e96f9df0afcc30508b14c554c0439569fd7"
    else
      url homepage + "/releases/download/#{version}/v-linux-amd64.zip"
      sha256 "197cf9c37fe0afdc9e0c0ec49c4f43e67f97093826ace68eb0a7f0a532cc0899"
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
