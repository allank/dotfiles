# Aerospace → OmniWM: the cheat sheet

Notes from migrating a keyboard-driven Aerospace setup (Hyper key, letter workspaces, app-to-workspace rules, external monitor as its own workspace) to [OmniWM](https://omniwm.app). Written against OmniWM **0.8.0**.

**Requirements:** macOS 26+ on Apple Silicon. Install with `brew install --cask omniwm`. **Quit Aerospace first**, because two window managers will fight over your windows.

---

## 1. Concept map

| Aerospace | OmniWM | Notes |
|---|---|---|
| `~/.aerospace.toml` | `~/.config/omniwm/settings.toml` | Live-reloads on save. See [§3](#3-the-config-file-is-strict-read-this-before-editing) before editing. |
| `workspace B` | `switchWorkspace.N` | Workspace names must be **numbers**. See [§2](#2-letter-workspaces). |
| `move-node-to-workspace B` | `moveToWorkspace.N` | Same zero-based numbering. |
| `workspace-back-and-forth` | `workspaceBackAndForth` | Also `workspaceAutoBackAndForth = true`: pressing the current workspace's key goes back. |
| `workspace-to-monitor-force-assignment` | `[workspaces.monitorAssignment]` | `type = "main"`, `"secondary"`, `"tertiary"` or `"specificDisplay"`. |
| `[[on-window-detected]]` → `move-node-to-workspace` | `[[appRules]]` with `assignToWorkspace` | Use the numeric workspace name. |
| `[[on-window-detected]]` → `layout floating` | `[[appRules]]` with `layout = "float"` | |
| `layout tiles` | **Dwindle** layout | Binary split tiling (BSP), like Hyprland. |
| `layout accordion` | Nothing equivalent | Use `toggleFullscreen` (Dwindle) or column widths (Niri). |
| — | **Niri** layout | Columns that scroll sideways. Toggle per workspace with `toggleWorkspaceLayout`. |
| `resize smart` | `resizeFocusedWindow.*` (Dwindle) or `resizeContainerPrimarySpan.*` (Niri) | |
| `flatten-workspace-tree` | `balanceSizes` | |
| `move-workspace-to-monitor --wrap-around next` | `moveWorkspaceToMonitor.left/right/up/down` | **No wrap-around.** Pick the direction your monitor actually sits. |
| Binding modes (`mode service`) | Keyboard modes | Mostly unnecessary because the config live-reloads. |
| Sticky / scratchpad (not supported) | **Scratchpads**, 10 slots | See [§6](#6-scratchpads). |
| — | **Quake terminal** | Embedded Ghostty that uses your Ghostty config. |
| — | Command palette, Overview | See [§8](#8-command-palette-and-overview). |

---

## 2. Letter workspaces

OmniWM rejects non-numeric workspace names. You can still get letter workspaces:

1. Give each letter a number from 10 upwards.
2. Set `displayName` to the letter, which is what the bar and menu bar show.
3. Bind your letter keys to those numbers.

```toml
[[workspaces]]
id = "780FF83F-6534-433B-BA4A-82538E30EC8B"   # any fixed UUID (run `uuidgen`); required
name = "10"
displayName = "B"
layoutType = "default"                        # "default", "niri" or "dwindle"; required
[workspaces.monitorAssignment]
type = "main"
```

**Gotcha: hotkey IDs are zero-based.** Workspace 10 is `switchWorkspace.9`, workspace 1 is `switchWorkspace.0`.

```toml
[[hotkeys]]
id = "switchWorkspace.9"                      # workspace 10 = "B"
binding = "Control+Option+Command+B"

[[hotkeys]]
id = "moveToWorkspace.9"
binding = "Control+Option+Shift+Command+B"
```

**Gotcha: OmniWM's default workspaces 6–9 live on the *secondary* monitor.** If you define your own `[[workspaces]]`, list every one you want and set `monitorAssignment` explicitly.

**External monitor as its own workspace** (Aerospace's `E = ['secondary', 'main']`):

```toml
[[workspaces]]
id = "153337F1-9875-404F-92ED-C49F519988F8"
name = "11"
displayName = "E"
layoutType = "default"
[workspaces.monitorAssignment]
type = "secondary"
```

---

## 3. The config file is strict (read this before editing)

This caused the most trouble.

- **Every section must be present.** If any of about 30 top-level tables is missing, OmniWM rejects the whole file. You can't hand-write a small config the way you can with Aerospace.
- **OmniWM rewrites the file** whenever you change something in its Settings window.
- **`[[hotkeys]]` replaces everything.** Any action you don't list is unassigned. That's useful, because it clears the default Option-key shortcuts, but you must list every shortcut you want.
- An **unknown or duplicate hotkey ID** rejects the whole file.

**Approach that works:**

1. Launch OmniWM once so it writes a complete default `settings.toml`.
2. Keep only *your* changes in a separate file.
3. Merge them in. With chezmoi, a modify template does this. Save it as `dot_config/omniwm/modify_settings.toml`:

```gotemplate
{{- /* chezmoi:modify-template */ -}}
{{- if eq (trim .chezmoi.stdin) "" -}}
{{-   .chezmoi.stdin -}}
{{- else -}}
{{-   $current := fromToml .chezmoi.stdin -}}
{{-   $overlay := fromToml (includeTemplate "omniwm-settings.toml" .) -}}
{{-   toToml (mergeOverwrite $current $overlay) -}}
{{- end -}}
```

Put your settings in `.chezmoitemplates/omniwm-settings.toml`. Tables are merged key by key, and arrays (`workspaces`, `hotkeys`, `appRules`) replace OmniWM's entirely. If OmniWM hasn't been launched yet, the template writes nothing. Apply with `chezmoi apply ~/.config/omniwm/settings.toml`.

The merge never deletes keys. If you remove a setting from your overlay, the old value stays in OmniWM's file until you change it.

Not using chezmoi? Edit the generated file in place, or use the Settings UI and copy the result into your dotfiles.

---

## 4. Hyper key

- **OmniWM's "Hyper" is not Aerospace's.** OmniWM defaults to all four modifiers, ⌃⌥⇧⌘. A Caps Lock remap such as Hyperkey.app usually sends ⌃⌥⌘ (no Shift).
- **Easiest fix:** write explicit modifiers in every binding: `"Control+Option+Command+H"`, and add `Shift` for the "move" variants.
- If something else already produces Hyper, leave `systemHyperTrigger = "None"`. OmniWM can also take over Caps Lock itself (`systemHyperTrigger = "CapsLock"`), which needs Input Monitoring permission.
- **Binding syntax:** modifiers in the order `Control+Option+Shift+Command`, then the key.
  - Letters and digits as-is: `H`, `1`.
  - Named keys: `Comma`, `Period`, `Slash`, `Minus`, `Equal`, `Grave` (backtick), `Tab`, `Space`, `Left Arrow`.

---

## 5. Layouts: what replaces tiles and accordion

| Want | Dwindle | Niri |
|---|---|---|
| One window fills the screen | `toggleFullscreen` | `toggleContainerFullPrimarySpan` (or `toggleFullscreen`) |
| Two windows side by side | Default behaviour | `cycleSizeForward`: column width 1/3 → 1/2 → 2/3 |
| Scroll sideways | n/a | Focus left/right, 3-finger swipe, or ⌥⇧ + scroll wheel |
| Accordion-ish | — | `toggleColumnTabbed` (stacks a column as tabs) |
| Switch layout | `toggleWorkspaceLayout` | `toggleWorkspaceLayout` |

Set the default with `[general] defaultLayoutType = "dwindle"` (or `"niri"`). Workspaces with `layoutType = "default"` follow it.

Mapping suggestion that kept Aerospace muscle memory:

| Key | Action |
|---|---|
| Hyper+/ | `toggleWorkspaceLayout` |
| Hyper+, | `toggleFullscreen` |
| Hyper+. | `cycleSizeForward` |

---

## 6. Scratchpads

| Action | What it does |
|---|---|
| `toggleScratchpad.N` | Shows or hides slot N |
| `assignFocusedWindowToScratchpad.N` | Puts the focused window in slot N; press again on it to send it back to the layout |

**Gotchas:**
- **Toggling doesn't add a window.** To add one, focus it, press the *assign* key, then use the *toggle* key from then on.
- **Assignments are lost when OmniWM restarts.** App rules with `scratchpad = 1` fix that, but they're only in unreleased main builds, not in 0.8.0.
- Some apps float by default (Calculator, for example). They can still go in a scratchpad.

---

## 7. Floating windows: the trap

`toggleFocusedWindowFloating` floats a window. The catch:

- **Directional focus (Hyper+H/J/K/L) only moves between *tiled* windows.** Once a window floats, you can't reach it from the keyboard to un-float it, so it feels stuck.
- **`toggleFloatingFocus`** fixes that. It jumps focus to the floating layer, and pressing it again returns you.

What worked:
- **Don't bind a "float this window" key.** Between Niri, Dwindle and fullscreen you rarely need it.
- **Float only fixed-size windows through app rules**, such as Preview and preference panes.
- **Bind `toggleFloatingFocus`** so you can reach them.

```toml
[[appRules]]
bundleId = "com.apple.Preview"
layout = "float"
```

Windows that were open when you change a float rule keep their old state until you reopen them.

---

## 8. Command palette and Overview

**Command palette** (`openCommandPalette`, default ⌃⌥Space). Modes switch with ⌘1–6:

| Key | Mode | What it does |
|---|---|---|
| ⌘1 | Windows | Fuzzy-find any window. Shift+Enter pulls it onto your current workspace. |
| ⌘2 | Menu | Search the current app's menus |
| ⌘3 | Clipboard | Clipboard history; off by default |
| ⌘4 | Commands | Run any OmniWM action, including unbound ones |
| ⌘5 | Launcher | Open apps, run saved scripts |
| ⌘6 | Files | File search |

If you already use Alfred or Raycast, keep clipboard history off: `[clipboard] historyEnabled = false`.

**Overview** (`toggleOverview`, default ⌥⇧O) shows every window on every workspace as thumbnails.
- Type to filter, then Enter to focus. Cmd+W closes the selected window.
- **Your move-to-workspace keys act on the selected thumbnail**, which makes Overview a keyboard way to sort windows.
- Needs **Screen Recording** permission for thumbnails.

---

## 9. Look and feel

| Want | Config |
|---|---|
| Thin, non-blue focus border | `[borders] width = 1.0`, plus `[borders.color]` with `red`/`green`/`blue`/`alpha` from 0 to 1. `enabled = false` removes it. |
| Aerospace-style menu bar: just the current workspace | `[workspaceBar] enabled = false`, then `[statusBar] showWorkspaceName = true` and `showIcon = false`. Shows only the *focused* monitor's workspace. |
| Keep the bar, just smaller | `[workspaceBar] hideEmptyWorkspaces = true`, `deduplicateAppIcons = true`, `autoHide = true`. App icons can't be turned off. |
| Gaps like Aerospace's 2/0 | `[gaps] size = 2.0` and `[gaps.outer]` with `top`/`bottom`/`left`/`right` set to `0.0` |
| Translucent Quake terminal | `[quakeTerminal] opacity = 0.9`. This is set in OmniWM, not Ghostty. |

---

## 10. Quick checklist

1. Quit Aerospace. Run `brew install --cask omniwm`, launch it, and grant Accessibility permission.
2. Grant Screen Recording permission if you want Overview thumbnails.
3. Let OmniWM write its default `settings.toml`, then merge your changes in ([§3](#3-the-config-file-is-strict-read-this-before-editing)).
4. Define *all* workspaces, with letters as `displayName` on numbers 10+ ([§2](#2-letter-workspaces)).
5. List *every* hotkey you want with explicit modifiers ([§4](#4-hyper-key)), remembering the zero-based workspace IDs.
6. Port `on-window-detected` rules to `[[appRules]]`, and float only fixed-size apps ([§7](#7-floating-windows-the-trap)).
7. Bind the Quake terminal and a scratchpad pair (toggle + assign).
