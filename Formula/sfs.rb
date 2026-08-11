class Sfs < Formula
  desc "SmallFileSync - A WebDAV-based terminal file sync tool"
  homepage "https://github.com/vst93/sfs"
  version "0.1.11"

  livecheck do
    url :stable
    regex(/(\d+\.\d+(\.\d+)?)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/sfs-darwin-arm64.zip"
      sha256 "7a69c04fab1b92b8ddd3856b2e9c54d5a1f283a5d757fbc8885d428eb814bc4f"
    else
      url homepage + "/releases/download/#{version}/sfs-darwin-amd64.zip"
      sha256 "a8a19fab57a29755e7c7b91e306a021993207cd42830b038b4332df46c535b7d"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/sfs-linux-arm64.zip"
      sha256 "b2c9ee73f85e6c0ff598da0d2f87d2ba695e533a51d364a92d111874cd39eb2f"
    else
      url homepage + "/releases/download/#{version}/sfs-linux-amd64.zip"
      sha256 "d7516dbd33984999f40ab802f02fc9b5e6f47ee5cd696ce1e069c552a7501968"
    end
  end

  def install
    bin.install "sfs"
  end

  test do
    system "#{bin}/sfs", "--version"
  end
end
