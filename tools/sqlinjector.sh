#!/bin/bash

echo "======================================="
echo "         [*] SQL Injection Tester       "
echo "              (Simulation)             "
echo "======================================="
read -p "Enter target URL (e.g., https://example.com/login.php?id=): " url

echo ""
echo "[*] Simulating SQL Injection on: $url"
echo ""

# Simulated payload categories
basic_payloads=(
  "' OR '1'='1"
  "' OR 1=1 --"
  "' OR '1'='1' --"
  "' OR ''='"
)

union_payloads=(
  "' UNION SELECT NULL,NULL--"
  "' UNION SELECT 1,2,3--"
  "' UNION SELECT username, password FROM users--"
)

blind_payloads=(
  "' AND 1=1 --"
  "' AND 1=2 --"
  "' OR SLEEP(5)--"
)

# Fake result generator
simulate_response() {
  payload="$1"
  sleep 0.3
  echo "[+] Payload: $payload"
  case $((RANDOM % 3)) in
    0) echo "    ↳ Simulated Result: No error. Page loaded normally." ;;
    1) echo "    ↳ Simulated Result: SQL error message returned!" ;;
    2) echo "    ↳ Simulated Result: Delayed response detected (possible blind SQLi)." ;;
  esac
}

echo "=== Testing Basic Authentication Bypass Payloads ==="
for p in "${basic_payloads[@]}"; do
  simulate_response "$p"
done

echo ""
echo "=== Testing UNION-based Extraction Payloads ==="
for p in "${union_payloads[@]}"; do
  simulate_response "$p"
done

echo ""
echo "=== Testing Blind SQL Injection Payloads ==="
for p in "${blind_payloads[@]}"; do
  simulate_response "$p"
done

echo ""
echo "[!] This test is purely simulated. No real HTTP requests were made."
echo "[*] Use tools like sqlmap, Burp Suite, or custom scripts for real testing (with legal authorization)."
read -p "Press Enter to return to menu..."
