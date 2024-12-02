#!/bin/bash

# Define directories and files
NOTES_DIR="$HOME/.fxb/notes"
ENV_FILE="$HOME/.fxb/.env"

# Check if curl is installed
if ! command -v curl &> /dev/null; then
  echo "Error: curl is required but not installed. Please install curl."
  exit 1
fi

# Create notes directory if it doesn't exist
if [ ! -d "$NOTES_DIR" ]; then
  mkdir -p "$NOTES_DIR"
fi

# Create .env file if it doesn't exist
if [ ! -f "$ENV_FILE" ]; then
  mkdir -p "$(dirname "$ENV_FILE")"
  touch "$ENV_FILE"
  echo "WEBHOOK_URL='your_webhook_url_here'" > "$ENV_FILE"
  echo "Please edit $ENV_FILE to include your webhook URL."
  exit 1
fi

# Source the .env file
source "$ENV_FILE"

# Check if WEBHOOK_URL is set
if [ -z "$WEBHOOK_URL" ]; then
  echo "Error: WEBHOOK_URL is not set in $ENV_FILE"
  exit 1
fi

# Generate filename
FILENAME="fxb$(date '+%Y%m%d-%H%M%S').md"
FILEPATH="$NOTES_DIR/$FILENAME"

# Open the file in vim
vim "$FILEPATH"

# Check if the file has content
if [ ! -s "$FILEPATH" ]; then
  echo "No content to send. Exiting."
  exit 0
fi

# Read file contents
FILE_CONTENTS=$(cat "$FILEPATH")

# Send GET request with URL-encoded data
curl --get \
  --data-urlencode "title=$FILENAME" \
  --data-urlencode "content=$FILE_CONTENTS" \
  "$WEBHOOK_URL"

# Exit the script
exit 0
