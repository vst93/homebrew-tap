cask "bili-fm" do
  arch arm: "arm64", intel: "amd64"

  version "1.9.5"
  sha256 arm:   "91f2651aa825a2514e318ef2702207f98d95318367dcd43815cb95185e40d08e",
         intel: "aa9c10f9d8f0430893620571157129a830d4ba4dbf2de9cce1387d3ace02b898"

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
