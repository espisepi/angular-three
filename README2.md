como creo un nuevo proyecto similar al de la carpeta examples:

(Respuesta IA Codex Chatgpt)

Este repositorio usa Nx. Para crear una aplicación Angular parecida a `apps/examples`, desde la raíz ejecuta:

```bash
node_modules/.bin/nx generate @nx/angular:application apps/mi-proyecto \
  --name=mi-proyecto \
  --standalone \
  --routing \
  --style=css \
  --linter=eslint \
  --unitTestRunner=jest \
  --e2eTestRunner=none
```

Después puedes arrancarla con:

```bash
node_modules/.bin/nx serve mi-proyecto
```

Y compilarla con:

```bash
node_modules/.bin/nx build mi-proyecto
```

Para utilizar Angular Three, puedes tomar como referencia los archivos:

- [app.config.ts](/Users/joseangel/Proyectos/angular-three/apps/examples/src/app/app.config.ts)
- [app.component.ts](/Users/joseangel/Proyectos/angular-three/apps/examples/src/app/app.component.ts)
- [styles.css](/Users/joseangel/Proyectos/angular-three/apps/examples/src/styles.css)

Los modelos, texturas y otros recursos estáticos deben colocarse en:

```text
apps/mi-proyecto/public/
```

Importante: ahora mismo tu terminal usa Node `21.7.0`, pero `pnpm 10.14.0` requiere al menos Node `22.13`. Por eso `pnpm nx ...` falla. Puedes usar temporalmente `node_modules/.bin/nx` como arriba, aunque lo recomendable es actualizar Node:

```bash
nvm install 22
nvm use 22
pnpm install
pnpm nx serve mi-proyecto
```

Si lo que buscas es una copia prácticamente idéntica de `examples` —incluyendo su navegación, configuración 3D y estructura— entonces conviene duplicarla y cambiar las referencias de `examples` por el nombre nuevo, en lugar de usar el generador.
