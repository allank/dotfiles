# Product Guidelines - Allan's Dotfiles

## Tone and Style
- **Pragmatic and Concise:** Documentation and comments should be brief and focused on utility. Avoid unnecessary verbosity; explain the "how" only when it isn't obvious from the code.
- **Action-Oriented:** Use imperative language in commits and documentation (e.g., "Add fish alias" instead of "Added a new alias for fish").

## Structure and Organization
- **Modular and Atomic:** Maintain the existing pattern of separating concerns. Use distinct files for macOS defaults, Brewfile packages, and individual application configurations within `dot_config`.
- **Clean Configuration:** Keep configuration files free of commented-out code or unused snippets unless they serve as necessary placeholders for machine-specific overrides.

## Development and Maintenance
- **Safety First:** Scripts that modify system state (like `macos-defaults.sh` or `bootstrap.sh`) must include safety checks or be idempotent. They should ideally be safe to run multiple times without side effects.
- **Latest and Greatest:** Favor the latest stable versions of tools. Rely on automated updates (e.g., `brew upgrade`) to keep the environment current rather than pinning to specific older versions.
- **Verification:** Before committing changes to core configuration files (like `nvim` or `tmux`), verify that they load correctly and do not introduce errors in the shell environment.
