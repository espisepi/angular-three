Builder para generar bundles de los web components

Objetivo
- Tomar la salida compilada de `libs/web-components` y generar bundles independientes (UMD/ESM) para consumo por clientes.

Contenido creado
- `apps/web-elements-builder/rollup.config.js` (config básica de ejemplo)
- `apps/web-elements-builder/src/main.ts` (entry que importa la librería y registra elementos)

Uso sugerido
1. Compila la librería primero (ver `libs/web-components` README).
2. Desde la carpeta del builder, ejecuta rollup para generar bundles:
```bash
pnpm add -w -D rollup @rollup/plugin-node-resolve @rollup/plugin-commonjs rollup-plugin-terser
npx rollup -c apps/web-elements-builder/rollup.config.js
```

Nota: Ajusta `rollup.config.js` según tus necesidades de externals y formátos (esm, umd, iife).
