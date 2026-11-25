class V < Formula
  desc "Gadgets under the terminal"
  homepage "https://github.com/vst93/v"
  version "0.0.16"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+\.\d+)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/v-darwin-arm64.zip"
      sha256 "69398f27574ee8f7ba4ab21d1b5b40b1fa6eb345e21f3cc18923a5e5dd998baa"
    else
      url homepage + "/releases/download/#{version}/v-darwin-amd64.zip"
      sha256 "30b5ff4f268c2d193aca2df217c93b618101a29a039663238a34dd4ae8f5c42f"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/v-linux-arm64.zip"
      sha256 "bf9d603efd4452c89c89aa92ebca70931d3122b9d384d0f258f608b24dc599b2"
    else
      url homepage + "/releases/download/#{version}/v-linux-amd64.zip"
      sha256 "fa1751ca7a73c342d5b8bfffb662ba216b3ba3393e1770e71e0be7667f8b6636"
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
