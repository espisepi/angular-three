#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

echo "Installing workspace dependencies for Angular Elements..."
pnpm add -w @angular/elements ngx-build-plus || true

echo "Attempting to run 'ng add ngx-build-plus' (uses npx @angular/cli)..."
if command -v ng >/dev/null 2>&1; then
  ng add ngx-build-plus --skip-confirmation || true
else
  npx -y @angular/cli ng add ngx-build-plus --skip-confirmation || true
fi

echo "To produce a single-bundle Angular Elements build you must have an Angular app that imports WebComponentsModule."
echo "Run (replace <app-name> with your app that registers the elements):"
echo "  npx -y @angular/cli ng build <app-name> --prod --output-hashing=none --extra-webpack-config webpack.extra.js --single-bundle true"

echo "The script attempted to add ngx-build-plus. If you want, run the build command above now."
