# dotfiles

macOS configuration managed with Homebrew, chezmoi, and shell scripts.

## Quick Start (New Machine)

```bash
git clone https://github.com/allank/dotfiles ~/Dev/dotfiles
cd ~/Dev/dotfiles
./bootstrap.sh
```

During setup, you will be prompted to:
1. Select a **Profile** (Home or Work). This determines which apps are installed and which Claude rules are deployed.
2. Enter your **Git Name and Email**. This configures your identity without storing PII in the repository.

## Daily Usage

| Task | Command |
|------|---------|
| **Add/remove packages** | Edit `Brewfile.tmpl` → `chezmoi apply` → `brew bundle --file=~/Brewfile` |
| **Update all packages** | `brew upgrade` |
| **Apply dotfile changes** | `chezmoi apply` |
| **Re-apply macOS settings** | `./macos-defaults.sh` |
| **See what chezmoi would change** | `chezmoi diff` |
| **Edit a dotfile** | `chezmoi edit ~/.config/fish/config.fish` |
| **Update Claude rules** | Edit `dot_claude/rules/*.md` → `chezmoi apply` |

## Structure

```
├── Brewfile.tmpl              # Template for Brewfile (Home/Work packages)
├── bootstrap.sh               # One-time setup for new machines
├── macos-defaults.sh          # macOS system preferences
│
├── dot_config/                # → ~/.config/
│   ├── fish/config.fish
│   ├── nvim/
│   ├── starship.toml
│   ├── aerospace/
│   ├── ghostty/
│   ├── gitui/
│   └── tmux/
│
├── dot_claude/                # → ~/.claude/
│   ├── CLAUDE.md.tmpl         #   Global Claude instructions (profile-aware)
│   └── rules/                 #   Work profile only: writing rules for AI sessions
│
├── dot_gemini/                # → ~/.gemini/
│   └── GEMINI.md              #   Global Gemini CLI instructions (both profiles)
│
├── dot_gitconfig.tmpl         # → ~/.gitconfig (Profile-aware identity)
└── dot_gitignore_global       # → ~/.gitignore_global
```

## Profile differences

| | Home | Work |
|---|---|---|
| GUI apps | Discord, Firefox | Slack |
| Claude rules | — | `~/.claude/rules/` (7 files) |
| Claude plugins | + understand-anything, Antigravity skills | + slack, Databricks AI Dev Kit |
| GEMINI.md | ✓ | ✓ |

## Claude Code setup

`bootstrap.sh` handles marketplace registration and plugin installs. `claude login` must be run before the Claude section executes — if Claude isn't authenticated when bootstrap runs, it prints the commands for you to run manually.

`~/.claude/settings.json` **cannot be managed by chezmoi** — Claude Code writes to it at runtime. `bootstrap.sh` and `claude plugin list` are the sources of truth for what's installed.

Work machine manual steps (not automated):
- `claude plugin install slack@claude-plugins-official`
- Databricks AI Dev Kit: `bash <(curl -sL https://raw.githubusercontent.com/databricks-solutions/ai-dev-kit/main/install.sh)`

## What's Included

### CLI Tools
fish, neovim, bat, eza, ripgrep, fzf, jq, starship, grc, tmux, gitui, dust, yazi, xh, rtk

### Development
python, uv, ruff, go, gopls, node, hugo, foundry, docker, colima

### GUI Apps
Discord (Home) / Slack (Work), Spotify, Firefox, Obsidian, Bitwarden, Alfred, Ghostty, Aerospace, Antigravity, and more

### macOS Settings
- Dock on right side, small icons
- Finder shows path bar and status bar
- Caps Lock → Hyper key (Cmd+Ctrl+Opt)
- Right-click on trackpad enabled
