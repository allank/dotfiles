# Keymaps Reference

Quick reference for all custom keybindings across Neovim, Tmux, and Aerospace.

> **Legend**: `<leader>` = Space, `C-` = Ctrl, `S-` = Shift, `M-` = Meta (Option ⌥ on macOS), `alt-cmd-ctrl` = ⌥⌘⌃
> **Note**: ⌥⌘⌃ is remaps to `<CAPS>` for ease of use
---

## Neovim

### General

| Key | Action |
|-----|--------|
| `Esc` | Clear search highlighting |
| `Y` | Yank to end of line |

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
| `<leader>sr` | Resume last search |
| `<leader>s.` | Recent files |
| `<leader>sh` | Search help |
| `<leader>sk` | Search keymaps |
| `<leader>sn` | Search Neovim config files |

### Formatting

| Key | Action |
|-----|--------|
| `<leader>cf` | Format buffer/selection (also runs on save) |

### Editing (mini.nvim)

| Key | Action |
|-----|--------|
| `gc` / `gcc` | Toggle comment (motion / line) |
| `sa` / `sd` / `sr` | Add / delete / replace surround |
| Bracket/quote pairs | Auto-close on insert (mini.pairs) |

---

## Tmux

Prefix is `C-s` (not the tmux default `C-b`). Model: one **tmux session per project**,
one **window per Claude session**, panes split a single Claude session's terminal
(not separate Claude sessions).

```
 SERVER
   │
   ├── SESSION "frontend" ──────────┐
   │     ├── WINDOW 1 "claude"      │  window = one Claude session
   │     │     ├── pane 0 (claude)  │  panes split *within* a Claude session
   │     │     └── pane 1 (shell)   │  (e.g. running tests beside it)
   │     └── WINDOW 2 "claude"      │
   │                                │
   ├── SESSION "backend" ───────────┘   switch sessions: prefix C-j (picker)
   │     └── WINDOW 1 "claude"
   │
   └── SESSION "dotfiles"
         └── WINDOW 1 "claude"

   switch windows: M-n / M-p (no prefix), or prefix n / p
   navigate panes: C-h / C-j / C-k / C-l (no prefix)
```

### Sessions

| Key | Action |
|-----|--------|
| `prefix N` | Create a new session (prompts for a name) |
| `prefix C-j` | Switch sessions/windows (tree picker) |
| `prefix s` | Switch sessions (tmux default picker) |

### Windows (= Claude sessions)

| Key | Action |
|-----|--------|
| `prefix c` | Create a new window (opens in current pane's directory) |
| `M-n` | Next window (no prefix needed) |
| `M-p` | Previous window (no prefix needed) |
| `prefix w` | Switch windows (tmux default picker) |

### Panes (within a window)

| Key | Action |
|-----|--------|
| `prefix %` | Split pane vertically (side by side) |
| `prefix "` | Split pane horizontally (stacked) |
| `C-h` / `C-j` / `C-k` / `C-l` | Move focus left/down/up/right (no prefix) |
| `prefix b` | Break pane out into its own window |

### Scroll & Copy (vi-style copy-mode)

| Key | Action |
|-----|--------|
| Mouse wheel / drag | Scroll into copy-mode; drag selects and copies |
| `prefix [` | Enter copy-mode manually |
| `j` / `k` / `h` / `l` | Move by line/char (in copy-mode) |
| `v` | Begin selection (in copy-mode) |
| `y` | Yank selection to system clipboard |
| `q` | Exit copy-mode |

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
