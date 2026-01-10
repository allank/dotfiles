# Track Spec: Multi-Profile Support (Home vs. Work)

## Overview
This track introduces the ability to manage different machine configurations (specifically "Home" and "Work") within a single dotfiles repository. It aims to eliminate configuration drift while allowing for machine-specific differences in application sets (Homebrew) and identity (Git config).

## Functional Requirements
1.  **Persistent Profile Selection:**
    -   Introduce a mechanism to set and persist a "profile" (e.g., `home`, `work`).
    -   The selection should be made during the `bootstrap.sh` process if not already set.
    -   The profile must be stored in a local, git-ignored configuration file (e.g., `local_config.sh`) within the repo.

2.  **Profile-Aware Package Management:**
    -   Modify the Homebrew installation process to handle profile-specific applications.
    -   "Work" profile: Include `Slack`, exclude `Discord`.
    -   "Home" profile: Include `Discord`, exclude `Slack`.

3.  **Dynamic Git Configuration:**
    -   Utilize `chezmoi` templates for `dot_gitconfig`.
    -   Differentiate Git identities (name/email) and service-specific configurations (GitHub vs. GitLab) based on the active profile.

4.  **Integrated Tooling:**
    -   Ensure `bootstrap.sh`, `chezmoi apply`, and other helper scripts respect the active profile.

## Non-Functional Requirements
-   **Idempotency:** Re-running scripts should not overwrite or conflict with the existing profile unless explicitly requested.
-   **Simplicity:** The logic for switching profiles should be easy to understand and maintain.

## Acceptance Criteria
-   The `bootstrap.sh` script prompts for or accepts a profile flag.
-   Setting the profile to `work` results in:
    -   Slack being installed via Brew.
    -   Discord NOT being installed via Brew.
    -   Git config reflecting the work identity (GitLab/Work email).
-   Setting the profile to `home` results in:
    -   Discord being installed via Brew.
    -   Slack NOT being installed via Brew.
    -   Git config reflecting the home identity (GitHub/Home email).
-   The selected profile persists locally and is ignored by Git.

## Out of Scope
-   Automated profile detection via hostname (manual selection is preferred).
-   Managing secrets/keys within the repo.
