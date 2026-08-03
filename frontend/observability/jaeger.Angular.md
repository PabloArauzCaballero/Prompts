# PROMPT MAESTRO: IMPLEMENTACIÓN COMPLETA DE JAEGER Y OPENTELEMETRY EN FRONTEND ANGULAR

## Rol

Actúa como un **Arquitecto de Software Senior especializado en Angular, TypeScript, RxJS, OpenTelemetry, Jaeger, observabilidad distribuida, seguridad, rendimiento web y experiencia de usuario**.

Debes inspeccionar, diseñar e implementar una solución completa de trazabilidad distribuida para el frontend Angular existente.

No debes limitarte a instalar dependencias o crear un interceptor HTTP. La implementación debe cubrir, según la arquitectura real del proyecto:

* Inicialización de Angular.
* Aplicaciones standalone.
* Aplicaciones basadas en `NgModule`.
* Aplicaciones con `zone.js`.
* Aplicaciones zoneless.
* Carga inicial del documento.
* Bootstrap de Angular.
* Navegaciones del Angular Router.
* Lazy loading.
* Guards.
* Resolvers.
* Redirecciones.
* Navegaciones canceladas.
* Navegaciones fallidas.
* `HttpClient`.
* Interceptores funcionales.
* Interceptores basados en clases.
* RxJS.
* Signals.
* Formularios reactivos.
* Formularios template-driven.
* Signal Forms, cuando existan.
* Errores globales.
* `ErrorHandler`.
* Errores del Router.
* Promesas rechazadas.
* Errores dentro de Observables.
* Subida y descarga de archivos.
* Autenticación.
* WebSockets.
* Server-Sent Events.
* Angular SSR.
* Hidratación.
* Hidratación incremental.
* Transfer Cache.
* Service Workers.
* PWA.
* Web Vitals.
* Propagación hacia el backend.
* Correlación con Jaeger.
* Seguridad.
* Privacidad.
* Muestreo.
* Rendimiento.
* Pruebas unitarias.
* Pruebas de integración.
* Pruebas E2E.
* Despliegue local.
* Despliegue en producción.
* Documentación técnica.
* Runbook operativo.

La solución debe utilizar:

```text
Angular
   │
   ▼
OpenTelemetry Web SDK
   │
   ▼
OTLP HTTP
   │
   ▼
OpenTelemetry Collector
   │
   ▼
Jaeger
```

OpenTelemetry debe ser la capa de instrumentación.

Jaeger debe ser únicamente el backend de almacenamiento, consulta y visualización de las trazas.

Ningún componente, servicio, guard, interceptor o feature de Angular debe depender directamente de Jaeger.

---

# 1. OBJETIVO GENERAL

Implementar una solución de observabilidad que permita reconstruir el flujo completo:

```text
Usuario
   │
   ▼
Componente Angular
   │
   ├── Evento de interfaz
   ├── Formulario
   ├── Signal o estado
   ├── Router
   ├── Guard
   ├── Resolver
   └── HttpClient
          │
          │ traceparent
          ▼
       Backend API
          │
          ├── Controller
          ├── Service
          ├── PostgreSQL
          ├── Redis
          ├── Eventos
          └── Worker
```

La implementación debe permitir responder:

* ¿Qué ruta estaba visitando el usuario?
* ¿Qué navegación inició la operación?
* ¿Cuánto tardó el Angular Router?
* ¿Cuánto tardó el lazy loading de una ruta?
* ¿Un guard bloqueó o redirigió la navegación?
* ¿Un resolver generó latencia?
* ¿Qué componente inició una solicitud?
* ¿Qué formulario inició la operación?
* ¿Cuánto tardó la validación?
* ¿Cuánto tardó el backend?
* ¿El problema ocurrió en Angular, la red o el backend?
* ¿Qué solicitud HTTP produjo el error?
* ¿Qué versión del frontend estaba desplegada?
* ¿Qué error fue enviado al `ErrorHandler`?
* ¿Qué Observable terminó con error?
* ¿Una solicitud fue cancelada por una desuscripción?
* ¿El frontend y el backend comparten el mismo `trace_id`?
* ¿La aplicación estaba ejecutándose con SSR o CSR?
* ¿El error ocurrió durante la hidratación?
* ¿La aplicación estaba usando Zone.js o modo zoneless?
* ¿Qué operación de negocio estaba ejecutándose?
* ¿Qué código de seguimiento puede entregarse al soporte?

---

# 2. PRINCIPIOS ARQUITECTÓNICOS

## Arquitectura recomendada

```text
Navegador
   │
   │ OTLP HTTP
   ▼
Endpoint de telemetría controlado
   │
   │ Reverse proxy / Gateway / BFF
   ▼
OpenTelemetry Collector
   │
   ▼
Jaeger
```

El frontend no debe enviar trazas directamente:

* A la interfaz web de Jaeger.
* A un Collector interno expuesto sin protección.
* A un puerto privado publicado indiscriminadamente.
* A un endpoint que requiera credenciales secretas dentro del bundle.
* A un dominio externo no aprobado.
* A una URL privada hardcodeada.

En producción se debe preferir un endpoint controlado del mismo origen:

```text
https://app.example.com/otel/v1/traces
```

El proxy podrá redirigir internamente hacia:

```text
http://otel-collector:4318/v1/traces
```

La indisponibilidad de Jaeger o del Collector nunca debe impedir que Angular:

* Inicie.
* Renderice.
* Navegue.
* Envíe formularios.
* Llame al backend.
* Procese respuestas.
* Muestre errores funcionales.
* Mantenga una sesión.

---

# 3. CONTEXTO TÉCNICO POSIBLE

El proyecto puede contener:

* Angular CLI.
* Angular standalone.
* `NgModule`.
* `bootstrapApplication`.
* `platformBrowserDynamic`.
* TypeScript.
* RxJS.
* Zone.js.
* Angular zoneless.
* Signals.
* Computed signals.
* Effects.
* Signal Stores.
* NgRx.
* NGXS.
* Akita.
* Servicios con Subjects.
* Angular Router.
* Lazy loading.
* Guards funcionales.
* Guards basados en clases.
* Resolvers.
* `HttpClient`.
* Interceptores funcionales.
* Interceptores basados en clases.
* Reactive Forms.
* Template-driven Forms.
* Signal Forms.
* Angular Material.
* CDK.
* SSR.
* `@angular/ssr`.
* Hidratación.
* Hidratación incremental.
* Event replay.
* Transfer State.
* Service Workers.
* PWA.
* WebSockets.
* Server-Sent Events.
* Jest.
* Vitest.
* Karma.
* Jasmine.
* Cypress.
* Playwright.
* Docker.
* Nginx.
* Vercel.
* Netlify.
* Cloudflare Pages.
* Firebase Hosting.
* Variables definidas en `environment.ts`.
* Runtime configuration mediante JSON.
* Monorepo Nx.
* Yarn.

Debes detectar la arquitectura real antes de escribir código.

No debes asumir:

* La versión de Angular.
* Que el proyecto sea standalone.
* Que utilice `NgModule`.
* Que utilice Zone.js.
* Que sea zoneless.
* Que utilice SSR.
* Que utilice NgRx.
* Que utilice Axios.
* Que use XHR directamente.
* Que todas las instrumentaciones sean compatibles.

Implementa únicamente lo que sea aplicable al repositorio real.

---

# 4. REGLAS OBLIGATORIAS

1. Utilizar OpenTelemetry.
2. Exportar trazas del navegador mediante OTLP HTTP.
3. No utilizar SDK antiguos de Jaeger.
4. No importar Jaeger desde Angular.
5. No modificar la lógica funcional del sistema.
6. No modificar contratos con el backend.
7. No alterar la interfaz visual.
8. No romper navegación.
9. No romper lazy loading.
10. No romper guards.
11. No romper resolvers.
12. No romper SSR.
13. No romper hidratación.
14. No romper Transfer Cache.
15. No romper Service Workers.
16. No bloquear el bootstrap esperando telemetría.
17. No bloquear una navegación esperando exportación.
18. No bloquear una respuesta HTTP esperando exportación.
19. No finalizar spans antes de que termine un Observable.
20. No crear spans al construir un Observable que nunca se suscribe.
21. No dejar spans abiertos después de una desuscripción.
22. No crear spans por cada emisión de un Observable.
23. No crear spans por cada actualización de un Signal.
24. No crear spans por cada ejecución de un `effect`.
25. No crear spans por cada ciclo de detección de cambios.
26. No crear spans por cada lifecycle hook.
27. No crear spans por cada render.
28. No instrumentar automáticamente todos los clics.
29. No capturar inputs.
30. No capturar cuerpos HTTP.
31. No capturar respuestas completas.
32. No capturar contraseñas.
33. No capturar tokens.
34. No capturar cookies.
35. No capturar códigos 2FA.
36. No capturar datos médicos.
37. No capturar datos financieros.
38. No capturar documentos de identidad.
39. No capturar nombres completos.
40. No capturar correos.
41. No capturar teléfonos.
42. No capturar nombres sensibles de archivos.
43. No capturar HTML.
44. No capturar estado completo de NgRx.
45. No capturar props o inputs completos de componentes.
46. No capturar query strings sin sanitización.
47. No propagar trazas a terceros no autorizados.
48. No generar manualmente `trace_id`.
49. No usar IDs enviados por el usuario como `trace_id`.
50. No utilizar `console.log` como solución de observabilidad.
51. No activar `withDebugTracing()` en producción.
52. No introducir secretos en `environment.ts`.
53. No introducir secretos en archivos públicos.
54. No almacenar spans en `localStorage`.
55. No reintentar indefinidamente.
56. No modificar Yarn por npm.
57. No agregar `any` injustificado.
58. Mantener tipado estricto.
59. Mantener archivos por debajo de 300 líneas, salvo justificación.
60. No dejar tareas críticas pendientes.
61. No inventar resultados de pruebas.
62. No afirmar compatibilidad sin comprobarla.
63. Medir el impacto sobre el bundle.
64. Medir el impacto de rendimiento.
65. Documentar decisiones y riesgos.

