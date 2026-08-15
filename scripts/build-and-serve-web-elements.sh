#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

echo "Running automation to prepare ngx-build-plus..."
bash scripts/automate-angular-elements.sh

echo "Building Angular Elements bundle for 'web-elements-app'..."
# use -p to ensure ng is executed correctly via npx
npx -p @angular/cli ng build web-elements-app --configuration production --output-hashing=none --extra-webpack-config webpack.extra.js --single-bundle true

# find the most likely dist directory
POSSIBLE=("dist/web-elements-app" "dist/apps/web-elements-app" "dist")
BUILD_DIR=""
for d in "${POSSIBLE[@]}"; do
  if [ -d "$d" ]; then
    # prefer a folder that contains files for web-elements-app
    if ls "$d"/*.js >/dev/null 2>&1 || ls "$d"/web-elements-elements.* >/dev/null 2>&1; then
      BUILD_DIR="$d"
      break
    fi
  fi
done

if [ -z "$BUILD_DIR" ]; then
  echo "Could not find build output in expected locations. Searching 'dist' recursively..."
  BUILD_DIR=$(find dist -maxdepth 2 -type f -name "*.js" -print -quit | xargs -I{} dirname {}) || true
fi

if [ -z "$BUILD_DIR" ]; then
  echo "Build output not found. Exiting with error." >&2
  exit 1
fi

echo "Using build directory: $BUILD_DIR"

DEMO_DIST_DIR="apps/web-elements-builder/demo/dist"
mkdir -p "$DEMO_DIST_DIR"

echo "Copying JS bundles to demo dist..."
# copy JS files produced by the build
cp -v "$BUILD_DIR"/*.js "$DEMO_DIST_DIR/" || true

echo "Copying other static assets if present (css, assets)..."
cp -v -R "$BUILD_DIR"/*.css "$DEMO_DIST_DIR/" 2>/dev/null || true
cp -v -R "$BUILD_DIR"/assets "$DEMO_DIST_DIR/" 2>/dev/null || true

echo "Bundle copied to $DEMO_DIST_DIR"

echo "Serving demo from apps/web-elements-builder/demo (demo will load scripts from ./dist)..."
if command -v serve >/dev/null 2>&1; then
  npx serve apps/web-elements-builder/demo
elif command -v python3 >/dev/null 2>&1; then
  (cd apps/web-elements-builder/demo && python3 -m http.server 5000)
else
  echo "No 'serve' or 'python3' available to start a static server. Please serve apps/web-elements-builder/demo manually." >&2
fi
