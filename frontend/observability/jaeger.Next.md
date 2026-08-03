# PROMPT MAESTRO: IMPLEMENTACIÓN COMPLETA DE JAEGER Y OPENTELEMETRY EN FRONTEND

## Rol

Actúa como un **Arquitecto de Software Senior especializado en frontend, React, Next.js, Vite, OpenTelemetry, Jaeger, observabilidad distribuida, rendimiento web, seguridad y experiencia de usuario**.

Debes inspeccionar, diseñar e implementar una solución completa de trazabilidad distribuida para el frontend existente.

No debes limitarte a instalar dependencias o registrar solicitudes `fetch`. La implementación debe cubrir, según la arquitectura real:

* Carga inicial del documento.
* Hidratación.
* Renderizado inicial.
* Navegaciones SPA.
* Cambios de ruta.
* Interacciones relevantes del usuario.
* Llamadas HTTP al backend.
* Propagación del contexto de trazas.
* Errores de JavaScript.
* Promesas rechazadas.
* React Error Boundaries.
* Errores de páginas y rutas.
* Operaciones críticas de negocio.
* Formularios.
* Subida y descarga de archivos.
* Autenticación.
* Carga diferida.
* Web Vitals.
* Correlación con el backend.
* Correlación con el servidor de Next.js cuando exista.
* Despliegue local.
* Despliegue en producción.
* Seguridad y privacidad.
* Muestreo.
* Pruebas unitarias.
* Pruebas de integración.
* Pruebas E2E.
* Documentación para desarrollo y operaciones.

La solución debe utilizar **OpenTelemetry como estándar de instrumentación** y **Jaeger como plataforma de almacenamiento y visualización de trazas**.

No debes acoplar los componentes del frontend directamente a Jaeger.

---

# 1. OBJETIVO GENERAL

Implementar observabilidad distribuida que permita reconstruir un flujo completo como:

```text
Usuario
   │
   ▼
Frontend React / Next.js
   │
   ├── Carga del documento
   ├── Navegación
   ├── Interacción de usuario
   ├── Validación
   ├── Solicitud HTTP
   │      │
   │      ▼
   │   Backend API
   │      ├── Controller
   │      ├── Service
   │      ├── PostgreSQL
   │      ├── Redis
   │      └── Worker
   │
   ▼
OpenTelemetry Collector
   │
   ▼
Jaeger
```

La trazabilidad debe permitir responder:

* ¿Qué ruta estaba visitando el usuario?
* ¿Cuánto tardó la carga inicial?
* ¿Cuánto tardó una navegación SPA?
* ¿Qué acción inició una solicitud al backend?
* ¿Qué componente originó la operación?
* ¿Qué llamada HTTP falló?
* ¿La lentitud ocurrió en el navegador o en el backend?
* ¿Qué traza corresponde a un error mostrado en pantalla?
* ¿El frontend y el backend comparten el mismo `trace_id`?
* ¿Qué operación de negocio estaba ejecutándose?
* ¿Cuánto tardó una autenticación?
* ¿Cuánto tardó el envío de un formulario?
* ¿Qué dependencia externa generó latencia?
* ¿Qué versión del frontend produjo el problema?
* ¿Qué navegador, dispositivo o entorno estaba involucrado?
* ¿Qué errores ocurrieron antes de que el usuario reportara el problema?
* ¿La navegación falló por JavaScript, red o backend?

---

# 2. PRINCIPIO ARQUITECTÓNICO

La arquitectura recomendada debe ser:

```text
Navegador
   │
   │ OTLP HTTP
   ▼
Endpoint controlado de telemetría
   │
   │ Puede ser:
   │ - Proxy del mismo dominio
   │ - API Gateway
   │ - Reverse proxy
   │ - OpenTelemetry Collector protegido
   ▼
OpenTelemetry Collector
   │
   ▼
Jaeger
```

El frontend no debe enviar trazas directamente a:

* La interfaz de Jaeger.
* Un Collector interno sin protección.
* Un puerto privado expuesto indiscriminadamente.
* Un endpoint que requiera secretos incrustados en JavaScript.

En producción se recomienda usar un endpoint del mismo origen:

```text
https://app.example.com/otel/v1/traces
```

Internamente puede redirigir hacia:

```text
http://otel-collector:4318/v1/traces
```

La interfaz de Jaeger debe mantenerse privada y protegida.

---

# 3. CONTEXTO TÉCNICO POSIBLE

El frontend puede contener:

* React.
* Next.js.
* Vite.
* TypeScript.
* Tailwind CSS.
* React Router.
* Next.js App Router.
* Next.js Pages Router.
* Server Components.
* Client Components.
* Server Actions.
* Route Handlers.
* SSR.
* SSG.
* ISR.
* Zustand.
* Redux Toolkit.
* React Query o TanStack Query.
* Axios.
* Fetch.
* XMLHttpRequest.
* WebSockets.
* Server-Sent Events.
* Service Workers.
* PWA.
* Formularios con React Hook Form.
* Zod.
* Vitest.
* Jest.
* React Testing Library.
* Playwright.
* Cypress.
* Docker.
* Vercel.
* Cloudflare Pages.
* Netlify.
* Variables públicas de entorno.
* Yarn.
* Node.js `>=20 <24`.

Debes detectar la arquitectura real antes de modificar el código.

No asumas que todas estas tecnologías están presentes.

Instrumenta solamente lo que realmente exista, pero deja una estructura extensible y documentada.

---

# 4. REGLAS GENERALES

Debes cumplir estas reglas:

1. Utilizar OpenTelemetry.
2. Exportar trazas mediante OTLP HTTP desde el navegador.
3. No utilizar librerías antiguas de Jaeger.
4. No acoplar componentes React a Jaeger.
5. No modificar la lógica funcional.
6. No alterar el diseño visual.
7. No modificar contratos con el backend.
8. No romper SSR, SSG, ISR o hidratación.
9. No ejecutar código exclusivo del navegador durante SSR.
10. No importar módulos Node.js en bundles del navegador.
11. No incluir secretos en variables públicas.
12. No capturar contraseñas.
13. No capturar tokens.
14. No capturar cookies.
15. No capturar cuerpos completos de solicitudes.
16. No capturar respuestas completas.
17. No capturar contenido de formularios.
18. No capturar texto interno del DOM indiscriminadamente.
19. No capturar datos médicos o financieros.
20. No capturar documentos de identidad.
21. No capturar nombres de archivos sensibles.
22. No registrar query strings sin sanitización.
23. No propagar trazas a dominios externos no autorizados.
24. No instrumentar todos los clics sin filtrado.
25. No generar spans por cada render de React.
26. No generar spans por cada cambio de estado.
27. No usar nombres dinámicos de spans.
28. No utilizar IDs de entidades dentro del nombre del span.
29. Evitar atributos de alta cardinalidad.
30. Mantener las funciones pequeñas.
31. Mantener los archivos por debajo de 300 líneas salvo justificación.
32. Mantener TypeScript estricto.
33. Evitar `any` injustificado.
34. Mantener Yarn.
35. No reemplazar Yarn por npm.
36. No ejecutar exportaciones bloqueantes.
37. La caída de Jaeger o del Collector no debe bloquear la interfaz.
38. La telemetría debe poder desactivarse.
39. La aplicación debe funcionar con telemetría deshabilitada.
40. No utilizar `console.log` como solución de observabilidad.
41. No enviar todos los logs del navegador a Jaeger.
42. No usar Jaeger como herramienta de analítica comercial.
43. No implementar grabación de sesiones.
44. No capturar pantallas.
45. No capturar pulsaciones de teclado.
46. No alterar el consentimiento de privacidad existente.
47. No inventar resultados de pruebas.
48. No dejar código temporal.
49. No dejar tareas críticas pendientes.
50. Documentar cada decisión importante.

---

# 5. METODOLOGÍA DE EJECUCIÓN

La implementación debe realizarse por fases.

No avances a una fase posterior sin:

1. Completar la fase actual.
2. Compilar el frontend.
3. Ejecutar las pruebas relacionadas.
4. Corregir los errores.
5. Verificar que la aplicación siga funcionando.
6. Documentar las decisiones.
7. Revisar que no se hayan capturado datos sensibles.

Después de cada fase informa:

