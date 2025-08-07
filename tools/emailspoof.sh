#!/bin/bash

# Clear screen and title
clear
echo "============== Cyber Drill: Email Spoof Demo =============="
echo
echo "[*] This is a safe simulation for educational purposes only."
echo

# Gather email inputs
read -p "Enter fake sender email: " sender
read -p "Enter recipient email: " recipient
read -p "Enter email subject: " subject
read -p "Enter email body message: " message

# Show options
echo
echo "Select Email Style:"
echo "1) Plain Text"
echo "2) Warning Notice"
echo "3) Alert Style"
echo "4) Friendly Format"
read -p "Choose a style (1-4): " style

# Confirm before sending
echo
echo "============================================"
echo "Please confirm the email details before simulation:"
echo "From: $sender"
echo "To: $recipient"
echo "Subject: $subject"
echo "Body: $message"
echo "Style Option: $style"
echo "============================================"
read -p "Do you want to simulate sending this email? (y/n): " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Cancelled. Returning to menu..."
    exit 0
fi

# Clear screen and simulate sending
clear
echo "Sending email..."
sleep 2
echo "Done."
sleep 1

# Display replica "sent" email as a new page
clear
echo "================== EMAIL PREVIEW =================="
echo "From: $sender"
echo "To: $recipient"
echo "Subject: $subject"
echo

case $style in
    1)
        echo "$message"
        ;;
    2)
        echo "⚠️  WARNING!"
        echo "$message"
        ;;
    3)
        echo "🚨 ALERT 🚨"
        echo "$message"
        ;;
    4)
        echo "Hi there,"
        echo "$message"
        echo
        echo "Regards,"
        echo "- $sender"
        ;;
    *)
        echo "$message"
        ;;
esac

echo "=================================================="
echo "[✔] Simulation Complete. Email was not actually sent."
echo
read -p "Press Enter to return to main menu..."
