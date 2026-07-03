# Claude Code configuration

## CLAUDE.md loading

Claude Code walks from the project root to the current working directory and loads every CLAUDE.md it finds along the path. Use this for layered instructions: shared conventions at the root, domain-specific rules in subdirectories.

## Skills scoping

Skills use `.claude/skills/<name>/SKILL.md` and are discovered at two levels:
- **Personal**: `~/.claude/skills/` - available in all projects
- **Project**: `.claude/skills/` - available in that project only

Skills do NOT walk parent directories like CLAUDE.md does. A skill in `docs/.claude/skills/` is not automatically available in `docs/homelab/`. To share a skill across areas, place it at the project root or use personal skills.

Same-name conflicts: personal skills take precedence over project skills.
