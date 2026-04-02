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
- Create scripts in `~/dev/mystrap/dotfiles/shell/.local/bin/`, not `~/.local/bin/` (symlinks go in `~/.local/bin/`)

## Communication
Be direct and natural. Avoid:
- Chatbot phrases ("Of course!", "Certainly!", "I hope this helps")
- Emojis, em dashes, title case headers, curly quotes
- Placeholder text, hallucinated facts
- Knowledge disclaimers ("As of [date]...")

Ask rather than guess. Cite sources when researching frameworks. When Jan drops an argument or direction, accept it — don't re-pitch it.

## Markdown files
Use "Jan" and "Claude" instead of pronouns to avoid ambiguity.

## Context on-demand
This CLAUDE.md is intentionally concise. For detailed knowledge:
- Read `~/Cloud/janvv/life/llm-context/index.md` to see available context
- Follow links only when relevant to the current task

## Vault structure
Most work happens in `~/Cloud/janvv/life/` with separate workspaces:
- **planning/** - Projects, tasks, ideas, daily overview (Claude Code root)
- **docs/** - Technical documentation, homelab (Claude Code root)
- **llm-context/** - Context summaries for Claude

Each subdirectory has its own CLAUDE.md with specific instructions. Work in the appropriate folder.

## External integrations
- **Mystrap**: `~/dev/mystrap` is the dotfiles repository. Uses stow, so scripts go in `dotfiles/shell/.local/bin/`. Skills live in `dotfiles/claude/.claude/skills/` and are tracked in this repo — commit skill changes via mystrap.
- **Vault scripts**: `~/.local/bin/vault-*` scripts for scanning, cleanup, creating tasks, and TODAY.md generation
- **Calendar**: `~/.local/bin/calendar-today` fetches Google Calendar events (see `llm-context/google-api.md`)
- **Homelab**: use the `remote-server` skill for server operations; source configs in `~/dev/homelab-docker/`

## Git commits
- Never run git commit directly. Always use the auto-committer agent via the Task tool.
- Only commit when the user explicitly asks, or when "commit" is clearly part of the requested task.
- If no git repository exists in the current directory, do nothing and inform the user.
- Before committing credential files (API keys, OAuth configs, tokens), check repo visibility with `gh repo view --json isPrivate`. Only commit credentials to private repos.

## After significant work
Propose `/evaluate` to reflect on the session and improve instructions.

