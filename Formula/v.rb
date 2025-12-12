class V < Formula
  desc "Gadgets under the terminal"
  homepage "https://github.com/vst93/v"
  version "0.0.1"
  url ""
  sha256 ""

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/v-darwin-arm64.zip"
      sha256 "bbf365b776403f839f61b3f681cb4f9a85c38b5a8ebad0e61c46ea2f3adb0ae2"
    else
      url homepage + "/releases/download/#{version}/v-darwin-amd64.zip"
      sha256 "c4691698461593700b123f45d41406155bef2e200bcaa7e4d71abe06b734fb80"
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/v-linux-arm64.zip"
      sha256 "9dddc62119d35fe5e008db866d199f06d0fde51e635b1ce7cb24771193e55dce"
    else
      url homepage + "/releases/download/#{version}/v-linux-amd64.zip"
      sha256 "f21562470a2c87177bdd37674392a5af47ffe5cbb4f666cfed195b91b0295808"
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
