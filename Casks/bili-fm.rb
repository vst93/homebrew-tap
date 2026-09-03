cask "bili-fm" do
  arch arm: "apple-silicon", intel: "intel"

  version "2.0.10"
  sha256 arm:   "755a1e10957da01025c9e3c61f5803caee024da9010d6c97908c4fa6c723893c",
         intel: "3f38de3139eb4e7aaeb062408aee3800f903c8c1dded795dc4e036a58fa52ae9"

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
