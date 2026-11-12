cask "bili-fm" do
  arch arm: "apple-silicon", intel: "intel"

  version "3.1.19"
  sha256 arm:   "ebc68fc302d2457df53cb96e1bb05d9cf0cc6746ebac3d9e00dff354f037331a",
         intel: "c1aab05a5c22675a6a1ba1b30678fa6acb1cb61764f1dba238750ae6fce7e891"

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