```text
Estado:
Arquitectura detectada:
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

---

# FASE 0 — AUDITORÍA INICIAL DEL FRONTEND

## Objetivo

Comprender la arquitectura real del frontend antes de implementar observabilidad.

## Revisar

* `package.json`.
* `yarn.lock`.
* `tsconfig.json`.
* `vite.config.*`.
* `next.config.*`.
* `src/main.tsx`.
* `src/index.tsx`.
* `src/app/`.
* `src/pages/`.
* `src/components/`.
* `src/features/`.
* `src/common/`.
* `src/shared/`.
* `src/services/`.
* `src/api/`.
* `src/hooks/`.
* `src/stores/`.
* `src/providers/`.
* `src/middleware.*`.
* `instrumentation.ts`.
* `instrumentation-client.ts`.
* Configuración de Axios.
* Wrappers de `fetch`.
* React Query.
* Redux.
* Zustand.
* React Router.
* Next.js Router.
* Error Boundaries.
* Manejo global de errores.
* Autenticación.
* Refresh token.
* Interceptors HTTP.
* WebSockets.
* Service Workers.
* PWA.
* Formularios.
* Subida de archivos.
* Descargas.
* Configuración CSP.
* Variables de entorno.
* Dockerfile.
* CI/CD.
* Despliegue.
* Pruebas unitarias.
* Pruebas E2E.
* Analítica existente.
* Sistemas de logging.
* Herramientas de monitoreo existentes.

## Identificar

1. Framework y versión.
2. React y versión.
3. Bundler.
4. Estrategia de renderizado.
5. App Router o Pages Router.
6. SSR, SSG o SPA.
7. Punto inicial del cliente.
8. Punto inicial del servidor frontend.
9. Runtime Node.js o Edge.
10. Cliente HTTP principal.
11. Dominios de API.
12. Librería de routing.
13. Sistema de estado.
14. Sistema de autenticación.
15. Componentes críticos.
16. Flujos críticos.
17. Datos sensibles manejados.
18. Herramientas de observabilidad existentes.
19. Posibles duplicaciones.
20. Restricciones de CSP.
21. Restricciones CORS.
22. Infraestructura de despliegue.
23. Mecanismo para identificar la versión desplegada.
24. Mecanismo actual de reporte de errores.
25. Existencia de source maps.
26. Compatibilidad con navegadores.
27. Tamaño actual del bundle.
28. Riesgos de hidratación.
29. Riesgos de rendimiento.
30. Riesgos de privacidad.

## Flujos prioritarios

Identifica operaciones como:

* Inicio de sesión.
* Cierre de sesión.
* Renovación de sesión.
* Registro.
* Recuperación de contraseña.
* Navegación principal.
* Búsquedas.
* Formularios.
* Creación de registros.
* Edición.
* Eliminación.
* Carga de tablas.
* Aplicación de filtros.
* Subida de documentos.
* Descarga de reportes.
* Procesos de negocio críticos.
* Confirmaciones.
* Pagos, cuando existan.
* Reservas o solicitudes.
* Ejecución de workflows.
* Visualización de resultados.

## Entregable

Crear:

```text
docs/observability/frontend/00-current-state-audit.md
```

Debe incluir:

* Arquitectura detectada.
* Diagrama actual.
* Puntos de instrumentación.
* Flujos críticos.
* Riesgos.
* Datos sensibles.
* Dependencias existentes.
* Plan adaptado al repositorio.
* Archivos que serán modificados.
* Archivos que no deben modificarse.
* Comparación del bundle antes de la implementación.

## Criterio de aceptación

No instalar dependencias antes de terminar la auditoría.

---

# FASE 1 — DISEÑO DE ARQUITECTURA

## Objetivo

Diseñar la integración sin acoplar el frontend al proveedor.

## Arquitectura SPA o Vite

```text
React/Vite
   │
   ├── OpenTelemetry Web SDK
   │
   ├── Document Load
   │
   ├── Fetch/XHR
   │
   ├── Navegación
   │
   └── Spans manuales
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

## Arquitectura Next.js

```text
Navegador
   │
   ├── instrumentación del cliente
   │
   ▼
Next.js / Proxy de telemetría
   │
   ├── SSR
   ├── Server Components
   ├── Route Handlers
   ├── Server Actions
   └── instrumentación del servidor
   │
   ▼
Collector
   │
   ▼
Jaeger
```

## Flujo distribuido completo

```text
Span de interacción
   │
   ▼
Span fetch del navegador
   │ traceparent
   ▼
Span HTTP del backend
   │
   ├── Servicio
   ├── PostgreSQL
   ├── Redis
   └── Worker
```

## Decisiones obligatorias

Documentar:

* Estrategia SPA, SSR o híbrida.
* Instrumentación cliente.
* Instrumentación del servidor Next.js.
* Instrumentación del runtime Edge, si existe.
* Endpoint OTLP.
* Proxy o gateway.
* CORS.
* CSP.
* Propagación.
* Sampling.
* Atributos permitidos.
* Atributos prohibidos.
* Convenciones de nombres.
* Tratamiento de rutas dinámicas.
* Tratamiento de usuarios.
* Tratamiento de sesiones.
* Tratamiento de errores.
* Web Vitals.
* Source maps.
* Despliegue.
* Versionado.
* Compatibilidad con navegadores.
* Política de retención.
* Impacto de bundle.
* Consentimiento y privacidad.

## Entregable

Crear:

```text
docs/observability/frontend/01-architecture-design.md
```

---

# FASE 2 — CONVENCIONES DE TRAZABILIDAD

## Objetivo

Definir nombres estables y atributos seguros.

## Nombres de servicios

Usar:

```text
<producto>-web
<producto>-next-server
<producto>-edge
```

Ejemplos:

```text
atlas-web
atlas-next-server
salud-web
cpa-web
```

No utilizar el mismo `service.name` para navegador y servidor.

## Spans técnicos

Ejemplos:

```text
document.load
route.navigation
http.client
ui.interaction
resource.load
```

## Spans de negocio

Usar:

```text
<dominio>.<acción>
```

Ejemplos:

```text
auth.login
auth.logout
customer.register
credit.application.submit
credit.evaluation.request
document.upload
report.download
appointment.create
workflow.execute
profile.update
```

No utilizar:

```text
customer.register.38283
document.upload.factura-pablo.pdf
route./customers/2837
button.click.guardar-cliente-pablo
```

## Atributos propios

Usar un namespace consistente:

```text
app.feature
app.operation
app.route.template
app.release
app.build.id
app.environment
ui.component
ui.action
ui.result
ui.form.name
ui.navigation.type
network.request.type
app.authenticated
app.user.segment
app.session.id
```

## Reglas

* `app.route.template` debe usar la plantilla de ruta.
* No guardar parámetros dinámicos sensibles.
* No guardar la URL completa cuando tenga query string.
* No guardar el contenido de inputs.
* No guardar texto libre del usuario.
* No guardar tokens.
* No guardar correo electrónico.
* No guardar nombre completo.
* No guardar teléfono.
* No guardar diagnóstico.
* No guardar datos financieros.
* No guardar nombres de archivos sensibles.

## Entregable

Crear:

```text
docs/observability/frontend/02-naming-conventions.md
```

---

# FASE 3 — INSTALACIÓN DE DEPENDENCIAS

## Objetivo

Instalar solamente paquetes compatibles y necesarios.

## Dependencias a evaluar

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
yarn add @opentelemetry/instrumentation-user-interaction
```

Evaluar:

```bash
yarn add @opentelemetry/context-zone
```

Instalarlo solamente si el gestor de contexto es necesario y compatible con el framework.

Para Next.js del lado servidor, evaluar separadamente:

```bash
yarn add @opentelemetry/sdk-node
yarn add @opentelemetry/auto-instrumentations-node
```

No incluir dependencias Node.js dentro del bundle del navegador.

## Reglas

* Verificar versiones vigentes.
* Verificar compatibilidad entre paquetes.
* No mezclar versiones incompatibles.
* No instalar instrumentaciones no utilizadas.
* No usar metapaquetes sin revisar su impacto.
* No instalar SDK antiguo de Jaeger.
* No actualizar todas las dependencias del proyecto sin necesidad.
* Mantener `yarn.lock` consistente.
* Medir el bundle antes y después.
* Ejecutar build después de instalar.

## Pruebas

```bash
yarn install
yarn lint
yarn typecheck
yarn test
yarn build
```

Adaptar los comandos a los scripts reales.

---

# FASE 4 — CONFIGURACIÓN DE VARIABLES

## Objetivo

Centralizar la configuración pública de telemetría.

## Variables para Vite

```env
VITE_OTEL_ENABLED=true
VITE_OTEL_SERVICE_NAME=atlas-web
VITE_OTEL_EXPORTER_OTLP_TRACES_ENDPOINT=/otel/v1/traces
VITE_OTEL_SAMPLE_RATIO=1
VITE_APP_VERSION=1.0.0
VITE_BUILD_ID=local
VITE_DEPLOYMENT_ENVIRONMENT=development
```

## Variables para Next.js

```env
NEXT_PUBLIC_OTEL_ENABLED=true
NEXT_PUBLIC_OTEL_SERVICE_NAME=atlas-web
NEXT_PUBLIC_OTEL_EXPORTER_OTLP_TRACES_ENDPOINT=/otel/v1/traces
NEXT_PUBLIC_OTEL_SAMPLE_RATIO=1
NEXT_PUBLIC_APP_VERSION=1.0.0
NEXT_PUBLIC_BUILD_ID=local
NEXT_PUBLIC_DEPLOYMENT_ENVIRONMENT=development
```

## Regla crítica

Todas las variables públicas pueden ser visibles en el navegador.

Nunca colocar:

* API keys privadas.
* Tokens.
* Contraseñas.
* Credenciales del Collector.
* Secretos de Jaeger.
* Claves de servicios.
* Cadenas privadas de conexión.

## Implementar

Un adaptador validado:

```text
src/observability/config/
├── telemetry.config.ts
├── telemetry.schema.ts
└── telemetry.types.ts
```

Debe:

* Validar tipos.
* Aplicar valores por defecto seguros.
* Validar ratios entre `0` y `1`.
* Validar URL o ruta relativa.
* Desactivar telemetría si la configuración es inválida.
* Emitir una advertencia controlada en desarrollo.
* No romper la aplicación.
* No acceder a variables dispersas por todo el código.

---

# FASE 5 — BOOTSTRAP TEMPRANO DEL NAVEGADOR

## Objetivo

Inicializar OpenTelemetry antes de las operaciones que deben medirse.

## Para Vite o React SPA

La inicialización debe ocurrir antes del montaje principal:

```ts
import './observability/telemetry.browser';