---

# 5. METODOLOGÍA DE IMPLEMENTACIÓN

La implementación debe realizarse por fases.

Después de cada fase debes informar:

```text
Estado:
Versión de Angular:
Modelo de bootstrap:
Modelo de detección de cambios:
Rendering detectado:
Archivos revisados:
Archivos creados:
Archivos modificados:
Dependencias agregadas:
Decisiones:
Riesgos:
Pruebas ejecutadas:
Resultados:
Pendientes justificados:
```

No avances hasta:

1. Compilar.
2. Ejecutar pruebas relacionadas.
3. Corregir errores.
4. Revisar privacidad.
5. Verificar que Angular siga iniciando.
6. Verificar navegación.
7. Verificar solicitudes HTTP.
8. Documentar la fase.

---

# FASE 0 — AUDITORÍA DEL WORKSPACE ANGULAR

## Objetivo

Comprender completamente el proyecto antes de modificarlo.

## Revisar

* `package.json`.
* `yarn.lock`.
* `angular.json`.
* `project.json`.
* `nx.json`.
* `tsconfig.json`.
* `tsconfig.app.json`.
* `tsconfig.spec.json`.
* `main.ts`.
* `main.server.ts`.
* `server.ts`.
* `app.config.ts`.
* `app.config.server.ts`.
* `app.module.ts`.
* `app.server.module.ts`.
* `app.routes.ts`.
* `app.routes.server.ts`.
* `environment.ts`.
* `environment.development.ts`.
* Configuración runtime.
* Polyfills.
* `zone.js`.
* `provideZonelessChangeDetection`.
* `bootstrapApplication`.
* `platformBrowserDynamic`.
* `provideHttpClient`.
* `HttpClientModule`.
* Interceptores.
* Router.
* Guards.
* Resolvers.
* Lazy routes.
* Error handlers.
* Formularios.
* NgRx.
* Signals.
* Services.
* WebSockets.
* Service Worker.
* SSR.
* Hidratación.
* Transfer Cache.
* Docker.
* Nginx.
* CI/CD.
* Tests.
* CSP.
* CORS.
* Herramientas de analítica.
* Herramientas de monitoreo.
* Source maps.

## Identificar

1. Versión exacta de Angular.
2. Versión de TypeScript.
3. Versión de RxJS.
4. Versión de Node.js.
5. Uso de Yarn.
6. Aplicación standalone o modular.
7. Zone.js o zoneless.
8. CSR, SSR, SSG o híbrido.
9. Hidratación.
10. Hidratación incremental.
11. Event replay.
12. Angular Service Worker.
13. Cliente HTTP.
14. Interceptores existentes.
15. Orden de los interceptores.
16. Router y estructura de rutas.
17. Rutas dinámicas.
18. Lazy loading.
19. Guards.
20. Resolvers.
21. Manejo global de errores.
22. Estado global.
23. Formularios.
24. Flujos críticos.
25. Datos sensibles.
26. Dominios backend.
27. CORS.
28. CSP.
29. Estrategia de configuración.
30. Infraestructura de despliegue.
31. Release y build ID.
32. Tamaño actual del bundle.
33. Rendimiento actual.
34. Pruebas existentes.
35. Riesgos de compatibilidad.

## Entregable

Crear:

```text
docs/observability/angular/00-current-state-audit.md
```

Debe contener:

* Arquitectura detectada.
* Diagrama Mermaid.
* Modelo de bootstrap.
* Modelo de rendering.
* Modelo de detección de cambios.
* Puntos de instrumentación.
* Flujos críticos.
* Riesgos.
* Datos sensibles.
* Dependencias actuales.
* Tamaño inicial del bundle.
* Plan adaptado al proyecto.
* Archivos que serán modificados.
* Archivos que no deben modificarse.

## Criterio de aceptación

No instalar dependencias antes de terminar esta auditoría.

---

# FASE 1 — DISEÑO DE LA ARQUITECTURA

## Objetivo

Diseñar la solución según el Angular real del repositorio.

## Angular CSR

```text
Angular Browser
   │
   ├── OpenTelemetry Web SDK
   ├── Router tracing
   ├── HttpClient tracing
   ├── ErrorHandler
   └── Business spans
   │
   ▼
/otel/v1/traces
   │
   ▼
Collector
   │
   ▼
Jaeger
```

## Angular SSR

```text
Navegador Angular
   │
   ├── Trazas browser
   │
   ▼
Angular SSR Server
   │
   ├── Render del servidor
   ├── HTTP saliente
   ├── Route rendering
   └── Hidratación correlacionada
   │
   ▼
Collector
   │
   ▼
Jaeger
```

## Decisiones obligatorias

Documentar:

* SDK browser.
* SDK Node para SSR, cuando aplique.
* Estrategia para Zone.js.
* Estrategia zoneless.
* Gestor de contexto.
* Bootstrap temprano.
* OTLP HTTP.
* Endpoint de exportación.
* Proxy.
* CORS.
* CSP.
* Sampling.
* Router tracing.
* HttpClient tracing.
* RxJS tracing.
* Error handling.
* SSR.
* Hidratación.
* Lazy loading.
* Guards.
* Resolvers.
* Signals.
* Formularios.
* NgRx.
* Source maps.
* Privacidad.
* Rendimiento.
* Bundle.
* Despliegue.

## Entregable

Crear:

```text
docs/observability/angular/01-architecture-design.md
```

---

# FASE 2 — CONVENCIONES DE NOMBRES

## Servicios

Utilizar nombres distintos:

```text
<producto>-angular-web
<producto>-angular-ssr
<producto>-angular-service-worker
```

Ejemplos:

```text
atlas-angular-web
atlas-angular-ssr
salud-angular-web
```

No usar el mismo `service.name` para navegador y SSR.

## Spans técnicos

```text
angular.bootstrap
angular.navigation
angular.lazy-route.load
angular.guard.evaluate
angular.resolver.execute
angular.http.request
angular.form.submit
angular.hydration
angular.defer.load
```

## Spans de negocio

```text
auth.login
auth.logout
customer.register
profile.update
credit.application.submit
document.upload
report.download
appointment.request
workflow.execute
```

## Atributos propios

```text
app.feature
app.operation
app.route.template
app.release
app.build.id
app.environment
angular.component
angular.guard
angular.resolver
angular.rendering.mode
angular.change_detection.mode
angular.navigation.trigger
angular.lazy.loaded
ui.form.name
ui.action
ui.result
```

## Prohibido

No incluir IDs dinámicos en nombres:

```text
customer.load.72839
route./customers/72839
document.upload.factura-pablo.pdf
```

Usar:

```text
customer.load
/customers/:customerId
document.upload
```

## Entregable

Crear:

```text
docs/observability/angular/02-naming-conventions.md
```

---

# FASE 3 — COMPATIBILIDAD DE VERSIONES

## Objetivo

Evitar instalar versiones incompatibles.

## Revisar

* Angular.
* TypeScript.
* RxJS.
* Node.
* Zone.js.
* OpenTelemetry API.
* SDK web.
* Exportador OTLP.
* Instrumentaciones.
* Gestor de contexto.
* Test runner.
* Bundler Angular.

## Reglas

* Consultar documentación oficial.
* Verificar peer dependencies.
* Mantener una sola versión de `@opentelemetry/api`.
* No utilizar versiones incompatibles del SDK y sus instrumentaciones.
* No actualizar Angular sin solicitud.
* No ejecutar una migración masiva.
* No cambiar el builder.
* No reemplazar Webpack o esbuild.
* No cambiar Karma, Jest o Vitest sin necesidad.
* No instalar paquetes sin uso real.

## Entregable

Agregar una matriz:

| Componente   | Versión detectada | Versión seleccionada | Compatibilidad |
| ------------ | ----------------: | -------------------: | -------------- |
| Angular      |              Real |                  N/A | Validada       |
| RxJS         |              Real |                  N/A | Validada       |
| OTel API     |               N/A |                 Real | Validada       |
| OTel Web SDK |               N/A |                 Real | Validada       |

---

# FASE 4 — INSTALACIÓN DE DEPENDENCIAS

## Dependencias base a evaluar

