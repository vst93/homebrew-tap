cask "bili-fm" do
  arch arm: "arm64", intel: "amd64"

  version "1.8.0"
  sha256 arm:   "1638afac7ba588c41eec2cb5ae6c49b8094d146ff2e0d09574d4648f4ae6fbd2",
         intel: "349db39045f34e3796d797c641d0ca3a3ad1ae18844d46fe0c68219a4063b31f"

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