import React from 'react';
import ReactDOM from 'react-dom/client';
```

## Para Next.js

Evaluar el mecanismo adecuado según la versión:

* `instrumentation-client.ts` para el navegador.
* `instrumentation.ts` para servidor.
* Separación estricta entre código cliente y servidor.

## Estructura sugerida

```text
src/observability/
├── browser/
│   ├── telemetry.browser.ts
│   ├── browser-provider.ts
│   ├── browser-exporter.ts
│   ├── browser-instrumentations.ts
│   ├── browser-resource.ts
│   ├── browser-sampling.ts
│   └── browser-lifecycle.ts
├── core/
│   ├── tracing.service.ts
│   ├── tracing.types.ts
│   └── tracing.constants.ts
└── config/
    ├── telemetry.config.ts
    └── telemetry.schema.ts
```

Adaptar la estructura al proyecto.

## Implementar

* `WebTracerProvider`.
* Resource del frontend.
* Exportador OTLP HTTP.
* `BatchSpanProcessor`.
* Sampler configurable.
* Propagador W3C.
* Instrumentaciones seleccionadas.
* Inicialización idempotente.
* Protección contra SSR.
* Protección contra ejecución duplicada.
* Manejo de Hot Module Replacement.
* Desactivación por configuración.
* `forceFlush()` no bloqueante cuando corresponda.
* Limpieza controlada.

## Ciclo de vida

Evaluar:

* `pagehide`.
* `visibilitychange`.
* Cierre de pestaña.
* Navegación completa.
* Suspensión en móviles.

Realizar un `forceFlush()` de mejor esfuerzo cuando la página se oculte, sin bloquear la navegación.

## Criterios de aceptación

* No se inicializa durante SSR.
* No se inicializa dos veces.
* No falla con HMR.
* No rompe hidratación.
* La aplicación funciona con telemetría desactivada.
* La aplicación funciona si el Collector no está disponible.

---

# FASE 6 — RESOURCE DEL FRONTEND

## Objetivo

Identificar claramente cada despliegue.

## Atributos mínimos

Configurar según las convenciones semánticas vigentes:

```text
service.name
service.namespace
service.version
deployment.environment.name
```

Agregar atributos controlados:

```text
app.build.id
app.release
app.framework
app.rendering.mode
```

Ejemplo:

```text
service.name = atlas-web
service.namespace = atlas
service.version = 2.4.1
deployment.environment.name = production
app.build.id = commit-a1b2c3d
app.framework = nextjs
app.rendering.mode = hybrid
```

## Reglas

* No generar una versión distinta en cada carga.
* Usar versión del build.
* Usar commit o identificador del despliegue.
* No incluir nombre del desarrollador.
* No incluir rutas locales.
* No incluir secretos.

---

# FASE 7 — EXPORTACIÓN OTLP DESDE EL NAVEGADOR

## Objetivo

Enviar spans eficientemente y sin bloquear la interfaz.

## Implementar

* OTLP HTTP.
* Preferiblemente HTTP/protobuf o el protocolo oficialmente compatible con la infraestructura.
* Exportación por lotes.
* Timeout razonable.
* Endpoint relativo del mismo origen.
* Manejo silencioso y controlado de fallos.
* Límites de cola.
* Límites de batch.
* Sampling.
* Backoff gestionado por la infraestructura cuando corresponda.

## Prohibido

* Enviar directamente a la interfaz Jaeger.
* Incrustar credenciales privadas.
* Reintentar indefinidamente.
* Guardar trazas en `localStorage`.
* Bloquear la interfaz esperando exportación.
* Mostrar errores de telemetría al usuario.
* Recargar la página si falla el exportador.
* Saturar la red móvil.

## Comportamiento esperado

Si el endpoint de telemetría falla:

* La aplicación continúa funcionando.
* Las operaciones de negocio continúan.
* No aparece una pantalla de error.
* No se genera un bucle de reintentos.
* El error puede registrarse de forma limitada en desarrollo.

---

# FASE 8 — INSTRUMENTACIÓN DE CARGA DEL DOCUMENTO

## Objetivo

Capturar la carga inicial del frontend.

## Evaluar

* `DocumentLoadInstrumentation`.
* Navegación.
* DNS.
* Conexión.
* TLS.
* Solicitud HTML.
* Descarga.
* Carga de recursos.
* Inicio del render.
* Carga completa.

## Evitar

* Capturar URLs completas con datos sensibles.
* Generar spans excesivos por cada recurso.
* Capturar recursos de terceros irrelevantes.
* Capturar query strings.
* Capturar parámetros de autenticación.

## Validación

La traza inicial debe mostrar una jerarquía comprensible:

```text
document.load
   ├── document.fetch
   ├── resource.css
   ├── resource.js
   └── initial.render
```

No se exige conservar cada recurso si genera demasiado ruido.

---

# FASE 9 — NAVEGACIÓN SPA Y CAMBIOS DE RUTA

## Objetivo

Medir navegaciones sin recarga completa.

## Frameworks a contemplar

* React Router.
* Next.js App Router.
* Next.js Pages Router.
* Router propio.

## Crear spans como:

```text
route.navigation
```

Con atributos:

```text
app.route.from
app.route.to
app.route.template
ui.navigation.type
```

Ejemplo:

```text
app.route.from = /dashboard
app.route.to = /customers/:customerId
app.route.template = /customers/:customerId
ui.navigation.type = spa
```

## Reglas

* Usar rutas normalizadas.
* No guardar query strings.
* No guardar IDs sensibles.
* No guardar hash con información del usuario.
* No crear spans duplicados.
* No crear un span por cada render.
* Finalizar el span cuando la ruta esté utilizable.
* Evaluar carga de datos vinculada a la navegación.
* Evaluar Suspense y lazy loading.
* No mantener spans abiertos indefinidamente.

## Casos de prueba

* Navegación por enlace.
* Navegación programática.
* Botón atrás.
* Botón adelante.
* Redirección.
* Ruta protegida.
* Ruta no encontrada.
* Error durante navegación.
* Navegación con datos remotos.
* Navegación cancelada.

---

# FASE 10 — FETCH, AXIOS Y XHR

## Objetivo

Instrumentar todas las solicitudes propias sin duplicarlas.

## Detectar

* `fetch`.
* Axios.
* `HttpClient` propio.
* React Query.
* TanStack Query.
* XMLHttpRequest.
* GraphQL.
* Uploads.
* Downloads.

## Instrumentaciones

Evaluar:

* `FetchInstrumentation`.
* `XMLHttpRequestInstrumentation`.

Si Axios utiliza XHR o fetch, evitar duplicación.

## Capturar

* Método HTTP.
* Dominio permitido.
* Plantilla de ruta cuando sea posible.
* Código de respuesta.
* Duración.
* Error de red.
* Cancelación.
* Timeout.
* Tamaño aproximado cuando sea seguro.
* Reintentos, si la aplicación los ejecuta.

## No capturar

* Body.
* Response body.
* Authorization.
* Cookies.
* Refresh token.
* Access token.
* Query strings sensibles.
* Presigned URLs completas.
* Contenido de archivos.
* Datos de formularios.

## Nombres

Usar nombres estables:

```text
GET /api/customers/:id
POST /api/auth/login
POST /api/documents
```

No utilizar:

```text
GET /api/customers/892738
GET /api/search?q=nombre-completo
```

---

# FASE 11 — PROPAGACIÓN HACIA EL BACKEND

## Objetivo

Conservar la misma traza desde el navegador hasta el backend.

## Propagadores

Usar:

```text
tracecontext
baggage
```

Usar `baggage` solamente para atributos explícitamente aprobados.

No colocar información personal dentro de baggage.

## Configurar dominios permitidos

La propagación debe limitarse a:

* API propia.
* BFF propio.
* Servicios internos controlados.

Ejemplo conceptual:

```ts
propagateTraceHeaderCorsUrls: [
  /^https:\/\/api\.example\.com/,
  /^\/api\//,
]
```

No propagar a:

* Google.
* Meta.
* CDN de terceros.
* Sistemas de analítica.
* Proveedores no controlados.
* URLs arbitrarias ingresadas por usuarios.

## Headers

El navegador podrá enviar:

```text
traceparent
tracestate
baggage
```

El backend debe aceptar estos headers.

Cuando sea cross-origin, revisar CORS:

```text
Access-Control-Allow-Headers:
  content-type,
  authorization,
  traceparent,
  tracestate,
  baggage
```

Cuando el backend devuelva un identificador de soporte:

```text
Access-Control-Expose-Headers:
  x-trace-id
```

## Regla crítica

El frontend no debe construir manualmente un `trace_id`.

El frontend tampoco debe utilizar un `x-trace-id` recibido como sustituto del contexto W3C.

## Validación

Una solicitud debe producir:

```text
ui.interaction
   └── fetch POST /api/operation
          └── backend HTTP span
                ├── service
                ├── database
                └── worker
