# tmux-bar

Herdr-style spaces, tabs and agent status built from tmux, Ghostty, SwiftBar and Claude Code hooks. No Herdr core and no Herdr app.

**Non-goals:** splits managed from the menu, a sidebar window, persistence across reboots (tmux-resurrect can come later), anything remote.

**Local only:** tmux talks over a local Unix socket, nothing calls ssh, and nothing listens on the network.

## 1. Mapping Herdr to tmux

| Herdr | tmux | Notes |
|---|---|---|
| core (`hc`) | tmux server (default socket) | Terminals outlive the Ghostty window |
| space | session | `@space_name` holds the display name; the session name is a slug (tmux forbids `.` and `:`) |
| space folder | session start directory (`new-session -c`) | Also stored as `@space_folder` |
| tab | window | `base-index 1`, so tabs number from 1 |
| terminal | pane | Addressed by pane id, e.g. `%12`. A new session or window starts with one pane; splits add more |
| sub-agent with no pane (`hc run`) | none | Every tmux process lives in a pane. Helpers go in a background window named `helpers` in the parent's session |
| agent status (OSC 7501) | pane option `@agent_status` | Set by agent hooks (section 3) |
| `where` label | `#{@space_name} / #{window_index}` | Computed, so nothing to keep in sync |
| Herdr app window | one Ghostty window running `tmux attach` | |

## 2. Components

```
~/.local/bin/tspace                  # CLI: the herdr verbs, on tmux
~/.config/swiftbar/tmux-bar.30s.sh   # SwiftBar plugin (30s poll, plus push refresh)
~/.config/tspace/focus.applescript   # Ghostty: focus the terminal with a given tty
~/.claude/hooks/tmux-agent-state.sh  # Claude Code hook: sets @agent_status
~/.config/tmux/tmux.conf             # the options and hooks in section 4
```

Everything is shell plus `jq`, with absolute paths, because SwiftBar runs plugins with a bare `PATH`.

In this repo:

| Target | Source |
|---|---|
| `~/.claude/hooks/tmux-agent-state.sh` | `dot_claude/hooks/executable_tmux-agent-state.sh` |
| hook entries in `~/.claude/settings.json` | `dot_claude/modify_private_settings.json` (a chezmoi modify script: it adds the tmux-bar hooks and leaves every other setting and hook alone) |
| `~/.config/tmux/tmux.conf` | `dot_config/tmux/tmux.conf` |

## 3. Agent status

Herdr gets status from programs reporting OSC 7501. Here each agent's hooks write a tmux pane option instead.

**Claude Code** hooks, all calling `tmux-agent-state.sh <status>`:

| Hook event | Status |
|---|---|
| `UserPromptSubmit`, `PreToolUse`, `PostToolUse` | `working` |
| `Notification` with matcher `permission_prompt` or `elicitation_dialog` | `blocked` |
| `Stop` | `done` |
| `SessionEnd` | unset |

`PostToolUse` is there so an approved permission prompt goes back to `working` straight away; otherwise the pane would read `blocked` until the next tool call.

The script is a no-op outside tmux (no `$TMUX_PANE`). Alongside `@agent_status` it sets `@agent claude-code`, and it asks SwiftBar to refresh the `tmux-bar` plugin when SwiftBar is installed, so the menu changes at once rather than on the next poll.

**done becomes idle once seen**, as in Herdr: a tmux hook turns `done` into `idle` when the pane gains focus (section 4).

**Other agents:** panes whose agent has no hooks show no status, the same as plain shells. Screen-scraping with `capture-pane` is a later option.

## 4. tmux configuration

```tmux
set -g base-index 1
setw -g pane-base-index 1
set -g focus-events on
set -g set-titles on
set -g set-titles-string "tspace: #{?@space_name,#{@space_name},#S} / #{window_index}"
# done -> idle when the pane is looked at
set-hook -g pane-focus-in 'if -F "#{==:#{@agent_status},done}" "set -p @agent_status idle"'
```

These are added to the existing `tmux.conf`, which keeps its prefix and keys. Sessions created outside `tspace` have no `@space_name`, so the title falls back to the session name.

## 5. Build order

| # | Deliverable | Acceptance |
|---|---|---|
| 0 | Environment checks | tmux 3.8; Ghostty's AppleScript `tty` property works, so a tmux client tty can be matched to a Ghostty terminal |
| 1 | Hook and tmux config | A Claude Code pane shows `working`, `blocked`, `done` in `tmux show -p @agent_status`; focusing it turns `done` into `idle` |
| 2 | `tspace ls --json` | The menu plugin, pointed at it, shows correct counts |
| 3 | `tspace space new` and `tab new` | Spaces open with a running agent and its task |
| 4 | `tspace focus` | A click lands in the right pane; a second click on another space reuses the same Ghostty window |
| 5 | Grouped menu and notifications | One notification per blocked transition |
| 6 | `send` and `read` | A report-back line works with `tspace send` |

**Done when:** a full working day runs on tmux-bar with no Herdr.
