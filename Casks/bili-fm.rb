cask "bili-fm" do
  arch arm: "apple-silicon", intel: "intel"

  version "3.1.22"
  sha256 arm:   "790952aa6cbc6770301e60d1bb9d17a5cc8a8a9a3e52363bfd4126c6ce6f03d9",
         intel: "5f5022da0be8170e3438ffce73d1394f4e9e985a6f9f1d5fc7c26d6bb65d1a99"

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
