#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

print_header() {
  echo "===================================="
  echo " Web Elements — Helper Commands"
  echo "===================================="
}

pause() { read -rp $'Presiona Enter para continuar...'; }

install_deps() {
  echo "Instalando dependencias del workspace..."
  pnpm install
}

build_lib() {
  echo "Construyendo la librería Angular (libs/web-components)..."
  pnpm nx build web-components
}

build_rollup() {
  echo "Construyendo builder (Rollup) en apps/web-elements-builder..."
  pnpm --filter web-elements-builder run build
}

build_angular_elements() {
  echo "Preparando ngx-build-plus y construyendo Angular Elements (web-elements-app)..."
  pnpm add -D ngx-build-plus @angular/elements || true
  echo "Ejecutando ng add (si no se ha integrado aún)..."
  npx -p @angular/cli ng add ngx-build-plus --skip-confirmation || true
  echo "Construyendo bundle single-file..."
  npx -p @angular/cli ng build web-elements-app --configuration production --output-hashing=none --extra-webpack-config webpack.extra.js --single-bundle true
}

copy_and_serve_demo() {
  echo "Copiando bundle a apps/web-elements-builder/demo/dist y sirviendo demo..."
  mkdir -p apps/web-elements-builder/demo/dist
  cp -v dist/web-elements-app/*.js apps/web-elements-builder/demo/dist/ || true
  cp -v -R dist/web-elements-app/assets apps/web-elements-builder/demo/dist/ 2>/dev/null || true
  if command -v serve >/dev/null 2>&1; then
    npx serve apps/web-elements-builder/demo
  elif command -v python3 >/dev/null 2>&1; then
    (cd apps/web-elements-builder/demo && python3 -m http.server 5000)
  else
    echo "No se encontró 'serve' ni 'python3' para servir la demo. Instala uno o sirve estáticamente." >&2
  fi
}

publish_npm() {
  read -rp $'Ruta al directorio a publicar (ej: dist/web-elements-app) : ' PUBDIR
  if [ -z "$PUBDIR" ]; then echo "Directorio vacío, abortando."; return; fi
  if [ ! -f "$PUBDIR/package.json" ]; then
    echo "No se encontró package.json en $PUBDIR. Asegúrate de preparar uno antes de publicar."; return
  fi
  (cd "$PUBDIR" && npm publish --access public)
}

show_menu() {
  print_header
  echo "Elige una opción:"
  echo " 1) Instalar dependencias del workspace"
  echo " 2) Build: librería Angular (libs/web-components)"
  echo " 3) Build: builder Rollup (apps/web-elements-builder)"
  echo " 4) Build: Angular Elements (single-bundle)"
  echo " 5) Copiar bundle a demo y servir demo"
  echo " 6) Publicar bundle a npm"
  echo " 7) Mostrar README de comandos"
  echo " 8) Salir"
  echo
}

while true; do
  show_menu
  read -rp $'Opción: ' opt
  case "$opt" in
    1) install_deps; pause;;
    2) build_lib; pause;;
    3) build_rollup; pause;;
    4) build_angular_elements; pause;;
    5) copy_and_serve_demo; pause;;
    6) publish_npm; pause;;
    7) less WEB_COMPONENTS_COMMANDS.md || true; pause;;
    8) echo "Saliendo..."; exit 0;;
    *) echo "Opción no válida."; pause;;
  esac
done