```bash
yarn add @opentelemetry/api
yarn add @opentelemetry/sdk-trace-web
yarn add @opentelemetry/sdk-trace-base
yarn add @opentelemetry/resources
yarn add @opentelemetry/semantic-conventions
yarn add @opentelemetry/exporter-trace-otlp-http
yarn add @opentelemetry/instrumentation
yarn add @opentelemetry/instrumentation-document-load
yarn add @opentelemetry/instrumentation-fetch
yarn add @opentelemetry/instrumentation-xml-http-request
```

Evaluar cuidadosamente:

```bash
yarn add @opentelemetry/instrumentation-user-interaction
yarn add @opentelemetry/context-zone
```

No instalar `@opentelemetry/context-zone` automáticamente.

Instalarlo solamente si:

* El proyecto utiliza Zone.js.
* La versión es compatible.
* Las pruebas demuestran que conserva correctamente el contexto.
* No genera zone pollution significativa.
* No rompe la detección de cambios.

En aplicaciones zoneless:

* No agregar Zone.js únicamente para OpenTelemetry.
* No reintroducir Zone.js sin aprobación.
* Evaluar la capacidad actual del SDK.
* Usar propagación explícita donde sea necesario.
* Documentar limitaciones de contexto asíncrono.
* Priorizar spans manuales correctamente delimitados.

Para SSR, evaluar por separado:

```bash
yarn add @opentelemetry/sdk-node
yarn add @opentelemetry/auto-instrumentations-node
yarn add @opentelemetry/exporter-trace-otlp-http
```

Los paquetes Node.js no deben terminar en el bundle del navegador.

## Validar

```bash
yarn install
yarn lint
yarn test
yarn build
```

---

# FASE 5 — CONFIGURACIÓN DE ENTORNOS

## Objetivo

Centralizar la configuración sin exponer secretos.

## Ejemplo de configuración pública

```ts
export interface TelemetryEnvironment {
  enabled: boolean;
  serviceName: string;
  namespace: string;
  version: string;
  buildId: string;
  environment: string;
  tracesEndpoint: string;
  sampleRatio: number;
}
```

## Ejemplo en environment

```ts
telemetry: {
  enabled: true,
  serviceName: 'atlas-angular-web',
  namespace: 'atlas',
  version: '1.0.0',
  buildId: 'local',
  environment: 'development',
  tracesEndpoint: '/otel/v1/traces',
  sampleRatio: 1,
}
```

## Regla crítica

Todo valor enviado al navegador es público.

No incluir:

* API keys privadas.
* Tokens.
* Credenciales.
* Contraseñas.
* Claves del Collector.
* Secretos de Jaeger.
* Cadenas privadas de conexión.
* Credenciales de servicios.

## Runtime configuration

Cuando el proyecto cargue configuración desde:

```text
/assets/config.json
```

debes:

* Validar el esquema.
* Definir valores seguros.
* No bloquear Angular indefinidamente.
* No introducir secretos.
* Evitar que el fallo de telemetría impida iniciar la aplicación.

## Inicializadores

Utilizar el mecanismo compatible con la versión real:

* `provideAppInitializer`.
* Inicializador existente.
* Estrategia heredada únicamente cuando el proyecto lo requiera.

No agregar inicializadores duplicados.

## Entregables

```text
src/app/core/observability/config/
├── telemetry.config.ts
├── telemetry-config.token.ts
├── telemetry-config.validator.ts
└── telemetry-config.types.ts
```

---

# FASE 6 — BOOTSTRAP TEMPRANO

## Objetivo

Inicializar OpenTelemetry antes de las operaciones que se desean capturar.

## Standalone

Evaluar una inicialización previa a:

```ts
bootstrapApplication(AppComponent, appConfig);
```

## NgModule

Evaluar una inicialización previa a:

```ts
platformBrowserDynamic()
  .bootstrapModule(AppModule);
```

## Requisitos

* Ejecutarse únicamente en navegador.
* Comprobar `isPlatformBrowser` cuando corresponda.
* No acceder a `window` durante SSR.
* Ser idempotente.
* No inicializarse dos veces.
* Soportar HMR.
* Soportar tests.
* Funcionar como no-op al estar deshabilitado.
* No bloquear el bootstrap.
* Manejar configuración inválida.
* Manejar Collector caído.
* Mantener errores técnicos fuera de la interfaz.

## Estructura sugerida

```text
src/app/core/observability/
├── browser/
│   ├── telemetry-browser.bootstrap.ts
│   ├── telemetry-browser.provider.ts
│   ├── telemetry-browser.exporter.ts
│   ├── telemetry-browser.resource.ts
│   ├── telemetry-browser.instrumentations.ts
│   ├── telemetry-browser.sampling.ts
│   └── telemetry-browser.lifecycle.ts
├── config/
├── tracing/
├── routing/
├── http/
├── errors/
├── rxjs/
└── security/
```

Adaptar la estructura sin crear archivos innecesarios.

---

# FASE 7 — PROVIDER, EXPORTADOR Y RESOURCE

## Implementar

* `WebTracerProvider`.
* Resource del frontend.
* Exportador OTLP HTTP.
* `BatchSpanProcessor`.
* Sampler configurable.
* Propagador W3C Trace Context.
* Baggage únicamente si está aprobado.
* Gestor de contexto compatible.
* Instrumentaciones seleccionadas.
* Inicialización única.

## Resource mínimo

```text
service.name
service.namespace
service.version
deployment.environment.name
app.build.id
app.framework
angular.version
angular.rendering.mode
angular.change_detection.mode
```

## Valores

```text
app.framework = angular
angular.rendering.mode = csr | ssr | ssg | hybrid
angular.change_detection.mode = zone | zoneless
```

No generar una versión diferente por carga.

Usar:

* Versión de aplicación.
* Build ID.
* Commit corto.
* Identificador de release.

---

# FASE 8 — ZONE.JS Y CONTEXTO ASÍNCRONO

## Objetivo

Seleccionar una estrategia compatible con el modelo real de Angular.

## Detectar Zone.js

Revisar:

* `angular.json`.
* Polyfills.
* `import 'zone.js'`.
* Configuración de tests.
* Providers de cambio zoneless.

## Aplicación con Zone.js

Evaluar `ZoneContextManager`.

Validar:

* `Promise`.
* `setTimeout`.
* Eventos DOM.
* HttpClient.
* RxJS.
* Router.
* Lazy loading.
* Formularios.
* Interceptores.
* Guards.
* Resolvers.

## Aplicación zoneless

No agregar Zone.js automáticamente.

Debes:

* Verificar capacidades actuales del SDK.
* Delimitar spans manualmente.
* Usar contextos explícitos cuando sea necesario.
* Evitar asumir propagación automática.
* Probar `Promise`.
* Probar RxJS.
* Probar Router.
* Probar HttpClient.
* Documentar cualquier limitación.

## Zone pollution

Cuando se utilice Zone.js:

* Medir change detection.
* Evitar timers permanentes.
* Evitar tareas periódicas del exportador dentro de Angular cuando provoquen detección innecesaria.
* Evaluar inicialización mediante `NgZone.runOutsideAngular`.
* Verificar que callbacks funcionales vuelvan al contexto apropiado.
* No alterar comportamiento de componentes.

## Entregable

```text
docs/observability/angular/03-async-context-strategy.md
```

---

# FASE 9 — INSTRUMENTACIÓN DE CARGA DEL DOCUMENTO

## Objetivo

Capturar la carga inicial.

## Evaluar

* `DocumentLoadInstrumentation`.
* Navegación del navegador.
* Descarga del documento.
* Recursos principales.
* Bootstrap Angular.
* Inicialización de configuración.
* Primer render.
* Estabilidad inicial.
* Hidratación, cuando aplique.

## Evitar

* Generar cientos de spans de recursos.
* Capturar URLs con query strings.
* Capturar recursos de terceros irrelevantes.
* Capturar URLs firmadas.
* Capturar tokens.

## Span manual sugerido

```text
angular.bootstrap
```

Eventos:

```text
config.loaded
otel.initialized
angular.bootstrap.started
angular.bootstrap.completed
application.stable
```

No mantener el span abierto indefinidamente cuando la aplicación tenga tareas permanentes.

---

# FASE 10 — ANGULAR ROUTER

## Objetivo

Medir el ciclo completo de navegación.

## Eventos a evaluar

* `NavigationStart`.
* `RoutesRecognized`.
* `RouteConfigLoadStart`.
* `RouteConfigLoadEnd`.
* `GuardsCheckStart`.
* `GuardsCheckEnd`.
* `ResolveStart`.
* `ResolveEnd`.
* `ActivationStart`.
* `ActivationEnd`.
* `NavigationEnd`.
* `NavigationCancel`.
* `NavigationError`.
* `NavigationSkipped`.

## Span principal

```text
angular.navigation
```

## Atributos

```text
app.route.from
app.route.to
app.route.template
angular.navigation.id
angular.navigation.trigger
angular.navigation.result
angular.navigation.cancellation.code
angular.navigation.redirected
```

## Reglas

* Normalizar rutas.
* No guardar query strings.
* No guardar IDs dinámicos.
* Utilizar la configuración de rutas para construir la plantilla.
* Finalizar en `NavigationEnd`.
* Marcar cancelación en `NavigationCancel`.
* Marcar error en `NavigationError`.
* Manejar `NavigationSkipped`.
* Manejar redirecciones.
* Evitar spans duplicados.
* No usar mensajes inestables de cancelación como categorías.
* No dejar spans abiertos.

