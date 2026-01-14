cask "bili-fm" do
  arch arm: "arm64", intel: "amd64"

  version "1.6.1"
  sha256 arm:   "6986fcbd653f64d528eda6d91cd43ffd7752ec24762f756f4ac77a230afbde71",
         intel: "4d84179459ef68b8b4bf1670f409b275aba20f68baaa650d5b07483fd7e10e93"

  url "https://github.com/vst93/bili-fm/releases/download/#{version}/bili-FM-darwin-#{arch}.zip"
  name "bili-fm"
  desc "Listen to Bilibili content in audio-only mode"
  homepage "https://github.com/vst93/bili-fm"

  app "bili-FM.app"

  zap trash: "~/Library/Application Support/bili-FM"
end
