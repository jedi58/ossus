#!/usr/bin/env bash
set -euo pipefail

echo $'\e[1;97;44m

 Shai-Hulud 2.0 / NPM Supply-Chain Scanner 
\e[0m'

CSV_URL="https://raw.githubusercontent.com/wiz-sec-public/wiz-research-iocs/main/reports/shai-hulud-2-packages.csv"
CSV_FILE="$(mktemp)"

echo "→ Downloading latest Wiz IOC package list…"
curl -sSL "$CSV_URL" -o "$CSV_FILE"

if [ ! -f package-lock.json ]; then
    echo "❌ package-lock.json not found — please run npm install first."
    exit 1
fi

echo "→ Extracting installed dependencies from package-lock.json…"
jq -r '
  .. | objects
  | select(has("version") and has("name"))
  | "\(.name)@\(.version)"
' package-lock.json | sort -u > installed.txt

echo "→ Checking for compromised package versions…"
BAD_MATCHES=$(grep -Fx -f installed.txt "$CSV_FILE" || true)

if [ -n "$BAD_MATCHES" ]; then
    echo "❌ Found compromised npm packages:"
    echo "$BAD_MATCHES"
    FOUND=1
else
    echo "✓ No compromised npm packages found in dependency tree."
fi

echo
echo "→ Checking for additional IOCs…"

FOUND_IOC=0

MALWARE_FILES=(
  "setup_bun.js"
  "bun_environment.js"
)

echo "  • Searching for malicious bun files…"
for f in "${MALWARE_FILES[@]}"; do
    if find . -type f -name "$f" | grep -q .; then
        echo "    ❌ Found malware file: $f"
        FOUND_IOC=1
    fi
done
if [ $FOUND_IOC -eq 0 ]; then
    echo "    ✓ No malicious bun files found"
fi

# --- IOC B: check file hashes ---
declare -a MALICIOUS_HASHES=(
  "a3894003ad1d293ba96d77881ccd2071446dc3f65f434669b49b3da92421901a"
  "62ee164b9b306250c1172583f138c9614139264f889fa99614903c12755468d0"
  "cbb9bc5a8496243e02f3cc080efbe3e4a1430ba0671f2e43a202bf45b05479cd"
  "f099c5d9ec417d4445a0328ac0ada9cde79fc37410914103ae9c609cbc0ee068"
  "f1df4896244500671eb4aa63ebb48ea11cee196fafaa0e9874e17b24ac053c02"
  "9d59fd0bcc14b671079824c704575f201b74276238dc07a9c12a93a84195648a"
  "e0250076c1d2ac38777ea8f542431daf61fcbaab0ca9c196614b28065ef5b918"
)

echo "  • Hash scanning for known malicious payloads (SHA-256)…"
while IFS= read -r file; do
    HASH=$(sha256sum "$file" | awk '{print $1}')
    for MAL in "${MALICIOUS_HASHES[@]}"; do
        if [[ "$HASH" == "$MAL" ]]; then
            echo "    ❌ Malicious file hash detected: $file"
            FOUND_IOC=1
        fi
    done
done < <(find . -type f -name "*.js")

if [ $FOUND_IOC -eq 0 ]; then
    echo "    ✓ No known malicious file hashes found"
fi

echo "  • Searching for references to bun.sh domain…"
if grep -R "bun.sh" . --include="*.js" >/dev/null 2>&1; then
    echo "    ❌ bun.sh domain reference found (possibly malware loader)"
    FOUND_IOC=1
else
    echo "    ✓ No suspicious bun.sh references found"
fi

echo "  • Searching for suspicious GitHub repo names (18-char random)…"
if grep -R "github\.com/[0-9a-z]\{18\}" . --include="*.js" | grep -v "author" >/dev/null 2>&1; then
    echo "    ❌ Exfiltration repository pattern detected"
    FOUND_IOC=1
else
    echo "    ✓ No exfiltration GitHub repo patterns found"
fi

echo
if [ "${FOUND_IOC:-0}" -eq 1 ] || [ "${FOUND:-0}" -eq 1 ]; then
    echo "⚠️  Suspicious indicators detected. Please investigate this project immediately."
    exit 1
else
    echo "✅ No Shai-Hulud 2.0 indicators detected."
fi

