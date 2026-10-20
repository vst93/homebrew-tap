cask "bili-fm" do
  arch arm: "apple-silicon", intel: "intel"

  version "3.1.2"
  sha256 arm:   "cec0effff805be115c2386b7d3c3660bfd21f28f01bf76bfb4eb9db38c1af02e",
         intel: "281d639fbfac2640752f63d93f804c375233b460285634608a7c70ad72431598"

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
