#!/bin/sh
set -eu

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

expand_path() {
    echo "$1" | sed "s|^~|$HOME|"
}

sync_item() {
    src="$1"
    dst="$REPO_DIR/$2"

    if [ ! -e "$src" ]; then
        return
    fi

    if [ -d "$src" ]; then
        mkdir -p "$dst"
        rsync -a --delete "$src" "$dst"
        echo "DIR:  $2"
    else
        mkdir -p "$(dirname "$dst")"
        cp -a "$src" "$dst"
        echo "FILE: $2"
    fi
}

# --- Global config (mystrap stow layout, not standard Claude structure) ---

GLOBAL_SRC=~/dev/mystrap/dotfiles/claude/.claude
GLOBAL_SRC=$(expand_path "$GLOBAL_SRC")

sync_item "$GLOBAL_SRC/CLAUDE.md"           "global/CLAUDE.md"
sync_item "$GLOBAL_SRC/settings.json"       "global/settings.json"
sync_item "$GLOBAL_SRC/settings.local.json" "global/settings.local.json"
sync_item "$GLOBAL_SRC/statusline.sh"       "global/statusline.sh"
sync_item "$GLOBAL_SRC/agents/"             "global/agents/"
sync_item "$GLOBAL_SRC/hooks/"              "global/hooks/"
sync_item "$GLOBAL_SRC/skills/"             "global/skills/"

# --- Projects (auto-discover Claude config patterns) ---

sync_project() {
    name="$1"
    src=$(expand_path "$2")

    # Top-level CLAUDE.md
    sync_item "$src/CLAUDE.md" "projects/$name/CLAUDE.md"

    # .claude/ subdirectories
    for dir in commands hooks agents; do
        sync_item "$src/.claude/$dir/" "projects/$name/$dir/"
    done

    # .claude/settings.local.json
    sync_item "$src/.claude/settings.local.json" "projects/$name/settings.local.json"

    # Nested CLAUDE.md files (one level deep)
    if [ -d "$src" ]; then
        for child in "$src"/*/; do
            child_name=$(basename "$child")
            if [ -f "$child/CLAUDE.md" ]; then
                sync_item "$child/CLAUDE.md" "projects/$name/$child_name/CLAUDE.md"
            fi
        done
    fi
}

echo "Syncing files to $REPO_DIR..."

sync_project "planning"    "~/Cloud/janvv/life/planning"
sync_project "vault-root"  "~/Cloud/janvv/life"
sync_project "docs"        "~/Cloud/janvv/life/docs"
sync_project "website"     "~/dev/janvv.nl"

echo "Done. Run 'git diff' to review changes."
