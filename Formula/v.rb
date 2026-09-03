class V < Formula
  desc "Gadgets under the terminal"
  homepage "https://github.com/vst93/v"
  version "0.0.15"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+\.\d+)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/v-darwin-arm64.zip"
      sha256 "4a4d78682182818fd8f6d36aeaaa82870771b9e245654fafdadcef749e9c63c7"
    else
      url homepage + "/releases/download/#{version}/v-darwin-amd64.zip"
      sha256 "366588012c32b21646c512a8806c8eadcee1a542622aa4b0d7113ced15194aa3"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/v-linux-arm64.zip"
      sha256 "57f78767df503c735ce5e2a69b8f9d38cb81efebc56fe74404adef883e0c84de"
    else
      url homepage + "/releases/download/#{version}/v-linux-amd64.zip"
      sha256 "21a5327b3a4e8f6f04a4bddee0a06cb3a8ba4e19b63614bc0bbaf095700d93d7"
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
