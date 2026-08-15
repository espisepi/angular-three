import { ApplicationConfig, provideBrowserGlobalErrorListeners, importProvidersFrom } from '@angular/core';
import { WebComponentsModule } from '../../../libs/web-components/src/lib/web-components.module';

export const appConfig: ApplicationConfig = {
	providers: [
		provideBrowserGlobalErrorListeners(),
		importProvidersFrom(WebComponentsModule),
	],
};
