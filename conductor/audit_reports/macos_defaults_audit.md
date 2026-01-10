# macOS Defaults Audit - 2026-01-09

## Current Coverage
- Dock: Orientation, Tile size, Bottom-right hot corner.
- Finder: ShowPathbar, ShowStatusBar.
- Trackpad: RightClick.

## Identified Enhancements for Modern macOS (Sonoma/Sequoia)

### Global / Keyboard
- Set faster key repeat rate (NSGlobalDomain KeyRepeat/InitialKeyRepeat).
- Disable automatic capitalization and smart substitutions (quotes, dashes, periods).

### Finder
- Show all filename extensions (AppleShowAllExtensions).
- Keep folders on top when sorting by name (_FXSortFoldersFirst).
- Avoid creating .DS_Store files on network volumes (DSDontWriteNetworkStores).

### Dock
- Enable autohide and remove the delay.
- Minimize windows into application icon (minimize-to-application).

### Robustness
- Automatically quit System Settings before applying defaults to prevent overrides.
- Add SystemUIServer to the killall list.
