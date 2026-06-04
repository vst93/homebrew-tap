class Sfs < Formula
  desc "SmallFileSync - A WebDAV-based terminal file sync tool"
  homepage "https://github.com/vst93/sfs"
  version "0.1.4"

  livecheck do
    url :stable
    regex(/(\d+\.\d+(\.\d+)?)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/sfs-darwin-arm64.zip"
      sha256 "1b67d754be865bb8e0e0cf485d6dc82aa37f2388292eaf5378574ee5882eeeb2"
    else
      url homepage + "/releases/download/#{version}/sfs-darwin-amd64.zip"
      sha256 "aa38fa3dbbdaa3162c94ca784a820c15d5c84cad3a08c4948707fc23a0660f38"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/sfs-linux-arm64.zip"
      sha256 "af8ab48b891618b742149a2b349bafc4eff70fb3f26bb24068a5cd1af1dddc79"
    else
      url homepage + "/releases/download/#{version}/sfs-linux-amd64.zip"
      sha256 "f194200819e5da6802e168e8897d478ed679b085d7042ff1145fb2d807c147ac"
    end
  end

  def install
    bin.install "sfs"
  end

  test do
    system "#{bin}/sfs", "--version"
  end
end
