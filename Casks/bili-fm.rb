cask "bili-fm" do
  arch arm: "apple-silicon", intel: "intel"

  version "3.1.23"
  sha256 arm:   "e9a4f955ddc45123df3e2da0d8bb285801ec5a3c17e816df1b605680aa8c3450",
         intel: "a1f6e4e202189f93611860cf6be4427f48bda8f5432c43086479eaf309224eb9"

  url "https://github.com/vst93/bili-fm/releases/download/mygo-v#{version}/bili-FM-#{version}-macos-#{arch}.dmg"
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