## Ejemplo

Ruta real:

```text
/customers/8437?tab=payments
```

Atributo permitido:

```text
app.route.template = /customers/:customerId
```

No registrar:

```text
/customer/8437?tab=payments
```

## Estructura sugerida

```text
src/app/core/observability/routing/
├── router-tracing.service.ts
├── route-template.service.ts
├── navigation-span.store.ts
└── router-tracing.types.ts
```

---

# FASE 11 — LAZY LOADING Y BLOQUES DIFERIDOS

## Objetivo

Identificar retrasos en carga de código.

## Instrumentar

* Rutas lazy.
* Componentes lazy.
* `loadComponent`.
* `loadChildren`.
* Bloques `@defer`, cuando sea viable.
* Errores de chunks.
* Reintentos.
* Fallos de red.

## Spans

```text
angular.lazy-route.load
angular.lazy-component.load
angular.defer.load
```

## Atributos

```text
app.route.template
angular.lazy.type
angular.lazy.result
resource.size.bucket
```

No capturar:

* URL completa del chunk con identificadores sensibles.
* Paths locales.
* Source map.
* Código fuente.
* Contenido de módulos.

## Validaciones

* Carga exitosa.
* Chunk no encontrado.
* Timeout.
* Navegación cancelada.
* Precarga.
* Carga repetida desde caché.

---

# FASE 12 — GUARDS

## Objetivo

Medir guards sin exponer información de autenticación.

## Detectar

* `CanActivateFn`.
* `CanMatchFn`.
* `CanDeactivateFn`.
* Guards basados en clases.
* Guards de roles.
* Guards de sesión.

## Spans

```text
angular.guard.evaluate
```

## Atributos

```text
angular.guard.name
angular.guard.type
angular.guard.result
app.route.template
```

Valores permitidos:

```text
allowed
denied
redirected
error
```

## Prohibido

* Token.
* Claims JWT.
* Roles completos sensibles.
* Datos de usuario.
* URL privada con parámetros.
* Motivos que revelen información interna.

## Reglas

* No crear spans duplicados para el mismo guard.
* Soportar resultados booleanos.
* Soportar `UrlTree`.
* Soportar `RedirectCommand`.
* Soportar Promise.
* Soportar Observable.
* Finalizar al completar o cancelar.
* Registrar errores sin ocultarlos.

---

# FASE 13 — RESOLVERS

## Objetivo

Determinar si la navegación es lenta por resolución de datos.

## Span

```text
angular.resolver.execute
```

## Atributos

```text
angular.resolver.name
app.route.template
angular.resolver.result
```

## Reglas

* No registrar datos resueltos.
* No registrar entidad completa.
* No registrar parámetros sensibles.
* Soportar valores directos.
* Soportar Promise.
* Soportar Observable.
* Finalizar con `finalize`.
* Marcar errores.
* Manejar cancelación.
* Evitar duplicar spans HTTP hijos.

---

# FASE 14 — HTTPCLIENT E INTERCEPTORES

## Objetivo

Instrumentar solicitudes Angular sin generar duplicaciones.

## Detectar

* `provideHttpClient`.
* `HttpClientModule`.
* `withInterceptors`.
* `withInterceptorsFromDi`.
* Interceptores funcionales.
* Interceptores de clases.
* Fetch backend.
* XHR backend.
* Wrappers de API.
* NgRx Effects.
* Servicios genéricos.
* Uploads.
* Downloads.

## Estrategias posibles

### Estrategia A

Instrumentación automática de Fetch/XHR y un interceptor Angular únicamente para enriquecer contexto.

### Estrategia B

Interceptor Angular responsable de spans HTTP, con instrumentación automática deshabilitada para esas solicitudes.

Debes seleccionar una sola estrategia principal.

No se acepta:

```text
Fetch span
   └── XHR span
        └── Angular interceptor span
             └── Otro wrapper span idéntico
```

## Interceptor

Preferir la forma compatible con el proyecto real.

El interceptor debe:

* Iniciar span en el momento correcto.
* Mantenerlo durante la suscripción.
* Registrar respuesta final.
* Registrar status.
* Registrar error.
* Manejar desuscripción.
* Finalizar una sola vez.
* No leer bodies.
* No registrar headers sensibles.
* No modificar el contrato.
* No interferir con auth.
* No interferir con refresh token.
* No romper retries.
* No romper cache.
* No propagar a dominios no autorizados.

## RxJS

Utilizar una combinación segura de:

```text
defer
tap
catchError
finalize
```

No iniciar el span antes de que exista suscripción cuando el Observable sea frío.

## Atributos

```text
http.request.method
server.address
url.scheme
http.response.status_code
error.type
app.api.route.template
```

Normalizar rutas API.

---

# FASE 15 — PROPAGACIÓN AL BACKEND

## Objetivo

Conservar el mismo trace entre Angular y el backend.

## Propagadores

```text
tracecontext
baggage
```

Baggage debe utilizarse solamente cuando exista una necesidad aprobada.

## Dominios permitidos

Configurar una allowlist:

```text
/api/**
https://api.example.com/**
https://staging-api.example.com/**
```

No propagar hacia:

* Google Analytics.
* Meta.
* CDNs externos.
* Servicios publicitarios.
* Proveedores no controlados.
* URLs proporcionadas por el usuario.

## Headers

```text
traceparent
tracestate
baggage
```

## Backend

Validar que CORS permita:

```text
traceparent
tracestate
baggage
```

Y exponga cuando corresponda:

```text
x-trace-id
```

## Reglas

* No reemplazar `Authorization`.
* No confiar en un trace ID recibido como parámetro.
* No construir `traceparent` manualmente salvo mediante la API oficial.
* No propagar baggage con información personal.
* No romper preflight.
* No configurar CORS con `*`.

## Validación

```text
angular.form.submit
   └── HTTP POST /api/applications
          └── backend HTTP request
                ├── service
                ├── database
                └── worker
```

Todos deben compartir `trace_id`.

---

# FASE 16 — SERVICIO CENTRAL DE TRACING

## Objetivo

Proporcionar una API estable y reutilizable.

## Estructura

```text
src/app/core/observability/tracing/
├── tracing.service.ts
├── tracing.tokens.ts
├── tracing.types.ts
├── tracing.constants.ts
├── tracing-attributes.builder.ts
└── noop-tracing.service.ts
```

## API sugerida

```ts
runInSpan<T>(
  name: string,
  attributes: Attributes,
  operation: (span: Span) => T,
): T;
```

Para Promise:

```ts
runInAsyncSpan<T>(
  name: string,
  attributes: Attributes,
  operation: (span: Span) => Promise<T>,
): Promise<T>;
```

Para Observable:

```ts
traceObservable<T>(
  name: string,
  attributes: Attributes,
  sourceFactory: (span: Span) => Observable<T>,
): Observable<T>;
```

## Requisitos para Observables

* Utilizar `defer`.
* Crear span al suscribirse.
* Mantener contexto durante la ejecución.
* Registrar error.
* Finalizar en `finalize`.
* Manejar desuscripción.
* No finalizar por cada emisión.
* No compartir accidentalmente un span entre varias suscripciones.
* Documentar comportamiento con `share`.
* Documentar comportamiento con `shareReplay`.
* Documentar reintentos.
* Documentar repetición.

## No-op

Cuando OTel esté deshabilitado:

* Ejecutar operación.
* Retornar resultado.
* Conservar errores.
* No crear spans.
* No alterar Observables.
* No alterar tiempos.

---

# FASE 17 — RXJS

## Objetivo

Evitar errores comunes al instrumentar flujos reactivos.

## Casos que deben probarse

* Observable frío.
* Observable caliente.
* Subject.
* BehaviorSubject.
* ReplaySubject.
* `switchMap`.
* `mergeMap`.
* `concatMap`.
* `exhaustMap`.
* `forkJoin`.
* `combineLatest`.
* `retry`.
* `retryWhen`.
* `catchError`.
* `share`.
* `shareReplay`.
* Cancelación.
* `takeUntilDestroyed`.
* Error.
* Completion.
* Multisuscripción.

## Reglas

* Un span debe representar una operación, no cada emisión.
* Crear spans por intento solamente cuando sea útil.
* No mantener spans abiertos en streams permanentes.
* No instrumentar Subjects globales indefinidos.
* No instrumentar selectores de estado.
* No instrumentar cada operador.
* No monkey-patchear RxJS globalmente sin justificación.
* No romper scheduler.
* No alterar orden de operadores.
* No convertir cold Observables en hot.
* No provocar suscripciones adicionales.

## Entregable

```text
docs/observability/angular/04-rxjs-tracing-guidelines.md
```

---

# FASE 18 — SIGNALS Y EFFECTS

## Objetivo

Instrumentar operaciones de negocio relacionadas con Signals sin crear ruido.

## No instrumentar

* Cada lectura de Signal.
* Cada `set`.
* Cada `update`.
* Cada recomputación de `computed`.
* Cada ejecución de `effect`.
* Cada render provocado por Signals.

## Instrumentar solamente

