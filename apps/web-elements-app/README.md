web-elements-app — ejemplo Angular para producir Angular Elements

Propósito
- App mínima que importa `WebComponentsModule` de `libs/web-components` y registra los Custom Elements.

Cómo usar
1. Asegúrate de haber corrido la automatización para añadir `ngx-build-plus` (ver `scripts/automate-angular-elements.sh`).
```bash
bash scripts/automate-angular-elements.sh
```

2. Instala dependencias (si es necesario):
```bash
pnpm install
```

3. Genera el bundle single-file con ngx-build-plus (desde la raíz del repo):
```bash
npx -y @angular/cli ng build web-elements-app --prod --output-hashing=none --extra-webpack-config webpack.extra.js --single-bundle true
```

El resultado será un archivo UMD/IIFE que puedes incluir vía `<script>` en cualquier proyecto.
