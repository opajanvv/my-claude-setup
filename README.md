# my-claude-setup

My personal [Claude Code](https://docs.anthropic.com/en/docs/claude-code) configuration: skills, hooks, agents, commands, and CLAUDE.md files.

Yes, this is a lot of config for a retired guy with no business to run. But I spent about 50 years in software, and now that I don't have to build things, I get to tinker with AI for fun. Turns out you can sink just as many hours into configuring your tools as into actually using them.

> **Not a template.** These files are tailored to my setup (Arch Linux, Hyprland, Obsidian vault, Proxmox homelab). Don't copy-paste them. Read through, steal the patterns that make sense, build your own.

## How Claude Code configuration works

Claude Code loads configuration from several layers:

| Layer | Location | Scope |
|-------|----------|-------|
| Global config | `~/.claude/CLAUDE.md` | Every conversation |
| Global settings | `~/.claude/settings.json` | Permissions, hooks, model prefs |
| Global skills | `~/.claude/skills/*/SKILL.md` | Available in every project |
| Global agents | `~/.claude/agents/*.md` | Subagents for delegation |
| Project CLAUDE.md | `./CLAUDE.md` in project root | Project-specific rules |
| Project commands | `./.claude/commands/*.md` | Project-specific slash commands |
| Project hooks | `./.claude/hooks/*.sh` | Project-specific event handlers |
| Project settings | `./.claude/settings.local.json` | Project-specific permissions |

This repo mirrors my files from both layers.

## What's in here

### `global/` -- lives in `~/.claude/`

**CLAUDE.md** -- the most impactful file. Working style, communication preferences, integration details. Claude reads it at the start of every conversation.

**settings.json** -- permissions allowlist, hook configuration, status line, model preference.

**settings.local.json** -- machine-specific permission overrides. Separate file so different machines don't conflict.

**statusline.sh** -- custom status bar showing git branch, task count, and other context.

#### Skills (`global/skills/`)

Skills are reusable capabilities Claude can invoke with `/skillname`. Each has a `SKILL.md` with instructions and optional `references/` for supporting material.

| Skill | What it does |
|-------|-------------|
| **plan** | Structured spec-plan-do workflow, from tiny fixes to large projects |
| **evaluate** | Session retrospective: what went well, what didn't, improve instructions |
| **skill-creator** | Meta-skill for creating new skills. From [anthropics/skills](https://github.com/anthropics/skills) |
| **review-text** | Writing review with style-aware feedback (Dutch + English) |
| **review-docs** | Documentation health check: orphans, missing index entries, overgrown files |
| **new-doc** | Files new docs into the correct location with index updates |
| **omarchy-skill** | Guards Hyprland/Omarchy config changes (version checks, safe editing) |
| **remote-server** | Runs commands on a Proxmox server via SSH |

#### Agents (`global/agents/`)

Agents are subprocesses Claude can delegate to. They run with their own context and return results.

| Agent | What it does |
|-------|-------------|
| **git-committer** | Stages, diffs, writes commit messages, handles pre-commit hooks. Runs on Haiku to keep costs down. |

#### Hooks (`global/hooks/`)

Shell scripts that fire on Claude Code events.

| Hook | Event | What it does |
|------|-------|-------------|
| **generate-dates.sh** | SessionStart | Injects today/yesterday/this week dates into context |
| **log-skill-usage.sh** | PostToolUse | Logs skill invocations (to find unused skills) |

### `projects/` -- project-level examples

How I set up project-specific configuration for different types of work.

#### `projects/planning/` -- GTD-style task management

Personal planning workspace with commands for managing tasks and ideas.

| Command | What it does |
|---------|-------------|
| `/new-idea` | Create a new idea file from a description |
| `/new-task` | Create a task in the inbox |
| `/process-inbox` | Triage inbox tasks and set weekly focus |
| `/refresh-planning` | Full planning cycle: inbox, cleanup, daily overview |
| `/review-ideas` | Systematic review of someday/maybe items |

#### `projects/vault-root/` -- multi-workspace routing

A root CLAUDE.md that acts as a router, redirecting Claude to the correct subdirectory. Plus a hook that warns when Claude starts in the wrong place.

#### `projects/docs/` -- documentation workspace

Minimal CLAUDE.md files defining documentation areas and domain-specific rules.

#### `projects/website/` -- publish workflow

A single command (`/publish`) that commits, rsyncs to a server, and clears cache.

## Context on demand

The global CLAUDE.md is deliberately small. It doesn't try to explain everything -- it just points Claude to an `llm-context/` folder with short summaries per topic. Claude reads only what's relevant to the current task.

The folder looks like this:

```
llm-context/
├── index.md              -- trigger table: which file to load when
├── 3d-printing.md
├── ai-infrastructure.md
├── church.md
├── claude-code.md
├── commands.md
├── desktop.md
├── google-api.md
├── homelab.md
├── personal.md
├── vault-structure.md
├── workflow-principles.md
└── writing-style.md
```

The `index.md` has a trigger table mapping keywords to files. When a conversation touches "homelab" or "Docker", Claude knows to read `homelab.md`. When it's about "Hyprland" or "keybindings", it loads `desktop.md`. No file is longer than a page or two.

These summaries in turn point to deeper documentation when needed. `homelab.md` links to detailed Proxmox configuration docs, service-specific pages, network diagrams. Claude follows those links only when the conversation actually goes that deep. Three layers: CLAUDE.md -> llm-context summary -> full documentation. Most conversations never get past the second.

This keeps every conversation lightweight. Claude doesn't burn context on your 3D printer setup when you're asking about calendar integration.

The whole llm-context idea comes from Teresa Torres' excellent writeup [Give Claude Code a memory](https://www.producttalk.org/give-claude-code-a-memory/). I took her concept and ran with it.

## How I manage these files

The global config lives in my dotfiles repo ([mystrap](https://github.com/opajanvv/janstrap)) and is deployed to `~/.claude/` via GNU Stow. Project-level files live in their respective repos.

This repo is a read-only mirror. `sync.sh` copies files from their source locations into this repo for publishing. Run it, review the diff, commit.

## Patterns worth stealing

The specifics won't apply to you, but these patterns might:

- **CLAUDE.md as behavioral contract** -- not just "what the project is" but "how Claude should work here"
- **Skills for recurring workflows** -- the plan skill alone saves a lot of back-and-forth
- **Cheap subagents for mechanical tasks** -- git-committer on Haiku, routine commits for pennies
- **Hooks for context injection** -- Claude always knows what day it is
- **Evaluate after significant work** -- a skill that reflects on what went well, what didn't, and feeds improvements back into your config. This is how the setup gets better over time.
- **Multi-workspace routing** -- a root CLAUDE.md that says "wrong place, go here instead"
- **Project commands for domain workflows** -- `/publish`, `/new-task` encode the steps so Claude doesn't have to figure them out each time
