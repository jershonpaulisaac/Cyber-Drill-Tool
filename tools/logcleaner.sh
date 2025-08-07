#!/bin/bash

echo "[*] Log Cleaner"
read -p "Enter the full path to the logs directory (e.g., /var/log or ../logs): " LOG_DIR

if [[ ! -d "$LOG_DIR" ]]; then
  echo "Directory not found: $LOG_DIR"
  read -p "Press Enter to return to menu..."
  exit 1
fi

echo "Logs directory set to: $LOG_DIR"
echo "Type 'list' to show logs, 'all' to clear all logs, or enter a specific log filename to clear."
read -p "Your choice: " path

if [[ "$path" == "list" ]]; then
  echo "Available log files in $LOG_DIR:"
  ls "$LOG_DIR"/*.log 2>/dev/null || echo "No log files found."
  read -p "Press Enter to return to menu..."
  exit 0
fi

confirm_clear() {
  read -p "Are you sure you want to clear '$1'? (y/n): " confirm
  [[ "$confirm" =~ ^[Yy]$ ]]
}

if [[ "$path" == "all" ]]; then
  if confirm_clear "all logs in $LOG_DIR"; then
    rm -f "$LOG_DIR"/*.log
    echo "All logs cleared."
  else
    echo "Operation cancelled."
  fi
elif [[ -f "$LOG_DIR/$path" ]]; then
  if confirm_clear "$LOG_DIR/$path"; then
    > "$LOG_DIR/$path"
    echo "Cleared $LOG_DIR/$path."
  else
    echo "Operation cancelled."
  fi
else
  echo "File not found: $LOG_DIR/$path"
fi

read -p "Press Enter to return to menu..."
