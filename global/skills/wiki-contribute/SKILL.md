---
name: wiki-contribute
description: Contribute source material to the shared Hermes/Claude wiki for ingestion. Use when Jan wants to add knowledge to the shared wiki (homelab, dev, infra, AI, church, finance, personal), says "add this to the wiki", "send to the shared wiki", or "file this for Hermes to ingest".
---

# Wiki contribute

Add source material to the shared wiki at `~/Dropbox/knowledge/wiki/` (synced with the Hermes
Agent via Dropbox). **Claude does not author wiki pages — Hermes is the sole author.** Claude's
job is to drop clean source material into the `raw/` layer and signal Hermes to ingest it.

## Domains

- `tech` — homelab, Proxmox, containers, services, networking, GitHub, dev, AI/ML
- `penningmeester` — church (De Lichtbron), notjortt, finance, bookkeeping
- `personal` — Jan's background, writing style, preferences, bio details (anything Hermes needs to represent Jan accurately)

Skip the wiki for anything outside these three domains.

## Steps

1. **Pick domain and raw subfolder.** Path is `~/Dropbox/knowledge/wiki/<domain>/raw/<subfolder>/`.
   - `articles/` — web clippings, external sources, single-source writeups
   - `notes/` — operational notes/facts dumped from a Claude session (create the folder if absent)
   - `papers/`, `transcripts/` — when the source type fits
2. **Choose a kebab-case slug** for the filename.
3. **Write the body to a temp file, compute its sha256, then write the raw file** with
   frontmatter. The sha is over the body only (everything below the closing `---`):
   ```bash
   slug=<slug>; domain=<tech|penningmeester|personal>; sub=<articles|notes|...>
   raw=~/Dropbox/knowledge/wiki/$domain/raw/$sub
   mkdir -p "$raw"
   sha=$(sha256sum /tmp/$slug.body | cut -d' ' -f1)
   { printf -- '---\nsource_url: %s\nsource_path: %s\ningested: %s\nsha256: %s\n---\n\n' \
       "$URL" "$ORIGIN" "$(date +%F)" "$sha"; cat /tmp/$slug.body; } > "$raw/$slug.md"
   ```
   - `source_url`: original URL if web, else leave empty.
   - `source_path`: original path if copied from the vault (e.g. a `docs/homelab/...` file), else empty.
   - Keep the body clean: a `# Title`, then the content. No chat framing or Claude commentary.
4. **Never touch** `index.md`, `log.md`, or any Layer-2 page (`entities/`, `concepts/`,
   `comparisons/`, `queries/`). Those are Hermes-owned.
5. **Trigger ingest** via a Gmail draft (the mailbox is `jan@janvv.nl`; Hermes' cron scans it
   for `[KANBAN]` items). Use the gcalcli Python environment to call the Gmail API:
   ```bash
   ~/.local/share/uv/tools/gcalcli/bin/python -c "
   from pathlib import Path; import base64
   from email.mime.text import MIMEText
   from google.auth.transport.requests import Request
   from google.oauth2.credentials import Credentials
   from googleapiclient.discovery import build
   TOKEN = Path.home() / '.config/calendar-cli/token-gmail.json'
   SCOPES = ['https://www.googleapis.com/auth/gmail.modify']
   creds = Credentials.from_authorized_user_file(str(TOKEN), SCOPES)
   if not creds.valid: creds.refresh(Request()); TOKEN.write_text(creds.to_json())
   svc = build('gmail', 'v1', credentials=creds)
   msg = MIMEText('Ingest into the <domain> wiki: wiki/<domain>/raw/<sub>/<slug>.md')
   msg['to'] = 'jan@janvv.nl'; msg['subject'] = '[KANBAN] wiki update'
   raw = base64.urlsafe_b64encode(msg.as_bytes()).decode()
   svc.users().drafts().create(userId='me', body={'message': {'raw': raw}}).execute()
   print('draft created')
   "
   ```
   - `to`: `jan@janvv.nl`
   - `subject`: `[KANBAN] wiki update`
   - `body`: domain + the raw file path(s) added + a one-line ask to ingest. Example:
     `Ingest into the tech wiki: wiki/tech/raw/notes/proxmox-zfs-trim.md`
6. **Report** the raw path(s) written and that the ingest draft was created. Hermes ingests,
   synthesizes/updates the Layer-2 pages, and deletes the draft.

## Notes

- `sha256` is Hermes' drift-detection bookkeeping; a full digest of the body is fine.
- One draft can list several raw files — batch related dumps into one `[KANBAN] wiki update`.
- If unsure whether something is wiki-worthy, ask Jan rather than dumping noise.
- Ingestion is asynchronous: the page appears after Hermes' cron runs, not immediately.
