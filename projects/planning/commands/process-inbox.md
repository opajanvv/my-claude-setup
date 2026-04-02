# Process inbox

Review and triage tasks in the inbox folder, then set focus for the week.

## Instructions

### Step 1: Scan planning status

Run `planning-scan` via Bash to get planning status as JSON. This gives an overview of inbox count, projects, and current focus.

**Note:** Run with `required_permissions: ["all"]` as the script needs access to Python libraries outside the workspace.

### Step 2: Triage inbox

If `inbox.count` > 0 from the scan:

1. Give a short overview: "Inbox has X items to process"
2. For each item in `inbox.items` (one at a time):
   - Read the full file content (note: Braintoss items may arrive as raw text without frontmatter - this is normal, add proper frontmatter during processing)
   - Present the item to the user and determine:
     - Is the task clear or does it need clarification?
     - What priority should it have?
     - Is it linked to a project?
     - Should it move to `active/` or somewhere else?
   - Make changes immediately (update status, move file, or delete)
   - Confirm the action before moving to the next item

3. After all items are processed, summarize what was done.

If inbox is empty, note this and move to focus selection.

### Step 3: Set focus

Use `projects.target` and `projects.active` from the scan:

1. Show current focus project (from `projects.target`) or "No focus set"
2. List all active projects with unchecked_count as step count

3. If `projects.wip_warning.exceeded` is true, show:
   "WIP limit exceeded: X/3 active projects. Before setting or keeping a focus, pause or kill an active project."
   Walk Jan through each active project (excluding the current target) and ask: keep active, pause, or kill?
   - **Pause**: set `status: paused` in that project's frontmatter
   - **Kill**: set `status: killed` in that project's frontmatter
   - **Keep active**: leave as-is
   Only proceed to focus selection once active_count <= 3.

4. Ask: "Keep current focus, or switch to a different project?"
   - If keeping: confirm and move on
   - If switching:
     - Remove `target: true` from old project's frontmatter
     - Add `target: true` to new project's frontmatter
     - Confirm the change
   - If clearing focus: remove `target: true` from current project

### Step 4: Review stale tasks

If `stale_tasks.count` > 0 from the scan:

1. Show count: "X tasks have been sitting untouched for 3+ weeks"
2. List all stale tasks with age and priority
3. For each, ask: keep as task, demote to idea, or delete?
   - **Keep**: leave as-is (task stays active)
   - **Demote**: move to `ideas/` with appropriate category, set `status: someday`
   - **Delete**: remove the file
4. Summarize what changed

If no stale tasks, skip this step.

### Step 5: Review ideas

Use the first 3 items of `ideas.review_queue` from the scan (sorted by oldest reviewed date, never-reviewed first):

1. Show: "3 ideas up for review"
2. For each of the first 3 ideas (one at a time):
   - Read the full file content
   - Present the idea name and category
   - Ask: keep as someday, promote to task, promote to project, or kill?
     - **Keep**: update `reviewed: YYYY-MM-DD` in the frontmatter to today
     - **Promote to task**: create a task in `tasks/active/` with appropriate frontmatter, set idea `status: done`
     - **Promote to project**: create a project in `projects/` from the project template, set idea `status: done`
     - **Kill**: set `status: killed` in the frontmatter
3. Summarize what changed

If `ideas.someday_count` is 0, skip this step.

### Step 6: Regenerate daily overview

Run `/refresh-planning` to regenerate the daily overview with updated focus.
