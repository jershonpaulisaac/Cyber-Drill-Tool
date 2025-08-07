#!/bin/bash

# Colors
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"

clear
echo -e "${CYAN}=============================="
echo -e "      WHOIS Lookup Tool"
echo -e "==============================${RESET}"

# Read user input
read -p "Enter domain or IP for WHOIS lookup: " target

# Validate input
if [[ -z "$target" ]]; then
  echo -e "${RED}[!] Input cannot be empty.${RESET}"
  read -p "Press Enter to return to menu..."
  exit 1
fi

# Simple regex for IP address (IPv4)
ip_regex='^([0-9]{1,3}\.){3}[0-9]{1,3}$'
domain_regex='^([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$'

if [[ "$target" =~ $ip_regex ]]; then
  echo -e "${GREEN}[*] Detected IP address: $target${RESET}"
elif [[ "$target" =~ $domain_regex ]]; then
  echo -e "${GREEN}[*] Detected domain name: $target${RESET}"
else
  echo -e "${YELLOW}[!] Warning: Input doesn't look like a valid domain or IPv4 address.${RESET}"
fi

echo

# Check if whois command exists
if command -v whois >/dev/null 2>&1; then
  echo -e "${CYAN}[*] Fetching WHOIS info using 'whois' command...${RESET}\n"
  whois "$target"
else
  echo -e "${YELLOW}[!] 'whois' command not found. Trying RDAP lookup via curl...${RESET}"

  # Check if curl is installed
  if ! command -v curl >/dev/null 2>&1; then
    echo -e "${RED}[!] Neither 'whois' nor 'curl' command found. Please install one of them.${RESET}"
    read -p "Press Enter to return to menu..."
    exit 1
  fi

  # Use RDAP service to fetch JSON info
  rdap_url="https://rdap.org/domain/$target"
  echo -e "${CYAN}[*] Fetching RDAP info for $target ...${RESET}"
  
  response=$(curl -s --fail "$rdap_url")
  if [[ $? -ne 0 || -z "$response" ]]; then
    echo -e "${RED}[!] Failed to retrieve data from RDAP service.${RESET}"
  else
    # Pretty print if jq available
    if command -v jq >/dev/null 2>&1; then
      echo "$response" | jq
    else
      echo "$response"
      echo -e "${YELLOW}Tip: Install 'jq' to see formatted output (e.g., sudo apt install jq)${RESET}"
    fi
  fi
fi

echo
read -p "Press Enter to return to menu..."
