cask "bili-fm" do
  arch arm: "arm64", intel: "amd64"

  version "1.7.1"
  sha256 arm:   "f917665de3948652aedc7889e6284fa48f6cbe0161b4271d85ddc408b83a0e07",
         intel: "67ba3b65e30f580b1f5d2a15b447025862b6c1972171956eefb8db416f9c7a8d"

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
