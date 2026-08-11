# Vst93 Tap

Homebrew tap for CLI tools and macOS apps by [vst93](https://github.com/vst93).

## Available Formulae

| Formula | Description |
|---------|-------------|
| **v** | Gadgets under the terminal |
| **ttm** | Tiny Terminal Manager |
| **lazyrdm** | Redis management tool for the terminal |
| **sfs** | SmallFileSync - WebDAV-based file sync |

## Available Casks

| Cask | Description |
|------|-------------|
| **bili-fm** | Listen to Bilibili content in audio-only mode (Tauri v2) |

## Installation

```bash
brew tap vst93/tap
brew install v              # or ttm, lazyrdm, sfs
brew install --cask bili-fm
```

Or directly: `brew install vst93/tap/<formula>`

## Auto-Update

The update workflow runs automatically when a release is published on the source repo, or can be triggered manually.

- **Formulas** (v, ttm, lazyrdm, sfs): Go binaries, `darwin/linux-arm64/amd64.zip`
- **Casks** (bili-fm): macOS `.dmg` files, `apple-silicon` + `intel` architectures

The `update-cask.rb` script auto-detects the asset naming pattern (Tauri `AppName-VERSION-macos-ARCH.dmg` vs legacy `AppName-darwin-ARCH.zip`).

Default: commit directly to main. Set `create_pr: true` to create a PR instead.

## Contributing

See [AGENTS.md](AGENTS.md) for guidelines and version automation scripts.
