cask "bili-fm" do
  arch arm: "arm64", intel: "amd64"

  version "1.4.1"
  sha256 arm:   "2dbc79cc6b0e1e6becf02d66c22fe06a6554438f69f6b826058ce264f835c312",
         intel: "ff3e5231bf0b58e996ecfa979349b8c238cc30ea5be9cc450d6e5071cf71f2a5"

  url "https://github.com/vst93/bili-fm/releases/download/#{version}/bili-FM-darwin-#{arch}.zip"
  name "bili-fm"
  desc "Listen to Bilibili content in audio-only mode"
  homepage "https://github.com/vst93/bili-fm"

  app "bili-FM.app"

  zap trash: "~/Library/Application Support/bili-FM"
end
