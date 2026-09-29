cask "bili-fm" do
  arch arm: "apple-silicon", intel: "intel"

  version "2.0.37"
  sha256 arm:   "8d4861561b6c2c7717ad14d1da480f968ec7b11b676e602137c7f27de7f6cbac",
         intel: "3ab96e4eece63a4d7b4bfa11d5372383e3e7bfccfa28654729ced183376719f1"

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
