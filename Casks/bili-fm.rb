cask "bili-fm" do
  arch arm: "arm64", intel: "amd64"

  version "1.7.3"
  sha256 arm:   "050d31820ab0d440a84b6d4cae137529e7f36b37d1157f66c6870285804efe09",
         intel: "cb2ecd8147f930bb68197c87bc6ba7ff7b3a14f7238856e5ceaa25f266871dd0"

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
