import { ComponentFixture, TestBed } from '@angular/core/testing';
import { SepinacoLibreriaComponent } from './sepinaco-libreria.component';

describe('SepinacoLibreriaComponent', () => {
	let component: SepinacoLibreriaComponent;
	let fixture: ComponentFixture<SepinacoLibreriaComponent>;

	beforeEach(async () => {
		await TestBed.configureTestingModule({
			imports: [SepinacoLibreriaComponent],
		}).compileComponents();

		fixture = TestBed.createComponent(SepinacoLibreriaComponent);
		component = fixture.componentInstance;
		await fixture.whenStable();
	});

	it('should create', () => {
		expect(component).toBeTruthy();
	});
});
