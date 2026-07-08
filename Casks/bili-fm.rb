cask "bili-fm" do
  arch arm: "arm64", intel: "amd64"

  version "1.9.3"
  sha256 arm:   "2fb529b405cee76e5f197d9671fa601af5fc6f0986203ebad3818b0898991006",
         intel: "bae74a3b9a2d3b91d5a420419d673d5eaebeb01ff7645294609dbc2e280c0bc5"

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
