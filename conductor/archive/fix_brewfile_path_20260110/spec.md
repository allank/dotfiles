# Track Spec: Fix Brewfile Path Mismatch

## Overview
The `dot_Brewfile.tmpl` generates a hidden file `~/.Brewfile`. However, `bootstrap.sh` and `README.md` reference `~/Brewfile` (visible). This causes the bootstrap process and manual updates to fail.

## Functional Requirements
1.  **Rename Template:** Change `dot_Brewfile.tmpl` to `Brewfile.tmpl` to ensure the generated file is visible (`~/Brewfile`).
2.  **Update Documentation:** Ensure `README.md` references the correct template name.

## Acceptance Criteria
-   `chezmoi apply` generates `~/Brewfile`.
-   `bootstrap.sh` runs `brew bundle --file="$HOME/Brewfile"` successfully.
