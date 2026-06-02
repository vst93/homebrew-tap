class Sfs < Formula
  desc "SmallFileSync - A WebDAV-based terminal file sync tool"
  homepage "https://github.com/vst93/sfs"
  version "0.1.1"

  livecheck do
    url :stable
    regex(/(\d+\.\d+(\.\d+)?)/i)
  end

  name "sfs"

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/#{name}-darwin-arm64.zip"
      sha256 "dd7fa9d7760de85ece48b93850b4b326d6770c53fb38ceefa13feab065b690f5"
    else
      url homepage + "/releases/download/#{version}/#{name}-darwin-amd64.zip"
      sha256 "1b454630e55bea0ad2a673c21f128e6f717a5576f2e69e60609498885942c9b3"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/#{name}-linux-arm64.zip"
      sha256 "c784851943456d047d8a3ea03a4a1ce086aa1477fc5c775ad3617367db36e1c1"
    else
      url homepage + "/releases/download/#{version}/#{name}-linux-amd64.zip"
      sha256 "c611569b4b1255e3ce5a616dd5b02f2a4cd8d310cc6de67fd318396ae41288ee"
    end
  end

  def install
    bin.install "sfs"
  end

  test do
    system "#{bin}/sfs", "--version"
  end
end
