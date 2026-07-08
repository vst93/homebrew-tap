cask "bili-fm" do
  arch arm: "arm64", intel: "amd64"

  version "1.9.0"
  sha256 arm:   "8f4fcad54f5bc67de72583c8dc7f19d84cd64638a8d92465e9442eb807718268",
         intel: "67b80367a486da91e744d8766203b8103b46a8963cde1b8a50643f1d574ed941"

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
