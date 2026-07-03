# Commands overview

Skills are available globally in any Claude Code session. Core skills live in `~/.claude/skills/`
(deployed from `~/dev/mystrap/dotfiles/claude/.claude/skills/`).

> Planning (tasks, projects, ideas, daily overview) now lives with the **Hermes Agent**, not in this
> vault. The old planning commands (`/refresh-planning`, `/new-task`, `/new-idea`, `/process-inbox`,
> `/review-ideas`) and the `librarian` agent have been retired.

## Skills

| Skill | When to use |
|-------|-------------|
| `/plan` | Before starting complex work — think through the approach first |
| `/review-text` | Reviewing/proofing written text (Dutch or English), in Jan's voice |
| `/review-docs` | Audit docs structure for broken refs, missing index entries, overgrown files |
| `/evaluate` | Reflect on completed work and improve instructions |
| `md-to-pdf` | Convert a .md to PDF (python-markdown + WeasyPrint) |
| `skill-creator` | Create or update a Claude Code skill |
| `wiki-contribute` | Add source material to the shared Hermes/Claude wiki (`raw/` + `[KANBAN]` draft) |
| `wiki-lint` | Check shared-wiki health (stale refs, orphans, missing cross-links) |
| `webapp` | Work on the lichtbron-admin penningmeester webapp |

## Agents

| Agent | When to use |
|-------|-------------|
| `homelab-admin` | Any homelab task — SSHes into the Proxmox server, runs pct/docker/systemctl/logs |
| `auto-committer` | Invoked on commit — stages, commits, pushes (triggered by CLAUDE.md rule, not a user command) |
| `omarchy-guru` | Desktop/WM config changes (Hyprland, Waybar, terminals, omarchy-*) |
| `android-builder` | Android app dev (Gradle, Jetpack Compose, adb) |

## Built-in hosted skills

`update-config`, `keybindings-help`, `simplify`, `loop`, `schedule`, `claude-api`, `init`, `review`,
`security-review` are always available — run `/help` in Claude Code for the current list.
