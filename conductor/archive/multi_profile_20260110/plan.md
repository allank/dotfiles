# Track Plan: Multi-Profile Support (Home vs. Work)

## Phase 1: Profile Management Infrastructure [checkpoint: f45da83]
- [x] Task: Define local config strategy (e.g., `local_config.sh` git-ignored in repo root) [7500af7]
- [x] Task: Update `.gitignore` to ignore the local config file [7500af7]
- [x] Task: Update `bootstrap.sh` to check for local config; prompt & create if missing (inputs: home/work) [d29104c]
- [x] Task: Ensure `bootstrap.sh` sources this local config for subsequent runs [d29104c]
- [x] Task: Conductor - User Manual Verification 'Phase 1: Profile Management Infrastructure' (Protocol in workflow.md)

## Phase 2: Dynamic Git Configuration [checkpoint: c5bc2e0]
- [x] Task: Configure `chezmoi` to read the profile from the local config/environment [0c3d3a4]
- [x] Task: Convert `dot_gitconfig` to a chezmoi template (`dot_gitconfig.tmpl`) [a1f29c1]
- [x] Task: Implement conditional logic in `dot_gitconfig.tmpl` for Name, Email, and Provider (GitHub/GitLab) [a1f29c1, 63ec7de]
- [x] Task: Conductor - User Manual Verification 'Phase 2: Dynamic Git Configuration' (Protocol in workflow.md)

## Phase 3: Profile-Aware Package Management [checkpoint: 8778a2d]
- [x] Task: Convert `Brewfile` to a chezmoi template (`Brewfile.tmpl`) managed in `dot_config` or root [61efaf5]
- [x] Task: Implement conditional logic in `Brewfile.tmpl` (Slack vs Discord) based on profile [61efaf5]
- [x] Task: Update `bootstrap.sh` to ensure `chezmoi apply` runs before `brew bundle` (to generate the correct Brewfile) [61efaf5]
- [x] Task: Conductor - User Manual Verification 'Phase 3: Profile-Aware Package Management' (Protocol in workflow.md)
- [ ] Task: Conductor - User Manual Verification 'Phase 3: Profile-Aware Package Management' (Protocol in workflow.md)

## Phase 4: Integration & Cleanup [checkpoint: 6067e62]
- [x] Task: Verify end-to-end flow on current machine ("Home" profile) [3ca41d6]
- [x] Task: Document the "first run" experience and local config mechanism in `README.md` [3ca41d6]
- [x] Task: Conductor - User Manual Verification 'Phase 4: Integration & Cleanup' (Protocol in workflow.md)
