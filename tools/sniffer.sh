#!/bin/bash

echo "=================================="
echo "[*] Simulated Network Sniffer"
echo "     (No external tools used)"
echo "=================================="
sleep 1

# Generate random packet details
generate_packet() {
  src_ip="$((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256))"
  dst_ip="$((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256))"
  
  # Random protocols
  protocols=("TCP" "UDP" "HTTP" "HTTPS" "DNS" "ICMP" "SSH")
  protocol=${protocols[$RANDOM % ${#protocols[@]}]}
  
  # Random port
  port=$(( (RANDOM % 64512) + 1024 ))

  echo "Packet: Src=$src_ip  Dst=$dst_ip  Protocol=$protocol  Port=$port"
}

# Simulate live traffic (10 packets per second)
for i in {1..50}; do
  generate_packet
  sleep 0.1
done

echo "=================================="
echo "[*] End of simulated capture"
read -p "Press Enter to return to menu..."
