import { NgModule, DoBootstrap } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { WebComponentsModule } from '../../../../libs/web-components/src/lib/web-components.module';

@NgModule({
    imports: [BrowserModule, WebComponentsModule]
})
export class AppModule implements DoBootstrap {
    ngDoBootstrap(): void {
        // Intentionally empty — WebComponentsModule registers custom elements on construction
    }
}
