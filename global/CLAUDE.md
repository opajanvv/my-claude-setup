# Global rules

## Working style
- Trust Jan's expertise; ask rather than assume wrong
- Work in small chunks; high-level structure first
- Prefer minimal solutions; don't create plugins when a simple hook/script will do
- Prefer tool-agnostic config (CLAUDE.md) over tool-specific features (.claude/rules/) for compatibility with other AI tools
- Skip obvious confirmations (commit after changes, mark done after completing)
- Test proactively: when implementing changes, suggest or create test cases before declaring work done. For scripts, consider: test fixtures, mock data, or temporary test resources.
- Use task tracking for 5+ steps or complex dependencies; skip for straightforward sequential work
- Clean up temp files when done
- Read project README and CLAUDE.md first in new projects
- When creating files for other agents (specs, plans, todos), be specific and unambiguous. Resolve all thinking before writing. These files must be executable by a cheaper model.
- When implementing a plan that contains factual claims about existing workflows or processes, verify those claims against source documentation before writing content.
- Verify CLI flag names and syntax before giving Jan a command to run. Check `--help` or the tool's docs instead of citing from memory.
- Some commands require an interactive terminal and cannot run via the `!` prefix (which gets EOF on stdin/tty prompts). Tell Jan to run these directly: OAuth browser flows (`rclone config reconnect`), passphrase prompts (`age -p`), and any tool that reads from `/dev/tty`.
- Create scripts in `~/dev/mystrap/dotfiles/shell/.local/bin/`, not `~/.local/bin/` (symlinks go in `~/.local/bin/`)

## Communication
Be direct and natural. Avoid:
- Chatbot phrases ("Of course!", "Certainly!", "I hope this helps")
- Emojis, em dashes, title case headers, curly quotes
- Placeholder text, hallucinated facts
- Knowledge disclaimers ("As of [date]...")

Ask rather than guess. Cite sources when researching frameworks. When Jan drops an argument or direction, accept it — don't re-pitch it.

Don't tell Jan something works until you've observed it working. Distinguish "should work" from "verified working", and verify before declaring success.

## Markdown files
Use "Jan" and "Claude" instead of pronouns to avoid ambiguity.

## Context on-demand
This CLAUDE.md is intentionally concise. For detailed knowledge:
- Read `~/.claude/llm-context/index.md` to see available context (routing into the shared wiki)
- Follow links only when relevant to the current task
- Shared wiki (co-maintained with the Hermes Agent, synced via Dropbox) at `~/Dropbox/knowledge/wiki/{tech,penningmeester,personal}/`: the single source of truth for Jan's knowledge — homelab/dev/infra/AI, church/finance, and personal/background. See the "Shared wiki" section in `llm-context/index.md`. Hermes authors the pages; Claude reads them and contributes only by dropping source material into `wiki/<domain>/raw/` (use the `wiki-contribute` skill).

## Where things live
The `~/Cloud/janvv/life/` vault has been fully retired. Now:
- **Knowledge** → the shared wiki (`~/Dropbox/knowledge/wiki/`, see Context on-demand).
- **Claude on-demand context** → `~/.claude/llm-context/` (routing + a few meta files).
- **Claude memory** → `~/Dropbox/claude-memory/` (Dropbox-synced across machines; symlinked from `~/.claude/projects/*/memory`).
- **Planning** (tasks, projects, ideas, daily overview) → managed by the **Hermes Agent**, not here.

## CLAUDE.md map

At session start, identify where the work belongs. If the task fits a specific project below, refuse and say: "This belongs in `<path>` — exit this session and open Claude Code there first."

| Path | Purpose |
|---|---|
| `~/Dropbox/GDrive/levensverhaal/` | Levensverhaal Probus presentation |
| `~/Dropbox/GDrive/Documents/route-retraite/` | Route retraite project |
| `~/dev/mystrap/` | Dotfiles and bootstrap system (stow) |
| `~/dev/janvv.nl/` | Personal website (Grav CMS, opa.janvv.nl) |
| `~/dev/penningmeester/` | Church treasurer app (Dutch) |
| `~/dev/probus/` | Probus name-learning Android app |
| `~/dev/homelab-lxc-base/` | LXC container bootstrap scripts |
| `~/dev/opajan-setup/` | opajan server setup |
| `~/dev/my-claude-setup/` | Read-only mirror of Claude config (sync.sh copies live → mirror) |

## External integrations
- **Mystrap**: `~/dev/mystrap` is the dotfiles repository. Uses stow, so scripts go in `dotfiles/shell/.local/bin/`. Skills live in `dotfiles/claude/.claude/skills/` and are tracked in this repo — commit skill changes via mystrap.
- **Calendar**: `~/.local/bin/calendar-today` fetches Google Calendar events (Google API setup is in the shared wiki: `tech/concepts/google-api-access`)
- **Homelab**: use the `homelab-admin` agent for server operations; source configs in `~/dev/homelab-docker/`

## Git commits
- Never run git commit directly. Always use the auto-committer agent via the Task tool.
- Only commit when the user explicitly asks, or when "commit" is clearly part of the requested task.
- If no git repository exists in the current directory, do nothing and inform the user.
- Before committing credential files (API keys, OAuth configs, tokens), check repo visibility with `gh repo view --json isPrivate`. Only commit credentials to private repos.
- When spawning the auto-committer for a repo that isn't the current directory, always state the repo path explicitly in the prompt ("the repo is at /path — cd there first").

## Process lookups
- Use `pgrep -ia` (case-insensitive) or `ps aux | grep -i` when process name case is uncertain. `pgrep` is case-sensitive by default.

## Arch Linux notes
- FUSE mounts use `fuse3`, not `fuse2`. The unmount command is `/usr/bin/fusermount3 -uz <path>`, not `fusermount`. Use this in any systemd `ExecStop=` for rclone mount or other FUSE services.

## systemd service types
- Before using `Type=forking`, verify the binary actually forks (parent spawns child, then exits). Scripts that use `exec` replace the process rather than forking — `Type=simple` is correct for those. `Type=forking` on an exec-based binary causes a 90-second timeout because the parent never exits.

## Desktop hotkeys (Hyprland/Wayland)
- To bind a key to an app action, prefer a Hyprland `bind` calling the app's own CLI/IPC (check `app --help` for a toggle/trigger command) over the app's built-in global-shortcut listener. Hyprland captures the key natively in every window; app-side X11/tauri global shortcuts silently fail in native Wayland windows.
- Avoid evdev/uinput key-grab listeners and adding the user to the `input` group just to make a hotkey work — they can exclusively grab and lock the keyboard. Flag the lockout risk and confirm before enabling. Recovery: kill the app, then `Ctrl+Alt+F1` back to the GUI.

## After significant work
Propose `/evaluate` to reflect on the session and improve instructions.

