# Initial Concept\nManage macOS configuration using Homebrew, chezmoi, and shell scripts.
# Product Guide - Allan's Dotfiles

## Vision
To provide a robust, reproducible, and highly automated macOS configuration environment. This project aims to transform a fresh macOS installation into a fully functional, personalized development powerhouse with minimal manual intervention.

## Core Goals
- **Total Automation:** Streamline the application of macOS system defaults, window management (Aerospace), and hardware-specific tweaks (Hyperkey) through scripts.
- **Reproducibility:** Ensure a "one-command" setup experience using a `bootstrap.sh` script that leverages Homebrew and `chezmoi`.
- **Portability:** Maintain a consistent environment across multiple personal machines while keeping the configuration modular.

## Target Audience
- **Primary:** Myself, for personal use and machine syncing.
- **Secondary:** macOS power users and developers seeking inspiration or a solid foundation for their own dotfile management.

## Key Features
- **Package Management:** Centralized dependency tracking via a `Brewfile`.
- **Multi-Profile Support:** Seamless switching between Home and Work profiles to manage machine-specific applications and Git identities.
- **Dotfile Orchestration:** Using `chezmoi` for intelligent management of configuration files in `dot_config`.
- **System Hardening:** Automated application of enhanced macOS defaults (keyboard, dock, finder) via `macos-defaults.sh` with support for modern versions (Sonoma/Sequoia).
- **Robust Automation:** Idempotent `bootstrap.sh` with comprehensive logging, error trapping, and colorized feedback.
- **Advanced UI/UX:** Integration of modern tools like Aerospace for tiling window management and Starship for cross-shell prompts.
