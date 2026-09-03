cask "bili-fm" do
  arch arm: "apple-silicon", intel: "intel"

  version "2.0.4"
  sha256 arm:   "de0950c4e9252ca9a0507097c42c623df1b2e091cc25625c6c0e8eb1103c75a1",
         intel: "d1576a4050d3b6c24bab4c120395ff4392996862ec252e1c6ea89d45f8b561f0"

  url "https://github.com/vst93/bili-fm/releases/download/#{version}/bili-FM-#{version}-macos-#{arch}.dmg"
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