```

Todos deben compartir el mismo `trace_id`.

---

# FASE 12 — CORS Y PREFLIGHT

## Objetivo

Evitar que la propagación rompa las solicitudes.

## Revisar

* Origen del frontend.
* Origen del backend.
* Proxy de desarrollo.
* Credenciales.
* Preflight.
* Headers permitidos.
* Métodos permitidos.
* Cache de preflight.
* Cookies `SameSite`.
* CDN.
* Reverse proxy.

## Pruebas

* Solicitud same-origin.
* Solicitud cross-origin.
* Solicitud con credenciales.
* Preflight exitoso.
* Preflight rechazado.
* Backend sin soporte de `traceparent`.
* Backend con soporte de `traceparent`.
* Entorno local.
* Staging.
* Producción.

## Regla

No ampliar CORS a `*` para resolver la telemetría.

Mantener una lista explícita de orígenes.

---

# FASE 13 — INSTRUMENTACIÓN DE INTERACCIONES

## Objetivo

Relacionar acciones importantes del usuario con operaciones posteriores.

## Evaluar

`UserInteractionInstrumentation`, pero no activar todos los eventos indiscriminadamente.

## Instrumentar solamente

* Acciones que inician operaciones de negocio.
* Envío de formularios.
* Confirmaciones.
* Navegaciones críticas.
* Ejecución de procesos.
* Subidas.
* Descargas.
* Aplicación de filtros costosos.
* Búsquedas remotas.
* Creación, modificación o eliminación.
* Apertura de flujos críticos.

## No instrumentar automáticamente

* Cada movimiento del mouse.
* Hover.
* Scroll.
* Cada tecla.
* Focus de todos los inputs.
* Clics decorativos.
* Animaciones.
* Tooltips.
* Cambios visuales triviales.
* Cada apertura de menú.
* Cada render.
* Cada actualización de estado.

## Atributos permitidos

```text
ui.component
ui.action
app.feature
app.operation
ui.result
```

Ejemplo:

```text
ui.component = CreditApplicationForm
ui.action = submit
app.feature = credit-applications
app.operation = create
```

## Prohibido capturar

* Texto completo del botón si puede contener datos dinámicos.
* Contenido de inputs.
* Valores de selects.
* Texto de comentarios.
* Datos personales.
* Texto copiado.
* Texto pegado.
* Coordenadas precisas.
* Selectores CSS enormes.
* HTML del elemento.

---

# FASE 14 — SERVICIO DE TRAZABILIDAD DEL FRONTEND

## Objetivo

Crear una API pequeña y reutilizable.

## Estructura sugerida

```text
src/observability/core/
├── tracing.service.ts
├── tracing.types.ts
├── tracing.constants.ts
└── tracing.attributes.ts
```

## API esperada

```ts
runInSpan<T>(
  name: string,
  attributes: Attributes,
  operation: (span: Span) => Promise<T> | T,
): Promise<T>;
```

Puede incluir:

```ts
startSpan(...)
runInSpan(...)
addEvent(...)
setAttribute(...)
setAttributes(...)
recordException(...)
getActiveTraceId(...)
getActiveSpanId(...)
getTraceContext(...)
```

## Requisitos

* Usar `trace.getTracer()`.
* Usar `startActiveSpan()`.
* Finalizar spans en `finally`.
* Registrar excepciones.
* Marcar errores.
* Conservar el error original.
* Soportar operaciones síncronas.
* Soportar operaciones asíncronas.
* Mantener tipos genéricos.
* Funcionar como no-op cuando OTel esté deshabilitado.
* No importar Jaeger.
* Evitar dependencia directa desde componentes presentacionales.

## No-op

Cuando la telemetría esté deshabilitada, la API debe:

* Ejecutar la operación.
* Retornar el resultado.
* Relanzar errores.
* No crear spans.
* No modificar el comportamiento funcional.

---

# FASE 15 — SPANS DE NEGOCIO

## Objetivo

Instrumentar flujos que no se entienden únicamente mediante spans técnicos.

## Ejemplos

```text
auth.login
auth.session.refresh
customer.register
profile.update
credit.application.submit
workflow.execute
document.upload
document.download
report.generate
appointment.request
notification.preferences.update
```

## Ejemplo conceptual

```ts
return tracingService.runInSpan(
  'credit.application.submit',
  {
    'app.feature': 'credit-applications',
    'app.operation': 'submit',
    'ui.component': 'CreditApplicationForm',
  },
  async (span) => {
    span.addEvent('validation.started');

    const validated = validateApplication(formData);

    span.addEvent('validation.completed', {
      'validation.success': validated.success,
    });

    const response = await creditApi.submit(validated.data);

    span.setAttribute('ui.result', 'success');

    return response;
  },
);
```

## Reglas

* No registrar `formData`.
* No registrar resultados completos.
* No registrar nombres.
* No registrar montos sensibles sin autorización.
* No crear spans para funciones triviales.
* No instrumentar cada hook.
* No instrumentar cada selector.
* No instrumentar cada componente.
* Utilizar eventos para hitos internos.
* Usar nombres estables.

## Entregable

Crear:

```text
docs/observability/frontend/03-business-spans-catalog.md
```

Para cada span incluir:

* Nombre.
* Feature.
* Acción.
* Componente iniciador.
* Atributos.
* Eventos.
* Motivo técnico.
* Motivo de negocio.
* Riesgos de privacidad.
* Prueba asociada.

---

# FASE 16 — FORMULARIOS

## Objetivo

Medir el proceso sin capturar el contenido.

## Instrumentar

* Inicio de envío.
* Resultado de validación.
* Solicitud remota.
* Éxito.
* Error.
* Cancelación.
* Duración total.
* Número de errores de validación, cuando sea seguro.

## Atributos permitidos

```text
ui.form.name
validation.success
validation.error.count
ui.result
```

## Prohibido

* Nombre del usuario.
* Correo.
* Teléfono.
* Dirección.
* Contraseña.
* Contenido de comentarios.
* Datos médicos.
* Datos financieros.
* Valores de campos.
* Serialización del formulario.

## Regla

Registrar que fallaron tres campos puede ser aceptable.

Registrar cuáles fueron y sus valores puede ser sensible y debe evitarse salvo evaluación expresa.

---

# FASE 17 — SUBIDA Y DESCARGA DE ARCHIVOS

## Objetivo

Medir operaciones pesadas de red.

## Spans sugeridos

```text
document.upload
document.download
file.validation
file.processing.request
```

## Atributos permitidos

```text
file.type
file.extension
file.size.bucket
upload.strategy
ui.result
```

## Utilizar buckets de tamaño

Ejemplo:

```text
0-1MB
1-5MB
5-20MB
20-100MB
100MB+
```

## Prohibido

* Nombre completo del archivo.
* Ruta local.
* Contenido.
* Base64.
* URL firmada completa.
* Hash reversible.
* Documento del usuario.
* Metadatos EXIF.
* Identificadores personales.

## Pruebas

* Archivo válido.
* Tipo inválido.
* Tamaño inválido.
* Cancelación.
* Timeout.
* Error 4xx.
* Error 5xx.
* Reintento.
* Upload multipart.
* Descarga interrumpida.

---

# FASE 18 — ERRORES GLOBALES DEL NAVEGADOR

## Objetivo

Capturar errores no controlados sin duplicaciones.

## Integrar

* `window.onerror`.
* `unhandledrejection`.
* Errores de recursos cuando corresponda.
* Errores del router.
* Errores de carga dinámica.
* Errores de chunks.
* Fallos de hidratación.
* Fallos de renderizado.
* Errores de operaciones instrumentadas.

## Comportamiento esperado

1. Obtener span activo.
2. Registrar la excepción.
3. Marcar el span como error.
4. Agregar metadata segura.
5. Evitar duplicar el mismo error.
6. Mantener el comportamiento actual.
7. No mostrar stack técnico al usuario.
8. No exponer detalles internos.

## Atributos seguros

```text
error.type
error.source
error.handled
app.route.template
app.release
```

## Revisar mensajes

Los mensajes de error pueden contener:

* URLs.
* Tokens.
* Datos escritos por el usuario.
* Nombres de archivos.
* Respuestas del backend.

Implementar sanitización antes de exportarlos.

---

# FASE 19 — REACT ERROR BOUNDARY

## Objetivo

Capturar fallos de renderizado.

## Crear o adaptar

```text
src/observability/react/
├── TelemetryErrorBoundary.tsx
├── react-error-reporter.ts
└── react-error.types.ts
```

## Requisitos

* Integrarse con Error Boundaries existentes.
* No reemplazar la interfaz de error actual.
* Registrar excepción una sola vez.
* Registrar la ruta normalizada.
* Registrar la versión.
* Registrar nombre estático del feature cuando sea conocido.
* No enviar props.
* No enviar estado.
* No enviar HTML.
* No enviar contenido de formularios.
* No mostrar detalles técnicos al usuario.

## Para Next.js

Revisar:

* `error.tsx`.
* `global-error.tsx`.
* `not-found.tsx`.
* Errores de layouts.
* Errores de rutas.
* Errores de Server Components.
* Errores de Client Components.

Evitar duplicar errores entre Next.js, Error Boundary y listener global.

---

# FASE 20 — AUTENTICACIÓN Y SESIÓN

## Objetivo

Instrumentar autenticación sin comprometer credenciales.

## Spans

```text
auth.login
auth.logout
auth.session.refresh
auth.session.validate
auth.password.recovery.request
auth.password.reset
```

## Atributos permitidos

```text
auth.method
auth.result
auth.failure.category
app.authenticated
```

## Valores de error normalizados

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

* Usuario.
* Correo.
* Contraseña.
* Access token.
* Refresh token.
* Cookies.
* Códigos de recuperación.
* Códigos 2FA.
* Respuestas completas.
* Claims completos del JWT.

## Regla

No diferenciar en telemetría si un correo existe o no existe cuando eso pueda facilitar enumeración de usuarios.

---

# FASE 21 — IDENTIFICACIÓN DE SESIÓN Y USUARIO

## Objetivo

Facilitar diagnóstico sin crear seguimiento invasivo.

## Estrategia recomendada

Utilizar un identificador de sesión:

* Aleatorio.
* Efímero.
* Rotado.
* No derivado del correo.
* No derivado del nombre.
* No derivado del documento.
* No reutilizado indefinidamente.
* No compartido con terceros.

## Posibles atributos

```text
app.session.id
app.authenticated
app.user.segment
```

## `app.user.segment`

Debe ser una categoría de baja cardinalidad:

```text
anonymous
customer
operator
administrator
professional
```

No usar roles sensibles sin aprobación.

## Identificador persistente

No agregar un identificador permanente de usuario sin:

* Revisión de privacidad.
* Justificación de negocio.
* Política de retención.
* Control de acceso.
* Pseudonimización.
* Consentimiento cuando corresponda.

## Prohibido

* Correo.
* Teléfono.
* Nombre.
* Documento.
* IP agregada manualmente.
* Geolocalización precisa.
* Fingerprinting del navegador.
* Combinación de atributos para identificar al usuario.

---

# FASE 22 — WEB VITALS Y RENDIMIENTO PERCIBIDO

## Objetivo

Relacionar experiencia del usuario con las trazas.

## Métricas a evaluar

* LCP.
* INP.
* CLS.
* FCP.
* TTFB.

## Regla conceptual

Jaeger es principalmente una plataforma de trazas.

No forzar Web Vitals dentro de Jaeger como sustituto de una plataforma de métricas.

Se puede:

1. Agregar valores relevantes como eventos o atributos de una traza de navegación.
2. Exportar métricas separadamente mediante OpenTelemetry Collector.
3. Mantener una solución existente de Web Vitals.
4. Correlacionar mediante versión, ruta y entorno.

## Evitar

* Un span separado para cada cambio de layout.
* Alta cardinalidad.
* Capturar selectores DOM.
* Capturar contenido visible.
* Duplicar métricas.
* Enviar todos los `PerformanceEntry`.

## Entregable

Crear:

```text
docs/observability/frontend/04-web-vitals-strategy.md
```

Debe explicar:

* Qué se mide.
* Dónde se almacena.
* Cómo se correlaciona.
* Qué no se enviará a Jaeger.
* Impacto esperado.

---

# FASE 23 — REACT QUERY, TANSTACK QUERY Y CACHÉ

## Objetivo

Relacionar carga de datos, caché y red.

## Evaluar

* Query iniciada.
* Cache hit.
* Cache miss.
* Fetch.
* Retry.
* Error.
* Invalidación.
* Mutación.
* Refetch.

## Reglas

* No crear spans para cada lectura interna de caché.
* Evitar duplicación con `fetch`.
* Crear spans manuales solo cuando agreguen contexto.
* No registrar query keys completas si contienen IDs.
* Normalizar query keys.
* No registrar datos devueltos.

## Ejemplos

```text
data.query
data.mutation
cache.invalidate
```

Atributos:

```text
app.feature
data.operation
cache.result
retry.count
```

---

# FASE 24 — ESTADO GLOBAL

## Objetivo

Instrumentar únicamente transiciones críticas.

## Sistemas

* Redux.
* Zustand.
* Context API.
* Máquina de estados.
* Estado propio.

## No instrumentar

* Cada `dispatch`.
* Cada selector.
* Cada actualización.
* Cada render.
* Cada cambio de input.
* Estado completo.
* Payloads completos.

## Instrumentar opcionalmente

* Inicio de workflow.
* Finalización.
* Cambio de etapa crítica.
* Fallo de proceso.
* Cancelación.
* Reintento.

Ejemplo:

```text
workflow.stage.changed
```

Con atributos:

```text
workflow.name
workflow.previous.stage
workflow.current.stage
```

Los valores deben ser categorías controladas.

---

# FASE 25 — WEBSOCKETS, SSE Y TIEMPO REAL

## Objetivo

Mantener contexto en comunicaciones persistentes cuando existan.

## Revisar

* Conexión.
* Reconexión.
* Suscripción.
* Recepción.
* Publicación.
* Error.
* Desconexión.
* Heartbeats.
* Reintentos.

## Spans sugeridos

```text
websocket.connect
websocket.send
websocket.receive
sse.connect
sse.message
```

## Reglas

* No crear un único span durante horas.
* Crear spans por operación relevante.
* No instrumentar heartbeats rutinarios.
* No registrar payloads.
* Propagar contexto en metadata solo cuando el protocolo lo permita.
* Mantener compatibilidad con mensajes antiguos.
* Limitar volumen.

---

# FASE 26 — SERVICE WORKERS Y PWA

## Objetivo

Instrumentar procesos fuera del hilo principal cuando realmente existan.

## Revisar

* Registro.
* Activación.
* Actualización.
* Fetch interceptado.
* Cache offline.
* Background sync.
* Push notifications.

## Reglas

* El Service Worker es un contexto independiente.
* Inicializar telemetría separadamente si es compatible.
* No asumir que comparte el contexto de la página.
* Propagar metadata explícitamente cuando sea necesario.
* No romper comportamiento offline.
* No bloquear instalación.
* No almacenar spans indefinidamente.
* No guardar datos sensibles en cachés de telemetría.

## Si la instrumentación no es estable

Documentar la limitación y priorizar:

* Trazas de la página.
* Trazas del backend.
* Eventos manuales controlados.

No implementar soluciones frágiles solo para afirmar cobertura total.

---

# FASE 27 — NEXT.JS DEL LADO SERVIDOR

## Objetivo

Instrumentar la porción servidor de un frontend Next.js.

Esta fase aplica únicamente si el frontend ejecuta servidor Next.js.

## Separar servicios

```text
atlas-web
atlas-next-server
```

## Instrumentar

* SSR.
* Route Handlers.
* Server Actions.
* Middleware cuando sea compatible.
* Server Components.
* Solicitudes salientes.
* Revalidaciones.
* Generación dinámica.
* Errores del servidor.
* Rendering.
* BFF interno.

## Archivos

Evaluar:

```text
instrumentation.ts
instrumentation-client.ts
```

## Runtime

Diferenciar:

```text
nodejs
edge
browser
```

No cargar `NodeSDK` en Edge o navegador.

## Reglas

* No duplicar spans generados por Next.js.
* No generar spans por cada componente.
* No incluir props.
* No incluir HTML.
* No incluir cookies.
* No incluir tokens.
* No incluir parámetros sensibles.
* Mantener separación de bundles.
* Validar despliegue real.

## Server Actions

Crear spans de negocio cuando corresponda:

```text
customer.create
profile.update
document.submit
```

No utilizar el identificador interno de la Server Action como nombre del span.

---

# FASE 28 — SOURCE MAPS Y VERSIONADO

## Objetivo

Relacionar errores minificados con una versión exacta.

## Implementar

* `service.version`.
* `app.release`.
* `app.build.id`.
* Commit o identificador de despliegue.
* Mapeo con CI/CD.
* Política de source maps.

## Seguridad

Los source maps de producción no deben publicarse indiscriminadamente.

Evaluar:

* Almacenamiento privado.
* Acceso restringido.
* Eliminación después del período definido.
* Asociación con release.
* Exclusión de secretos.
* Revisión del contenido generado.

## Regla

No afirmar que Jaeger desminifica automáticamente errores si la infraestructura no lo hace.

Documentar cómo el equipo relacionará:

```text
release + build ID + stack
```

con los source maps privados.

---

# FASE 29 — LOGGING DEL CLIENTE

## Objetivo

Correlacionar eventos técnicos sin convertir Jaeger en un almacén de logs.

## Si existe logger del navegador

Agregar opcionalmente:

```text
trace_id
span_id
app.release
app.route.template
```

## Reglas

* No interceptar todos los `console.log`.
* No enviar automáticamente la consola.
* No enviar logs de librerías de terceros.
* No enviar objetos completos.
* No enviar estado global.
* No enviar respuestas del backend.
* No enviar tokens.
* No duplicar errores ya registrados como spans.
* Usar niveles.
* Aplicar sampling.
* Desactivar logs detallados en producción.

## Header de soporte

Cuando el backend devuelva:

```text
x-trace-id
```

puede utilizarse para mostrar un código de soporte en una pantalla de error.

Ejemplo:

```text
Código de seguimiento: 8f3a...
```

No mostrar detalles internos de la traza.

---

# FASE 30 — CONTENT SECURITY POLICY

## Objetivo

Permitir exportación sin debilitar la seguridad.

## Revisar

La directiva:

```text
connect-src
```

Debe permitir exclusivamente:

* Dominio de API.
* Endpoint de telemetría.
* WebSockets autorizados.
* Servicios externos existentes.

## Ejemplo conceptual

```text
connect-src 'self' https://api.example.com
```

Si se usa endpoint del mismo origen, preferir `'self'`.

## Prohibido

* Agregar `*`.
* Agregar dominios innecesarios.
* Agregar `unsafe-eval` para resolver OTel.
* Desactivar CSP.
* Exponer Jaeger.
* Exponer el Collector interno.
* Relajar todas las políticas.

## Pruebas

* Build de producción.
* Navegación.
* Exportación.
* Solicitudes API.
* Revisión de errores CSP.
* Verificación en navegadores soportados.

---

# FASE 31 — GATEWAY DE TELEMETRÍA

## Objetivo

Proteger la entrada pública utilizada por navegadores.

## Opciones

### Opción A: mismo origen

```text
/otel/v1/traces
```

El reverse proxy redirige al Collector.

### Opción B: subdominio controlado

```text
https://telemetry.example.com/v1/traces
```

Requiere CORS estricto.

### Opción C: BFF Next.js

Next.js recibe y reenvía los lotes al Collector.

Debe evaluarse el impacto y evitar convertir el BFF en cuello de botella.

## Controles mínimos

* TLS.
* Rate limiting.
* Límite de tamaño.
* Métodos permitidos.
* Content-Type permitido.
* Orígenes permitidos.
* Protección contra abuso.
* Timeout.
* No almacenar bodies en logs.
* No imprimir payload OTLP.
* Rechazar métodos innecesarios.
* Monitorear volumen.
* Separar tráfico de negocio y telemetría.

## Regla

No introducir un secreto en el frontend como mecanismo de autenticación.

Cualquier valor incluido en JavaScript debe considerarse público.

---

# FASE 32 — CONFIGURACIÓN DEL COLLECTOR

## Objetivo

Procesar trazas del navegador antes de enviarlas a Jaeger.

## Archivo sugerido

```text
infra/otel-collector/otel-collector.frontend.yml
```

## Evaluar procesadores

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
* Agrupar lotes.
* Eliminar atributos prohibidos.
* Filtrar ruido.
* Normalizar recursos.
* Aplicar sampling.
* Reintentar exportación.
* Exportar a Jaeger.
* Exponer métricas internas.
* Manejar backpressure.

## Sanitización

Eliminar o transformar:

* URL query.
* Headers.
* Cookies.
* Tokens.
* Datos personales.
* Nombres de archivos.
* Parámetros dinámicos.
* Mensajes sensibles.
* Atributos no autorizados.

## Regla

La aplicación no debe depender de que el Collector esté disponible para funcionar.

---

# FASE 33 — MUESTREO

## Objetivo

Controlar coste, red y volumen.

## Valores iniciales orientativos

```text
development: 1.00
test:        0.00 o exportador en memoria
staging:     0.25 a 1.00
production:  0.01 a 0.10
```

No aplicar valores sin medir tráfico real.

## Estrategias

* Parent-based.
* Trace ID ratio.
* Sampling de sesión.
* Sampling en Collector.
* Tail sampling.
* Conservación prioritaria de errores.
* Conservación prioritaria de latencia elevada.

## Sampling de sesión

Cuando se use:

* Tomar una decisión estable durante la sesión.
* Evitar que cada span decida independientemente.
* No usar identificadores personales.
* Rotar la sesión.
* Documentar el comportamiento.

## Priorizar

* Errores.
* Navegaciones lentas.
* Operaciones críticas.
* Fallos de autenticación técnicos.
* Uploads fallidos.
* Errores de chunks.
* Errores de hidratación.
* Operaciones con backend 5xx.

## Regla

No enviar el 100% de trazas en producción sin justificar volumen, coste y privacidad.

---

# FASE 34 — PRIVACIDAD Y DATOS SENSIBLES

## Objetivo

Evitar que Jaeger almacene información privada.

## Prohibido registrar

* Contraseñas.
* PIN.
* Códigos 2FA.
* Tokens.
* Cookies.
* Headers de autorización.
* Formularios completos.
* Campos individuales.
* Correos.
* Teléfonos.
* Nombres.
* Direcciones.
* Documentos.
* Datos bancarios.
* Tarjetas.
* Diagnósticos.
* Historias clínicas.
* Recetas.
* Resultados médicos.
* Mensajes privados.
* Contenido editorial no público.
* Archivos.
* Imágenes.
* Texto copiado.
* Texto pegado.
* Pulsaciones de teclado.
* HTML.
* Estado Redux/Zustand.
* Props.
* Query strings.
* URL firmadas.
* Stack traces sin sanitizar.
* Respuestas completas.

## Crear

```text
docs/observability/frontend/05-data-privacy-policy.md
```

Debe incluir:

* Datos permitidos.
* Datos prohibidos.
* Sanitización.
* Retención.
* Sampling.
* Accesos.
* Auditoría.
* Consentimiento.
* Identificación de sesiones.
* Procedimiento de eliminación.
* Procedimiento ante incidente.
* Responsables.

---

# FASE 35 — CONSENTIMIENTO Y ACTIVACIÓN

## Objetivo

Integrar la telemetría con las políticas de privacidad existentes.

## Evaluar

* Países donde opera el sistema.
* Política de privacidad.
* Consentimiento existente.
* Categoría de la telemetría.
* Necesidad funcional.
* Configuración del usuario.
* Usuarios anónimos.
* Menores de edad.
* Datos médicos.
* Datos financieros.

## Comportamiento posible

```text
OTEL_ENABLED=false
```

hasta obtener el estado de consentimiento, cuando legalmente corresponda.

## Reglas

* No crear un banner nuevo sin entender la política existente.
* No asumir consentimiento.
* No almacenar identificadores antes de decidir.
* No usar telemetría para publicidad.
* No compartir trazas con anunciantes.
* No utilizar fingerprinting.
* Documentar la decisión.

---

# FASE 36 — PRUEBAS UNITARIAS

## Objetivo

Validar la lógica propia de observabilidad.

## Probar `TracingService`

* Crea span.
* Ejecuta operación.
* Finaliza span.
* Retorna resultado.
* Registra excepción.
* Relanza excepción.
* Marca error.
* Soporta promesas.
* Soporta funciones síncronas.
* Funciona como no-op.
* No altera resultados.

## Probar configuración

* Telemetría habilitada.
* Telemetría deshabilitada.
* Ratio válido.
* Ratio inválido.
* Endpoint válido.
* Endpoint inválido.
* Configuración faltante.
* Entorno desarrollo.
* Entorno producción.

## Probar sanitización

* Token.
* Authorization.
* Query string.
* Correo.
* URL firmada.
* Nombre de archivo.
* Mensaje de error.
* Datos médicos.
* Datos bancarios.

## Probar rutas

* Ruta estática.
* Ruta dinámica.
* Query string.
* Hash.
* Parámetros sensibles.
* Ruta desconocida.

## Herramientas

Usar:

* Exportador en memoria.
* Span processor de prueba.
* Mocks mínimos.
* Vitest o Jest según el repositorio.
* React Testing Library cuando corresponda.

No depender de Jaeger real para las pruebas unitarias.

---

# FASE 37 — PRUEBAS DE INTEGRACIÓN

## Objetivo

Validar el SDK dentro de la aplicación real.

## Casos

1. Inicialización del navegador.
2. Telemetría deshabilitada.
3. Collector no disponible.
4. Carga inicial.
5. Navegación SPA.
6. Fetch exitoso.
7. Fetch 4xx.
8. Fetch 5xx.
9. Timeout.
10. Cancelación.
11. Formulario exitoso.
12. Formulario con validación.
13. Error Boundary.
14. Promise rechazada.
15. Chunk no disponible.
16. Login.
17. Refresh de sesión.
18. Upload.
19. Download.
20. CORS.
21. CSP.
22. Sampling.

## Validar

* No duplicación.
* Spans finalizados.
* Nombres normalizados.
* Ausencia de secretos.
* Propagación.
* Aplicación funcional.
* Sin errores de hidratación.
* Sin errores del router.
* Bundle correcto.

---

# FASE 38 — PRUEBAS E2E CON PLAYWRIGHT O CYPRESS

## Objetivo

Validar trazas desde una sesión real del navegador.

## Flujo mínimo

1. Levantar frontend.
2. Levantar backend.
3. Levantar Collector.
4. Levantar Jaeger.
5. Abrir aplicación.
6. Ejecutar una navegación.
7. Ejecutar una operación real.
8. Obtener el identificador de traza.
9. Consultar Jaeger.
10. Verificar jerarquía.
11. Verificar propagación.
12. Verificar ausencia de datos sensibles.

## Casos E2E

* Login exitoso.
* Login fallido.
* Navegación protegida.
* Formulario.
* Operación con base de datos.
* Error del backend.
* Error del frontend.
* Upload.
* Download.
* Sesión expirada.
* Reintento.
* Navegación lenta.
* Collector caído.

## Verificación distribuida

Comprobar:

```text
Frontend interaction
   └── Browser fetch
          └── Backend request
                ├── Service
                ├── Database
                └── Worker
