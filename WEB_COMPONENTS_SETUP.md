Guía paso a paso para crear y publicar Web Components (Angular Elements + bundle vanilla)

Resumen
- Esta guía muestra cómo reproducir el scaffolding y construir web components reutilizables usando este repo.
- Incluye: 1) un builder vanilla (web component escrito en JS usando three.js) y 2) pasos recomendados para producir Angular Elements a partir de `libs/web-components`.

Requisitos
- Node.js >= 16, pnpm instalado
- Estar en la raíz del repo

1) Builder vanilla (ya implementado aquí)

- Archivos clave:
  - `apps/web-elements-builder/src/vanilla-three-element.js` : web component en JS usando three.js
  - `apps/web-elements-builder/rollup.config.js` : rollup config
  - `apps/web-elements-builder/src/main.js` : entry
  - `apps/web-elements-builder/demo/index.html` : demo estática

Pasos para generar el bundle y ver la demo:
```bash
# instalar dependencias del workspace
pnpm install

# instalar dependencias del builder (si no está hecho por pnpm install)
pnpm --filter web-elements-builder install

# construir el bundle
pnpm --filter web-elements-builder run build

# servir la demo (sirve `apps/web-elements-builder/demo` y `apps/web-elements-builder/dist` juntos)
# ejemplo con 'serve' (instalar global o usar npx):
npx serve apps/web-elements-builder/demo

# o copiar el bundle a demo/dist y abrir demo/index.html en un servidor estático
```

2) Angular Elements (recomendado: usar ngx-build-plus o ng-packagr)

Notas: `libs/web-components` contiene ejemplos de componentes Angular (`ThreeElementComponent`) y un módulo que registra elementos con `createCustomElement`. Para compilar estos componentes como bundles independientes se recomienda usar `ngx-build-plus` con Angular CLI o configurar `ng-packagr` + rollup. A continuación un flujo probado:

a) Añadir dependencias en el workspace:
```bash
pnpm add -w @angular/elements ngx-build-plus
```

b) Usar Angular CLI para construir un elemento como bundle único (ejemplo):
```bash
# generar un proyecto Angular o usar el existente que importe WebComponentsModule
ng add ngx-build-plus

# build en modo single-bundle (reemplaza project-name por tu app que bootstrapea y registra los elementos)
ng build project-name --output-hashing=none --extra-webpack-config webpack.extra.js --single-bundle true
```

c) Alternativa: compilar la librería con `ng-packagr` y luego usar `rollup` para empacar la salida en un bundle UMD/ESM para cada elemento.

d) Probar el bundle resultante en una página estática incluyendo el script y usando la etiqueta custom.

3) Publicación
- Publica bundles como paquetes npm o súbelos a un CDN (unpkg, jsdelivr). Para consumo via `<script>` publica un archivo UMD/IIFE accesible.

Consejos y trade-offs
- Angular Elements permite reusar tus componentes Angular pero añade runtime Angular al bundle: optimiza con treeshaking, lazy loading y bundles por elemento.
- Para bundles mínimos, portar la UI y renderer crítico a Lit/Stencil (o usar vanilla JS) produce outputs mucho más pequeños.

Soporte en este repo
- `libs/web-components` : lugar para mantener componentes Angular.
- `apps/web-elements-builder` : ejemplo de builder y demo vanilla.

Si quieres, puedo:
- configurar `ngx-build-plus` y añadir un `webpack.extra.js` y un app de ejemplo para producir un Angular Elements bundle aquí; o
- añadir scripts npm que automatizan el copy/serve del demo.

Automatización incluida
- `webpack.extra.js` en la raíz: archivo de configuración extra para usar con `ngx-build-plus` y producir un bundle UMD.
- `scripts/automate-angular-elements.sh`: script que instala `ngx-build-plus` y muestra el comando `ng build` recomendado para generar un `single-bundle`.

Uso rápido de la automatización:
```bash
bash scripts/automate-angular-elements.sh
# luego (reemplaza <app-name> por tu app Angular que importe WebComponentsModule):
npx -y @angular/cli ng build <app-name> --prod --output-hashing=none --extra-webpack-config webpack.extra.js --single-bundle true
```
