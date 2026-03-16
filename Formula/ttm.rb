class Ttm < Formula
  desc "Tiny Terminal Manager"
  homepage "https://github.com/vst93/ttm"
  version "0.3.1"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+(\.\d+)?)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-darwin-arm64.zip"
      sha256 "00733fd0bf8542c8738a099c486cf776b081a084c125512035574b2e376cb310"
    else
      url homepage + "/releases/download/#{version}/ttm-darwin-amd64.zip"
      sha256 "1cdd298e8aaa070bfa388c301a4f1d07f06bbcce8ee4209f4b5676651e95b40e"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-linux-arm64.zip"
      sha256 "c2e3300762143a0c31f15003629e70ae806be542b4161fb849a34157739a8e6f"
    else
      url homepage + "/releases/download/#{version}/ttm-linux-amd64.zip"
      sha256 "82f2f27f05f6ecfb83ce8942ea3c68dc40c86ddd48140d2914cfb7dd23efa7f7"
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