* Operaciones de negocio explícitas.
* Transiciones importantes.
* Inicio y finalización de workflows.
* Carga remota iniciada por una acción.
* Errores.
* Confirmaciones.

## Riesgo

Un `effect` puede ejecutarse varias veces.

No crear un span nuevo en cada ejecución sin una razón explícita.

## Spans permitidos

```text
workflow.stage.change
filter.remote.apply
dashboard.refresh
```

No registrar valores completos de Signals.

---

# FASE 19 — NGRX Y ESTADO GLOBAL

## Objetivo

Agregar contexto de negocio sin instrumentar cada acción.

## Detectar

* Store.
* Effects.
* Component Store.
* Signal Store.
* Selectors.
* Actions.
* Reducers.

## No instrumentar

* Cada action.
* Cada reducer.
* Cada selector.
* Todo el estado.
* Payloads.
* DevTools.
* Acciones internas del Router Store.
* Acciones de inicialización.

## Instrumentar

* Effects que representan operaciones remotas importantes.
* Workflows críticos.
* Errores de efectos.
* Reintentos.
* Finalización de una operación.

## Spans

```text
state.effect.execute
workflow.command.execute
```

## Atributos

```text
app.feature
app.operation
state.effect.name
ui.result
```

No registrar payloads.

---

# FASE 20 — FORMULARIOS ANGULAR

## Objetivo

Medir formularios sin capturar sus valores.

## Detectar

* Reactive Forms.
* Template-driven Forms.
* Typed Forms.
* Signal Forms.
* Validadores síncronos.
* Validadores asíncronos.
* Formularios por pasos.

## Instrumentar

* Inicio de submit.
* Validación.
* Validación asíncrona.
* Solicitud HTTP.
* Éxito.
* Error.
* Cancelación.
* Duración total.

## Span

```text
angular.form.submit
```

## Atributos

```text
ui.form.name
validation.success
validation.error.count
ui.result
app.feature
```

## Prohibido

* `form.value`.
* `getRawValue()`.
* Contenido de controles.
* Nombres.
* Correos.
* Teléfonos.
* Contraseñas.
* Comentarios.
* Diagnósticos.
* Montos.
* Direcciones.
* Archivos.

## Validadores asíncronos

Evitar registrar:

* Campo validado.
* Valor.
* Existencia de un usuario.
* Respuesta completa.

Utilizar categorías seguras.

---

# FASE 21 — INTERACCIONES DE USUARIO

## Objetivo

Relacionar acciones críticas con solicitudes posteriores.

## Evaluar instrumentación automática

No habilitarla sin:

* Revisar su madurez.
* Medir volumen.
* Verificar compatibilidad.
* Configurar allowlist de eventos.
* Revisar privacidad.

## Instrumentar manualmente

* Submit.
* Confirmar operación.
* Crear.
* Editar.
* Eliminar.
* Ejecutar workflow.
* Descargar reporte.
* Subir archivo.
* Buscar remotamente.
* Aplicar filtro costoso.

## No instrumentar

* Hover.
* Scroll.
* Mousemove.
* Cada click.
* Focus.
* Blur.
* Cada tecla.
* Tooltips.
* Menús decorativos.
* Animaciones.
* Apertura de todos los diálogos.

## Atributos

```text
ui.action
ui.component
app.feature
app.operation
ui.result
```

No capturar texto libre del botón si puede ser dinámico.

---

# FASE 22 — ERRORES GLOBALES Y ERRORHANDLER

## Objetivo

Centralizar errores Angular sin duplicarlos.

## Implementar

Un `ErrorHandler` personalizado que:

1. Preserve el comportamiento funcional.
2. Desenvuelva errores cuando sea seguro.
3. Sanitice el mensaje.
4. Obtenga el span activo.
5. Registre la excepción.
6. Marque el span como error.
7. Cree una traza raíz cuando no exista contexto y sea apropiado.
8. No exponga información sensible.
9. No duplique errores.
10. Mantenga la experiencia visual existente.

## También revisar

* `window.error`.
* `unhandledrejection`.
* Errores de recursos.
* Errores de chunks.
* Errores de lazy loading.
* Errores de hidratación.
* Errores de Router.
* Errores RxJS no manejados.
* Errores de `HttpClient`.

## Duplicación

Un mismo error no debe aparecer como:

```text
ErrorHandler
window.onerror
unhandledrejection
HttpInterceptor
Router error
```

sin una estrategia de deduplicación.

## Atributos

```text
error.type
error.source
error.handled
app.route.template
app.release
angular.component
```

## Estructura

```text
src/app/core/observability/errors/
├── telemetry-error-handler.ts
├── error-sanitizer.ts
├── error-deduplicator.ts
├── browser-error-listeners.ts
└── telemetry-error.types.ts
```

---

# FASE 23 — AUTENTICACIÓN

## Objetivo

Medir autenticación sin exponer credenciales.

## Spans

```text
auth.login
auth.logout
auth.session.refresh
auth.session.validate
auth.password.recovery.request
auth.password.reset
auth.mfa.verify
```

## Atributos permitidos

```text
auth.method
auth.result
auth.failure.category
app.authenticated
```

## Categorías

```text
invalid_credentials
expired_session
network_error
server_error
validation_error
rate_limited
unknown
```

## Prohibido

* Username.
* Email.
* Password.
* Token.
* Refresh token.
* Cookie.
* Código MFA.
* Claims JWT.
* Respuesta completa.
* Identificador persistente sin aprobación.

## Refresh interceptor

Verificar:

* Que no duplique spans.
* Que los retries sean hijos comprensibles.
* Que no se propaguen tokens a telemetría.
* Que el trace no se rompa durante el refresh.
* Que no exista recursión infinita.
* Que solicitudes excluidas sigan excluidas.

---

# FASE 24 — ARCHIVOS

## Objetivo

Medir uploads y downloads de forma segura.

## Spans

```text
document.upload
document.download
file.validation
```

## Atributos permitidos

```text
file.extension
file.mime.type
file.size.bucket
upload.strategy
ui.result
```

## Buckets

```text
0-1MB
1-5MB
5-20MB
20-100MB
100MB+
```

## Prohibido

* Nombre del archivo.
* Ruta local.
* Contenido.
* Base64.
* Hash reversible.
* URL firmada completa.
* Metadata EXIF.
* Identificadores personales.

## Probar

* Upload exitoso.
* Tipo inválido.
* Tamaño inválido.
* Cancelación.
* Progreso.
* Timeout.
* Retry.
* 4xx.
* 5xx.
* Descarga interrumpida.

---

# FASE 25 — ANGULAR SSR

## Objetivo

Instrumentar por separado el servidor Angular.

## Aplica cuando existan

* `@angular/ssr`.
* `main.server.ts`.
* `server.ts`.
* `AngularNodeAppEngine`.
* `CommonEngine`.
* SSR Express.
* Server routes.
* Prerender.
* Render modes híbridos.

## Servicio separado

```text
atlas-angular-ssr
```

## Instrumentar

* Solicitud SSR.
* Reconocimiento de ruta.
* Render.
* HTTP saliente.
* Transfer State.
* Errores.
* Tiempo hasta HTML.
* Prerender.
* Revalidación, cuando aplique.

## Reglas

* SDK Node separado del SDK browser.
* No importar SDK web en servidor.
* No importar módulos Node en navegador.
* Inicializar antes de dependencias instrumentadas.
* No capturar cookies.
* No capturar Authorization.
* No capturar HTML.
* No capturar estado transferido.
* No duplicar solicitudes reutilizadas por Transfer Cache.
* Cierre limpio.
* Exportación tolerante a fallos.

---

# FASE 26 — HIDRATACIÓN

## Objetivo

Medir el paso de HTML de servidor a aplicación interactiva.

## Detectar

* `provideClientHydration`.
* Transfer Cache.
* Event replay.
* Hidratación incremental.
* Bloques `@defer`.
* Errores de mismatch.
* Estabilidad de la aplicación.

## Span

```text
angular.hydration
```

## Eventos

```text
hydration.started
hydration.completed
hydration.failed
application.stable
```

## Reglas

* No modificar el DOM antes de hidratación.
* No agregar nodos de telemetría.
* No alterar comentarios o espacios requeridos.
* No provocar timers que mantengan la aplicación inestable.
* No duplicar llamadas HTTP transferidas desde SSR.
* Medir impacto sobre estabilidad.
* Marcar errores de hidratación de forma sanitizada.

## Hidratación incremental

Evaluar:

* Inicio.
* Boundary.
* Trigger.
* Finalización.
* Error.

No crear un span por cada detalle interno.

---

# FASE 27 — SERVICE WORKER Y PWA

## Objetivo

Instrumentar únicamente cuando exista soporte suficiente.

## Revisar

* `ngsw-config.json`.
* Registro del Service Worker.
* Actualizaciones.
* Caching.
* Offline.
* Push.
* Background sync.

## Reglas

* Service Worker posee contexto separado.
* No asumir contexto compartido con la página.
* No romper funcionamiento offline.
* No almacenar trazas indefinidamente.
* No saturar red al recuperar conexión.
* No instrumentar heartbeats.
* No registrar payload de notificaciones.
* No registrar contenido cacheado.
* No alterar estrategias de cache.

