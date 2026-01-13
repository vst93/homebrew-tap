cask "bili-fm" do
  arch arm: "arm64", intel: "amd64"

  version "1.4.2"
  sha256 arm:   "61ea7769fe79abb7fcaf3965283d99ad7870815e99cccdae242e7ea9dea5cba7",
         intel: "70e590bdd3fa2a2392a8ceaa53da67396c5a954fd6dc995d9341a12c7e47706f"

  url "https://github.com/vst93/bili-fm/releases/download/#{version}/bili-FM-darwin-#{arch}.zip"
  name "bili-fm"
  desc "Listen to Bilibili content in audio-only mode"
  homepage "https://github.com/vst93/bili-fm"

  app "bili-FM.app"

  zap trash: "~/Library/Application Support/bili-FM"
end
