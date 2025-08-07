#!/bin/bash

# Colors
CYAN="\e[36m"
YELLOW="\e[33m"
GREEN="\e[32m"
MAGENTA="\e[35m"
RESET="\e[0m"

tips=(
"🔐 Use strong, unique passwords for all your accounts."
"📧 Beware of phishing attempts — always verify email senders."
"🔄 Keep your software and devices updated regularly."
"🔒 Enable two-factor authentication wherever possible."
"🕵️ Don’t overshare personal data on social platforms."
"🌐 Use VPN on public Wi-Fi networks."
"💾 Keep backups of important data in multiple locations."
"🧠 Think twice before clicking links or downloading files."
"🛡️ Use antivirus and firewall software."
"📱 Lock your devices when not in use."
)

clear
echo -e "${CYAN}=========================================="
echo -e "        ${MAGENTA}Cybersecurity Tips - Stay Safe!${CYAN}"
echo -e "==========================================${RESET}\n"

for i in "${!tips[@]}"; do
  echo -e "${YELLOW}$((i+1)). ${tips[$i]}${RESET}"
done

echo -e "\n${GREEN}💡 Remember: Security is a continuous journey, not a destination.${RESET}\n"

read -p "Press Enter to return to menu..."
