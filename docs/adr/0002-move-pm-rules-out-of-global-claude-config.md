# Move PM/vault-specific Claude rules out of dotfiles-managed global config

`dot_claude/rules/` held seven files (`how-i-product.md`, `writing-style.md`, `avoid-ai-patterns.md`, `pm-deliverables.md`, `output-obsidian.md`, `output-gdocs.md`, `output-confluence.md`) that chezmoi deployed to `~/.claude/rules/` on the `work` profile, and `CLAUDE.md.tmpl` auto-imported three of them into every session. All seven are Product Management / Obsidian-vault content — PM persona, deliverable formatting standards, and destination-specific markup for the vault at `~/Documents/Obsidian` — not general-purpose. Being globally deployed meant every Claude Code session on the work profile paid their context cost, including sessions in ordinary coding repos that never touch PM work. The vault's own `CLAUDE.md` already expected a project-local `.agent/rules/` directory for this content; that directory didn't exist, so its pointers were dead links, and the files had drifted into global scope as a workaround. Moved all seven into the vault itself, at a visible `claude/rules/` directory (Obsidian Sync ignores dot-prefixed directories, so a plain `.claude/` inside the vault wouldn't sync — the visible `claude/` folder is symlinked as `.claude` so Claude Code still resolves it at the conventional project-local path), and repointed the vault's `CLAUDE.md` at `.claude/rules/...`.

## Considered Options

Keeping the files in `dot_claude/rules/` but tightening the profile gate further was rejected: profile-gating already existed (`work` vs `home`) and the files still cost context on every work-profile project, coding repos included, since chezmoi has no concept of "this project is the PM vault."

Leaving the files in the dotfiles repo and symlinking the vault's `.claude/rules/` back to `~Dev/dotfiles/dot_claude/rules/` was also rejected: it keeps the source of truth outside the vault, invisible to Obsidian Sync, and reintroduces the same dead-link risk if the dotfiles repo and vault ever diverge across machines.

## Consequences

- `chezmoi apply` no longer deploys anything into `~/.claude/rules/`; the directory stays empty.
- `dot_claude/CLAUDE.md.tmpl` no longer has a `work`-profile branch — the global template is now profile-independent (just the Markdown-output preference).
- `.chezmoiignore` no longer needs the `home`-profile exclusion for `dot_claude/rules` — there's nothing left to conditionally exclude.
- The vault's `CLAUDE.md` is now the source of truth for these seven files, reached at `.claude/rules/<name>.md` (vault-local, synced via the visible `claude/` folder).
- A future genuinely general-purpose (non-PM, non-vault) global Claude rule can still use `dot_claude/rules/` — this ADR retires its current contents, not the mechanism.
