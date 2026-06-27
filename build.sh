#!/usr/bin/env bash
set -e

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DIST="$REPO/dist"

mkdir -p "$DIST"
rm -f "$DIST"/*.ext "$DIST"/*.mod

if [ -d "$REPO/extensions" ]; then
    for dir in "$REPO/extensions"/*/; do
        [ -d "$dir" ] || continue
        name=$(basename "$dir")
        echo "  $name.ext"
        (cd "$dir" && zip -rq "$DIST/$name.ext" . \
            --exclude "README.md" --exclude "*.zip" --exclude "*.ext" --exclude "*.mod")
    done
fi

if [ -d "$REPO/modules" ]; then
    for dir in "$REPO/modules"/*/; do
        [ -d "$dir" ] || continue
        name=$(basename "$dir")
        echo "  $name.mod"
        (cd "$dir" && zip -rq "$DIST/$name.mod" . \
            --exclude "README.md" --exclude "*.zip")
    done
fi

echo ""
ls -lh "$DIST"
