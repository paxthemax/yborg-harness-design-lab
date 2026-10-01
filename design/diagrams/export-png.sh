#!/usr/bin/env bash
set -euo pipefail
DIAGRAM_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DIAGRAM_PROFILE="$(mktemp -d "${TMPDIR:-/tmp}/lab-diagram-export.XXXXXX")"
trap 'rm -rf -- "$DIAGRAM_PROFILE"' EXIT
export_diagram() {
  chromium --headless --no-sandbox --disable-gpu --hide-scrollbars \
    --user-data-dir="$DIAGRAM_PROFILE" --force-device-scale-factor=1 \
    --window-size="1400,$2" --screenshot="$DIAGRAM_DIR/$1.png" \
    "file://$DIAGRAM_DIR/$1.html"
}
export_diagram harness-architecture 1820
export_diagram investigation-lifecycle 1640
export_diagram premise-change-flow 1450
