# Skipping Gatekeeper quarantine on Homebrew cask installs

**Decision:** Won't fix. `bootstrap.sh` will not attempt to prevent Homebrew from quarantining cask installs.

**Reason:** The originally proposed fix — `HOMEBREW_CASK_OPTS=--no-quarantine` — doesn't work on current Homebrew. Investigation of the installed Homebrew (v6.0.x) source confirmed:

- `HOMEBREW_CASK_OPTS`'s own documented option list is `--*dir` options, `--language`, `--require-sha`, `--no-binaries` — no quarantine-related flag.
- The actual quarantine call (`Cask::Quarantine.cask!`, `extend/os/mac/cask/quarantine.rb`) is unconditional — it applies quarantine via a direct macOS FFI call whenever `xattr` is available, with no option anywhere in the cask install/download path to skip it.
- Empirically, unrecognized flags in `HOMEBREW_CASK_OPTS` are silently ignored rather than erroring, so setting `--no-quarantine` would be a silent no-op — it would look like a fix without doing anything.

`--no-quarantine` was a real flag in the old, pre-2019 standalone Homebrew Cask, but it was removed when Cask was merged into Homebrew core.

The maintainer considered a scoped alternative (strip `com.apple.quarantine` only from the specific casks a given bootstrap run just installed, not a blanket sweep of every installed app) but decided the one-time per-app Gatekeeper prompt is an acceptable cost, rather than have bootstrap remove quarantine attributes at all — including on a work machine where any quarantine-attribute removal is a plausible trigger for security tooling.

**Prior requests:**
- allank/dotfiles#3