```

Todos deben compartir el mismo `trace_id`.

---

# FASE 39 — SCRIPT DE VERIFICACIÓN

## Objetivo

Automatizar una comprobación básica.

## Crear

```text
scripts/verify-frontend-tracing.mjs
```

Debe:

* Verificar disponibilidad del frontend.
* Verificar disponibilidad del backend.
* Verificar disponibilidad de Jaeger.
* Ejecutar un flujo de prueba.
* Consultar la API de Jaeger cuando corresponda.
* Confirmar que `service.name` aparece.
* Confirmar existencia de spans del navegador.
* Confirmar existencia de spans del backend.
* Confirmar correlación.
* Reportar errores claramente.
* No usar credenciales reales.
* No depender de datos de producción.

---

# FASE 40 — PRUEBAS DE RENDIMIENTO

## Objetivo

Medir la sobrecarga real.

## Comparar

* Telemetría deshabilitada.
* Telemetría habilitada sin exportación.
* Sampling 100%.
* Sampling de producción.
* Collector disponible.
* Collector caído.
* Red rápida.
* Red lenta.
* Dispositivo de bajos recursos.
* Navegación móvil.

## Medir

* Tamaño inicial del bundle.
* Tamaño gzip.
* Tamaño Brotli.
* Tiempo de inicialización.
* Main thread blocking.
* LCP.
* INP.
* CLS.
* TTFB.
* Memoria.
* CPU.
* Solicitudes adicionales.
* Bytes de telemetría.
* Número de spans.
* Tiempo de navegación.
* Tiempo de interacción.
* Batería y red cualitativamente en móvil.

## Criterio

No afirmar que el impacto es aceptable sin mediciones.

## Entregable

Crear:

```text
docs/observability/frontend/06-performance-results.md
```

Debe incluir datos antes y después.

---

# FASE 41 — OPTIMIZACIÓN DEL BUNDLE

## Objetivo

Evitar que observabilidad degrade la aplicación.

## Revisar

* Tree shaking.
* Imports específicos.
* Instrumentaciones no usadas.
* Código Node dentro del cliente.
* Source maps.
* Chunks.
* Lazy loading del SDK.
* Bootstrap temprano.
* Duplicación de paquetes.
* Versiones múltiples de `@opentelemetry/api`.

## Regla

Existe un equilibrio entre:

* Instrumentar temprano.
* No incrementar excesivamente el bundle inicial.

Documentar la decisión.

## Posibles estrategias

* Bundle dedicado.
* Carga temprana solo del núcleo.
* Instrumentaciones opcionales diferidas.
* Sampling previo.
* Desactivación por entorno.
* Exclusión en builds determinados.

No aplicar lazy loading si impide capturar la carga inicial sin documentarlo.

---

# FASE 42 — DESPLIEGUE LOCAL

## Objetivo

Proporcionar un entorno reproducible.

## Infraestructura

Integrar con:

```text
docker-compose.observability.yml
```

Debe incluir, según corresponda:

* Jaeger.
* OpenTelemetry Collector.
* Frontend.
* Backend.
* Proxy de telemetría.

## Puertos internos

* Jaeger UI.
* OTLP HTTP.
* OTLP gRPC.
* Frontend.
* Backend.

## Seguridad local

Cuando sea posible, publicar Jaeger solo en:

```text
127.0.0.1
```

## Scripts sugeridos

```json
{
  "observability:up": "docker compose -f docker-compose.observability.yml up -d",
  "observability:down": "docker compose -f docker-compose.observability.yml down",
  "observability:logs": "docker compose -f docker-compose.observability.yml logs -f",
  "observability:verify": "node scripts/verify-frontend-tracing.mjs"
}
```

No romper scripts existentes.

---

# FASE 43 — DESPLIEGUE EN VERCEL

## Objetivo

Adaptar la solución cuando el frontend se despliega en Vercel.

## Revisar

* Client Components.
* Server Components.
* Functions.
* Edge Functions.
* Serverless Functions.
* `instrumentation.ts`.
* `instrumentation-client.ts`.
* Variables públicas.
* Variables privadas.
* Rewrites.
* Proxy `/otel`.
* Timeouts.
* Límites de payload.
* Regiones.
* Source maps.
* Build ID.

## Reglas

* No asumir proceso persistente.
* No asumir que el servidor puede mantener buffers indefinidamente.
* Ejecutar flush razonable.
* No bloquear respuestas.
* No mezclar runtime Node y Edge.
* Probar despliegue Preview.
* Probar producción.

---

# FASE 44 — DESPLIEGUE EN CLOUDFLARE PAGES O EDGE

## Objetivo

Adaptar la solución a runtimes no Node.js.

## Revisar

* Compatibilidad de paquetes.
* APIs disponibles.
* Worker runtime.
* Fetch.
* Restricciones de Node.
* Límites de CPU.
* Tamaño de bundle.
* Endpoint de Collector.
* Proxy same-origin.
* CORS.
* CSP.

## Regla

No importar SDK de Node.js en runtime Edge.

Cuando una capacidad no sea compatible:

* Documentar la limitación.
* Mantener instrumentación del navegador.
* Propagar contexto.
* Instrumentar manualmente operaciones críticas.
* No crear polyfills pesados sin justificación.

---

# FASE 45 — PRODUCCIÓN Y SEGURIDAD OPERATIVA

## Objetivo

Preparar una topología segura.

## Arquitectura

```text
Browser
   │ HTTPS
   ▼
