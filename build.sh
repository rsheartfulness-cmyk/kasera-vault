#!/bin/bash
# Cloudflare Pages Build Script
# Injects environment variables into index.html at build time.

set -euo pipefail

escape_sed_replacement() {
  printf '%s' "$1" | sed 's/[&|\\]/\\&/g'
}

FIREBASE_API_KEY_ESCAPED="$(escape_sed_replacement "${FIREBASE_API_KEY:-}")"
FIREBASE_AUTH_DOMAIN_ESCAPED="$(escape_sed_replacement "${FIREBASE_AUTH_DOMAIN:-}")"
FIREBASE_PROJECT_ID_ESCAPED="$(escape_sed_replacement "${FIREBASE_PROJECT_ID:-}")"
FIREBASE_STORAGE_BUCKET_ESCAPED="$(escape_sed_replacement "${FIREBASE_STORAGE_BUCKET:-}")"
FIREBASE_MESSAGING_SENDER_ID_ESCAPED="$(escape_sed_replacement "${FIREBASE_MESSAGING_SENDER_ID:-}")"
FIREBASE_APP_ID_ESCAPED="$(escape_sed_replacement "${FIREBASE_APP_ID:-}")"
APPS_SCRIPT_URL_ESCAPED="$(escape_sed_replacement "${APPS_SCRIPT_URL:-}")"

sed -i "s|__FIREBASE_API_KEY__|$FIREBASE_API_KEY_ESCAPED|g" index.html
sed -i "s|__FIREBASE_AUTH_DOMAIN__|$FIREBASE_AUTH_DOMAIN_ESCAPED|g" index.html
sed -i "s|__FIREBASE_PROJECT_ID__|$FIREBASE_PROJECT_ID_ESCAPED|g" index.html
sed -i "s|__FIREBASE_STORAGE_BUCKET__|$FIREBASE_STORAGE_BUCKET_ESCAPED|g" index.html
sed -i "s|__FIREBASE_MESSAGING_SENDER_ID__|$FIREBASE_MESSAGING_SENDER_ID_ESCAPED|g" index.html
sed -i "s|__FIREBASE_APP_ID__|$FIREBASE_APP_ID_ESCAPED|g" index.html
sed -i "s|__APPS_SCRIPT_URL__|$APPS_SCRIPT_URL_ESCAPED|g" index.html

echo "Secrets injected successfully"
