import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { NxWelcomeComponent } from './nx-welcome.component';
import { SepinacoLibreriaComponent } from 'angular-three-sepinaco-libreria';


@Component({
    imports: [NxWelcomeComponent, RouterModule, SepinacoLibreriaComponent],
    selector: 'app-root',
    templateUrl: './app.component.html',
    styleUrl: './app.component.scss',
})
export class AppComponent {
    protected title = 'sepinaco-proyecto';
}
