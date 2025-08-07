#!/bin/bash

# Fixed key and IV (16 bytes hex)
KEY="0123456789abcdef"
IV="abcdef9876543210"

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

encrypt() {
  echo -n "$1" | openssl enc -aes-256-cbc -a -salt -K $(echo -n $KEY | xxd -p) -iv $(echo -n $IV | xxd -p)
}

decrypt() {
  echo "$1" | openssl enc -aes-256-cbc -a -d -salt -K $(echo -n $KEY | xxd -p) -iv $(echo -n $IV | xxd -p)
}

while true; do
  clear
  echo "====== AES-256-CBC Encryption & Decryption (No Password) ======"
  echo "1) Encrypt text"
  echo "2) Decrypt text"
  echo "3) Exit"
  read -p "Choose an option: " choice

  case $choice in
    1)
      read -p "Enter text to encrypt: " txt
      output=$(encrypt "$txt")
      echo -e "\nEncrypted output:"
      echo "$output"
      ;;
    2)
      read -p "Enter base64 encrypted text to decrypt: " txt
      output=$(decrypt "$txt")
      echo -e "\nDecrypted output:"
      echo "$output"
      ;;
    3)
      echo "Exiting..."
      break
      ;;
    *)
      echo "Invalid option, please try again."
      ;;
  esac

  # Ask to copy output
  read -p "Copy output to clipboard? (y/n): " copy_choice
  if [[ "$copy_choice" =~ ^[Yy]$ ]]; then
    if copy_to_clipboard "$output"; then
      echo "Copied to clipboard!"
    else
      echo "Failed to copy to clipboard."
    fi
  fi

  echo
  read -p "Press Enter to continue..."
done
