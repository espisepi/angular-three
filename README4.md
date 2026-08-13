
Pasos a seguir:

1 - Importar libreria creada sepinaco-library en la
aplicacion sepinaco-proyecto, lo hare en el componente 

app.component.ts:

import { SepinacoLibreriaComponent } from 'angular-three-sepinaco-libreria';

@component({
imports: [SepinacoLibreriaComponent, ... ],
...
})

2 - usar componentes de la libreria creada en el template html ya que lo hemos importado en el paso anterior:

app.component.html:

<platform-sepinaco-libreria></platform-sepinaco-libreria>

3 - Ejecutar los siguientes comandos:

pnpm nx serve sepinaco-proyecto

pnpm nx build sepinaco-libreria

pnpm nx build sepinaco-proyecto


=================================

como puedo usar la libreria creada sepinaco-libreria en el proyecto sepinaco-proyecto. Dime los pasos a seguir para hacerlo:

(Respuesta codex chatgpt)

Ambos proyectos están dentro del mismo workspace Nx y la ruta de importación ya está configurada. No necesitas publicar ni instalar la librería con `npm`.

1. La librería exporta este componente desde [index.ts](/Users/joseangel/Proyectos/angular-three/libs/sepinaco-libreria/src/index.ts):

```ts
export * from './lib/sepinaco-libreria/sepinaco-libreria.component';
```

2. Importa el componente en [app.component.ts](/Users/joseangel/Proyectos/angular-three/apps/sepinaco-proyecto/src/app/app.component.ts):

```ts
import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { SepinacoLibreriaComponent } from 'angular-three-sepinaco-libreria';
import { NxWelcomeComponent } from './nx-welcome.component';

@Component({
  selector: 'app-root',
  imports: [
    NxWelcomeComponent,
    RouterModule,
    SepinacoLibreriaComponent,
  ],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss',
})
export class AppComponent {
  protected title = 'sepinaco-proyecto';
}
```

La ruta `angular-three-sepinaco-libreria` ya existe en [tsconfig.base.json](/Users/joseangel/Proyectos/angular-three/tsconfig.base.json):

```json
"angular-three-sepinaco-libreria": [
  "./libs/sepinaco-libreria/src/index.ts"
]
```

3. Utiliza el selector de la librería en [app.component.html](/Users/joseangel/Proyectos/angular-three/apps/sepinaco-proyecto/src/app/app.component.html):

```html
<platform-sepinaco-libreria></platform-sepinaco-libreria>

<app-nx-welcome></app-nx-welcome>
<router-outlet></router-outlet>
```

El selector está definido como:

```ts
selector: 'platform-sepinaco-libreria'
```

4. Arranca la aplicación desde la raíz del workspace:

```bash
pnpm nx serve sepinaco-proyecto
```

Al abrir la URL indicada por Nx deberías ver:

```text
SepinacoLibreria works!
```

5. Opcionalmente, comprueba por separado que la librería se empaqueta correctamente:

```bash
pnpm nx build sepinaco-libreria
```

Y verifica la aplicación completa:

```bash
pnpm nx build sepinaco-proyecto
```

Mientras ambos proyectos permanezcan en este monorepo, importa siempre desde `angular-three-sepinaco-libreria`. Solo necesitarías publicar o instalar el paquete si quisieras utilizarlo desde otro repositorio independiente.

