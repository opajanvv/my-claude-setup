# my-claude-setup

My personal [Claude Code](https://docs.anthropic.com/en/docs/claude-code) configuration: skills, hooks, agents, commands, and CLAUDE.md files.

Yes, this is a lot of config for a retired guy with no business to run. But I spent about 50 years in software, and now that I don't have to build things, I get to tinker with AI for fun. Turns out you can sink just as many hours into configuring your tools as into actually using them.

> **Not a template.** These files are tailored to my setup (Arch Linux, Hyprland, Proxmox homelab). Don't copy-paste them. Read through, steal the patterns that make sense, build your own.

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
| **md-to-pdf** | Convert a Markdown file to PDF via python-markdown + WeasyPrint |
| **wiki-contribute** | Drop source material into a shared knowledge wiki for another agent to ingest |

#### Agents (`global/agents/`)

Agents are subprocesses Claude can delegate to. They run with their own context and return results.

| Agent | What it does |
|-------|-------------|
| **auto-committer** | Stages, diffs, writes commit messages, handles pre-commit hooks. Runs on Haiku to keep costs down. |
| **android-builder** | Android app builds and deploys (Gradle, Compose, adb). Runs on Sonnet. |
| **homelab-admin** | Runs commands on the Proxmox homelab server via SSH. Runs on Sonnet. |
| **omarchy-guru** | Manages Omarchy/Hyprland desktop config safely. Runs on Sonnet. |

#### Hooks (`global/hooks/`)

Shell scripts that fire on Claude Code events.

| Hook | Event | What it does |
|------|-------|-------------|
| **generate-dates.sh** | SessionStart | Injects today/yesterday/this week dates into context |
| **log-skill-usage.sh** | PostToolUse | Logs skill invocations (to find unused skills) |

### `projects/` -- project-level examples

How I set up project-specific configuration for different types of work.

#### `projects/website/` -- publish workflow

A single command (`/publish`) that commits, rsyncs to a server, and clears cache.

## Context on demand

The global CLAUDE.md is deliberately small. It doesn't try to explain everything -- it just points Claude to an `llm-context/` folder ([`global/llm-context/`](global/llm-context/)) with a trigger table mapping keywords to where the actual knowledge lives. Claude reads only what's relevant to the current task.

Start with [`index.md`](global/llm-context/index.md). Most rows point out to a shared knowledge wiki (Dropbox-synced, not included here -- it's private and co-maintained with another agent I run for planning and admin). A couple of Claude-meta files (`commands.md`, `claude-code.md`) stay local because they're about Claude Code itself, not personal knowledge.

This used to be a bigger local folder with one summary file per topic (homelab, desktop, 3D printing, ...). I moved that content into the shared wiki once I had a second agent that also needed to read and write it -- Dropbox-syncing a wiki works across machines and agents better than a folder tracked in a dotfiles repo. The layering idea is the same either way: CLAUDE.md -> trigger table -> topic page -> deeper docs, so a conversation about calendar integration never pulls in the 3D printer setup.

The whole llm-context idea comes from Teresa Torres' excellent writeup [Give Claude Code a memory](https://www.producttalk.org/give-claude-code-a-memory/). I took her concept and ran with it.

## How I manage these files

The global config lives in my dotfiles repo ([mystrap](https://github.com/opajanvv/mystrap)) and is deployed to `~/.claude/` via GNU Stow. Project-level files live in their respective repos.

This repo is a read-only mirror. `sync.sh` copies files from their source locations into this repo for publishing. Run it, review the diff, commit.

## Patterns worth stealing

The specifics won't apply to you, but these patterns might:

- **CLAUDE.md as behavioral contract** -- not just "what the project is" but "how Claude should work here"
- **Skills for recurring workflows** -- the plan skill alone saves a lot of back-and-forth
- **Cheap subagents for mechanical tasks** -- auto-committer on Haiku, routine commits for pennies
- **Hooks for context injection** -- Claude always knows what day it is
- **Evaluate after significant work** -- a skill that reflects on what went well, what didn't, and feeds improvements back into your config. This is how the setup gets better over time.
- **Project commands for domain workflows** -- `/publish` encodes the steps so Claude doesn't have to figure them out each time
