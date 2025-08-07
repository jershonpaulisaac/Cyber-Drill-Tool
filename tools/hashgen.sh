#!/bin/bash

copy_to_clipboard() {
  local text="$1"
  if command -v clip.exe &>/dev/null; then
    echo -n "$text" | clip.exe
  elif command -v xclip &>/dev/null; then
    echo -n "$text" | xclip -selection clipboard
  elif command -v pbcopy &>/dev/null; then
    echo -n "$text" | pbcopy
  else
    echo "Clipboard copy not supported on this system."
    return 1
  fi
  return 0
}

while true; do
  clear
  echo "====== Advanced Hash Generator ======"
  echo "1) MD5"
  echo "2) SHA1"
  echo "3) SHA256"
  echo "4) SHA512"
  echo "5) Exit"
  read -p "Choose a hash algorithm: " choice

  if [[ "$choice" == "5" ]]; then
    echo "Exiting..."
    break
  fi

  if ! [[ "$choice" =~ ^[1-4]$ ]]; then
    echo "Invalid option. Please enter 1-5."
    sleep 2
    continue
  fi

  read -p "Enter text to hash: " txt

  case $choice in
    1) hash=$(echo -n "$txt" | md5sum | awk '{print $1}') ;;
    2) hash=$(echo -n "$txt" | sha1sum | awk '{print $1}') ;;
    3) hash=$(echo -n "$txt" | sha256sum | awk '{print $1}') ;;
    4) hash=$(echo -n "$txt" | sha512sum | awk '{print $1}') ;;
  esac

  echo -e "\nHash result:\n$hash"

  read -p "Copy hash to clipboard? (y/n): " copy_choice
  if [[ "$copy_choice" =~ ^[Yy]$ ]]; then
    if copy_to_clipboard "$hash"; then
      echo "Copied to clipboard!"
    else
      echo "Failed to copy to clipboard."
    fi
  fi

  read -p "Press Enter to continue..."
done
 