class TTM < Formula
  desc "Redis management tool designed for the terminal"
  homepage "https://github.com/vst93/ttm"
  version "0.1.0"

  put RUBY_PLATFORM
  
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vst93/ttm/releases/download/#{version}/ttm-darwin-arm64.zip"
      sha256 "1d726ce214fad246a3911ed3f9c98988a66df1610d373a633659da7f1551d3a3"
    else
      url "https://github.com/vst93/lazyrdm/releases/download/#{version}/ttm-darwin-amd64.zip"
      sha256 "3208667d66aadfd560fa2d9b6171d266d0c5e5de69d2e9556aabea5cfd62c74f"
    end
  end

  if OS.linux?
    url "https://github.com/vst93/lazyrdm/releases/download/#{version}/ttm-linux-amd64.zip"
    sha256 "e795778242c04e3554e6a0f35ca934d507b294663f1af119604ec15fd35385a5"
  end

  if RUBY_PLATFORM =~ /android/?
    url "https://github.com/vst93/lazyrdm/releases/download/#{version}/ttm-android-arm64.zip"
    sha256 "0d466f44afdab4484d6e6242d5329bbbfe0c38587573a082323c65509a97dbae"
  end

  def install
    bin.install "ttm"
  end

  test do
    system "false"
  end
end
