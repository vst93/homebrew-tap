class V < Formula
  desc "Gadgets under the terminal"
  homepage "https://github.com/vst93/v"
  version "0.0.13"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+\.\d+)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/v-darwin-arm64.zip"
      sha256 "9faa965418ef6743019434931b749f5f282afa75db3f0a72d6dc7bad4c9e8359"
    else
      url homepage + "/releases/download/#{version}/v-darwin-amd64.zip"
      sha256 "c5b3802e5c30a9a4b5c3777efcba6e930c7395f324b54025ed756c93d27451e9"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/v-linux-arm64.zip"
      sha256 "68c7c7a5cd69e0a24d906b2427bc8beea09bec2b3567d569895e62f9accc1548"
    else
      url homepage + "/releases/download/#{version}/v-linux-amd64.zip"
      sha256 "c924f1ec61c594188988eae0b882a71758c84347d6efe3d8c7ffece451c55018"
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
