#!/bin/bash

# Check if jq is installed for pretty JSON output
has_jq=false
if command -v jq &>/dev/null; then
  has_jq=true
fi

get_public_ip() {
  echo "$(curl -s ifconfig.me)"
}

resolve_domain_to_ip() {
  local domain=$1
  # Use dig or nslookup depending on availability
  if command -v dig &>/dev/null; then
    dig +short "$domain" | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | head -n1
  elif command -v nslookup &>/dev/null; then
    nslookup "$domain" | awk '/^Address: / { print $2 }' | head -n1
  else
    echo ""
  fi
}

extract_domain() {
  # Extract domain from a full URL (strip protocol and path)
  echo "$1" | sed -E 's#^(https?://)?([^/]+).*#\2#'
}

while true; do
  clear
  read -p "Enter IP, domain, or full URL (leave blank for your public IP): " input

  if [[ -z "$input" ]]; then
    ip=$(get_public_ip)
    echo "[*] No input provided. Using your public IP: $ip"
  else
    # Extract domain if input looks like URL
    if [[ "$input" =~ ^https?:// ]]; then
      domain=$(extract_domain "$input")
      echo "[*] Extracted domain: $domain"
    else
      domain=$input
    fi

    # Check if input is IP address
    if [[ "$domain" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
      ip=$domain
      echo "[*] IP address detected: $ip"
    else
      # Resolve domain to IP
      echo "[*] Resolving domain $domain ..."
      ip=$(resolve_domain_to_ip "$domain")
      if [[ -z "$ip" ]]; then
        echo "[-] Could not resolve domain to IP. Please check your input."
        read -p "Press Enter to try again..."
        continue
      fi
      echo "[*] Domain resolved to IP: $ip"
    fi
  fi

  echo "[*] Fetching info for $ip ..."
  response=$(curl -s --max-time 10 "https://ipinfo.io/$ip")

  # Check if response contains IP
  if echo "$response" | grep -q '"ip"'; then
    if $has_jq; then
      echo "$response" | jq
    else
      echo "$response"
      echo "Tip: Install 'jq' for formatted output (sudo apt install jq)"
    fi
  else
    echo "[-] Failed to get info from ipinfo.io or invalid IP."
  fi

  # Ask user to continue or return to main menu (exit)
  while true; do
    read -p "Check another IP/domain? (y = yes, n = no, exit): " yn
    case $yn in
      [Yy]* ) break ;;  # Continue loop for another check
      [Nn]* ) echo "Returning to main menu..."; exit 0 ;; # Exit script or modify to go to your menu
      exit ) echo "Exiting..."; exit 0 ;;
      * ) echo "Please answer y (yes), n (no), or exit." ;;
    esac
  done
done
