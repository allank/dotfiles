# Bootstrap Script Audit - 2026-01-09

## Idempotency Analysis

### bootstrap.sh
- **Homebrew:** Safe. Checks for existence.
- **Brewfile:** Safe. `brew bundle` handles idempotency.
- **Chezmoi:** **Potential Issue.** `chezmoi init --source ... --apply` might error or be redundant if already initialized. Recommendation: Check if initialized, then just run `apply`.
- **macOS Defaults:** Safe.
- **Hyperkey:** Safe.
- **Fish Shell:** Safe. Checks `/etc/shells`. `chsh` is safe but interactive (password).

### macos-defaults.sh
- Uses `defaults write`. Safe/Idempotent.
- `killall` has `|| true`. Safe.

### hyperkey-defaults.sh
- Uses `defaults write`. Safe/Idempotent.

## Recommendations
1.  Modify `bootstrap.sh` to conditionally run `chezmoi init` only if not already initialized.
2.  Ensure paths are absolute or robustly relative (currently uses `SCRIPT_DIR`, which is good).
