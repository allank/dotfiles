# dotfiles

macOS configuration managed with Homebrew, chezmoi, and shell scripts.

## Quick Start (New Machine)

```bash
git clone https://github.com/allank/dotfiles ~/Dev/dotfiles
cd ~/Dev/dotfiles
./bootstrap.sh
```

During setup, you will be prompted to:
1. Select a **Profile** (Home or Work). This determines which apps are installed (e.g., Discord vs. Slack).
2. Enter your **Git Name and Email**. This configures your identity without storing PII in the repository.

## Daily Usage

| Task | Command |
|------|---------|
| **Add/remove packages** | Edit `dot_Brewfile.tmpl` → `chezmoi apply` → `brew bundle --file=~/Brewfile` |
| **Update all packages** | `brew upgrade` |
| **Apply dotfile changes** | `chezmoi apply` |
| **Re-apply macOS settings** | `./macos-defaults.sh` |
| **See what chezmoi would change** | `chezmoi diff` |
| **Edit a dotfile** | `chezmoi edit ~/.config/fish/config.fish` |

## Structure

```
├── dot_Brewfile.tmpl     # Template for Brewfile (Home/Work packages)
├── bootstrap.sh          # One-time setup for new machines
├── macos-defaults.sh     # macOS system preferences
│
├── dot_config/           # → ~/.config/
│   ├── fish/config.fish
│   ├── nvim/
│   ├── starship.toml
│   ├── aerospace/
│   ├── ghostty/
│   ├── gitui/
│   └── tmux/
│
├── dot_gitconfig.tmpl    # → ~/.gitconfig (Profile-aware identity)
└── dot_gitignore_global  # → ~/.gitignore_global
```

## What's Included

### CLI Tools
fish, neovim, bat, eza, ripgrep, fzf, jq, starship, grc, tmux, gitui, dust, yazi, xh, atac

### Development
python, uv, ruff, go, gopls, node, hugo, foundry, docker, colima

### GUI Apps
Discord (Home) / Slack (Work), Spotify, Firefox, Obsidian, Bitwarden, Alfred, Ghostty, Aerospace, Karabiner-Elements, Antigravity, and more

### macOS Settings
- Dock on right side, small icons
- Finder shows path bar and status bar
- Caps Lock → Hyper key (Cmd+Ctrl+Opt) via Karabiner-Elements
- Right-click on trackpad enabled