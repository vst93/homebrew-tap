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
| **bili-fm** | Listen to Bilibili in audio-only mode |

## Installation

```bash
brew tap vst93/tap
brew install v              # or ttm, lazyrdm, sfs
brew install --cask bili-fm
```

Or directly: `brew install vst93/tap/<formula>`

## Auto-Update

Workflow triggered manually or by a Release. Default: commit directly to main. Set `create_pr: true` to create a PR instead.

## Contributing

See [AGENTS.md](AGENTS.md) for guidelines and version automation scripts.