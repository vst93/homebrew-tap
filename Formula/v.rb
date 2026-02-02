class V < Formula
  desc "Gadgets under the terminal"
  homepage "https://github.com/vst93/v"
  version "0.0.5"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+\.\d+)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/v-darwin-arm64.zip"
      sha256 "c142293f13def7aea92ec3ef7de7a30e24353bf8af72bb225182df357136a081"
    else
      url homepage + "/releases/download/#{version}/v-darwin-amd64.zip"
      sha256 "be48f6f5993c8758694db14c7529446e6928e369b1a5a1b97be73938e1ec6762"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/v-linux-arm64.zip"
      sha256 "d820cf7e4429caf0c189bbeed553aac098c231883a6adae4fb74eb5d0458d8c1"
    else
      url homepage + "/releases/download/#{version}/v-linux-amd64.zip"
      sha256 "367922ee794b749e6e524ae16c7da6ae70fb97ebec28ed8952a45ad246ba0e3f"
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
