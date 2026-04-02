# Planning workspace

Projects, tasks, and ideas. The workbench where work gets planned and tracked.

## Structure

- `projects/` - What's on the workbench (committed work)
- `ideas/` - The pin-up board (someday-maybes, with category subdirs)
- `tasks/inbox/` - Quick captures, unsorted
- `tasks/active/` - Things being worked on
- `.archive/` - Soft-deleted items (auto-purged after 4 weeks)
- `templates/` - Obsidian templates for tasks, ideas, projects
- `TODAY.md` - Daily overview (generated, not edited manually). Sections: hard landscape (calendar only), needs attention (overdue + due today + high priority + stalled projects), focus project, available (start date passed but not due soon), this week (due soon with day names), backlog (medium priority standalone), active projects (with WIP warning if > 3 active), consider (random idea)

**Three tiers:** Task = do it, done. Project = multi-step, committed. Idea = uncommitted possibility.

**Availability windows:** Tasks support optional `start` dates — see vault-structure.md for how `start` and `due` interact.

**Focus:** One project can have `target: true` - front and center on the bench. Set during `/process-inbox`.

For detailed frontmatter formats and processing rules, see `../llm-context/vault-structure.md`.

## Working preferences

- Always plan before making changes
- When creating files, use appropriate templates from `templates/`
- When completing work that matches an existing idea, mark it as done without asking
- Before processing inbox, check planning root for stray files - move them to `tasks/inbox/`
- When an inbox item references a file in a temporary location (Downloads, /tmp), copy/move it to the vault immediately during triage - don't defer it
- Inbox triage default is idea, not task. Only promote to task when there's a concrete trigger: due date, someone waiting, project link, or doing it this week
- When documenting facts about Jan, stick to what Jan stated. Don't infer motivations or narratives from job titles or timelines.
- When walking Jan through a checklist interactively, present each item and wait for completion. Don't offer to skip items or suggest alternatives unless there's a genuine blocker — assume Jan intends to complete the work.
- For church treasury tasks: llm-context/church.md has orientation; ~/dev/penningmeester/ is ground truth for step-by-step workflows. Read it before writing workflow content.

## Tracking progress

When checking off a step in a project's checklist, also update `last_progress: YYYY-MM-DD` in that project's frontmatter to today's date.

## Completing a project

Follow all steps from `../llm-context/vault-structure.md` automatically:
1. Set `status: done` and add `completed: YYYY-MM-DD`
2. Remove `target: true` if present
3. Check llm-context for stale references
4. planning-refresh will archive it automatically (purged after 4 weeks)
5. check if any documentation needs to be updated

## Git
The vault (planning/, llm-context/, docs/) is not a git repository — it is cloud-synced. Skip git operations here; there is nothing to commit.

## Scripts

- **planning-scan**: `~/.local/bin/planning-scan` scans planning status for `/process-inbox`
- **planning-create**: `~/.local/bin/planning-create` creates tasks/ideas from templates
- **planning-refresh**: `~/.local/bin/planning-refresh` processes Braintoss inbox, archives done/killed items, and generates TODAY.md. Runs hourly via cron. Scripts run from cron need `export PATH="$HOME/.local/bin:$PATH"` since cron uses a minimal PATH.
