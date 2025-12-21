# Keymaps Reference

Quick reference for all custom keybindings across Neovim and Aerospace.

> **Legend**: `<leader>` = Space, `C-` = Ctrl, `S-` = Shift, `alt-cmd-ctrl` = ⌥⌘⌃

---

## Neovim

### General

| Key | Action |
|-----|--------|
| `Esc` | Clear search highlighting |
| `Y` | Yank to end of line |

### Diagnostics

| Key | Action |
|-----|--------|
| `[d` | Go to previous diagnostic |
| `]d` | Go to next diagnostic |
| `<leader>e` | Show diagnostic error messages |
| `<leader>q` | Open diagnostic quickfix list |

### Window Navigation

| Key | Action |
|-----|--------|
| `C-h` | Move focus left |
| `C-j` | Move focus down |
| `C-k` | Move focus up |
| `C-l` | Move focus right |

### Buffer Management

| Key | Action |
|-----|--------|
| `Tab` | Next buffer |
| `S-Tab` | Previous buffer |
| `<leader>bd` | Close current buffer |

### Text Manipulation (Visual Mode)

| Key | Action |
|-----|--------|
| `K` | Move selected lines up |
| `J` | Move selected lines down |

### Command Mode

| Key | Action |
|-----|--------|
| `C-a` | Move to start of line |
| `C-e` | Move to end of line |
| `C-f` | Insert current file path |

### Search (Snacks Picker)

| Key | Action |
|-----|--------|
| `<leader>sf` | Search files |
| `<leader>sb` | Browse files (explorer) |
| `<leader><leader>` | Find buffers |
| `<leader>/` | Fuzzy search current buffer |
| `<leader>s/` | Search in open files |
| `<leader>sg` | Search by grep |
| `<leader>sw` | Search current word |
| `<leader>ss` | Select picker |
| `<leader>sd` | Search diagnostics |
| `<leader>sr` | Resume last search |
| `<leader>s.` | Recent files |
| `<leader>sh` | Search help |
| `<leader>sk` | Search keymaps |
| `<leader>sn` | Search Neovim config files |

### LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `<leader>D` | Type definition |
| `<leader>ds` | Document symbols |
| `<leader>ws` | Workspace symbols |

---

## Aerospace (Window Manager)

All Aerospace bindings use `alt-cmd-ctrl` (⌥⌘⌃) as the modifier.

### Layout

| Key | Action |
|-----|--------|
| `⌥⌘⌃ /` | Toggle tiles layout (horizontal/vertical) |
| `⌥⌘⌃ ,` | Toggle accordion layout |
| `⌥⌘⌃ .` | Toggle floating/tiling |

### Focus

| Key | Action |
|-----|--------|
| `⌥⌘⌃ h` | Focus left |
| `⌥⌘⌃ j` | Focus down |
| `⌥⌘⌃ k` | Focus up |
| `⌥⌘⌃ l` | Focus right |

### Move Window

| Key | Action |
|-----|--------|
| `⌥⌘⌃⇧ h` | Move window left |
| `⌥⌘⌃⇧ j` | Move window down |
| `⌥⌘⌃⇧ k` | Move window up |
| `⌥⌘⌃⇧ l` | Move window right |

### Resize

| Key | Action |
|-----|--------|
| `⌥⌘⌃ -` | Shrink window (-50) |
| `⌥⌘⌃ =` | Grow window (+50) |

### Workspaces

| Key | Workspace |
|-----|-----------|
| `⌥⌘⌃ 1` | 1 - Mail & Calendar |
| `⌥⌘⌃ 2` | 2 - Socials (Slack, Discord, WhatsApp) |
| `⌥⌘⌃ 3` | 3 - Work (Jira) |
| `⌥⌘⌃ 4-9` | 4-9 |
| `⌥⌘⌃ b` | B - Browser |
| `⌥⌘⌃ e` | E - External monitor |
| `⌥⌘⌃ f` | F - Finder |
| `⌥⌘⌃ m` | M - Music (Spotify) |
| `⌥⌘⌃ n` | N - Notes (Obsidian) |
| `⌥⌘⌃ t` | T - Terminal (Ghostty) |

### Move Window to Workspace

| Key | Action |
|-----|--------|
| `⌥⌘⌃⇧ 1-9` | Move to workspace 1-9 |
| `⌥⌘⌃⇧ b/e/f/m/n/t` | Move to named workspace |

### Other

| Key | Action |
|-----|--------|
| `⌥⌘⌃ Tab` | Switch to previous workspace |
| `⌥⌘⌃⇧ Tab` | Move workspace to next monitor |
| `⌥⌘⌃⇧ ;` | Enter service mode |

### Service Mode

Enter with `⌥⌘⌃⇧ ;`, exit with `Esc`:

| Key | Action |
|-----|--------|
| `Esc` | Reload config & exit |
| `r` | Reset/flatten workspace |
| `f` | Toggle floating |
| `Backspace` | Close all windows but current |
| `⌥⌘⌃⇧ h/j/k/l` | Join with adjacent window |
