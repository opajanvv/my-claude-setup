# Review ideas

Systematically review someday/maybe ideas from the vault. Run anytime you have time and energy to process ideas.

## Instructions

### Step 1: Load ideas to review

Run `planning-scan` via Bash to get planning status as JSON.

**Note:** Run with `required_permissions: ["all"]` as the script needs access to Python libraries outside the workspace.

Use `ideas.review_queue` from the result — all someday ideas sorted by oldest reviewed date (never-reviewed first). This is the order to process them in.

If `review_queue` is empty, inform the user there are no ideas to review.

Keep the list in memory for the session — don't re-run `planning-scan` for each idea.

Show: "X ideas to review, starting with the oldest."

### Step 2: Process ideas from the list

For each idea in `review_queue`:

**Show progress:**
Display: "**Reviewing idea N of M**" where:
- N = position in current session (1, 2, 3...)
- M = total items in `review_queue`

**Present the idea:**
- Read the full content of the idea file
- Show the idea title, category, created date, and last reviewed date
- Show the full content

**Ask for decision:**
1. **Promote to project** - Has clear next steps, ready to commit
2. **Keep as someday** - Still interesting, not ready yet
3. **Move to different category** - Belongs in a different folder
4. **Kill** - No longer relevant or interesting

**Execute the decision:**

*Promote to project:*
- Create a new file in `projects/` using the project template
- Copy relevant content from the idea
- Ask the user to define initial next steps (checkboxes)
- Set `status: killed` on the original idea (it's now a project)
- Update `reviewed: YYYY-MM-DD` in the idea's frontmatter

*Keep as someday:*
- Update `reviewed: YYYY-MM-DD` in the idea's frontmatter

*Move to different category:*
- Ask which category folder to move to (show available categories from vault-structure.md)
- Move the file to the new folder
- Update `reviewed: YYYY-MM-DD` in the idea's frontmatter

*Kill:*
- Set `status: killed` in the idea's frontmatter
- Update `reviewed: YYYY-MM-DD` in the idea's frontmatter

**Continue automatically:**
Proceed immediately to the next item. The user will type "stop" to end the session.

### Step 3: Show summary

When the user types "stop" (or the list is exhausted), show:
- Number of ideas reviewed this session
- Breakdown: promoted / kept / moved / killed
- How many remain in the queue
