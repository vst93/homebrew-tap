class Sfs < Formula
  desc "SmallFileSync - A WebDAV-based terminal file sync tool"
  homepage "https://github.com/vst93/sfs"
  version "0.1.5"

  livecheck do
    url :stable
    regex(/(\d+\.\d+(\.\d+)?)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/sfs-darwin-arm64.zip"
      sha256 "1e57fac7ba18a90511cad509f0c6ab13854f7d5000cc39f2dd4d537d842d1a46"
    else
      url homepage + "/releases/download/#{version}/sfs-darwin-amd64.zip"
      sha256 "7c86407882c1d094e2e1a0103ff7c635fa44f80fd460b67357201d46d75b17c9"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/sfs-linux-arm64.zip"
      sha256 "cea44e7e78c4e676337d82e229e4e1a1c0d8d09af792a14af243a30ce1b97933"
    else
      url homepage + "/releases/download/#{version}/sfs-linux-amd64.zip"
      sha256 "d8accc36a87e3a6138fc35a3f0f97bd3ed961430d53ac4ce3046fb59eb6c50ad"
    end
  end

  def install
    bin.install "sfs"
  end

  test do
    system "#{bin}/sfs", "--version"
  end
end
