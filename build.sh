#!/bin/bash
# Cloudflare Pages Build Script
# Injects environment variables into index.html at build time

sed -i "s|__FIREBASE_API_KEY__|$FIREBASE_API_KEY|g" index.html
sed -i "s|__APPS_SCRIPT_URL__|$APPS_SCRIPT_URL|g" index.html

echo "✅ Secrets injected successfully"
