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
~/.config/tspace/ghostty.applescript # Ghostty: list ttys, focus a tty, open a window
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
| `~/.local/bin/tspace` | `dot_local/bin/executable_tspace` |
| `~/.config/tspace/ghostty.applescript` | `dot_config/tspace/ghostty.applescript` |
| `~/.config/swiftbar/tmux-bar.30s.sh` | `dot_config/swiftbar/executable_tmux-bar.30s.sh` (SwiftBar's plugin folder is set in `macos-defaults.sh`; the cask is in `Brewfile.tmpl`) |

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

**done becomes idle once seen**, as in Herdr: a tmux hook turns `done` into `idle` when the pane gains focus, and refreshes the menu (section 4).

**One notification per blocked transition.** When the status changes into `blocked` from anything else, the hook posts a macOS notification titled with the space and tab (`My Space / 2`) and plays the Glass sound. Clicking it runs `tspace focus` on that pane. This needs `terminal-notifier` (in the Brewfile); without it the hook falls back to `osascript`, whose notifications open Script Editor when clicked. A repeated `blocked` posts nothing. The notification is skipped when a focused tmux client is already showing that pane, since the person is looking at it.

**Other agents:** panes whose agent has no hooks show no status, the same as plain shells. Screen-scraping with `capture-pane` is a later option.

## 4. tmux configuration

```tmux
set -g base-index 1
setw -g pane-base-index 1
set -g focus-events on
set -g set-titles on
set -g set-titles-string "tspace: #{?@space_name,#{@space_name},#S} / #{window_index}"
# done -> idle when the pane is looked at, and refresh the menu
set-hook -g pane-focus-in 'if -F "#{==:#{@agent_status},done}" "set -p @agent_status idle ; run-shell -b \"open -g swiftbar://refreshplugin?name=tmux-bar >/dev/null 2>&1\""'
```

These are added to the existing `tmux.conf`, which keeps its prefix and keys. Sessions created outside `tspace` have no `@space_name`, so the title falls back to the session name.

## 5. `tspace`

| `tspace` | tmux underneath | Replaces |
|---|---|---|
| `ls [--json]` | one `list-panes -a -F` call | `hc ls --json` |
| `space new --name N [--folder F] [--argv '[...]'] [--task T]` | `new-session -d -s <slug> -c F`, then set `@space_name` and `@space_folder` | `herdr-app do space.new` |
| `tab new [--space S] [--name N] [--folder F] [--argv '[...]'] [--task T] [--focus false]` | `new-window -t <space> -c <folder>` | `herdr-app do tab.new` |
| `focus <terminal> [--one-window-per-space]` | `switch-client`, `select-window`, `select-pane`, then Ghostty AppleScript | `herdr-app do agent.focus` |
| `send [--force] [--if STATUS] <terminal> <text>` | `load-buffer`, `paste-buffer -p`, then `send-keys Enter` | `hc send` |
| `read [--lines N] <terminal>` | `capture-pane -p -J`, with `-S -N` for history | `hc read` |

### `space new` and `tab new`

- They print what they made as `{"space":"$3","tab":"@7","terminal":"%12"}`, and errors as `{"error":"..."}` with exit 1, as `herdr-app do` does.
- `--argv` is a JSON array of strings, e.g. `'["claude"]'`. With no `--argv` the tab is a plain shell.
- `--task` is the agent's first message, passed as its last argument. That is how `claude "<task>"` starts with a prompt. `--task` needs `--argv`.
- The agent runs as `fish -lic '<argv> <task>'`, with no `exec fish` at the end. The login shell's `PATH` applies, and quitting the agent closes its pane. When the last pane of a tab closes, the tab goes; when the last tab closes, the space goes. Herdr differs here: it leaves a shell prompt behind.
- `--folder` defaults to the current directory for `space new`, and to the space's folder for `tab new`.
- The session name is a slug of `--name`, because tmux forbids `.` and `:`. A clash gets `-2`, `-3` and so on. The display name goes in `@space_name`.
- `--space` takes a session id (`$3`), a session name or a display name. Inside tmux it defaults to the current space.
- An agent tab is named after the agent (`claude`) unless `--name` is given. `--focus false` makes the tab without selecting it.

### `focus`

Ghostty's AppleScript dictionary (1.4) gives each terminal a `tty`, and tmux knows each client's tty. Matching the two finds the right Ghostty terminal with no state file.

**Default: one Ghostty window, like the Herdr app.** Showing an agent switches that window's tmux client to the agent's space, tab and pane.

1. Find the pane's session and window. An unknown pane is an error.
2. List the tmux clients running in Ghostty, most recently active first. Clients in other terminal apps are left out, because Ghostty can't bring them to the front.
3. Use a client already on the pane's space. Otherwise use any Ghostty client and `switch-client` it to the pane.
4. If there is no Ghostty client, open a Ghostty window whose command is `tmux attach -t <pane>`, and wait up to 5 seconds for it to attach.
5. `select-window` and `select-pane` on the target, which also turns `done` into `idle`.
6. Focus the Ghostty terminal with that client's tty, and activate Ghostty.

It prints `{"terminal":"%12","client":"/dev/ttys003"}`.

**`--one-window-per-space`** (or `TSPACE_ONE_WINDOW_PER_SPACE=1`): step 3 only reuses a client already on the pane's space, so each space gets its own Ghostty window.

Closing a Ghostty window only detaches its tmux client; every pane keeps running. Running `focus` from inside tmux never nests tmux, because it only switches clients or opens a new Ghostty window. The Ghostty window title follows `set-titles-string`, e.g. `tspace: My Space / 2`.

The first AppleScript call from a new app (a terminal, or SwiftBar) asks for macOS Automation permission to control Ghostty.

### `send` and `read`

`send` pastes the text as one bracketed paste, so multi-line text arrives as one message, then presses Enter. It prints `{"sent":true,"terminal":"%12","status":"idle"}` with the status before the send.

- It refuses an agent that is `blocked` unless `--force` is given, so a message can't answer a permission prompt by accident.
- `--if <status>` sends only when the status is exactly that.
- Unlike `hc send`, it doesn't wait for a person's unfinished draft, and it has no `--wait`.

A report-back line from a worker to its orchestrator is:

```sh
tspace send %3 "Worker finished: <what changed; anything left>"
```

`read` prints the pane's screen; `--lines N` adds N lines of history above it. Full-screen programs such as Claude Code keep no tmux history, so for them `read` gives the screen only.

### `ls`

`tspace ls --json` emits the same shape as `hc ls --json`, so a menu plugin written for `hc` reads it unchanged:

```json
{"terminals":[{"address":"%12","agent":"claude-code","cwd":"/Users/me/Dev/x",
  "status":"blocked","where":"My Space / 2","space":"$3","tab":"@7"}]}
```

- It comes from one `list-panes -a -F` call.
- `status` is left out for panes with no `@agent_status` (plain shells), as `hc` does.
- `agent` falls back to the pane's running command (e.g. `fish`), as `hc` does.
- `where` falls back to the session name when there is no `@space_name`.
- `space` and `tab` are tmux's stable session and window ids, for grouping.
- With no tmux server running it prints nothing on stdout and exits 1, which a plugin reads as "server down".

Plain `tspace ls` prints the same panes as tab-separated lines. `TSPACE_SOCKET=<name>` points it at a server started with `tmux -L <name>`, for tests.

## 6. Menu

A SwiftBar plugin, `tmux-bar.30s.sh`. It polls every 30 seconds, and the agent hook and the tmux focus hook push a refresh when a status changes.

**Title**, most urgent first:

| State | Shows |
|---|---|
| Any blocked | Red `exclamationmark.bubble.fill` with `N!`, plus `M✓` if any are done |
| Done, none blocked | `checkmark.bubble.fill` with `M✓` |
| Only working | `ellipsis.bubble` |
| All idle, or no agents | `bubble` |
| No tmux server | Grey `terminal` |

**Dropdown:** one section per space, ordered by its most urgent agent (blocked > done > working > idle), then by name. Rows read `tab · agent`. Agents have a status symbol that differs in shape as well as colour: red exclamation for blocked, green check for done, yellow ellipsis for working, grey circle for idle. Plain shells are listed under their space with no symbol. Clicking a row runs `tspace focus` on its pane.

**Footer:** "New space…" asks for a name and a folder, runs `tspace space new` and shows the new space. "Open Ghostty" opens Ghostty.

## 7. Build order

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
