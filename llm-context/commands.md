# Commands overview

Skills are available globally in any Claude Code session; commands are workspace-specific. Core skills are defined in `~/.claude/skills/` and `~/dev/mystrap/dotfiles/claude/.claude/skills/`. Planning commands live in `planning/.claude/commands/`.

## Daily rhythm

| Command | When to use | What it does |
|---------|-------------|--------------|
| `/refresh-planning` | Anytime (also runs hourly via cron) | Processes Braintoss inbox, archives done items, regenerates TODAY.md |

## Working on things

| Command | When to use | What it does |
|---------|-------------|--------------|
| `/new-task` | Quick capture | Creates a task in inbox/ |
| `/new-idea` | Something catches your interest | Pins a note to the board (ideas/) |
| `/plan` | Before starting complex work | Think through approach before doing |

## Weekly review

| Command | When to use | What it does |
|---------|-------------|--------------|
| `/process-inbox` | Weekly (or when inbox piles up) | Triage inbox, set what's on the bench |
| `/review-ideas` | When browsing the pin-up board | Look at old ideas, kill or promote them |

## Documentation

| Command | When to use | What it does |
|---------|-------------|--------------|
| `/new-doc` | Adding documentation | Files content into docs/ or llm-context/, updates index and routing |
| `/review-docs` | Periodic maintenance | Audits docs structure for broken refs, missing index entries, overgrown files |

## Wrapping up

| Command | When to use | What it does |
|---------|-------------|--------------|
| `/review-text` | Before publishing/sending | Review written text |
| `/evaluate` | Reflect on something | Structured evaluation |

## Always available

These are global — available in any Claude Code session.

| | When to use | What it does |
|-|-------------|--------------|
| `remote-server` skill | Any homelab task | Connects to Proxmox server via SSH and runs commands (pct, docker, systemctl, logs) |
| `auto-committer` agent | Invoked internally on commit | Stages, commits, and pushes changes automatically; triggered by CLAUDE.md rule, not a user command |

For a full inventory of all Claude Code items (all workspaces, skills, commands, hooks, agents), run `claude-inventory` to regenerate `~/Cloud/janvv/life/claude-overview.md`.

## The essentials

For daily flow, only three are essential:

1. **`/refresh-planning`** - refresh the daily overview
2. **`/process-inbox`** - weekly tidy-up, set focus
3. **`/plan`** - think before doing

The rest are there when needed.
