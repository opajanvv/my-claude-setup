# Workflow principles

The philosophy behind Opa Jan's Workbench.

## The workbench metaphor

This isn't a productivity system - it's a satisfaction system. The goal is enjoying the work, finishing things that matter, and keeping a curious mind organized.

Picture a craftsman's workbench:
- **Projects** sit on the bench - committed work, actively being shaped
- **Ideas** are pinned to the board behind - notes, sketches, someday-maybes
- **Tasks** are the errands and obligations - things that need doing whether fun or not

## Three tiers

| Tier | What it is | Where it lives |
|------|------------|----------------|
| Task | Single action, then done | `tasks/` |
| Project | Multi-step, committed to | `projects/` |
| Idea | Note on the board, uncommitted | `ideas/` |

Tasks need doing. Projects are chosen. Ideas are possibilities.

## Focus mechanism

Inspired by Teresa Torres' Continuous Discovery Habits: work on ONE opportunity at a time.

- One project has `target: true` - front and center on the bench
- Other active projects sit at the edge
- Set during `/process-inbox` (weekly)
- No obligation to work exclusively on it - just a reminder of what matters most

Quick wins (standalone tasks) fill gaps between focused work.

## Daily ritual

Cron runs `/morning` at 5 AM:
- Commits mobile syncs
- Generates TODAY.md with calendar, tasks, what's on the bench

Run `/today` anytime to refresh the view.

## Building context

If explaining something twice, capture it:
- Repeated explanations -> `llm-context/`
- Service details -> `docs/homelab/services/`
- Procedures -> `docs/homelab/how-to/`

## Preventing idea graveyards

Two mechanisms prevent ideas from quietly rotting:

1. **Random resurfacing** - `/today` shows one random idea
2. **Systematic review** - `/review-ideas` processes oldest first

### Review workflow

Run `/review-ideas` when browsing the board. For each idea:
- **Promote** - Ready for the bench, move to projects/
- **Keep** - Still interesting, not ready
- **Move** - Belongs in different category
- **Kill** - No longer relevant

Ideas get `reviewed: YYYY-MM-DD`. After 90 days, they resurface.

## Scripts vs. Claude

**Use scripts for:** deterministic logic, frequently-called operations (token savings), complex file system operations, external API integrations.

**Let Claude handle:** simple status changes, one-off file operations, content requiring judgment or interpretation.