Cuando no sea viable una integración estable:

* Documentar la limitación.
* Instrumentar la página.
* Instrumentar el backend.
* Registrar únicamente eventos manuales controlados.

---

# FASE 28 — WEBSOCKETS Y SSE

## Objetivo

Medir conexiones en tiempo real sin spans infinitos.

## Spans

```text
websocket.connect
websocket.send
websocket.receive
websocket.reconnect
sse.connect
sse.message
```

## Reglas

* No mantener un único span durante horas.
* No registrar payloads.
* No instrumentar heartbeats.
* No instrumentar cada mensaje de alta frecuencia.
* Crear spans para operaciones relevantes.
* Manejar reconexiones.
* Manejar desconexiones.
* Manejar errores.
* Propagar contexto únicamente si el protocolo lo soporta.

---

# FASE 29 — WEB VITALS Y RENDIMIENTO

## Objetivo

Relacionar rendimiento percibido con las trazas.

## Evaluar

* LCP.
* INP.
* CLS.
* FCP.
* TTFB.
* Angular bootstrap.
* Navigation duration.
* Lazy loading.
* Hydration.
* Long tasks.
* Change detection.
* Bundle loading.

## Regla

Jaeger es un backend de trazas.

No convertir cada métrica en cientos de spans.

Opciones:

* Eventos en span de carga.
* Atributos limitados.
* Métricas OpenTelemetry separadas.
* Herramienta existente.
* Correlación por release, ruta y entorno.

## Entregable

```text
docs/observability/angular/05-web-vitals-strategy.md
```

---

# FASE 30 — LOGS DEL CLIENTE

## Objetivo

Correlacionar logs técnicos sin enviar toda la consola.

## Campos opcionales

```text
trace_id
span_id
app.release
app.route.template
```

## Reglas

* No interceptar toda la consola.
* No enviar objetos completos.
* No enviar estado.
* No enviar bodies.
* No enviar tokens.
* No duplicar excepciones.
* Aplicar niveles.
* Aplicar sampling.
* Limitar logs de producción.

## Código de soporte

Cuando el backend exponga:

```text
x-trace-id
```

la interfaz puede mostrar:

```text
Código de seguimiento: 8f3a…
```

No mostrar:

* Stack.
* Nombre de servicio.
* URL de Jaeger.
* Atributos internos.
* Información de infraestructura.

---

# FASE 31 — CORS

## Objetivo

Permitir propagación sin abrir el backend.

## Revisar

* Frontend origin.
* Backend origin.
* Credenciales.
* Preflight.
* Headers permitidos.
* Headers expuestos.
* Métodos.
* Cache de preflight.
* Proxy local.
* Staging.
* Producción.

## Headers permitidos

```text
traceparent
tracestate
baggage
```

## Header expuesto

```text
x-trace-id
```

## Prohibido

* `Access-Control-Allow-Origin: *` con credenciales.
* Permitir orígenes arbitrarios.
* Permitir headers indiscriminados.
* Desactivar protección para facilitar tracing.

---

# FASE 32 — CSP

## Objetivo

Permitir exportación sin debilitar seguridad.

## Revisar

```text
connect-src
```

Debe permitir solamente:

* API propia.
* Endpoint de telemetría.
* WebSockets autorizados.
* Servicios existentes.

Preferir:

```text
connect-src 'self'
```

cuando el endpoint sea del mismo origen.

## Prohibido

* Agregar `*`.
* Agregar `unsafe-eval`.
* Desactivar CSP.
* Exponer Collector.
* Exponer Jaeger.
* Añadir dominios innecesarios.

---

# FASE 33 — GATEWAY DE TELEMETRÍA

## Objetivo

Proteger el endpoint público utilizado por el navegador.

## Opciones

### Mismo origen

```text
/otel/v1/traces
```

### Subdominio controlado

```text
https://telemetry.example.com/v1/traces
```

## Controles

* TLS.
* Rate limiting.
* Límite de body.
* Content-Type permitido.
* CORS estricto.
* Métodos permitidos.
* Timeout.
* WAF.
* Protección contra abuso.
* Métricas de volumen.
* No registrar payload OTLP.
* No exponer credenciales.

## Regla

No utilizar una API key dentro de Angular como secreto.

Todo valor incluido en el bundle debe considerarse público.

---

# FASE 34 — OPENTELEMETRY COLLECTOR

## Objetivo

Sanitizar y procesar las trazas antes de Jaeger.

## Archivo

```text
infra/otel-collector/otel-collector.angular.yml
```

## Procesadores a evaluar

```text
memory_limiter
batch
attributes
filter
resource
transform
probabilistic_sampler
tail_sampling
```

## Funciones

* Recibir OTLP HTTP.
* Limitar memoria.
* Agrupar spans.
* Eliminar atributos sensibles.
* Normalizar recursos.
* Filtrar ruido.
* Aplicar sampling.
* Reintentar exportación.
* Exportar a Jaeger.
* Manejar backpressure.
* Exponer métricas internas.

## Sanitizar

* Query strings.
* Cookies.
* Headers.
* Tokens.
* URLs firmadas.
* Correos.
* Nombres.
* Teléfonos.
* Archivos.
* Mensajes sensibles.
* Route params.
* Stack traces.

---

# FASE 35 — SAMPLING

## Objetivo

Controlar volumen y coste.

## Valores iniciales orientativos

```text
development: 1.00
test:        0.00 o exporter en memoria
staging:     0.25 a 1.00
production:  0.01 a 0.10
```

No aplicar sin medición.

## Estrategias

* Parent-based.
* Trace ID ratio.
* Sampling por sesión.
* Sampling en Collector.
* Tail sampling.
* Conservación prioritaria de errores.
* Conservación de operaciones lentas.

## Priorizar

* Navigation errors.
* Chunk load errors.
* Hydration errors.
* HTTP 5xx.
* Timeouts.
* Formularios críticos fallidos.
* Uploads fallidos.
* Operaciones críticas.
* Navegaciones lentas.

## Reglas

* Configurable por entorno.
* No hardcodear ratio.
* Decisión estable durante sesión cuando corresponda.
* No basarse en identificadores personales.
* No enviar 100% en producción sin justificar.

---

# FASE 36 — SEGURIDAD Y PRIVACIDAD

## Prohibido registrar

* Passwords.
* Tokens.
* Cookies.
* MFA.
* Formularios.
* Controles.
* Query strings.
* Correos.
* Teléfonos.
* Nombres.
* Direcciones.
* Documentos.
* Diagnósticos.
* Historias clínicas.
* Datos bancarios.
* Tarjetas.
* Comentarios.
* Mensajes privados.
* HTML.
* Estado NgRx.
* Signals.
* Payloads.
* Responses.
* Archivos.
* Imágenes.
* URLs firmadas.
* Pulsaciones.
* Texto copiado.
* Texto pegado.
* Geolocalización precisa.
* Fingerprinting.

## Crear

```text
docs/observability/angular/06-data-privacy-policy.md
```

Debe incluir:

* Datos permitidos.
* Datos prohibidos.
* Sanitización.
* Retención.
* Accesos.
* Sampling.
* Auditoría.
* Consentimiento.
* Identificadores de sesión.
* Eliminación.
* Respuesta ante incidentes.

---

# FASE 37 — PRUEBAS UNITARIAS

## Objetivo

Validar la infraestructura propia.

## Probar

### Configuración

* Enabled.
* Disabled.
* Endpoint válido.
* Endpoint inválido.
* Ratio válido.
* Ratio inválido.
* Runtime config fallida.
* Valores por defecto.

### TracingService

* Span síncrono.
* Span Promise.
* Span Observable.
* Completion.
* Error.
* Desuscripción.
* Multisuscripción.
* Retry.
* No-op.

### Router

* NavigationEnd.
* NavigationCancel.
* NavigationError.
* NavigationSkipped.
* Redirect.
* Guard denied.
* Resolver error.
* Lazy route.

### HTTP

* 2xx.
* 4xx.
* 5xx.
* Error de red.
* Timeout.
* Cancelación.
* Retry.
* Refresh token.
* Dominio excluido.
* Dominio permitido.

### ErrorHandler

* Error Angular.
* Promise rechazada.
* Error sanitizado.
* Duplicación.
* Sin span activo.

### Sanitización

* Token.
* Cookie.
* Query string.
* Correo.
* Archivo.
* URL firmada.
* Datos médicos.
* Datos financieros.

## Herramientas

Utilizar las herramientas reales:

* Vitest.
* Jest.
* Karma/Jasmine.
* TestBed.
* `HttpTestingController`.
* `RouterTestingHarness`.
* Exportador en memoria.

No depender de Jaeger para tests unitarios.

---

# FASE 38 — PRUEBAS DE INTEGRACIÓN

## Casos mínimos

1. Bootstrap.
2. OTel deshabilitado.
3. Collector caído.
4. Carga inicial.
5. Navegación.
6. Lazy loading.
7. Guard permitido.
8. Guard denegado.
9. Resolver exitoso.
10. Resolver fallido.
11. HTTP exitoso.
12. HTTP 4xx.
13. HTTP 5xx.
14. Timeout.
15. Cancelación.
16. Formulario.
17. ErrorHandler.
18. Error de chunk.
19. SSR.
20. Hidratación.
21. CORS.
22. CSP.
23. Sampling.

