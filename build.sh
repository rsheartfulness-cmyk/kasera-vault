#!/bin/bash
# Cloudflare Pages Build Script
# Injects environment variables into index.html at build time.

set -euo pipefail

: "${FIREBASE_API_KEY:?Missing FIREBASE_API_KEY. Add it in Cloudflare Pages environment variables.}"

FIREBASE_AUTH_DOMAIN="${FIREBASE_AUTH_DOMAIN:-kasera-delegation.firebaseapp.com}"
FIREBASE_PROJECT_ID="${FIREBASE_PROJECT_ID:-kasera-delegation}"
FIREBASE_STORAGE_BUCKET="${FIREBASE_STORAGE_BUCKET:-kasera-delegation.firebasestorage.app}"
FIREBASE_MESSAGING_SENDER_ID="${FIREBASE_MESSAGING_SENDER_ID:-117646348596}"
FIREBASE_APP_ID="${FIREBASE_APP_ID:-1:117646348596:web:07a7eaf7e1cdb32a0e5561}"
APPS_SCRIPT_URL="${APPS_SCRIPT_URL:-https://script.google.com/macros/s/AKfycbzqidcT7WDelCIYBskExWhjW4VBpL_pPcxQfgilLB0BnseW5K4sSkhitz_XfZ8iZEAd/exec}"

escape_sed_replacement() {
  printf '%s' "$1" | sed 's/[&|\\]/\\&/g'
}

FIREBASE_API_KEY_ESCAPED="$(escape_sed_replacement "$FIREBASE_API_KEY")"
FIREBASE_AUTH_DOMAIN_ESCAPED="$(escape_sed_replacement "$FIREBASE_AUTH_DOMAIN")"
FIREBASE_PROJECT_ID_ESCAPED="$(escape_sed_replacement "$FIREBASE_PROJECT_ID")"
FIREBASE_STORAGE_BUCKET_ESCAPED="$(escape_sed_replacement "$FIREBASE_STORAGE_BUCKET")"
FIREBASE_MESSAGING_SENDER_ID_ESCAPED="$(escape_sed_replacement "$FIREBASE_MESSAGING_SENDER_ID")"
FIREBASE_APP_ID_ESCAPED="$(escape_sed_replacement "$FIREBASE_APP_ID")"
APPS_SCRIPT_URL_ESCAPED="$(escape_sed_replacement "$APPS_SCRIPT_URL")"

sed -i "s|__FIREBASE_API_KEY__|$FIREBASE_API_KEY_ESCAPED|g" index.html
sed -i "s|__FIREBASE_AUTH_DOMAIN__|$FIREBASE_AUTH_DOMAIN_ESCAPED|g" index.html
sed -i "s|__FIREBASE_PROJECT_ID__|$FIREBASE_PROJECT_ID_ESCAPED|g" index.html
sed -i "s|__FIREBASE_STORAGE_BUCKET__|$FIREBASE_STORAGE_BUCKET_ESCAPED|g" index.html
sed -i "s|__FIREBASE_MESSAGING_SENDER_ID__|$FIREBASE_MESSAGING_SENDER_ID_ESCAPED|g" index.html
sed -i "s|__FIREBASE_APP_ID__|$FIREBASE_APP_ID_ESCAPED|g" index.html
sed -i "s|__APPS_SCRIPT_URL__|$APPS_SCRIPT_URL_ESCAPED|g" index.html

echo "Secrets injected successfully"