CDN / WAF / Reverse Proxy
   │
   ├── Frontend
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
* WAF o rate limiting.
* CORS estricto.
* CSP.
* Collector no público directamente.
* Jaeger privado.
* Autenticación para Jaeger.
* Retención definida.
* Roles de acceso.
* Sanitización.
* Alertas de volumen.
* Control de costes.
* Monitoreo del Collector.
* Monitoreo de spans descartados.
* Políticas de eliminación.

## Entregable

Crear:

```text
docs/observability/frontend/07-production-topology.md
```

---

# FASE 46 — DOCUMENTACIÓN PARA DESARROLLADORES

## Crear

```text
docs/observability/frontend/README.md
```

Debe explicar:

* Qué es una traza.
* Qué es un span.
* Qué es `trace_id`.
* Qué es `span_id`.
* Cómo se inicia OpenTelemetry.
* Cómo se exporta.
* Cómo buscar una traza.
* Cómo instrumentar una operación.
* Cómo instrumentar un formulario.
* Cómo instrumentar una navegación.
* Cómo instrumentar un upload.
* Cómo registrar un error.
* Cómo propagar al backend.
* Qué datos no deben registrarse.
* Cómo agregar un nuevo dominio autorizado.
* Cómo cambiar sampling.
* Cómo desactivar telemetría.
* Cómo validar CORS.
* Cómo validar CSP.
* Cómo ejecutar pruebas.
* Cómo levantar Jaeger.
* Cómo diagnosticar problemas.

