#!/bin/bash

# Configuration
LOG_DIR="$HOME/.config/niri/data"  # Updated to reflect Niri configuration
API_URL="https://segs.lol/api/upload"

# Function to send Noctalia Toast Notifications
send_toast() {
  local title="$1"
  local body="$2"
  local type="${3:-notice}"
  local icon="${4:-image-x-generic}"
  
  local json=$(jq -n \
    --arg title "$title" \
    --arg body "$body" \
    --arg type "$type" \
    --arg icon "$icon" \
    '{title: $title, body: $body, type: $type, icon: $icon}')

  qs -c noctalia-shell ipc call toast send "$json"
}

# 1. Prepare temporary file
file=$(mktemp --suffix=.png /tmp/kappa_XXXXXX)

# 2. Capture interactive screen region using Niri's native action
# This opens Niri's built-in interactive crop tool and saves directly to our temp file
grim -g "$(slurp)" "$file"

# Check if the file exists and has a size greater than 0 (handles user cancellation)
if [[ ! -s "$file" ]]; then
  send_toast "Screenshot" "Cancelled by user or capture failed" "warning" "camera-photo"
  rm -f "$file"
  exit 1
fi

# 3. Upload to segs.lol
response=$(curl -sS -F "file=@$file" "$API_URL")

if [ $? -ne 0 ]; then
  send_toast "Upload Failed" "Could not connect to segs.lol" "error" "network-error"
  rm "$file"
  exit 1
fi

link=$(echo "$response" | jq -r .link)
delete=$(echo "$response" | jq -r .delete)

# 4. Copy view link to clipboard (Niri still uses wayland, so wl-copy works perfectly)
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
} >> "$log_file"

# Cleanup temporary file
rm "$file"