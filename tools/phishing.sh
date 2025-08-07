#!/bin/bash

echo "[*] Realistic Phishing Page Simulator (Simulation Only)"
echo "Choose a website to simulate:"
options=("Facebook" "Instagram" "Google" "Amazon" "Netflix" "Twitter" "LinkedIn" "Snapchat" "Spotify" "GitHub")

select opt in "${options[@]}"; do
    if [[ -n "$opt" ]]; then
        site=$(echo "$opt" | tr '[:upper:]' '[:lower:]')
        break
    else
        echo "Invalid option. Please select a valid number."
    fi
done

# Create output directory
OUTDIR="fake_sites/$site"
mkdir -p "$OUTDIR"

# Site-specific logos (use official logo URLs for realism)
declare -A logos
logos=(
  [facebook]="https://www.facebook.com/images/fb_icon_325x325.png"
  [instagram]="https://upload.wikimedia.org/wikipedia/commons/a/a5/Instagram_icon.png"
  [google]="https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_160x56dp.png"
  [amazon]="https://upload.wikimedia.org/wikipedia/commons/a/a9/Amazon_logo.svg"
  [netflix]="https://upload.wikimedia.org/wikipedia/commons/0/08/Netflix_2015_logo.svg"
  [twitter]="https://upload.wikimedia.org/wikipedia/commons/6/6f/Logo_of_Twitter.svg"
  [linkedin]="https://upload.wikimedia.org/wikipedia/commons/c/ca/LinkedIn_logo_initials.png"
  [snapchat]="https://upload.wikimedia.org/wikipedia/en/a/ad/Snapchat_logo.svg"
  [spotify]="https://upload.wikimedia.org/wikipedia/commons/8/84/Spotify_icon.svg"
  [github]="https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png"
)

# Create fake login page
cat > "$OUTDIR/index.html" <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>$opt Login</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f9f9f9;
      text-align: center;
      padding-top: 50px;
    }
    .login-box {
      background: #fff;
      max-width: 400px;
      margin: auto;
      padding: 40px;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    img.logo {
      max-width: 100px;
      margin-bottom: 20px;
    }
    input[type="text"], input[type="password"] {
      width: 90%;
      padding: 12px;
      margin: 10px 0;
      border: 1px solid #ccc;
      border-radius: 5px;
    }
    input[type="submit"] {
      background: #4CAF50;
      color: white;
      padding: 12px;
      width: 95%;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }
    .notice {
      color: red;
      margin-top: 20px;
      font-size: 0.85em;
    }
  </style>
</head>
<body>
  <div class="login-box">
    <img src="${logos[$site]}" alt="$opt Logo" class="logo" />
    <h2>Login to $opt</h2>
    <form onsubmit="alert('This is a simulation. No data is collected.'); return false;">
      <input type="text" placeholder="Username or Email" required><br>
      <input type="password" placeholder="Password" required><br>
      <input type="submit" value="Log In">
    </form>
    <div class="notice">This is a safe simulation for educational purposes only.</div>
  </div>
</body>
</html>
EOF

# Auto open in browser
PAGE_PATH="$(realpath "$OUTDIR/index.html")"
echo "[+] Simulated phishing page created at: $PAGE_PATH"

if command -v xdg-open &>/dev/null; then
  xdg-open "$PAGE_PATH" &
elif command -v open &>/dev/null; then
  open "$PAGE_PATH" &
elif command -v start &>/dev/null; then
  start "" "$PAGE_PATH" &
else
  echo "Please open the page manually."
fi

read -p "Press Enter to return to menu..."
