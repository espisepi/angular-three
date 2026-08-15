import { Injector, NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { createCustomElement } from '@angular/elements';
import { ThreeElementComponent } from './three-element.component';

@NgModule({
    imports: [BrowserModule, ThreeElementComponent]
})
export class WebComponentsModule {
    constructor(private injector: Injector) {
        const ThreeEl = createCustomElement(ThreeElementComponent, { injector: this.injector });
        if (!customElements.get('three-element')) {
            customElements.define('three-element', ThreeEl);
        }
    }

    ngDoBootstrap(): void { }
}
