cask "bili-fm" do
  arch arm: "arm64", intel: "amd64"

  version "1.4.0"
  sha256 arm:   "29443e0d0bbd1e75f123a9f5a1a82d061b51a83a72450f815da95e33e28e5ec9",
         intel: "a35a758e2095ad7e282cfc46346f2ad0eb31b96a69b8418d2242d48020b8f814"

  url "https://github.com/vst93/bili-fm/releases/download/#{version}/bili-FM_#{version}_mac_#{arch}.zip"
  name "bili-fm"
  desc "Listen to Bilibili content in audio-only mode"
  homepage "https://github.com/vst93/bili-fm"

  app "bili-FM.app"

  zap trash: "~/Library/Application Support/bili-FM"
end