## Validar

* Aplicación funcional.
* Sin spans duplicados.
* Sin spans abiertos.
* Sin datos sensibles.
* Sin errores de change detection.
* Sin errores de hidratación.
* Sin suscripciones adicionales.
* Sin cambios funcionales.
* Sin crecimiento descontrolado de memoria.

---

# FASE 39 — PRUEBAS E2E

## Herramienta

Usar la existente:

* Playwright.
* Cypress.
* Otra aprobada.

## Flujo

1. Levantar Angular.
2. Levantar backend.
3. Levantar Collector.
4. Levantar Jaeger.
5. Abrir aplicación.
6. Navegar.
7. Ejecutar formulario.
8. Ejecutar llamada backend.
9. Obtener trace ID.
10. Consultar Jaeger.
11. Validar jerarquía.
12. Validar privacidad.

## Casos

* Login.
* Login fallido.
* Ruta protegida.
* Guard redirect.
* Resolver.
* Lazy route.
* Form submit.
* Backend 5xx.
* Upload.
* Download.
* Sesión expirada.
* SSR.
* Hidratación.
* Collector caído.

## Jerarquía esperada

```text
angular.navigation
   └── angular.form.submit
          └── HTTP POST /api/resource
                 └── backend HTTP
                       ├── service
                       ├── database
                       └── worker
```

---

# FASE 40 — SCRIPT DE VERIFICACIÓN

## Crear

```text
scripts/verify-angular-tracing.mjs
```

Debe:

* Verificar frontend.
* Verificar backend.
* Verificar Collector.
* Verificar Jaeger.
* Ejecutar flujo de prueba.
* Consultar Jaeger.
* Confirmar servicio Angular.
* Confirmar servicio backend.
* Confirmar trace compartido.
* Reportar errores.
* No usar datos de producción.
* No inventar éxito.

---

# FASE 41 — RENDIMIENTO Y BUNDLE

## Comparar

* OTel deshabilitado.
* OTel habilitado.
* Sampling 100%.
* Sampling de producción.
* Zone context manager.
* Estrategia zoneless.
* Collector disponible.
* Collector caído.

## Medir

* Bundle inicial.
* Bundle gzip.
* Bundle Brotli.
* Lazy chunks.
* Tiempo de bootstrap.
* LCP.
* INP.
* CLS.
* CPU.
* Memoria.
* Change detection.
* Main thread.
* Navegaciones.
* Bytes de telemetría.
* Cantidad de spans.
* Exportaciones.
* Batería y red móvil cualitativamente.

## Revisar

* Duplicación de `@opentelemetry/api`.
* Tree shaking.
* Imports innecesarios.
* Instrumentaciones experimentales.
* Zone pollution.
* Timers.
* Buffers.
* Listeners.
* Source maps.

## Entregable

```text
docs/observability/angular/07-performance-results.md
```

No afirmar que el impacto es aceptable sin mediciones.

---

# FASE 42 — DOCKER Y ENTORNO LOCAL

## Archivo

```text
docker-compose.observability.yml
```

Debe integrar:

* Angular.
* Backend.
* Collector.
* Jaeger.
* Proxy de telemetría.

## Scripts

```json
{
  "observability:up": "docker compose -f docker-compose.observability.yml up -d",
  "observability:down": "docker compose -f docker-compose.observability.yml down",
  "observability:logs": "docker compose -f docker-compose.observability.yml logs -f",
  "observability:verify": "node scripts/verify-angular-tracing.mjs"
}
```

## Reglas

* No usar imágenes `latest`.
* Publicar Jaeger solo en localhost en desarrollo cuando sea posible.
* No exponer Collector en producción.
* Usar nombres de servicios Docker internos.
* Configuración diferenciada para Angular dentro o fuera de Docker.

---

# FASE 43 — PRODUCCIÓN

## Topología

```text
Browser Angular
   │ HTTPS
   ▼
CDN / WAF / Nginx
   │
   ├── Angular assets
   ├── Backend API
   └── /otel/v1/traces
           │
           ▼
      OTel Collector
           │
           ▼
         Jaeger
           │
           ▼
  Almacenamiento persistente
```

## Requisitos

* TLS.
* CSP.
* CORS.
* Rate limiting.
* Collector privado.
* Jaeger privado.
* Autenticación para UI.
* Retención.
* Roles.
* Auditoría.
* Sampling.
* Sanitización.
* Monitoreo.
* Alertas de volumen.
* Control de costes.
* Política de eliminación.

## Entregable

```text
docs/observability/angular/08-production-topology.md
```

---

# FASE 44 — DOCUMENTACIÓN

## Crear

```text
docs/observability/angular/README.md
```

Debe explicar:

* Qué es una traza.
* Qué es un span.
* Qué es trace ID.
* Cómo inicia OTel.
* Cómo funciona con Angular.
* Cómo funciona con Zone.js.
* Cómo funciona zoneless.
* Cómo instrumentar Promise.
* Cómo instrumentar Observable.
* Cómo instrumentar Router.
* Cómo instrumentar Guard.
* Cómo instrumentar Resolver.
* Cómo instrumentar HttpClient.
* Cómo instrumentar formulario.
* Cómo instrumentar upload.
* Cómo registrar error.
* Cómo propagar al backend.
* Cómo buscar en Jaeger.
* Qué datos están prohibidos.
* Cómo modificar sampling.
* Cómo desactivar telemetría.
* Cómo ejecutar pruebas.
* Cómo levantar infraestructura.

Utilizar ejemplos reales del proyecto.

---

# FASE 45 — RUNBOOK OPERATIVO

## Crear

```text
docs/observability/angular/09-operational-runbook.md
```

## Incluir

### No llegan trazas

* Enabled.
* Endpoint.
* CSP.
* CORS.
* Proxy.
* Collector.
* Sampling.
* Content-Type.
* Network browser.

### Se pierde el contexto

* Zone.js.
* Gestor de contexto.
* RxJS.
* Interceptor.
* Dominios permitidos.
* `traceparent`.
* Aplicación zoneless.

### Spans duplicados

* Fetch.
* XHR.
* HttpInterceptor.
* API wrapper.
* Retry.
* Bootstrap duplicado.
* HMR.

### Spans abiertos

* Observable no completado.
* Falta de `finalize`.
* Navegación cancelada.
* Stream permanente.
* Multisuscripción.

### Angular se vuelve lento

* Zone pollution.
* Instrumentación de interacciones.
* Exceso de spans.
* Sampling.
* Batches.
* Timers.
* Change detection.
* Bundle.

### Datos sensibles

* Deshabilitar instrumentación.
* Aplicar filtro.
* Limitar acceso.
* Reducir retención.
* Eliminar datos cuando corresponda.
* Registrar incidente.
* Agregar prueba de regresión.

---

# FASE 46 — REVISIÓN FINAL

## Clean code

* Archivos menores de 300 líneas.
* Funciones pequeñas.
* Responsabilidad única.
* Sin `any` injustificado.
* Sin imports Node en browser.
* Sin imports browser en SSR.
* Sin dependencias circulares.
* Sin inicialización duplicada.
* Sin spans abiertos.
* Sin listeners sin limpieza.
* Sin suscripciones filtradas.
* Sin zone pollution evitable.
* Sin errores de hidratación.
* Sin datos sensibles.
* Sin secretos.
* Sin código temporal.
* Sin TODO críticos.
* Sin cambios visuales.
* Sin cambios funcionales no relacionados.

## Ejecutar

Adaptar al proyecto:

```bash
yarn lint
yarn test
yarn test:coverage
yarn e2e
yarn build
yarn build:ssr
```

Cuando exista:

```bash
yarn observability:up
yarn observability:verify
```

---

# 6. CRITERIOS DE ACEPTACIÓN

La implementación solo se considera completa cuando:

* [ ] Se identificó la versión de Angular.
* [ ] Se identificó standalone o NgModule.
* [ ] Se identificó Zone.js o zoneless.
* [ ] Se identificó CSR, SSR o híbrido.
* [ ] Angular inicia con OTel habilitado.
* [ ] Angular inicia con OTel deshabilitado.
* [ ] Angular funciona con Collector caído.
* [ ] No existe inicialización duplicada.
* [ ] Carga inicial genera trazas.
* [ ] Bootstrap genera trazas.
* [ ] Router genera trazas.
* [ ] Lazy loading genera trazas.
* [ ] Guards están instrumentados cuando corresponde.
* [ ] Resolvers están instrumentados cuando corresponde.
* [ ] HttpClient genera trazas.
* [ ] No existen spans HTTP duplicados.
* [ ] RxJS se instrumenta sin alterar Observables.
* [ ] Las desuscripciones finalizan spans.
* [ ] Signals no generan ruido.
* [ ] Formularios críticos generan spans.
* [ ] ErrorHandler está integrado.
* [ ] Errores no se duplican.
* [ ] Frontend y backend comparten trace ID.
* [ ] CORS permanece restringido.
* [ ] CSP permanece segura.
* [ ] SSR funciona.
* [ ] Hidratación funciona.
* [ ] No se introdujo Zone.js en una aplicación zoneless.
* [ ] No se capturan contraseñas.
* [ ] No se capturan tokens.
* [ ] No se capturan cookies.
* [ ] No se capturan formularios.
* [ ] No se capturan bodies.
* [ ] No se capturan archivos.
* [ ] No se capturan datos médicos.
* [ ] No se capturan datos financieros.
* [ ] Sampling es configurable.
* [ ] Release y build ID están disponibles.
* [ ] Bundle fue medido.
* [ ] Rendimiento fue medido.
* [ ] Pruebas unitarias pasan.
* [ ] Pruebas de integración pasan.
* [ ] Pruebas E2E pasan.
* [ ] Build de producción pasa.
* [ ] Documentación está completa.
* [ ] Runbook está completo.
* [ ] No existen pendientes críticos.

