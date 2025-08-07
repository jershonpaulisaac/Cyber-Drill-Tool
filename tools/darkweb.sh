#!/bin/bash
clear
echo "===================================="
echo "   DARK WEB ACCESS TOOL (Simulated)"
echo "===================================="
echo ""
echo "[*] This script is for EDUCATIONAL USE ONLY."
echo "[*] No illegal browsing is supported or allowed."
echo ""

read -p "Do you want to simulate accessing the dark web? (y/n): " answer

if [[ "$answer" != "y" ]]; then
  echo "Aborted."
  exit
fi

echo ""
echo "[*] Step 1: Installing TOR (simulated)..."
sleep 2
echo "       sudo apt install tor"
echo "       systemctl start tor"
sleep 1

echo ""
echo "[*] Step 2: Connecting to the Tor network (simulated)..."
sleep 2
echo "       tor --quiet &"
sleep 2
echo "[✓] Connected to Tor network."

echo ""
echo "[*] Step 3: Opening a .onion site in Tor browser (simulated)"
sleep 2
echo "       Example: http://duskgytldkxiuqc6.onion (DuckDuckGo - .onion)"
sleep 2

echo ""
echo "[!] You should ONLY use the official Tor Browser to visit .onion sites safely."
echo "[!] Never reveal personal information or credentials on unknown dark web sites."
echo ""
echo "REMINDER: This was a simulation only — no connection to dark web was made."
echo ""
read -p "Press Enter to return to menu..."
