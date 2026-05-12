#!/bin/bash
# sync.sh — push repo → ~/.claude, or pull ~/.claude → repo
# Usage: ./sync.sh push | pull

REPO="$(cd "$(dirname "$0")" && pwd)"
CLAUDE="$HOME/.claude"

case "$1" in
  push)
    echo "Pushing repo → ~/.claude..."
    cp "$REPO/CLAUDE.md" "$HOME/Claude/CLAUDE.md"
    cp "$REPO/settings.json" "$CLAUDE/settings.json"
    rsync -a "$REPO/skills/" "$CLAUDE/skills/"
    echo "Done."
    ;;
  pull)
    echo "Pulling ~/.claude → repo..."
    cp "$HOME/Claude/CLAUDE.md" "$REPO/CLAUDE.md"
    rsync -a "$CLAUDE/skills/" "$REPO/skills/" --exclude '_archived/'
    echo "Done. Review changes with: git diff"
    ;;
  *)
    echo "Usage: ./sync.sh push | pull"
    exit 1
    ;;
esac