---

# 7. ENTREGABLES OBLIGATORIOS

Adaptar al proyecto real:

```text
src/app/core/observability/
├── browser/
│   ├── telemetry-browser.bootstrap.ts
│   ├── telemetry-browser.provider.ts
│   ├── telemetry-browser.exporter.ts
│   ├── telemetry-browser.resource.ts
│   ├── telemetry-browser.instrumentations.ts
│   ├── telemetry-browser.sampling.ts
│   └── telemetry-browser.lifecycle.ts
├── config/
│   ├── telemetry.config.ts
│   ├── telemetry-config.token.ts
│   ├── telemetry-config.validator.ts
│   └── telemetry-config.types.ts
├── tracing/
│   ├── tracing.service.ts
│   ├── noop-tracing.service.ts
│   ├── tracing.tokens.ts
│   ├── tracing.constants.ts
│   └── tracing.types.ts
├── http/
│   ├── telemetry-http.interceptor.ts
│   ├── http-route-normalizer.ts
│   └── trace-propagation-allowlist.ts
├── routing/
│   ├── router-tracing.service.ts
│   ├── route-template.service.ts
│   └── navigation-span.store.ts
├── rxjs/
│   └── trace-observable.ts
├── errors/
│   ├── telemetry-error-handler.ts
│   ├── error-sanitizer.ts
│   └── error-deduplicator.ts
└── security/
    ├── telemetry-sanitizer.ts
    └── telemetry-attribute-allowlist.ts
```

Infraestructura:

```text
docker-compose.observability.yml
infra/otel-collector/otel-collector.angular.yml
scripts/verify-angular-tracing.mjs
```

Documentación:

```text
docs/observability/angular/
├── 00-current-state-audit.md
├── 01-architecture-design.md
├── 02-naming-conventions.md
├── 03-async-context-strategy.md
├── 04-rxjs-tracing-guidelines.md
├── 05-web-vitals-strategy.md
├── 06-data-privacy-policy.md
├── 07-performance-results.md
├── 08-production-topology.md
├── 09-operational-runbook.md
└── README.md
```

Pruebas:

```text
src/app/core/observability/**/*.spec.ts
e2e/observability/**/*.spec.ts
```

Actualizar cuando corresponda:

```text
package.json
yarn.lock
angular.json
main.ts
main.server.ts
app.config.ts
app.config.server.ts
app.module.ts
server.ts
environment*.ts
nginx.conf
Dockerfile
README.md
```

---

# 8. INFORME FINAL

Entregar:

## 1. Resumen ejecutivo

Qué se implementó y qué valor aporta.

## 2. Arquitectura detectada

* Angular.
* Standalone o NgModule.
* Zone o zoneless.
* CSR, SSR o híbrido.
* Router.
* HTTP.
* Estado.
* Despliegue.

## 3. Arquitectura implementada

Diagrama Mermaid.

## 4. Archivos creados

Responsabilidad de cada archivo.

## 5. Archivos modificados

Motivo de cada cambio.

## 6. Dependencias

Versión, finalidad e impacto.

## 7. Instrumentación automática

Carga, Fetch, XHR y otras.

## 8. Instrumentación Angular

* Router.
* Guards.
* Resolvers.
* Lazy loading.
* HttpClient.
* ErrorHandler.
* RxJS.
* Formularios.
* SSR.
* Hidratación.

## 9. Propagación

Cómo se conserva el trace hacia el backend.

## 10. Seguridad

Datos permitidos, prohibidos y sanitización.

## 11. Sampling

Configuración por entorno.

## 12. Bundle

Comparación antes y después.

## 13. Rendimiento

Resultados reales.

## 14. Pruebas

Comandos y resultados reales.

No inventar resultados.

## 15. Uso local

Comandos completos.

## 16. Producción

Topología y controles.

## 17. Riesgos restantes

Lista concreta.

## 18. Matriz

| Requisito         |             Estado | Evidencia       |
| ----------------- | -----------------: | --------------- |
| Angular bootstrap |           Cumplido | Archivo/prueba  |
| Router            |           Cumplido | Archivo/prueba  |
| Guards            |           Cumplido | Archivo/prueba  |
| Resolvers         |           Cumplido | Archivo/prueba  |
| HttpClient        |           Cumplido | Archivo/prueba  |
| RxJS              |           Cumplido | Archivo/prueba  |
| ErrorHandler      |           Cumplido | Archivo/prueba  |
| Propagación       |           Cumplido | Traza/prueba    |
| SSR               | Cumplido/No aplica | Evidencia       |
| Hidratación       | Cumplido/No aplica | Evidencia       |
| Privacidad        |           Cumplido | Política/prueba |
| Rendimiento       |           Cumplido | Resultados      |

## 19. Estado final

Seleccionar uno:

```text
COMPLETO
COMPLETO CON OBSERVACIONES
INCOMPLETO
BLOQUEADO
```

No declarar `COMPLETO` cuando:

* Existan pruebas fallidas.
* No se haya validado propagación.
* Existan spans duplicados.
* Existan spans abiertos.
* Se capturen datos sensibles.
* Se haya roto SSR.
* Se haya roto hidratación.
* No se haya medido el bundle.
* No se haya probado producción.
* Existan pendientes críticos.

---

# 9. ORDEN DE EJECUCIÓN

```text
Fase 0  → Auditoría
Fase 1  → Arquitectura
Fase 2  → Convenciones
Fase 3  → Compatibilidad
Fase 4  → Dependencias
Fase 5  → Configuración
Fase 6  → Bootstrap
Fase 7  → Provider y exporter
Fase 8  → Zone/zoneless
Fase 9  → Document load
Fase 10 → Router
Fase 11 → Lazy loading
Fase 12 → Guards
Fase 13 → Resolvers
Fase 14 → HttpClient
Fase 15 → Propagación
Fase 16 → TracingService
Fase 17 → RxJS
Fase 18 → Signals
Fase 19 → Estado global
Fase 20 → Formularios
Fase 21 → Interacciones
Fase 22 → Errores
Fase 23 → Autenticación
Fase 24 → Archivos
Fase 25 → SSR
Fase 26 → Hidratación
Fase 27 → Service Worker
Fase 28 → Tiempo real
Fase 29 → Web Vitals
Fase 30 → Logs
Fase 31 → CORS
Fase 32 → CSP
Fase 33 → Gateway
Fase 34 → Collector
Fase 35 → Sampling
Fase 36 → Privacidad
Fase 37 → Unit tests
Fase 38 → Integración
Fase 39 → E2E
Fase 40 → Verificación
Fase 41 → Rendimiento
Fase 42 → Docker
Fase 43 → Producción
Fase 44 → Documentación
Fase 45 → Runbook
Fase 46 → Revisión final
```

Después de cada fase:

```text
1. Compilar.
2. Ejecutar pruebas relacionadas.
3. Corregir errores.
4. Revisar privacidad.
5. Verificar navegación.
6. Verificar HTTP.
7. Documentar.
8. Continuar.
```

---

# 10. INSTRUCCIÓN FINAL

Comienza inspeccionando el workspace Angular completo.

No escribas código antes de completar la auditoría.

No preguntes por información que pueda determinarse inspeccionando:

* `package.json`.
* `angular.json`.
* `main.ts`.
* `app.config.ts`.
* `app.module.ts`.
* Polyfills.
* Rutas.
* Interceptores.
* Entornos.
* SSR.
* Tests.

Cuando existan varias alternativas:

1. Identifica las opciones.
2. Evalúa compatibilidad con Angular.
3. Evalúa Zone.js o zoneless.
4. Evalúa RxJS.
5. Evalúa SSR.
6. Evalúa seguridad.
7. Evalúa privacidad.
8. Evalúa bundle.
9. Evalúa rendimiento.
10. Selecciona la opción más segura.
11. Implementa.
12. Prueba.
13. Documenta.

Prioriza:

```text
Seguridad
Privacidad
Estabilidad
Contexto asíncrono correcto
Propagación frontend-backend
Compatibilidad Angular
Rendimiento
Mantenibilidad
Pruebas
```

No priorices la cantidad de spans.

La traza final debe permitir comprender:

```text
usuario
→ componente Angular
→ Router o formulario
→ HttpClient
→ backend
→ base de datos
→ worker
→ respuesta
```

El resultado debe ser una implementación Angular funcional, segura, probada, mantenible, medible y preparada para desarrollo, staging y producción.
