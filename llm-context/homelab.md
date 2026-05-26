# Homelab context

For any homelab work (servers, Docker, Proxmox, networking, services, backups), read the primary documentation:

- **Start here:** `~/Cloud/janvv/life/docs/homelab/index.md`
- **Service details:** `docs/homelab/services/` (one file per service)
- **How-to guides:** `docs/homelab/how-to/` (procedures and troubleshooting)
- **Infrastructure:** `docs/homelab/infrastructure/` (Proxmox, network, storage)
- **Docker configs:** `~/dev/homelab-docker/`

## Quick facts

- All LXC containers are unprivileged (`unprivileged: 1`). Root inside maps to uid 100000 on the host. Bind-mounted files must be world-readable (`o+rX`).
- The host repo at `/home/jan/homelab-docker` is bind-mounted into all LXCs at `/opt/homelab-docker`. Config changes are deployed via git push + pull (no per-container sync).
- The server repo has `core.sharedRepository=world` so git pull creates world-readable files.

## Published to opa.janvv.nl

The homelab docs are also published on the personal website at `https://opa.janvv.nl/homelab`. The Grav pages at `~/dev/janvv.nl/user/pages/10.homelab/` are **generated** from the vault by `sync-homelab-to-grav` (in `~/dev/mystrap/dotfiles/shell/.local/bin/`). The site's `publish.sh` runs the sync automatically before deploying. Never hand-edit files under `10.homelab/` — edit the vault source.

Do not rely on this file for specifics. Always read the docs.
