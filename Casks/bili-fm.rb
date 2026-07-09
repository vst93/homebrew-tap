cask "bili-fm" do
  arch arm: "arm64", intel: "amd64"

  version "1.9.4"
  sha256 arm:   "5c02a7a70375d349d1559f8ab54726ebf1ac8da49dab3525eceac980b9943624",
         intel: "7c597693484112cb3e9283e220409447406dff73405782ba4137bb41bc5b9529"

  url "https://github.com/vst93/bili-fm/releases/download/#{version}/bili-FM-darwin-#{arch}.zip"
  name "bili-fm"
  desc "Listen to Bilibili content in audio-only mode"
  homepage "https://github.com/vst93/bili-fm"

  livecheck do
    url "https://github.com/vst93/bili-fm/releases"
    regex(/v?(\d+\.\d+(\.\d+)?)/i)
  end

  app "bili-FM.app"

  zap trash: "~/Library/Application Support/bili-FM"
end
