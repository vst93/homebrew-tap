cask "bili-fm" do
  arch arm: "apple-silicon", intel: "intel"

  version "3.1.16"
  sha256 arm:   "5676c414cd8e94678a263fd775c61866b1ad9fcb1806f7b48d6aab647945cb44",
         intel: "fcdbb28073cdfd2a3b9a3dc8b46592b4914d338edfeaada8386e3f2b13fc3f74"

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
