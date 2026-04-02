# Documentation workspace

Technical documentation organized by area. Each subdirectory has its own CLAUDE.md with domain-specific instructions.

## Areas

- `homelab/` - Self-hosted services and infrastructure
- `church/` - (planned)
- `3d-printing/` - (planned)

## General preferences

- Keep docs factual and up to date
- Update `updated` or `last-tested` dates when modifying docs
- Each area has its own templates; use them when creating new docs

## rclone operations

- `rclone move`/`rclone sync` fails on overlapping remotes (e.g. subdirectory to parent). Use `rclone copy --files-from` instead when source and destination share a common ancestor.
- Before running `rclone purge` or `rclone delete`, verify the destination file count matches expectations. Only purge after confirming the move/copy succeeded.
- Don't pipe rclone output inline (e.g. `rclone lsf ... | grep ...`). Write to a file first, then process separately -- shell pipes mangle rclone's argument parsing.
