# Agent Guidelines for vst93/homebrew-tap

This document provides guidelines for AI agents working with this Homebrew tap repository.

## Build/Lint/Test Commands

### Formula Validation
```bash
# Audit a specific formula
brew audit --formula Formula/v.rb

# Audit all formulas
brew audit --formula Formula/*.rb

# Audit all casks
brew audit --cask Casks/*.rb

# Install a formula from local tap
brew install ./Formula/v.rb

# Test a specific formula
brew test Formula/v.rb

# Style check (Ruby)
rubocop Formula/ Casks/

# Check for missing dependencies
brew bundle check
```

### Full Tap Audit
```bash
# Full audit with all checks
brew audit --strict --tap .

# Validate all formula URLs
brew fetch --build-from-source Formula/v.rb

# Check for outdated versions
brew outdated --formula
```

### Version Automation (NEW!)

**Check for new versions:**
```bash
# Check single formula
brew livecheck --formula v

# Check all formulas
brew livecheck --formula v ttm lazyrdm

# Check single cask
brew livecheck --cask bili-fm

# Check all casks
brew livecheck --cask bili-fm
```

**Auto-update formula (fetches latest version + SHA256):**
```bash
# Update single formula
ruby scripts/update-formula.rb v

# Update multiple formulas
ruby scripts/update-formula.rb v ttm lazyrdm

# What it does:
# 1. Fetches latest release from GitHub API
# 2. Downloads all platform assets (darwin-arm64, darwin-amd64, linux-arm64, linux-amd64)
# 3. Calculates SHA256 for each asset
# 4. Updates formula with new version + SHA256s
# 5. Runs brew audit for verification
```

**Auto-update cask (fetches latest version + SHA256):**
```bash
# Update single cask
ruby scripts/update-cask.rb bili-fm

# Update multiple casks
ruby scripts/update-cask.rb bili-fm another-cask

# What it does:
# 1. Fetches latest release from GitHub API
# 2. Downloads darwin-arm64 and darwin-amd64 assets
# 3. Calculates SHA256 for each architecture
# 4. Updates cask with new version + SHA256s
# 5. Runs brew audit for verification
```

## Code Style Guidelines

### Ruby Style (Formula Files)

**Naming Conventions:**
- Class name: PascalCase (e.g., `class V < Formula`)
- File name: snake_case matching formula name (e.g., `v.rb`, `lazyrdm.rb`)
- Desc: Short, imperative description under 80 chars
- Use `name` variable consistently for binary name

**Structure:**
```ruby
class FormulaName < Formula
  desc "Brief description"
  homepage "https://github.com/org/project"
  version "x.y.z"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+(\.\d+)?)/i)
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/#{name}-darwin-arm64.zip"
      sha256 "..."
    else
      url homepage + "/releases/download/#{version}/#{name}-darwin-amd64.zip"
      sha256 "..."
    end
  end

  if OS.linux?
    if Hardware::CPU.arm?
      url homepage + "/releases/download/#{version}/#{name}-linux-arm64.zip"
      sha256 "..."
    else
      url homepage + "/releases/download/#{version}/#{name}-linux-amd64.zip"
      sha256 "..."
    end
  end

  if url == ""
    onoe "No release found for your platform"
    exit 1
  end

  def install
    bin.install "binary_name"
  end

  test do
    system "false"
  end
end
```

**Indentation:** 2 spaces (Ruby default)

**Architecture Detection:**
- Always check `OS.mac?` before `OS.linux?`
- Use `Hardware::CPU.arm?` for Apple Silicon detection
- Fallback to amd64 for Intel Macs

**Error Handling:**
- Use `onoe` for user-facing errors (Homebrew standard)
- Exit with code 1 on platform mismatch
- Verify SHA256 checksums match exactly (64 hex characters)

**URL Pattern:**
- Format: `#{homepage}/releases/download/#{version}/#{name}-#{platform}-#{arch}.#{ext}`
- Supported platforms: darwin, linux
- Supported arch: arm64, amd64

### Cask Style

**Structure:**
```ruby
cask "app-name" do
  arch arm: "arm64", intel: "amd64"

  version "x.y.z"
  sha256 arm:   "...",
         intel: "..."

  url "https://github.com/org/project/releases/download/#{version}/app-name-darwin-#{arch}.zip"
  name "App Name"
  desc "Description"
  homepage "https://github.com/org/project"

  livecheck do
    url :stable
    regex(/v?(\d+\.\d+(\.\d+)?)/i)
  end

  app "App.app"

  zap trash: "~/Library/Application Support/app-name"
end
```

**Key Differences:**
- Use `sha256` with arm/intel keys
- Use `arch` helper for URL interpolation
- Use `app` for .app bundle paths
- Use `zap trash:` for user data cleanup

### Import/Dependency Patterns

- No external Ruby dependencies in formulas
- Homebrew core provides all required modules (Formula, Cask, etc.)
- Use only Homebrew's built-in helpers (onoe, bin.install, etc.)

### String Syntax
- Use double quotes for interpolation: `"#{version}/#{name}-darwin-arm64.zip"`
- Use single quotes for static strings: `"No release found for your platform"`

### Comments
- Avoid unnecessary comments; code should be self-documenting
- Add comments only for non-obvious platform-specific behavior

## Repository Structure

```
Formula/      # CLI formula files (.rb)
Casks/        # macOS application casks (.rb)
template/     # Formula template (formula.tpl)
README.md     # Tap documentation
.gitignore    # Ignores .DS_Store, .git/, .vscode/
```

## Adding New Formulae

1. Copy `template/formula.tpl` to `Formula/newtool.rb`
2. Fill in all placeholders:
   - `[tpl_class_name]` → PascalCase class name
   - `[tpl_desc]` → Brief description
   - `[tpl_homepage]` → GitHub homepage URL
   - `[tpl_version]` → Current version
   - `[tpl_name]` → Binary name (lowercase)
   - `[tpl_sha256_*]` → SHA256 checksums for each platform/arch
3. Run `brew audit --formula Formula/newtool.rb`
4. Test installation: `brew install ./Formula/newtool.rb`

## Verification Checklist

Before submitting changes:
- [ ] `brew audit --formula Formula/*.rb` passes (use `--except FormulaAudit/Urls,FormulaAudit/PyPiUrls` to skip known RuboCop bugs)
- [ ] `brew audit --cask Casks/*.rb` passes
- [ ] SHA256 checksums verified for all platforms
- [ ] URLs match expected GitHub release format
- [ ] Ruby syntax valid: `ruby -c Formula/v.rb`
- [ ] Consistent with existing formula patterns
