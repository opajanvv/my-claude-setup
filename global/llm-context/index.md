# LLM context index

Most of Jan's knowledge now lives in the **shared wiki** (`~/Dropbox/knowledge/wiki/`, three domains:
`tech`, `penningmeester`, `personal`). This folder keeps only a few Claude-meta files plus thin
pointers into the wiki. Read only what's relevant to the current task.

## Trigger table

### In the shared wiki (`~/Dropbox/knowledge/wiki/`)

| Context | Triggers | Where |
|---------|----------|-------|
| Personal | who is Jan, background, preferences, family, career | `personal/` (entities/jan-van-veldhuizen, concepts/interests) |
| Writing style | blog, LinkedIn, voice, tone, write for Jan, style | `personal/concepts/writing-style` |
| Homelab | servers, Docker, Proxmox, networking, SSH, services | `tech/` (start at `tech/index.md`) |
| Desktop | Hyprland, Omarchy, keybindings, wallpapers, mystrap scripts | `tech/concepts/desktop-setup` |
| AI infrastructure | Ollama, models, LLM, AI tooling | `tech/concepts/ai-infrastructure` |
| Cloud sync | rclone, FUSE mount, ~/Cloud sync, Dropbox, ~/Dropbox/GDrive, OAuth token expired | `tech/concepts/cloud-sync` |
| Google APIs | calendar, OAuth, credentials, calendar-today | `tech/concepts/google-api-access` |
| 3D printing | printer, slicer, OrcaSlicer, filament, prints | `tech` (entities/3d-printing-setup, concepts/orcaslicer-lan-discovery) |
| Church | treasurer, penningmeester, communication workgroup, kerk | `penningmeester/` (Dutch) |

### Local Claude-meta files (not migrated)

| Context | Triggers | File |
|---------|----------|------|
| Commands | /plan, slash commands, skills, agents | [[commands]] |
| Claude Code | skills, CLAUDE.md scoping, configuration | [[claude-code]] |

(Planning now lives with the Hermes Agent; `vault-structure` and `workflow-principles` were retired.)

## Shared wiki

Cross-referenced knowledge base shared with the Hermes Agent, synced via Dropbox at
`~/Dropbox/knowledge/wiki/`. Three domains:

- `wiki/tech/` — homelab, Proxmox, containers, services, networking, GitHub, dev, AI/ML, desktop, 3D printing
- `wiki/penningmeester/` — church (De Lichtbron), notjortt, finance, bookkeeping
- `wiki/personal/` — background, career, interests, writing voice, personal projects

**How to use it (query):** treat `<domain>/index.md` as the table of contents.
1. Match the question to a domain.
2. Read `~/Dropbox/knowledge/wiki/<domain>/index.md` — it lists every page with a one-line summary.
3. Read the relevant pages and follow `[[wikilinks]]`.

**How to contribute (Claude does not author pages):** Hermes is the sole author. To add
knowledge, drop source material into `~/Dropbox/knowledge/wiki/<domain>/raw/<subfolder>/`
with raw frontmatter (`source_url`/origin, `ingested`, `sha256`), then create a Gmail draft
with subject `[KANBAN] wiki update` and the request in the body. Hermes' cron ingests it and
synthesizes the pages. Never edit `index.md`, `log.md`, or Layer-2 pages directly.

## Key paths

| Content | Path |
|---------|------|
| Shared wiki (Hermes + Claude) | `~/Dropbox/knowledge/wiki/` |
| Personal files (ex-Google Drive) | `~/Dropbox/GDrive/` |
| Homelab Docker configs | `~/dev/homelab-docker/` |
| Penningmeester (Quartz) | `~/dev/penningmeester/` |
| Dotfiles | `~/dev/mystrap/` |
