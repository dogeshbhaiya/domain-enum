#!/bin/bash
set -euo pipefail

DOMAIN=${1:-}
if [ -z "$DOMAIN" ]; then
  echo "Usage: $0 <domain>"
  exit 1
fi

: "${PD_API_KEY:?Set PD_API_KEY}"
: "${VT_API_KEY:?Set VT_API_KEY}"

OUTPUT_DIR="${DOMAIN}_results"
SUBDOMAIN_FILE="${OUTPUT_DIR}/${DOMAIN}_subdomains.txt"
mkdir -p "$OUTPUT_DIR"

check_dependency() {
  command -v "$1" &>/dev/null || { echo "Missing $1"; exit 1; }
}

TOOLS=(curl jq assetfinder subfinder findomain anew gau unfurl)
for t in "${TOOLS[@]}"; do check_dependency "$t"; done

curl -s "https://dns.projectdiscovery.io/dns/$DOMAIN/subdomains" -H "Authorization: $PD_API_KEY" | jq -r ".subdomains[]? | "\(.).$DOMAIN"" > "$OUTPUT_DIR/projectdiscovery.txt"

curl -s "https://crt.sh/?q=%25.$DOMAIN&output=json" | jq -r '.[].name_value' | sort -u > "$OUTPUT_DIR/crtsh.txt"

curl -s -H "x-apikey: $VT_API_KEY" "https://www.virustotal.com/api/v3/domains/$DOMAIN/subdomains" | jq -r '.data[]?.id' > "$OUTPUT_DIR/virustotal.txt"

cat "$OUTPUT_DIR"/*.txt | sort -u | anew "$SUBDOMAIN_FILE"

echo "Done. Results in $SUBDOMAIN_FILE"
