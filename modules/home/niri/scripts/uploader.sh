#!/usr/bin/env bash

# --- SINGLE INSTANCE LOCK ---
LOCKFILE="/tmp/screenshot_uploader.lock"
exec 200>"$LOCKFILE"
if ! flock -n 200; then
  # Another instance is actively running
  exit 0
fi

# Store PID into lockfile for easy debugging
echo $$ >&200

# Ensure lock FD is NOT inherited by child processes (Satty, Grim, Curl, etc.)
# This prevents stale locks when background GUI tools open
exec 200>&-

# Configuration
LOG_DIR="$HOME/.config/niri/data"
API_URL="https://segs.lol/api/upload"

# Cleanup trap to remove leftover lock & temp files on exit
cleanup() {
  rm -f "$LOCKFILE" "${file:-}" "${annotated_file:-}"
}
trap cleanup EXIT

# Parse CLI flags
FAST_MODE=false
PIPE_MODE=false

for arg in "$@"; do
  case "$arg" in
  --fast) FAST_MODE=true ;;
  --pipe) PIPE_MODE=true ;;
  esac
done

send_toast() {
  local title="$1"
  local body="$2"
  local type="${3:-low}"
  local icon="${4:-camera-photo}"

  case "$type" in
  warning | error) urgency="critical" ;;
  notice | info) urgency="normal" ;;
  *) urgency="$type" ;;
  esac

  local json
  json=$(jq -n -c \
    --arg app_name "Screenshot" \
    --arg summary "$title" \
    --arg body "$body" \
    --arg urgency "$urgency" \
    --arg icon "$icon" \
    --argjson timeout_ms 4000 \
    '{app_name: $app_name, summary: $summary, body: $body, urgency: $urgency, timeout_ms: $timeout_ms, icon: $icon}')

  noctalia msg notification-show "$json"
}

file=$(mktemp --suffix=.png /tmp/kappa_XXXXXX)

# 1. Capture Image
if [ "$PIPE_MODE" = true ]; then
  cat >"$file"
else
  grim -g "$(slurp)" "$file"
fi

if [[ ! -s $file ]]; then
  send_toast "Screenshot" "Cancelled by user or capture failed" "low" "camera-photo"
  exit 1
fi

upload_target="$file"

# 2. Annotation Step (Only run if NOT in fast mode)
if [ "$FAST_MODE" = false ]; then
  annotated_file=$(mktemp --suffix=.png /tmp/kappa_edited_XXXXXX)

  # Run Satty
  satty --filename "$file" --output-filename - --early-exit >"$annotated_file"

  # If closed without saving (Esc), cancel upload
  if [[ ! -s $annotated_file ]]; then
    send_toast "Screenshot" "Annotation cancelled" "low" "camera-photo"
    exit 1
  fi

  upload_target="$annotated_file"
fi

# 3. Upload to segs.lol
if ! response=$(curl -sS -F "file=@$upload_target" "$API_URL"); then
  send_toast "Upload Failed" "Could not connect to segs.lol" "error" "network-error"
  exit 1
fi

link=$(echo "$response" | jq -r .link)
delete=$(echo "$response" | jq -r .delete)

# 4. Copy to Clipboard
echo -n "$link" | wl-copy

# 5. Success Notification
send_toast "Uploaded successfully!" "Link: $link" "notice" "content-copy"

# 6. Logging
mkdir -p "$LOG_DIR"
log_file="$LOG_DIR/$(date +%F).txt"

{
  echo "[$(date +%T)]"
  echo "View:   $link"
  echo "Delete: $delete"
  echo ""
} >>"$log_file"
