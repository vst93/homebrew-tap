class Ttm < Formula
  desc "Tiny Terminal Manager"
  homepage "https://github.com/vst93/ttm"
  version "0.3.13"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+(\.\d+)?)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-darwin-arm64.zip"
      sha256 "b5874b1b4abc681656f942a8944501f42b327ba5e7ec433d05e2d1cd3ae36f47"
    else
      url homepage + "/releases/download/#{version}/ttm-darwin-amd64.zip"
      sha256 "d678ed6e7ee8ca7546b6bb113fb09f06c746dccd9ea81481d940ab1882a74cbd"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/ttm-linux-arm64.zip"
      sha256 "5e501d05e05437012c61d96f0cc9c4b3aa0b169718b4847de37b3472cf42f868"
    else
      url homepage + "/releases/download/#{version}/ttm-linux-amd64.zip"
      sha256 "c4143166253ec6767da20e8e933c5ac4365c2a6829d0ab82a159d05465bfd607"
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
