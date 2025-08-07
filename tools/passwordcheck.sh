#!/bin/bash
read -p "Enter password to check strength: " pass

length=${#pass}
if [[ $length -lt 6 ]]; then
  echo "Password too short."
elif [[ $pass =~ [0-9] ]] && [[ $pass =~ [A-Z] ]] && [[ $pass =~ [a-z] ]] && [[ $pass =~ [\@\#\$\%\^\&\*\-\_] ]]; then
  echo "Strong password."
else
  echo "Weak password. Try including uppercase, lowercase, numbers, and symbols."
fi

read -p "Press Enter to return to menu..."
