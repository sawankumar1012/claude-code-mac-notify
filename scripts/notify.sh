#!/usr/bin/env bash
# Claude Code hook: fires on Stop and Notification events.
# Reads the hook JSON payload from stdin and pops a macOS notification.

set -u

# No-op on non-macOS.
if [[ "$(uname)" != "Darwin" ]]; then
  exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

input="$(cat)"

# Extract the hook event type (Stop or Notification).
hook_event="$(printf '%s' "$input" | python3 -c '
import json, sys
try:
    data = json.load(sys.stdin)
    sys.stdout.write(data.get("hook_event_name", "") or "")
except Exception:
    pass
' 2>/dev/null)"

# Extract working directory to derive project name.
cwd="$(printf '%s' "$input" | python3 -c '
import json, sys
try:
    data = json.load(sys.stdin)
    sys.stdout.write(data.get("cwd", "") or "")
except Exception:
    pass
' 2>/dev/null)"

project="Claude Code"
if [[ -n "$cwd" ]]; then
  project="$(basename "$cwd")"
fi

# Pick message based on event type.
if [[ "$hook_event" == "Notification" ]]; then
  message="Waiting for input"
else
  message="Turn finished"
fi

/usr/bin/osascript "${SCRIPT_DIR}/notify.applescript" "$project" "$message" >/dev/null 2>&1 || true

exit 0
