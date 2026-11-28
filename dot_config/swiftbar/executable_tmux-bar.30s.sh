#!/usr/bin/env bash
# <swiftbar.title>tmux-bar</swiftbar.title>
# <swiftbar.desc>Agent status in tmux spaces, from tspace ls --json. See docs/tmux-bar.md in the dotfiles repo.</swiftbar.desc>
# <swiftbar.hideAbout>true</swiftbar.hideAbout>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>
# <swiftbar.hideLastUpdated>true</swiftbar.hideLastUpdated>
# <swiftbar.hideDisablePlugin>true</swiftbar.hideDisablePlugin>

# SwiftBar runs plugins with a bare PATH. Polls every 30s; the Claude Code hook
# and the tmux focus hook push a refresh when a status changes.
export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/bin:/bin"
self="$0"

case "${1:-}" in
  # Clicked row: the pane id comes without its % so SwiftBar passes it untouched.
  focus)
    tspace focus "%$2" >/dev/null
    exit 0 ;;
  # "New space…": ask for a name and a folder, make the space, show it.
  new-space)
    name=$(osascript -e 'text returned of (display dialog "Name for the new space:" default answer "" with title "New space")') || exit 0
    [ -n "$name" ] || exit 0
    folder=$(osascript - "$name" <<'OSA'
on run argv
	POSIX path of (choose folder with prompt "Folder for " & (item 1 of argv) & ":" default location (path to home folder))
end run
OSA
) || exit 0
    made=$(tspace space new --name "$name" --folder "$folder")
    terminal=$(jq -r '.terminal // empty' <<<"$made")
    if [ -n "$terminal" ]; then
      tspace focus "$terminal" >/dev/null
    else
      msg=$(jq -r '.error // "could not make the space"' <<<"$made")
      osascript - "$msg" <<'OSA'
on run argv
	display alert "New space failed" message (item 1 of argv)
end run
OSA
    fi
    exit 0 ;;
esac

footer() {
  echo "---"
  echo "New space… | bash=$self param1=new-space terminal=false refresh=true"
  echo "Open Ghostty | bash=/usr/bin/open param1=-a param2=Ghostty terminal=false"
}

if ! json=$(tspace ls --json 2>/dev/null); then
  echo "| sfimage=terminal sfcolor=gray"
  echo "---"
  echo "No tmux server running | color=gray"
  footer
  exit 0
fi

jq -r --arg self "$self" '
  def rank: {"blocked": 0, "done": 1, "working": 2, "idle": 3}[.status // ""] // 4;
  def icon: {"blocked": "exclamationmark.circle.fill sfcolor=#ff6188",
             "done": "checkmark.circle.fill sfcolor=#a9dc76",
             "working": "ellipsis.circle.fill sfcolor=#ffd866",
             "idle": "circle sfcolor=#939293"}[.status];
  def safe: gsub("\\|"; "¦");
  def count($s): [.[] | select(.status == $s)] | length;

  .terminals as $all
  | ($all | count("blocked")) as $blocked
  | ($all | count("done")) as $done
  | ($all | count("working")) as $working

  # Title: most urgent first.
  | (if $blocked > 0 then
       ([("\($blocked)!"), (if $done > 0 then "\($done)✓" else empty end)] | join(" "))
       + " | sfimage=exclamationmark.bubble.fill sfcolor=#ff6188"
     elif $done > 0 then "\($done)✓ | sfimage=checkmark.bubble.fill"
     elif $working > 0 then "| sfimage=ellipsis.bubble"
     else "| sfimage=bubble" end),

  # One section per space, ordered by its most urgent agent, then by name.
  ($all
   | map(. + {tabn: (.where | capture(" / (?<n>[0-9]+)$").n // "0" | tonumber),
              sname: (.where | sub(" / [0-9]+$"; ""))})
   | group_by(.space)
   | map({name: .[0].sname, rank: (map(rank) | min), panes: sort_by(.tabn, .address)})
   | sort_by(.rank, (.name | ascii_downcase))
   | .[]
   | "---",
     "\(.name | safe) | size=12 color=gray",
     (.panes[]
      | "\(.tabn) · \(.agent | safe) | bash=\($self) param1=focus param2=\(.address | ltrimstr("%")) terminal=false refresh=true"
        + (if .status then " sfimage=\(icon)" else "" end)))
' <<<"$json"
footer
