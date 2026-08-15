Comandos para desarrollar y desplegar la librería y el proyecto de Web Components

Prerequisitos
- Node.js (16+), pnpm
- Tener acceso a la cuenta npm/CDN si vas a publicar

1) Preparar el workspace (una sola vez)

```bash
# instalar dependencias del monorepo
pnpm install
```

2) Desarrollo de la librería Angular (`libs/web-components`)

- ejecutar build rápido (Nx target si está configurado):

```bash
pnpm nx build web-components
```

- (alternativa) compilar con ng-packagr para publicar paquete npm:

```bash
npx ng-packagr -p libs/web-components/ng-package.json
```

- ejecutar pruebas / lint según el repo (opcional):

```bash
pnpm nx test web-components
pnpm nx lint web-components
```

3) Desarrollo del builder vanilla (Rollup) `apps/web-elements-builder`

- instalar dependencias del builder (si no lo hizo el paso global):

```bash
pnpm --filter web-elements-builder install
```

- ejecutar build rollup:

```bash
pnpm --filter web-elements-builder run build
# o directamente
npx rollup -c apps/web-elements-builder/rollup.config.js
```

- servir demo estática localmente:

```bash
npx serve apps/web-elements-builder/demo
```

4) Generar Angular Elements (bundle single-file) — app ejemplo `web-elements-app`

- instalar y preparar `ngx-build-plus` (si no está):

```bash
pnpm add -D ngx-build-plus @angular/elements
npx -p @angular/cli ng add ngx-build-plus --skip-confirmation
```

- generar el bundle single-file (produce `dist/web-elements-app/*.js`):

```bash
npx -p @angular/cli ng build web-elements-app --configuration production \
  --output-hashing=none --extra-webpack-config webpack.extra.js --single-bundle true
```

- copiar bundle a demo (opcional):

```bash
mkdir -p apps/web-elements-builder/demo/dist
cp dist/web-elements-app/*.js apps/web-elements-builder/demo/dist/
```

5) Comando todo-en-uno (el repo incluye un script):

- build + copiar + servir demo (ya creado):

```bash
pnpm run build:web-elements
```

Atajos útiles
- Ejecutar el asistente interactivo con todas las acciones disponibles:

```bash
pnpm run commands
```

- Ejecutar el flujo completo (build Angular Elements + copiar bundle + servir demo):

```bash
pnpm run web-elements:serve
```

6) Publicar como paquete npm

- preparar `package.json` en la salida `dist` o en la librería con `files` que expongan el bundle y metadatos.
- publicar (desde la carpeta que contenga `package.json` y el bundle):

```bash
# login si es necesario
npm login
npm publish --access public
```

7) Desplegar a CDN (opción S3)

```bash
# ejemplo: subir bundle a S3 público
aws s3 cp dist/web-elements-app/main.js s3://mi-bucket/web-elements/main.js --acl public-read
# configurar CDN (CloudFront) sobre el bucket
```

8) Consumir en cualquier proyecto

- Via `<script>` desde CDN o archivo local:

```html
<script src="https://cdn.example.com/web-elements/main.js"></script>
<three-element></three-element>
```

- Via npm install y `import` (recomendado en proyectos modernos):

```js
import '@mi-org/web-elements/dist/main.js';
// luego usar <three-element> en HTML/JSX
```

Notas y recomendaciones
- Si quieres bundles más ligeros, publica la versión vanilla (Rollup) o reescribe en Lit/Stencil.
- Verifica versiones de `@angular/core` y `@angular/elements` para evitar warnings de peerDependencies.
- Asegúrate de que el bundle registra el componente con `if (!customElements.get(...))`.

Archivo útil en este repo
- Demo de consumo: apps/web-elements-builder/demo/index.html
- Script todo-en-uno: scripts/build-and-serve-web-elements.sh y scripts/automate-angular-elements.sh