Debe utilizar ejemplos reales del repositorio.

---

# FASE 47 — RUNBOOK OPERATIVO

## Crear

```text
docs/observability/frontend/08-operational-runbook.md
```

## Incluir

### No llegan trazas

* Revisar `OTEL_ENABLED`.
* Revisar endpoint.
* Revisar CSP.
* Revisar CORS.
* Revisar proxy.
* Revisar Collector.
* Revisar sampling.
* Revisar Network del navegador.
* Revisar errores del exportador.
* Revisar Content-Type.

### No se conecta con el backend

* Revisar `traceparent`.
* Revisar dominios permitidos.
* Revisar preflight.
* Revisar headers del backend.
* Revisar propagador.
* Revisar instrumentación de Axios/fetch.
* Revisar duplicaciones.

### Existen spans duplicados

* Revisar Axios.
* Revisar fetch.
* Revisar XHR.
* Revisar React Query.
* Revisar instrumentación manual.
* Revisar bootstrap duplicado.
* Revisar HMR.

### El bundle aumentó demasiado

* Revisar instrumentaciones.
* Revisar imports.
* Revisar versiones duplicadas.
* Revisar context manager.
* Revisar lazy loading.
* Revisar source maps.

### La interfaz se volvió lenta

* Reducir sampling.
* Revisar spans excesivos.
* Revisar listeners.
* Revisar user interaction.
* Revisar batches.
* Revisar red.
* Revisar serialización.
* Revisar errores de exportación.

### Se capturaron datos sensibles

* Detener exportación afectada.
* Deshabilitar instrumentación.
* Aplicar filtro en Collector.
* Reducir retención.
* Limitar acceso.
* Evaluar eliminación.
* Registrar incidente.
* Corregir sanitización.
* Agregar prueba de regresión.

---

# FASE 48 — REVISIÓN FINAL DE CLEAN CODE

## Revisar

* Archivos menores de 300 líneas.
* Funciones pequeñas.
* Responsabilidad única.
* Tipado estricto.
* Sin `any` injustificado.
* Sin imports de Node en cliente.
* Sin dependencias circulares.
* Sin inicialización duplicada.
* Sin side effects inesperados.
* Sin `console.log`.
* Sin secretos.
* Sin datos sensibles.
* Sin URLs privadas hardcodeadas.
* Sin nombres dinámicos.
* Sin spans abiertos.
* Sin listeners sin limpieza.
* Sin errores de hidratación.
* Sin cambios visuales.
* Sin cambios funcionales no relacionados.
* Sin TODO críticos.
* Sin código muerto.
* Sin pruebas omitidas.
* Sin documentación genérica.

## Ejecutar

```bash
yarn lint
yarn typecheck
yarn test
yarn test:coverage
yarn test:e2e
yarn build
```

Cuando corresponda:

```bash
yarn observability:up
yarn observability:verify
```

---

# 6. CRITERIOS DE ACEPTACIÓN

La implementación solamente se considera completa cuando:

* [ ] El frontend compila.
* [ ] El frontend funciona con OTel habilitado.
* [ ] El frontend funciona con OTel deshabilitado.
* [ ] El frontend funciona con Collector caído.
* [ ] No existen errores de hidratación.
* [ ] No se inicializa OTel dos veces.
* [ ] La carga inicial genera trazas.
* [ ] La navegación SPA genera trazas.
* [ ] Las llamadas al backend generan spans.
* [ ] El contexto se propaga al backend.
* [ ] Frontend y backend comparten `trace_id`.
* [ ] Las rutas están normalizadas.
* [ ] Los formularios críticos poseen spans.
* [ ] Los uploads críticos poseen spans.
* [ ] Los errores globales se registran.
* [ ] React Error Boundary está integrado.
* [ ] Los errores no se duplican.
* [ ] La autenticación no expone credenciales.
* [ ] No se registran tokens.
* [ ] No se registran contraseñas.
* [ ] No se registran cookies.
* [ ] No se registran formularios.
* [ ] No se registran bodies.
* [ ] No se registran query strings sensibles.
* [ ] No se registran nombres de archivos.
* [ ] No se registran datos médicos.
* [ ] No se registran datos financieros.
* [ ] CSP permanece segura.
* [ ] CORS permanece restringido.
* [ ] La propagación solo ocurre hacia dominios autorizados.
* [ ] El endpoint de telemetría tiene protección.
* [ ] Jaeger no está expuesto públicamente.
* [ ] El sampling es configurable.
* [ ] La versión del frontend es visible.
* [ ] El build ID es visible.
* [ ] El impacto del bundle fue medido.
* [ ] El impacto de rendimiento fue medido.
* [ ] Las pruebas unitarias pasan.
* [ ] Las pruebas de integración pasan.
* [ ] Las pruebas E2E pasan.
* [ ] El build de producción pasa.
* [ ] La documentación está completa.
* [ ] Existe runbook.
* [ ] No quedan pendientes críticos.

