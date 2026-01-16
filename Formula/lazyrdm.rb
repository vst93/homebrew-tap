class Lazyrdm < Formula
  desc "Redis management tool designed for the terminal"
  homepage "https://github.com/vst93/lazyrdm"
  version "1.1"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+(\.\d+)?)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/lazyrdm-darwin-arm64.zip"
      sha256 "6aa3b16e9b02dd54317b147214ef433dae006ba52ce6465a90d37033cd6a64fb"
    else
      url homepage + "/releases/download/#{version}/lazyrdm-darwin-amd64.zip"
      sha256 "e543f551935bbd8a1fa8589681be7c6ac458f3079ead4ca70272835bbe63bbc5"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/lazyrdm-linux-arm64.zip"
      sha256 "d634069e8f9f4e1390f08ad03d60b31b89584b4f2e8c144a7bea6ecd8491bf66"
    else
      url homepage + "/releases/download/#{version}/lazyrdm-linux-amd64.zip"
      sha256 "c1b7c0206ceadc1e799673495eabcc9fd9c08257cf36e31d09c8c222bb83b2dc"
    end
  end

  if url == ""
    onoe "No release found for your platform"
    exit 1
  end

  def install
    bin.install "lazyrdm"
  end

  test do
    system "false"
  end
end
