#!/bin/bash

while true; do
  clear
#!/bin/bash

# Define ANSI color codes
RED='\033[0;31m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Display the heading with a banner
echo -e "${WHITE}============================================================${NC}"
echo -e "${CYAN}       _____      _                 ____           _  _ "
echo -e "      / ____|    | |              |  _  \       _ | || |      "
echo -e "     | |    _   _| |__   ___ _ __ | | | | _ __ |_|| || |      "
echo -e "     | |   | | | | '_ \ / _ \ '__|| | | || '__|| || || |      "
echo -e "     | |___| |_| | |_) |  __/ |   | |_| || |   | || || |      "
echo -e "      \_____\__, |_.__/ \___|_|   |___ / |_|   |_||_||_|      "
echo -e "             __/ |                               Toolkit      "
echo -e "            |___/                       ${NC}"
echo -e "${RED}                                  Developed By Jershon Paul R${NC}"
echo -e "${WHITE}===========================================================${NC}"


  echo "1.  Port Scanner"
  echo "2.  SQL Injection Tester"
  echo "3.  Phishing Page Simulator"
  echo "4.  XSS Attack Demo"
  echo "5.  Darkweb Access Tool"
  echo "6.  WHOIS Lookup"
  echo "7.  Password Strength Checker"
  echo "8.  Encryption/Decryption Tools"
  echo "9.  Network Sniffer"
  echo "10. Cybersecurity Tips"
  echo "11. WiFi Scanner"
  echo "12. Log Cleaner"
  echo "13. Hash Generator"
  echo "14. Email Spoof Demo"
  echo "15. IP Information"
  echo "16. Exit"
  
  read -p "Choose an option: " opt

  case $opt in
    1) bash tools/portscanner.sh ;;
    2) bash tools/sqlinjector.sh ;;
    3) bash tools/phishing.sh ;;
    4) bash tools/xss.sh ;;
    5) bash tools/darkweb.sh ;;
    6) bash tools/whois.sh ;;
    7) bash tools/passwordcheck.sh ;;
    8) bash tools/encryption.sh ;;
    9) bash tools/sniffer.sh ;;
    10) bash tools/tips.sh ;;
    11) bash tools/wifiscanner.sh ;;
    12) bash tools/logcleaner.sh ;;
    13) bash tools/hashgen.sh ;;
    14) bash tools/emailspoof.sh ;;
    15) bash tools/ipinfo.sh ;;
    16) echo "Goodbye!"; exit ;;
    *) echo "Invalid option"; sleep 1 ;;
  esac
done
