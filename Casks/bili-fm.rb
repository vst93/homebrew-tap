cask "bili-fm" do
  arch arm: "apple-silicon", intel: "intel"

  version "2.0.13"
  sha256 arm:   "a4d040a09f1b2307d75607a909095f18c2620b9b3a239aa88d2ff87bb139d005",
         intel: "43de53051517e3289a2d129070db85e28336820d94144a703880fce0b60234b5"

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
