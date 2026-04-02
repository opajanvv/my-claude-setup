# my-claude-setup

My personal [Claude Code](https://docs.anthropic.com/en/docs/claude-code) configuration: skills, hooks, agents, commands, and CLAUDE.md files across multiple projects.

> **This is not a template.** These files are tailored to my specific setup (Arch Linux, Hyprland, Obsidian vault, Proxmox homelab). Don't blindly copy-paste them into your own config. Instead, read through them to understand the patterns, then build your own version that fits your workflow.

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

## Repository structure

### `global/` -- global Claude Code config

Files that live in `~/.claude/` and apply to every conversation.

**CLAUDE.md** -- global instructions: working style, communication preferences, integration details. This is the most impactful file. Claude reads it at the start of every conversation.

**settings.json** -- permissions allowlist (which tools Claude can run without asking), hook configuration, status line, model preference.

**settings.local.json** -- machine-specific permission overrides. Kept separate so different machines can have different permissions without conflicting.

**statusline.sh** -- custom status bar showing git branch, task count, and other context.

#### Skills (`global/skills/`)

Skills are reusable capabilities that Claude can invoke with `/skillname`. Each has a `SKILL.md` with instructions and optional `references/` for supporting material.

| Skill | What it does |
|-------|-------------|
| **plan** | Structured spec-plan-do workflow that scales from tiny fixes to large projects |
| **evaluate** | Session retrospective: reflect on what went well/wrong, improve instructions |
| **skill-creator** | Meta-skill for creating new skills (includes validation scripts). From [anthropics/skills](https://github.com/anthropics/skills) |
| **review-text** | Writing review with style-aware feedback (Dutch + English) |
| **review-docs** | Documentation health check: finds orphans, missing index entries, overgrown files |
| **new-doc** | Files new documentation into the correct location with index updates |
| **omarchy-skill** | Guards Hyprland/Omarchy config changes (version checks, safe editing) |
| **remote-server** | Executes commands on a Proxmox server via SSH |

#### Agents (`global/agents/`)

Agents are subprocesses Claude can delegate to. They run with their own context and return results.

| Agent | What it does |
|-------|-------------|
| **git-committer** | Autonomous git commit agent. Stages, diffs, writes commit messages, handles pre-commit hooks. Runs on a cheaper model (Haiku) to save cost. |

#### Hooks (`global/hooks/`)

Hooks are shell scripts that run on Claude Code events.

| Hook | Event | What it does |
|------|-------|-------------|
| **generate-dates.sh** | SessionStart | Injects today/yesterday/this week dates into conversation context |
| **log-skill-usage.sh** | PostToolUse | Logs which skills are invoked and when |

### `projects/` -- project-level examples

These show how to set up project-specific configuration for different types of work.

#### `projects/planning/` -- GTD-style task management

A personal planning workspace with commands for managing tasks and ideas.

| Command | What it does |
|---------|-------------|
| `/new-idea` | Create a new idea file from a description |
| `/new-task` | Create a task in the inbox |
| `/process-inbox` | Triage inbox tasks and set weekly focus |
| `/refresh-planning` | Full planning cycle: inbox, cleanup, daily overview |
| `/review-ideas` | Systematic review of someday/maybe items |

#### `projects/vault-root/` -- multi-workspace routing

Shows how to use a root CLAUDE.md as a router that redirects Claude to the correct subdirectory, plus a hook that warns when Claude starts in the wrong place.

#### `projects/docs/` -- documentation workspace

Minimal CLAUDE.md files that define documentation areas and domain-specific rules.

#### `projects/website/` -- publish workflow

A single command (`/publish`) that commits changes, rsyncs to a server, and clears cache.

## How I manage these files

The global config lives in my dotfiles repo ([mystrap](https://github.com/opajanvv/janstrap)) and is deployed to `~/.claude/` via GNU Stow. Project-level files live in their respective project repos.

This repo is a read-only mirror. The `sync.sh` script copies files from their source locations into this repo for publishing. Run it, review the diff, commit.

## Patterns worth stealing

Even if the specifics don't apply to you, these patterns might be useful:

- **CLAUDE.md as behavioral contract** -- not just "what the project is" but "how Claude should work here": communication style, what to avoid, when to ask vs. assume
- **Skills for recurring workflows** -- the plan skill alone saves significant back-and-forth on every new piece of work
- **Cheap subagents for mechanical tasks** -- the git-committer runs on Haiku, keeping costs down for routine commits
- **Hooks for context injection** -- generating dates on session start means Claude always knows what day it is
- **Multi-workspace routing** -- a root CLAUDE.md that says "you're in the wrong place, go here instead"
- **Project commands for domain workflows** -- `/publish`, `/new-task`, `/process-inbox` encode the specific steps so Claude doesn't have to figure them out each time
- **Dotfiles integration** -- treating Claude config as dotfiles means it's versioned, portable, and deployed automatically
