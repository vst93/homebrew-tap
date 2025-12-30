cask "bili-fm" do
  arch arm: "arm64", intel: "amd64"

  version "1.4.1"
  sha256 arm:   "9ace074f8b88289d24d7278688fa9671ce035da5a5dd7714cdae0fb67641b34e",
         intel: "5ff8f8cab8158d8ac7cde15b2ac31e4c02be43d82260674eab6ea01567639837"

  url "https://github.com/vst93/bili-fm/releases/download/#{version}/bili-FM-darwin-#{arch}.zip"
  name "bili-fm"
  desc "Listen to Bilibili content in audio-only mode"
  homepage "https://github.com/vst93/bili-fm"

  app "bili-FM.app"

  zap trash: "~/Library/Application Support/bili-FM"
end
