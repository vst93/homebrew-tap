class Ttm < Formula
  desc "Tiny Terminal Manager"
  homepage "https://github.com/vst93/ttm"
  version "0.3.12"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+(\.\d+)?)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-darwin-arm64.zip"
      sha256 "ddaeea999cddab96ec92432901a6cd18b28dd7812f93bfd8340b538457d11f70"
    else
      url homepage + "/releases/download/#{version}/ttm-darwin-amd64.zip"
      sha256 "07e6bab876e9bf89f594cb0d747f63a5e96de8b61773b09b1369066ba0fe443c"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-linux-arm64.zip"
      sha256 "3d2d7684a34d9f9e0f1a1b60f6a8add4c1abd4f59f923fd4078e2b2f84137a99"
    else
      url homepage + "/releases/download/#{version}/ttm-linux-amd64.zip"
      sha256 "fcaeccfe8463294e18f2fc2fae65e8ce744c0fc8640d2c49358a4c93e18371cf"
    end
  end

  if url == ""
    onoe "No release found for your platform"
    exit 1
  end

  def install
    bin.install "ttm"
  end

  test do
    system "false"
  end
end
