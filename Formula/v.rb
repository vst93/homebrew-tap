class V < Formula
  desc "Gadgets under the terminal"
  homepage "https://github.com/vst93/v"
  version "0.0.2"
  url ""
  sha256 ""

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/v-darwin-arm64.zip"
      sha256 "c0a1d614df93d900fdcf5b47c3f987fc3d4c60c52e2d91ff49b73a9d9a296b19"
    else
      url homepage + "/releases/download/#{version}/v-darwin-amd64.zip"
      sha256 "106b763f069b408074a312402d4d62f8ef19210dc8b1348ee0bbde7cdaa1ff37"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/v-linux-arm64.zip"
      sha256 "de0971e8a8da9d31c85b43cf776f85df20b19257b6b14ca6c11de01b91b1d8cb"
    else
      url homepage + "/releases/download/#{version}/v-linux-amd64.zip"
      sha256 "2f8340287407ce90e53b2da5372f481daf38b5c22044e4402534dafdeee602a2"
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
