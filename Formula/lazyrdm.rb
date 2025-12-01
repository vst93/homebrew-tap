class Lazyrdm < Formula
  desc "Redis management tool designed for the terminal"
  homepage "https://github.com/vst93/lazyrdm"
  version "1.1"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vst93/lazyrdm/releases/download/#{version}/lazyrdm_#{version}_macos_arm64.zip"
      sha256 "64497171c7b0dda3fa48225ac62039d149d9c20ce17cee88619e01a78027de32"
    else
      url "https://github.com/vst93/lazyrdm/releases/download/#{version}/lazyrdm_#{version}_macos_amd64.zip"
      sha256 "360d1006beabd7418c54c8029c28f9aaf3f7348d1bb1de2ad5d2d54d7a613f04"
    end
  end

  if OS.linux?
    url "https://github.com/vst93/lazyrdm/releases/download/#{version}/lazyrdm_#{version}_linux_amd64.zip"
    sha256 "62665ef6d01b482082264c46ca7328a6440d1e640ad9d5b8b50f86e0817a267c"
  end

  def install
    bin.install "lazyrdm"
  end

  test do
    system "false"
  end
end
