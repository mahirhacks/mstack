#!/usr/bin/env bash
# Sync canonical skill/ into plugin/skills/mvp-spec-driven-delivery/
# Run from the repository root after editing skill/.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE="$ROOT/skill"
DEST="$ROOT/plugin/skills/mvp-spec-driven-delivery"

if [[ ! -d "$SOURCE" ]]; then
  echo "skill/ not found at $SOURCE" >&2
  exit 1
fi

mkdir -p "$DEST" "$ROOT/plugin/agents"
rsync -a --delete "$SOURCE/" "$DEST/"
rsync -a --delete "$SOURCE/agents/" "$ROOT/plugin/agents/"

echo "Synced skill/ -> plugin/skills/mvp-spec-driven-delivery/"
echo "Synced skill/agents/ -> plugin/agents/"
