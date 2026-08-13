===========================================


Comando usado para crear proyecto sepinaco-libreria:

```bash
pnpm nx generate @nx/angular:library libs/sepinaco-libreria \
  --name=sepinaco-libreria \
  --publishable \
  --style=scss \
  --importPath=angular-three-sepinaco-libreria \
  --prefix=platform \
  --unitTestRunner=vitest-analog \
  --skipModule \
```

----- SEGUIR LEYENDO README4.md -----

===========================================


como creo un nuevo proyecto de tipo libreria similar a los que aparecen dentro de la carpeta libs:

(Respuesta IA Codex Chatgpt)

Este repositorio usa Nx. Para crear una librería publicable similar a `theatre`, `tweakpane` o `rapier`, ejecuta desde la raíz:

```bash
pnpm nx generate @nx/angular:library libs/mi-libreria \
  --name=mi-libreria \
  --publishable \
  --style=scss \
  --importPath=angular-three-mi-libreria \
  --prefix=platform \
  --unitTestRunner=vitest-analog \
  --skipModule
```

Antes de ejecutarlo realmente, puedes comprobar qué archivos generará:

```bash
pnpm nx generate @nx/angular:library libs/mi-libreria \
  --name=mi-libreria \
  --publishable \
  --style=scss \
  --importPath=angular-three-mi-libreria \
  --prefix=platform \
  --unitTestRunner=vitest-analog \
  --skipModule \
  --dry-run
```

Después:

1. Exporta la API pública desde:

```ts
// libs/mi-libreria/src/index.ts
export * from './lib/mi-funcionalidad';
```

2. Revisa `libs/mi-libreria/package.json` y añade las `peerDependencies` correspondientes.

3. Comprueba que `tsconfig.base.json` contenga:

```json
"angular-three-mi-libreria": ["libs/mi-libreria/src/index.ts"]
```

4. Añade `mi-libreria` a los proyectos de publicación de `nx.json`:

```json
"release": {
  "projects": [
    "...",
    "mi-libreria"
  ]
}
```

5. Si debe incluirse en el empaquetado general, añádela al script `package` de `package.json`.

6. Verifica el resultado:

```bash
pnpm nx build mi-libreria
pnpm nx test mi-libreria
pnpm nx lint mi-libreria
```

El generador no llegó a ejecutarse en esta sesión porque el gestor local intentó verificar/descargar `pnpm@10.14.0` y la red restringida impidió validar su firma, pero la configuración indicada corresponde al generador Nx 23 instalado en este workspace.
