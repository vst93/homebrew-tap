cask "bili-fm" do
  arch arm: "apple-silicon", intel: "intel"

  version "2.0.26"
  sha256 arm:   "ef8aaceb66898fcb2244b982e85e231d27c7cf6feedec111fc52ffdf0b562262",
         intel: "ba69c4394b41958702c7701de7f18c24e37fffd03d4faad679276ee7ec80d9eb"

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
