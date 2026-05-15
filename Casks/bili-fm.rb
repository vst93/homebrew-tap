cask "bili-fm" do
  arch arm: "arm64", intel: "amd64"

  version "1.7.2"
  sha256 arm:   "5dd027d0f12b8efaa579a011362d97ca3a229c0aa2a5751de60b67809ed1e1d0",
         intel: "c3e3856b065d163fe9a4ee753a1d7ee9d04e954c9ca84b0af4e480cd143a591e"

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
