cask "bili-fm" do
  arch arm: "apple-silicon", intel: "intel"

  version "3.1.1"
  sha256 arm:   "4aad8a5d2dcbdd0a4eb903a28a7868da00796d1e7b33472f07fce15cacd7498f",
         intel: "ba54a6be1c5cba7a263e7bbb516b9aadf5980f35da283aa1dd1fd33a286265c3"

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
