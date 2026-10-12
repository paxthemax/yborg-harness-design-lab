#!/usr/bin/env bash
set -euo pipefail
DIAGRAM_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DIAGRAM_PROFILE="$(mktemp -d "${TMPDIR:-/tmp}/lab-diagram-export.XXXXXX")"
trap 'rm -rf -- "$DIAGRAM_PROFILE"' EXIT
export_diagram() {
  chromium --headless --no-sandbox --disable-gpu --hide-scrollbars \
    --user-data-dir="$DIAGRAM_PROFILE" --force-device-scale-factor="${3:-1}" \
    --window-size="${4:-1400},$2" --screenshot="$DIAGRAM_DIR/$1.png" \
    "file://$DIAGRAM_DIR/$1.html"
}
export_named() {
  case "$1" in
    harness-architecture) export_diagram "$1" 1820 ;;
    investigation-lifecycle) export_diagram "$1" 1800 ;;
    premise-change-flow) export_diagram "$1" 1450 ;;
    human-agent-audit-flow) export_diagram "$1" 3120 2 1440 ;;
    harness-architecture-clean) export_diagram "$1" 1600 2 ;;
    *) printf 'Unknown diagram: %s\n' "$1" >&2; return 1 ;;
  esac
}
if (( $# )); then
  for DIAGRAM_NAME in "$@"; do export_named "$DIAGRAM_NAME"; done
else
  for DIAGRAM_NAME in harness-architecture investigation-lifecycle premise-change-flow human-agent-audit-flow harness-architecture-clean; do
    export_named "$DIAGRAM_NAME"
  done
fi