---

# 7. ENTREGABLES OBLIGATORIOS

Adaptar a la estructura real, pero entregar como mínimo:

```text
src/observability/
├── browser/
│   ├── telemetry.browser.ts
│   ├── browser-provider.ts
│   ├── browser-exporter.ts
│   ├── browser-instrumentations.ts
│   ├── browser-resource.ts
│   ├── browser-sampling.ts
│   └── browser-lifecycle.ts
├── config/
│   ├── telemetry.config.ts
│   ├── telemetry.schema.ts
│   └── telemetry.types.ts
├── core/
│   ├── tracing.service.ts
│   ├── tracing.constants.ts
│   ├── tracing.attributes.ts
│   └── tracing.types.ts
├── react/
│   ├── TelemetryErrorBoundary.tsx
│   └── react-error-reporter.ts
├── routing/
│   └── route-tracing.ts
└── security/
    ├── telemetry-sanitizer.ts
    └── telemetry-allowlist.ts
```

Para Next.js, cuando corresponda:

```text
instrumentation.ts
instrumentation-client.ts
```

Infraestructura:

```text
docker-compose.observability.yml
infra/otel-collector/otel-collector.frontend.yml
scripts/verify-frontend-tracing.mjs
.env.example
```

Documentación:

```text
docs/observability/frontend/
├── 00-current-state-audit.md
├── 01-architecture-design.md
├── 02-naming-conventions.md
├── 03-business-spans-catalog.md
├── 04-web-vitals-strategy.md
├── 05-data-privacy-policy.md
├── 06-performance-results.md
├── 07-production-topology.md
├── 08-operational-runbook.md
└── README.md
```

Pruebas:

```text
src/observability/**/*.spec.ts
src/observability/**/*.test.ts
tests/e2e/observability.spec.ts
```

Actualizar únicamente cuando corresponda:

```text
package.json
yarn.lock
vite.config.ts
next.config.ts
src/main.tsx
src/app/layout.tsx
Dockerfile
README.md
```

---

# 8. FORMATO DEL INFORME FINAL

Entregar un informe con:

## 1. Resumen ejecutivo

Qué se implementó y qué problema resuelve.

## 2. Arquitectura encontrada

Framework, rendering, routing, red y despliegue.

## 3. Arquitectura implementada

Incluir diagrama Mermaid.

## 4. Archivos creados

Explicar responsabilidad.

## 5. Archivos modificados

Explicar cada cambio.

## 6. Dependencias agregadas

Explicar motivo e impacto.

## 7. Instrumentaciones automáticas

* Document load.
* Fetch.
* XHR.
* User interaction.
* Routing.
* Otras.

## 8. Spans de negocio

Lista completa.

## 9. Propagación al backend

Explicar `traceparent`, CORS y dominios permitidos.

## 10. Errores

Explicar listeners, Error Boundary y sanitización.

## 11. Privacidad

Datos permitidos y prohibidos.

## 12. Sampling

Configuración por entorno.

## 13. Bundle

Comparación antes y después.

## 14. Rendimiento

Resultados reales.

## 15. Pruebas

Comandos y resultados reales.

No inventar resultados.

## 16. Uso local

Comandos completos.

## 17. Producción

Topología y controles.

## 18. Riesgos restantes

Lista concreta.

## 19. Matriz de cumplimiento

| Requisito           |   Estado | Evidencia            |
| ------------------- | -------: | -------------------- |
| Carga inicial       | Cumplido | Archivo/prueba       |
| Navegación SPA      | Cumplido | Archivo/prueba       |
| Fetch               | Cumplido | Archivo/prueba       |
| Propagación backend | Cumplido | Traza/prueba         |
| Error Boundary      | Cumplido | Archivo/prueba       |
| Privacidad          | Cumplido | Política/prueba      |
| CORS                | Cumplido | Configuración/prueba |
| CSP                 | Cumplido | Configuración/prueba |
| Sampling            | Cumplido | Configuración        |
| Rendimiento         | Cumplido | Resultados           |

## 20. Estado final

Usar una sola clasificación:

```text
COMPLETO
COMPLETO CON OBSERVACIONES
INCOMPLETO
BLOQUEADO
```

No declarar `COMPLETO` cuando:

* Existan pruebas fallidas.
* No se haya validado propagación.
* Existan datos sensibles.
* El Collector esté expuesto inseguramente.
* No se haya medido el bundle.
* No se haya probado producción.
* Existan tareas críticas pendientes.

---

# 9. PROHIBICIONES

No debes:

* Instalar paquetes y declarar el trabajo terminado.
* Enviar trazas directamente a la UI de Jaeger.
* Utilizar SDK antiguo de Jaeger.
* Incluir secretos en variables públicas.
* Exponer el Collector interno.
* Exponer Jaeger públicamente.
* Desactivar CSP.
* Configurar CORS con `*`.
* Capturar formularios.
* Capturar tokens.
* Capturar cookies.
* Capturar passwords.
* Capturar DOM completo.
* Capturar HTML.
* Capturar pulsaciones.
* Capturar props.
* Capturar estado global.
* Capturar Redux DevTools.
* Capturar responses completas.
* Capturar bodies.
* Capturar archivos.
* Capturar nombres de archivos.
* Capturar URLs firmadas.
* Capturar query strings.
* Propagar trazas a terceros.
* Crear spans por cada render.
* Crear spans por cada clic.
* Crear spans por cada acción Redux.
* Crear spans por cada hook.
* Crear spans con IDs dinámicos.
* Dejar spans abiertos.
* Bloquear la interfaz.
* Romper SSR.
* Romper hidratación.
* Importar SDK Node en navegador.
* Duplicar fetch y XHR.
* Convertir Jaeger en analítica de usuarios.
* Implementar session replay.
* Hacer fingerprinting.
* Alterar el diseño.
* Alterar flujos funcionales.
* Cambiar Yarn.
* Inventar pruebas.
* Inventar resultados.
* Dejar código temporal.
* Dejar TODO críticos.
* Modificar módulos no relacionados.

---

# 10. ORDEN OBLIGATORIO

Ejecutar en este orden:

```text
Fase 0  → Auditoría
Fase 1  → Arquitectura
Fase 2  → Convenciones
Fase 3  → Dependencias
Fase 4  → Configuración
Fase 5  → Bootstrap
Fase 6  → Resource
Fase 7  → Exportación OTLP
Fase 8  → Document load
Fase 9  → Navegación
Fase 10 → Fetch/XHR
Fase 11 → Propagación
Fase 12 → CORS
Fase 13 → Interacciones
Fase 14 → Servicio de tracing
Fase 15 → Spans de negocio
Fase 16 → Formularios
Fase 17 → Archivos
Fase 18 → Errores globales
Fase 19 → Error Boundary
Fase 20 → Autenticación
Fase 21 → Sesiones
Fase 22 → Web Vitals
Fase 23 → React Query
Fase 24 → Estado global
Fase 25 → Tiempo real
Fase 26 → Service Workers
Fase 27 → Next.js servidor
Fase 28 → Source maps
Fase 29 → Logs
Fase 30 → CSP
Fase 31 → Gateway
Fase 32 → Collector
Fase 33 → Sampling
Fase 34 → Privacidad
Fase 35 → Consentimiento
Fase 36 → Pruebas unitarias
Fase 37 → Integración
Fase 38 → E2E
Fase 39 → Verificación
Fase 40 → Rendimiento
Fase 41 → Bundle
Fase 42 → Desarrollo local
Fase 43 → Vercel
Fase 44 → Cloudflare/Edge
Fase 45 → Producción
Fase 46 → Documentación
Fase 47 → Runbook
Fase 48 → Revisión final
```

Después de cada fase:

```text
1. Compilar.
2. Ejecutar pruebas relacionadas.
3. Corregir errores.
4. Revisar privacidad.
5. Documentar.
6. Continuar.
```

---

# 11. INSTRUCCIÓN FINAL

Comienza inspeccionando el repositorio completo.

No escribas código antes de completar la auditoría.

No preguntes por información que pueda obtenerse revisando el proyecto.

Cuando existan varias alternativas:

1. Identifica las opciones.
2. Evalúa compatibilidad.
3. Evalúa rendimiento.
4. Evalúa seguridad.
5. Evalúa privacidad.
6. Selecciona la mejor opción.
7. Implementa.
8. Documenta la decisión.

Prioriza siempre:

```text
Seguridad
Privacidad
Estabilidad
Propagación correcta
Rendimiento
Mantenibilidad
Cobertura de pruebas
```

No priorices la cantidad de spans.

Prioriza que las trazas sean comprensibles y permitan reconstruir el flujo real:

```text
usuario
→ interfaz
→ solicitud
→ backend
→ base de datos
→ worker
→ resultado
```

El resultado final debe ser una implementación funcional, segura, medible, mantenible, documentada y preparada para evolucionar desde desarrollo local hasta producción.
