Guía rápida: scaffolding de libs/web-components

Objetivo
- Crear una librería que contenga componentes Angular listos para convertirse en Web Components (Custom Elements) que usen three.js / angular-three.

Contenido creado
- Estructura mínima en `libs/web-components`
- Código ejemplo de un componente (`ThreeElementComponent`) que monta una escena básica de three.js
- Módulo que sirve como punto de registro para convertir componentes en Custom Elements

Pasos repetibles (para ejecutar en este repo)
1. Crear la carpeta del paquete y los archivos fuente (ya creados aquí):
   - `libs/web-components/src/lib/three-element.component.ts`
   - `libs/web-components/src/lib/web-components.module.ts`
   - `libs/web-components/src/index.ts`

2. Añadir dependencias necesarias en el monorepo (si aún no están):
```bash
pnpm add -w @angular/elements @angular/cli @angular-devkit/build-angular three
```

3. Construir la librería con Nx / Angular (ejemplo genérico):
```bash
pnpm nx build web-components
```

4. Empaquetar cada web component como bundle independiente (opciones):
   - Usar `ngx-build-plus` para producir un bundle por elemento.
   - Usar el proyecto `apps/web-elements-builder` y `rollup` para tomar la salida compilada y generar bundles UMD/ESM independientes.

5. Probar en una página estática: incluir el bundle y usar la etiqueta custom.

Recomendaciones
- Generar bundles por elemento para reducir peso.
- Para bundles muy ligeros, valorar portar componentes a Lit/Stencil (requiere reescribir).

Archivos de interés
- [libs/web-components/src/index.ts](libs/web-components/src/index.ts#L1)
- [libs/web-components/src/lib/three-element.component.ts](libs/web-components/src/lib/three-element.component.ts#L1)
- [libs/web-components/src/lib/web-components.module.ts](libs/web-components/src/lib/web-components.module.ts#L1)

Demo y builder
- Hay un builder vanilla en `apps/web-elements-builder` que incluye un web component independiente (no-Angular) con three.js listo para bundle y demo.
- Para generar el bundle y ver la demo:
```bash
pnpm --filter web-elements-builder install
pnpm --filter web-elements-builder build
# luego sirve la carpeta apps/web-elements-builder/demo junto a dist (por ejemplo con `npx serve`)
```
