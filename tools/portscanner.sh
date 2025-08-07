#!/bin/bash

echo "[*] Advanced Port Scanner (No nmap required)"
read -p "Enter IP or domain to scan: " target

# Check for netcat (nc) availability
has_nc=false
if command -v nc >/dev/null 2>&1; then
  has_nc=true
fi

# Common port list (can be extended)
common_ports=(
  21 22 23 25 53 80 110 139 143 443
  445 587 8080 8443 3306 3389 5900
)

echo "[*] Scanning common ports on $target..."
echo "--------------------------------------"

for port in "${common_ports[@]}"; do
  if $has_nc; then
    timeout 1 nc -zv "$target" "$port" &>/dev/null
  else
    timeout 1 bash -c "echo > /dev/tcp/$target/$port" &>/dev/null
  fi

  if [[ $? -eq 0 ]]; then
    echo "Port $port is OPEN"
  else
    echo "Port $port is CLOSED"
  fi
done

echo "--------------------------------------"
read -p "Scan complete. Press Enter to return to menu..."
