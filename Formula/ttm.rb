class Ttm < Formula
  desc "Tiny Terminal Manager"
  homepage "https://github.com/vst93/ttm"
  version "0.3.11"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+(\.\d+)?)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-darwin-arm64.zip"
      sha256 "b0b7e81474e6db51e2c7af4a051e3ea2acd76ab7dbf145741a58c92ac693a7f8"
    else
      url homepage + "/releases/download/#{version}/ttm-darwin-amd64.zip"
      sha256 "fea0b69890878207825c45957b50b7e45db36b8e5b4f4c5f21d21eac4416691a"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-linux-arm64.zip"
      sha256 "cdf1360f2dd0111b14e2eaa6b12a141f0b3ea2602aabfdbe8bd9582bdb811b28"
    else
      url homepage + "/releases/download/#{version}/ttm-linux-amd64.zip"
      sha256 "3a7948c8eb514fef677d6d0493582e448fa0db5bcd41b7b79d1aeb6b3d9d5fa6"
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
