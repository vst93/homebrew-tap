class Ttm < Formula
  desc "Tiny Terminal Manager"
  homepage "https://github.com/vst93/ttm"
  version "0.3.6"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+(\.\d+)?)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-darwin-arm64.zip"
      sha256 "ee7680fe1122ed042c9321c757d790b83771814c9b23151451267684c16ce0f8"
    else
      url homepage + "/releases/download/#{version}/ttm-darwin-amd64.zip"
      sha256 "f3ba93484c9b8782399deb98f89a00f53436ef48fdc99c70c99893777517ea00"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-linux-arm64.zip"
      sha256 "ca80c8f9dd2b70f68d60c803cb2e38ed836c9a9f7717384fe468c957d535158b"
    else
      url homepage + "/releases/download/#{version}/ttm-linux-amd64.zip"
      sha256 "3e08489607b8f6cb922e3fcce2798d9f5712367109c1b9ccf74c76a3befc93d7"
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
