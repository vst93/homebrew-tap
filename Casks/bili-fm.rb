cask "bili-fm" do
  arch arm: "arm64", intel: "amd64"

  version "1.4.1"
  sha256 arm:   "5813904cac05562b6cf024848cd8ba7ff3734308d7c8e33bebc738c32519e72f",
         intel: "d5ce5403c239cd46680977b1fbcca611ef8b840e682bdf10f4e15d064c808e34"

  url "https://github.com/vst93/bili-fm/releases/download/#{version}/bili-FM-darwin-#{arch}.zip"
  name "bili-fm"
  desc "Listen to Bilibili content in audio-only mode"
  homepage "https://github.com/vst93/bili-fm"

  app "bili-FM.app"

  zap trash: "~/Library/Application Support/bili-FM"
end
