#!/bin/sh
set -eu

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

# Sync manifest: source -> destination
# Each line: source_path destination_path
# Directories end with /
sync_manifest() {
    cat <<'EOF'
# Global config (from mystrap stow package)
~/dev/mystrap/dotfiles/claude/.claude/CLAUDE.md           global/CLAUDE.md
~/dev/mystrap/dotfiles/claude/.claude/settings.json       global/settings.json
~/dev/mystrap/dotfiles/claude/.claude/settings.local.json global/settings.local.json
~/dev/mystrap/dotfiles/claude/.claude/statusline.sh       global/statusline.sh
~/dev/mystrap/dotfiles/claude/.claude/agents/             global/agents/
~/dev/mystrap/dotfiles/claude/.claude/hooks/              global/hooks/
~/dev/mystrap/dotfiles/claude/.claude/skills/             global/skills/

# Project: planning (GTD-style task management)
~/Cloud/janvv/life/planning/CLAUDE.md                     projects/planning/CLAUDE.md
~/Cloud/janvv/life/planning/.claude/commands/             projects/planning/commands/

# Project: vault root (multi-workspace routing)
~/Cloud/janvv/life/CLAUDE.md                              projects/vault-root/CLAUDE.md
~/Cloud/janvv/life/.claude/hooks/                         projects/vault-root/hooks/

# Project: docs
~/Cloud/janvv/life/docs/CLAUDE.md                         projects/docs/CLAUDE.md
~/Cloud/janvv/life/docs/homelab/CLAUDE.md                 projects/docs/homelab/CLAUDE.md

# Project: website (publish workflow)
~/dev/janvv.nl/.claude/commands/publish.md                projects/website/commands/publish.md
EOF
}

# Expand ~ to $HOME
expand_path() {
    echo "$1" | sed "s|^~|$HOME|"
}

echo "Syncing files to $REPO_DIR..."

sync_manifest | while IFS= read -r line; do
    # Skip comments and empty lines
    case "$line" in
        '#'*|'') continue ;;
    esac

    src=$(echo "$line" | awk '{print $1}')
    dst=$(echo "$line" | awk '{print $2}')
    src=$(expand_path "$src")
    dst="$REPO_DIR/$dst"

    if [ ! -e "$src" ]; then
        echo "SKIP (not found): $src"
        continue
    fi

    # Directory sync
    if [ -d "$src" ]; then
        mkdir -p "$dst"
        rsync -a --delete "$src" "$dst"
        echo "DIR:  $dst"
    else
        mkdir -p "$(dirname "$dst")"
        cp -a "$src" "$dst"
        echo "FILE: $dst"
    fi
done

echo "Done. Run 'git diff' to review changes."
