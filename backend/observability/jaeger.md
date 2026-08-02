## Rol

Actúa como un **Arquitecto de Software Senior especializado en observabilidad, sistemas distribuidos, NestJS, OpenTelemetry y Jaeger**.

Debes inspeccionar, diseñar e implementar una solución completa de trazabilidad distribuida en el backend existente.

No debes limitarte a instalar dependencias o agregar un archivo de configuración. La implementación debe cubrir todo el flujo del sistema:

* Solicitudes HTTP entrantes.
* Solicitudes HTTP salientes.
* Controllers.
* Services.
* Repositories.
* Base de datos.
* Redis.
* Colas y workers.
* Eventos internos.
* Procesos programados.
* Errores.
* Logs.
* Propagación del contexto entre procesos.
* Despliegue local.
* Despliegue en producción.
* Pruebas.
* Documentación operativa.

La solución debe utilizar:

```text
Aplicación NestJS
        │
        ▼
OpenTelemetry SDK
        │
        ▼
OTLP
        │
        ▼
Jaeger
```

No debes acoplar la aplicación directamente a APIs propietarias o antiguas de Jaeger.

La instrumentación se implementará con **OpenTelemetry**, utilizando Jaeger como plataforma de almacenamiento y visualización de trazas.

---

# 1. CONTEXTO TÉCNICO ESPERADO

El backend puede incluir:

* NestJS.
* TypeScript.
* Node.js `>=20 <24`.
* Yarn.
* PostgreSQL.
* Sequelize.
* Redis.
* Pino.
* Axios o `HttpModule`.
* Bull, BullMQ u otro sistema de colas.
* Workers independientes.
* Cron jobs.
* WebSockets.
* Arquitectura modular.
* Docker.
* Docker Compose.
* Variables de entorno.
* Pruebas con Jest.
* Pruebas de integración con Supertest.

Debes detectar la arquitectura real antes de modificar el código.

No asumas que todas estas tecnologías están presentes. Instrumenta solamente las que realmente existan en el repositorio, pero deja una estructura extensible para las demás.

---

# 2. REGLAS GENERALES DE IMPLEMENTACIÓN

Debes cumplir estrictamente las siguientes reglas:

1. Utilizar OpenTelemetry como estándar principal.
2. Exportar trazas mediante OTLP.
3. No utilizar librerías Jaeger antiguas o descontinuadas.
4. No modificar la lógica funcional del negocio.
5. No romper los contratos existentes.
6. No cambiar respuestas HTTP salvo que sea necesario agregar un header de trazabilidad.
7. No registrar contraseñas, tokens, cookies ni información sensible.
8. No registrar cuerpos completos de solicitudes o respuestas.
9. No registrar documentos de identidad, datos médicos, información bancaria o secretos.
10. No usar `console.log` para observabilidad.
11. Mantener Pino como sistema principal de logs si ya está instalado.
12. No duplicar logs innecesariamente.
13. No generar spans redundantes que no aporten información.
14. Evitar atributos de cardinalidad excesiva.
15. No utilizar nombres de spans construidos con IDs dinámicos.
16. Mantener cada archivo por debajo de 300 líneas, salvo justificación técnica documentada.
17. Mantener funciones pequeñas y de responsabilidad única.
18. Evitar dependencias circulares.
19. Usar inyección de dependencias de NestJS.
20. Mantener la implementación desacoplada de Jaeger.
21. Permitir desactivar la telemetría mediante configuración.
22. Garantizar un cierre limpio del SDK.
23. Realizar pruebas antes de considerar una fase terminada.
24. No dejar código temporal.
25. No dejar tareas marcadas como pendientes sin justificación.
26. No ocultar errores de instrumentación.
27. No alterar el comportamiento de producción sin documentarlo.
28. Mantener compatibilidad con Yarn.
29. No reemplazar Yarn por npm.
30. No modificar el lockfile de manera innecesaria.

---

# 3. OBJETIVO GENERAL

Implementar una solución completa que permita responder preguntas como:

* ¿Qué endpoint recibió la solicitud?
* ¿Cuánto tardó la solicitud completa?
* ¿Qué controller la procesó?
* ¿Qué servicios participaron?
* ¿Qué consultas fueron realizadas a PostgreSQL?
* ¿Cuánto tardaron las consultas?
* ¿Qué operaciones se realizaron en Redis?
* ¿Qué APIs externas fueron llamadas?
* ¿Qué worker procesó un mensaje?
* ¿El contexto de la traza se conservó entre API y worker?
* ¿Dónde ocurrió un error?
* ¿Qué operación de negocio estaba ejecutándose?
* ¿Qué logs pertenecen a la misma solicitud?
* ¿Cuál es el `trace_id` que puede entregarse al soporte técnico?
* ¿Qué dependencia generó mayor latencia?
* ¿Cuál fue la ruta crítica de una operación?

---

# 4. METODOLOGÍA DE TRABAJO

La implementación debe realizarse por fases.

No avances a una fase posterior sin:

1. Completar la fase actual.
2. Ejecutar las pruebas correspondientes.
3. Corregir los errores encontrados.
4. Documentar las decisiones tomadas.
5. Verificar que el backend siga arrancando.
6. Verificar que no se haya roto ninguna funcionalidad existente.

Para cada fase debes presentar:

```text
Estado:
Archivos revisados:
Archivos creados:
Archivos modificados:
Decisiones:
Riesgos:
Pruebas ejecutadas:
Resultado:
Pendientes justificados:
```

---

# FASE 0 — AUDITORÍA INICIAL DEL BACKEND

## Objetivo

Comprender la arquitectura real antes de introducir observabilidad.

## Actividades

Inspecciona:

* `package.json`.
* `yarn.lock`.
* `tsconfig.json`.
* `nest-cli.json`.
* `src/main.ts`.
* `src/app.module.ts`.
* Configuración de entornos.
* Configuración Pino.
* Configuración de Sequelize.
* Configuración de PostgreSQL.
* Configuración Redis.
* Clientes HTTP.
* Colas.
* Workers.
* Cron jobs.
* Microservicios NestJS.
* WebSockets.
* Dockerfiles.
* Docker Compose.
* Configuración de CI/CD.
* Pruebas unitarias.
* Pruebas de integración.
* Health checks.
* Manejo global de errores.
* Interceptors.
* Guards.
* Filters.
* Middleware.
* Repositories.
* Módulos de infraestructura.

## Debes identificar

1. Punto exacto de arranque del proceso.
2. Cantidad de procesos ejecutables.
3. Si API y workers arrancan por separado.
4. Adaptador HTTP utilizado:

   * Express.
   * Fastify.
5. ORM utilizado.
6. Driver real de PostgreSQL.
7. Cliente Redis.
8. Librería HTTP saliente.
9. Sistema de logs.
10. Sistema de colas.
11. Estrategia actual de configuración.
12. Existencia de correlación de requests.
13. Existencia de request ID.
14. Existencia de propagación de contexto.
15. Posibles datos sensibles.
16. Endpoints que deben excluirse:

* `/health`.
* `/healthz`.
* `/ready`.
* `/metrics`.

17. Arquitectura de despliegue.
18. Riesgos de compatibilidad.

## Entregable

Crear:

```text
docs/observability/00-current-state-audit.md
```

Debe contener:

* Arquitectura detectada.
* Diagrama del flujo actual.
* Puntos de instrumentación.
* Dependencias involucradas.
* Riesgos.
* Plan de implementación adaptado al repositorio.
* Lista de archivos que serán modificados.
* Lista de archivos que no deben modificarse.

## Criterio de aceptación

No comenzar la instalación hasta entender cómo se inicia cada proceso del backend.

---

# FASE 1 — DISEÑO DE LA ARQUITECTURA DE OBSERVABILIDAD

## Objetivo

Definir cómo se integrará OpenTelemetry sin acoplar el dominio a Jaeger.

## Arquitectura esperada en desarrollo

```text
NestJS API ──────────────┐
                        │
Workers ─────────────────┼── OTLP HTTP o gRPC ──► Jaeger
                        │
Cron jobs ───────────────┘
```

## Arquitectura recomendada en producción

```text
NestJS API ──────────────┐
                        │
Workers ─────────────────┼── OTLP ──► OpenTelemetry Collector
                        │                     │
Cron jobs ───────────────┘                     ▼
                                             Jaeger
                                                │
                                                ▼
                                  Almacenamiento persistente
```

## Decisiones que debes documentar

* OTLP HTTP o OTLP gRPC.
* Endpoint de exportación.
* Nombre de cada servicio.
* Namespace de servicios.
* Versión de aplicación.
* Entorno de despliegue.
* Estrategia de muestreo.
* Exclusiones.
* Propagadores.
* Convenciones de nombres.
* Atributos permitidos.
* Atributos prohibidos.
* Políticas de errores.
* Estrategia de cierre.
* Estrategia para workers.
* Estrategia para colas.
* Estrategia para logs.
* Estrategia para datos sensibles.

## Convenciones mínimas

### Nombre del servicio

```text
<producto>-<componente>
```

Ejemplos:

```text
atlas-api
atlas-worker-notifications
atlas-worker-documents
atlas-scheduler
```

### Nombre de spans de negocio

```text
<dominio>.<acción>
```

Ejemplos:

```text
credit.evaluate
customer.register
document.extract
notification.dispatch
outbox.publish
workflow.execute
```

Nunca usar:

```text
credit.evaluate.387471
customer.register.12345
```

### Atributos propios

Usar un namespace consistente:

```text
app.operation
app.module
app.tenant.id
app.entity.type
app.entity.id
app.job.name
app.job.attempt
app.event.type
app.event.id
```

No almacenar datos sensibles en estos atributos.

## Entregable

Crear:

```text
docs/observability/01-architecture-design.md
```

Debe contener diagramas Mermaid y decisiones justificadas.

---

# FASE 2 — INSTALACIÓN Y CONFIGURACIÓN DE DEPENDENCIAS

## Objetivo

Instalar únicamente las dependencias necesarias y compatibles.

## Dependencias esperadas

Evalúa e instala las dependencias vigentes que correspondan a la arquitectura real:

```bash
yarn add @opentelemetry/api
yarn add @opentelemetry/sdk-node
yarn add @opentelemetry/resources
yarn add @opentelemetry/semantic-conventions
yarn add @opentelemetry/auto-instrumentations-node
yarn add @opentelemetry/exporter-trace-otlp-http
```

Cuando la arquitectura use OTLP gRPC, emplear el exportador correspondiente.

Para pruebas puede ser necesario:

```bash
yarn add -D @opentelemetry/sdk-trace-base
```

## Reglas

* Verificar compatibilidad entre versiones.
* No instalar varios exportadores si no son necesarios.
* No instalar el cliente Jaeger antiguo.
* No agregar paquetes sin uso real.
* Mantener el lockfile consistente.
* Ejecutar compilación después de instalar.
* Revisar vulnerabilidades sin realizar actualizaciones masivas no solicitadas.

## Pruebas

Ejecutar:

```bash
yarn install
yarn build
yarn test
```

Adaptar los comandos a los scripts reales del proyecto.

## Entregable

Actualizar:

```text
package.json
yarn.lock
```

Documentar las dependencias agregadas y su propósito.

---

# FASE 3 — BOOTSTRAP TEMPRANO DE OPENTELEMETRY

## Objetivo

Inicializar OpenTelemetry antes de cargar las bibliotecas que serán instrumentadas.

## Requisito crítico

La inicialización debe ocurrir antes de importar:

* NestJS.
* Express.
* Fastify.
* Sequelize.
* PostgreSQL.
* Redis.
* Axios.
* Pino.
* Bull o BullMQ.

Una importación tardía puede impedir que la instrumentación automática funcione.

## Estructura sugerida

```text
src/
└── observability/
    ├── telemetry.bootstrap.ts
    ├── telemetry.config.ts
    ├── telemetry.constants.ts
    ├── telemetry.types.ts
    └── telemetry.shutdown.ts
```

## Ejemplo conceptual de arranque

```ts
import './observability/telemetry.bootstrap';

import { NestFactory } from '@nestjs/core';
```

La importación de telemetría debe ser la primera importación ejecutada.

## Configuración obligatoria

Implementar variables como:

```env
OTEL_ENABLED=true
OTEL_SERVICE_NAME=backend-api
OTEL_SERVICE_NAMESPACE=platform
OTEL_SERVICE_VERSION=1.0.0
OTEL_DEPLOYMENT_ENVIRONMENT=development

OTEL_EXPORTER_OTLP_TRACES_ENDPOINT=http://localhost:4318/v1/traces
OTEL_EXPORT_TIMEOUT_MS=10000

OTEL_TRACES_SAMPLER=parentbased_traceidratio
OTEL_TRACES_SAMPLER_ARG=1.0

OTEL_DIAG_LOG_LEVEL=ERROR
```

## Comportamiento esperado

Cuando:

```env
OTEL_ENABLED=false
```

el backend debe iniciar normalmente sin intentar exportar trazas.

## Requisitos técnicos

* Crear `NodeSDK`.
* Crear `Resource`.
* Configurar identificadores del servicio.
* Configurar exportador OTLP.
* Configurar sampler.
* Configurar instrumentaciones.
* Inicializar el SDK una sola vez.
* Evitar inicialización duplicada en pruebas.
* Manejar errores de arranque.
* Implementar cierre limpio.
* Escuchar `SIGTERM`.
* Escuchar `SIGINT`.
* Ejecutar `sdk.shutdown()`.
* No cerrar el proceso abruptamente desde el módulo de observabilidad.

## Criterios de aceptación

* El backend compila.
* El backend inicia con telemetría habilitada.
* El backend inicia con telemetría deshabilitada.
* No existen dobles inicializaciones.
* El cierre no deja errores abiertos.

---

# FASE 4 — INSTRUMENTACIÓN AUTOMÁTICA

## Objetivo

Capturar automáticamente operaciones técnicas sin ensuciar la lógica del negocio.

## Instrumentaciones a evaluar

Según las tecnologías detectadas:

* HTTP.
* HTTPS.
* Express.
* Fastify.
* NestJS.
* PostgreSQL.
* Sequelize.
* Redis.
* Axios.
* Undici.
* Pino.
* DNS.
* Net.
* BullMQ.
* GraphQL.
* WebSockets.

## Reglas

* Activar solamente las instrumentaciones necesarias.
* Desactivar instrumentaciones excesivamente ruidosas.
* Evaluar desactivar `fs`.
* Excluir health checks.
* Excluir métricas.
* Excluir archivos estáticos.
* Excluir endpoints internos de monitoreo.
* Evitar capturar headers sensibles.
* No capturar bodies.
* No capturar parámetros SQL sensibles.
* Verificar que la instrumentación de Sequelize y PostgreSQL no genere duplicación perjudicial.
* Mantener una jerarquía de spans comprensible.

## Exclusiones mínimas

```text
/health
/healthz
/ready
/readiness
/liveness
/metrics
/favicon.ico
```

Adaptar la lista al proyecto.

## Validaciones

Una solicitud HTTP debe mostrar, cuando corresponda:

```text
HTTP request
  ├── NestJS controller
  ├── Service span manual
  ├── Sequelize operation
  │     └── PostgreSQL query
  ├── Redis operation
  └── External HTTP request
```

## Criterio de aceptación

Las trazas deben ser útiles y legibles. No se acepta generar cientos de spans irrelevantes por una solicitud sencilla.

---

# FASE 5 — MÓDULO DE OBSERVABILIDAD DE NESTJS

## Objetivo

Crear una capa reutilizable para que el resto del backend pueda crear spans sin depender de Jaeger.

## Estructura sugerida

```text
src/observability/
├── observability.module.ts
├── tracing.service.ts
├── tracing.decorator.ts
├── trace-context.service.ts
├── trace-response.interceptor.ts
├── trace-exception.filter.ts
├── messaging-trace.service.ts
├── telemetry.bootstrap.ts
├── telemetry.config.ts
└── index.ts
```

No crear archivos innecesarios. Adapta la estructura al proyecto.

## `TracingService`

Debe proporcionar métodos como:

```ts
runInSpan<T>(
  name: string,
  attributes: Attributes,
  operation: (span: Span) => Promise<T> | T,
): Promise<T>;
```

También puede incluir:

```ts
addEvent(...)
setAttribute(...)
setAttributes(...)
recordException(...)
getActiveTraceId()
getActiveSpanId()
```

## Requisitos

* Utilizar `trace.getTracer()`.
* Utilizar `startActiveSpan()`.
* Finalizar spans en `finally`.
* Marcar errores correctamente.
* Registrar excepciones.
* No ocultar el error original.
* Conservar tipos genéricos.
* Permitir spans internos, productores y consumidores.
* Evitar que los módulos de dominio importen paquetes de Jaeger.
* Preferiblemente evitar que el dominio dependa directamente de OpenTelemetry cuando pueda abstraerse.

## Criterio de aceptación

Los servicios de negocio deben poder instrumentarse mediante una dependencia pequeña y estable.

---

# FASE 6 — CORRELACIÓN ENTRE TRAZAS Y LOGS PINO

## Objetivo

Permitir que cada log pueda relacionarse con su traza correspondiente.

## Campos esperados

Cuando exista un span activo, los logs deben incluir:

```json
{
  "trace_id": "....",
  "span_id": "....",
  "trace_flags": 1
}
```

## Reglas

* Mantener JSON estructurado.
* No reemplazar Pino.
* No duplicar cada log.
* No agregar un middleware incompatible con el logger actual.
* Integrarse con `nestjs-pino` cuando exista.
* Mantener logs legibles en desarrollo.
* Mantener logs estructurados en producción.
* No incluir información sensible.
* No depender del header enviado por el cliente para crear el `trace_id`.
* El `trace_id` debe provenir del contexto activo de OpenTelemetry.

## Respuesta HTTP

Agregar, cuando corresponda:

```http
x-trace-id: <trace-id>
```

Esto permite que soporte técnico relacione un error reportado por el usuario con la traza.

No modificar el contrato JSON de las respuestas solo para incluir el trace ID.

## Validación

Para una misma solicitud:

* El header `x-trace-id` debe coincidir con la traza.
* Los logs deben incluir el mismo `trace_id`.
* Los spans hijos deben compartir el mismo `trace_id`.
* Cada span debe tener su propio `span_id`.

---

# FASE 7 — MANEJO DE EXCEPCIONES

## Objetivo

Registrar correctamente errores sin duplicarlos ni ocultarlos.

## Comportamiento esperado

Ante una excepción:

1. Obtener el span activo.
2. Registrar la excepción.
3. Marcar el span como error.
4. Conservar el mensaje técnico apropiado.
5. Permitir que el filtro de excepciones existente continúe procesando el error.
6. No convertir errores en respuestas exitosas.
7. No alterar códigos HTTP existentes.
8. No registrar información sensible.

## Evitar

* Registrar la misma excepción cinco veces.
* Finalizar manualmente spans automáticos que no fueron creados por la aplicación.
* Reemplazar el stack original.
* Capturar y silenciar errores.
* Exponer stack traces al cliente.

## Validación

Probar:

* Error de validación.
* Recurso no encontrado.
* Error de autenticación.
* Error de base de datos.
* Error de Redis.
* Error de API externa.
* Excepción no controlada.

---

# FASE 8 — SPANS DE NEGOCIO

## Objetivo

Instrumentar operaciones importantes que no puedan entenderse únicamente con spans técnicos.

## Prioridades

Identifica operaciones críticas como:

* Registro de usuario.
* Autenticación.
* Evaluación de crédito.
* Ejecución de workflow.
* Procesamiento de documentos.
* Generación de reportes.
* Publicación de eventos.
* Envío de notificaciones.
* Actualización de estados.
* Procesamiento de pagos.
* Ejecución de reglas.
* Procesamiento de archivos.
* Tareas masivas.
* Operaciones administrativas sensibles.

## Ejemplo esperado

```ts
return this.tracingService.runInSpan(
  'credit.evaluate',
  {
    'app.module': 'credit',
    'app.operation': 'evaluate',
    'app.entity.type': 'credit-application',
    'app.entity.id': applicationId,
  },
  async (span) => {
    span.addEvent('rules.started');

    const result = await this.rulesEngine.evaluate(input);

    span.setAttribute('credit.decision', result.decision);
    span.addEvent('rules.completed');

    return result;
  },
);
```

## Reglas

* Instrumentar operaciones importantes, no cada función.
* Evitar spans de métodos triviales.
* No usar datos sensibles.
* No registrar payloads completos.
* No registrar objetos serializados indiscriminadamente.
* Utilizar eventos para hitos internos.
* Mantener nombres estables.
* Utilizar atributos de baja cardinalidad.
* Documentar cada span manual incorporado.

## Entregable

Crear:

```text
docs/observability/02-business-spans-catalog.md
```

Debe describir:

* Nombre del span.
* Módulo.
* Operación.
* Atributos.
* Eventos.
* Motivo de negocio.
* Riesgos de privacidad.

---

# FASE 9 — POSTGRESQL Y SEQUELIZE

## Objetivo

Visualizar consultas y latencia de acceso a datos.

## Actividades

* Validar instrumentación automática de `pg`.
* Validar instrumentación de Sequelize.
* Revisar duplicación de spans.
* Confirmar relación padre-hijo.
* Confirmar duración.
* Confirmar errores.
* Revisar si se captura SQL.
* Redactar o desactivar captura insegura cuando corresponda.
* Evitar registrar valores de parámetros.
* Identificar queries lentas.

## Atributos permitidos

Según convenciones semánticas vigentes:

```text
db.system
db.namespace
db.operation.name
server.address
server.port
```

No registrar credenciales de conexión.

## Pruebas mínimas

* `SELECT`.
* `INSERT`.
* `UPDATE`.
* Transacción exitosa.
* Rollback.
* Constraint violation.
* Timeout.
* Consulta lenta controlada en entorno de prueba.

## Criterio de aceptación

Las consultas deben aparecer dentro de la traza correspondiente y no como trazas aisladas sin contexto.

---

# FASE 10 — REDIS

## Objetivo

Capturar operaciones Redis relevantes.

## Operaciones a validar

* `GET`.
* `SET`.
* `DEL`.
* Operaciones hash.
* Cache hit.
* Cache miss.
* Locks.
* Pub/Sub, si existe.
* Streams, si existen.
* Errores de conexión.
* Timeouts.

## Reglas

* No registrar valores almacenados.
* Evitar registrar claves que contengan datos sensibles.
* Normalizar claves dinámicas cuando sea necesario.
* Evitar cardinalidad excesiva.

## Spans de negocio sugeridos

```text
cache.lookup
cache.invalidate
distributed-lock.acquire
distributed-lock.release
```

Solo cuando aporten información adicional a la instrumentación automática.

---

# FASE 11 — LLAMADAS HTTP EXTERNAS

## Objetivo

Propagar el contexto hacia otros servicios y visualizar dependencias externas.

## Actividades

* Detectar Axios, `HttpModule`, fetch o Undici.
* Validar propagación W3C.
* Confirmar envío de `traceparent`.
* Confirmar envío de `tracestate` cuando exista.
* Confirmar que no se sobrescriban headers de negocio.
* Registrar latencia.
* Registrar código HTTP.
* Registrar error.
* Evitar URL con parámetros sensibles.

## Propagadores

Configurar como mínimo:

```text
tracecontext
baggage
```

Evaluar B3 solamente cuando exista compatibilidad heredada necesaria.

## Pruebas

* API externa exitosa.
* API externa con 4xx.
* API externa con 5xx.
* Timeout.
* DNS error.
* Conexión rechazada.
* Retry, cuando exista.

## Criterio de aceptación

El span saliente debe ser hijo de la operación que originó la llamada.

---

# FASE 12 — COLAS, EVENTOS Y WORKERS

## Objetivo

Mantener la misma traza cuando el procesamiento cruza procesos o se vuelve asíncrono.

## Problema

El contexto de OpenTelemetry no se conserva automáticamente cuando un mensaje se guarda en una cola y luego es procesado por otro worker.

Debes implementar propagación explícita.

## Al publicar

Inyectar el contexto en un carrier:

```ts
const carrier: Record<string, string> = {};

propagation.inject(context.active(), carrier);
```

Incluirlo en:

* Headers del mensaje.
* Metadata.
* Campo reservado como `_trace`.
* Propiedad específica del sistema de colas.

Preferir headers o metadata cuando la tecnología lo permita.

## Al consumir

Extraer el contexto:

```ts
const parentContext = propagation.extract(
  context.active(),
  carrier,
);
```

Crear un span consumidor usando ese contexto como padre.

## Tipos de span

Para publicación:

```text
SpanKind.PRODUCER
```

Para consumo:

```text
SpanKind.CONSUMER
```

## Atributos sugeridos

```text
messaging.system
messaging.destination.name
messaging.operation.type
messaging.message.id
app.event.type
app.job.name
app.job.attempt
```

## Reglas

* No duplicar el mensaje completo en los atributos.
* No agregar payloads sensibles.
* No romper consumidores existentes.
* Mantener compatibilidad con mensajes antiguos sin metadata de traza.
* Permitir procesamiento cuando no exista `traceparent`.
* Manejar reintentos.
* Registrar el número de intento.
* Registrar DLQ cuando exista.
* Registrar error del consumidor.
* Finalizar el span correctamente.

## Workers independientes

Cada proceso worker debe:

1. Inicializar su propio SDK.
2. Tener su propio `OTEL_SERVICE_NAME`.
3. Exportar hacia el mismo Collector o Jaeger.
4. Propagar contexto.
5. Ejecutar cierre limpio.
6. No reutilizar de forma incorrecta el nombre de la API.

## Pruebas mínimas

* API publica evento y worker lo procesa.
* Ambos comparten `trace_id`.
* Cada uno posee spans distintos.
* Reintento conserva o enlaza correctamente el contexto.
* Mensaje antiguo sin `_trace` continúa funcionando.
* Error en worker aparece en Jaeger.

---

# FASE 13 — CRON JOBS Y PROCESOS PROGRAMADOS

## Objetivo

Crear trazas raíz para tareas que no se originan en una solicitud HTTP.

## Ejemplos

```text
scheduler.daily-report
scheduler.cleanup
scheduler.sync-products
scheduler.refresh-data
```

## Atributos

```text
app.job.name
app.job.schedule
app.job.execution.id
app.job.attempt
```

## Reglas

* Crear un nuevo trace para cada ejecución.
* Registrar inicio y finalización.
* Registrar cantidad procesada cuando no sea sensible.
* Registrar fallos.
* Evitar un span infinito en tareas permanentes.
* Dividir procesamiento por lotes cuando sea necesario.
* No crear un span por cada registro si se procesan millones de elementos.

---

# FASE 14 — DOCKER COMPOSE PARA DESARROLLO

## Objetivo

Permitir ejecutar Jaeger localmente de forma reproducible.

## Archivo esperado

```text
docker-compose.jaeger.yml
```

O integrar el servicio en el Docker Compose existente sin romperlo.

## Servicio de desarrollo esperado

Utilizar una versión estable y explícita de la imagen de Jaeger.

No utilizar `latest`.

Exponer solamente lo necesario:

```text
16686  Jaeger UI
4317   OTLP gRPC
4318   OTLP HTTP
```

## Seguridad local

Cuando sea posible, enlazar puertos a:

```text
127.0.0.1
```

en lugar de publicarlos en todas las interfaces.

## Redes

* Integrar Jaeger en la red Docker apropiada.
* La API dentro de Docker debe usar el nombre del servicio.
* La API fuera de Docker debe usar `localhost`.

Ejemplo dentro de Docker:

```env
OTEL_EXPORTER_OTLP_TRACES_ENDPOINT=http://jaeger:4318/v1/traces
```

Ejemplo fuera de Docker:

```env
OTEL_EXPORTER_OTLP_TRACES_ENDPOINT=http://localhost:4318/v1/traces
```

## Scripts sugeridos

Agregar sin romper scripts existentes:

```json
{
  "jaeger:up": "docker compose -f docker-compose.jaeger.yml up -d",
  "jaeger:down": "docker compose -f docker-compose.jaeger.yml down",
  "jaeger:logs": "docker compose -f docker-compose.jaeger.yml logs -f"
}
```

## Criterio de aceptación

Con una sola instrucción se debe poder levantar Jaeger localmente.

---

# FASE 15 — OPENTELEMETRY COLLECTOR

## Objetivo

Preparar una arquitectura adecuada para staging y producción.

## Archivo sugerido

```text
infra/otel-collector/otel-collector.config.yml
```

## Funciones esperadas

* Recibir OTLP.
* Aplicar batching.
* Limitar memoria.
* Reintentar exportaciones.
* Redactar atributos.
* Filtrar health checks.
* Exportar a Jaeger.
* Proporcionar métricas internas.
* Manejar backpressure.

## Procesadores mínimos a evaluar

```text
memory_limiter
batch
attributes
filter
resource
```

## Reglas

* No eliminar atributos necesarios sin documentarlo.
* Eliminar headers sensibles.
* No exponer el Collector públicamente.
* Configurar límites de memoria.
* Configurar colas y reintentos.
* Evitar que una caída de Jaeger bloquee el backend.

## Arquitectura

La aplicación nunca debe depender de que Jaeger esté disponible para procesar una solicitud de negocio.

La exportación debe ser asíncrona y tolerante a fallos.

---

# FASE 16 — ALMACENAMIENTO Y PRODUCCIÓN

## Objetivo

Evitar utilizar una configuración efímera de desarrollo en producción.

## Requisitos

El modo `all-in-one` con almacenamiento en memoria solo debe utilizarse para:

* Desarrollo.
* Demostraciones.
* Pruebas locales.

Para producción debes diseñar:

* Jaeger Collector.
* Jaeger Query.
* Almacenamiento persistente.
* Política de retención.
* Alta disponibilidad, si el volumen lo requiere.
* Autenticación para la UI.
* TLS.
* Red privada.
* Backups cuando corresponda.
* Monitoreo del almacenamiento.

## Debes evaluar el almacenamiento según infraestructura existente

Ejemplos posibles:

* OpenSearch.
* Elasticsearch.
* Cassandra.
* Otro backend oficialmente soportado.

No debes desplegar un nuevo sistema de almacenamiento sin justificar:

* Volumen.
* Retención.
* Coste.
* Complejidad operativa.
* Disponibilidad.
* Compatibilidad.

## Entregable

Crear:

```text
docs/observability/03-production-topology.md
```

Debe incluir:

* Topología.
* Componentes.
* Puertos.
* Redes.
* Seguridad.
* Retención.
* Escalabilidad.
* Estrategia de recuperación.
* Costos operativos estimados cualitativamente.

---

# FASE 17 — MUESTREO

## Objetivo

Controlar volumen y coste sin perder trazas importantes.

## Configuración por entorno

Valores iniciales orientativos:

```text
development: 1.0
test:        0.0 o exportador en memoria
staging:     0.25 a 1.0
production:  0.05 a 0.20
```

No aplicar estos valores ciegamente. Debes ajustarlos según tráfico real.

## Requisitos

* Utilizar muestreo basado en padre.
* Respetar decisiones de servicios aguas arriba.
* Permitir configurar ratio por variable de entorno.
* No hardcodear porcentaje.
* Documentar implicaciones.
* Preparar opción para tail sampling en Collector cuando se requiera.

## Casos que pueden necesitar conservación prioritaria

* Errores.
* Latencias anormales.
* Operaciones críticas.
* Flujos de alto valor.
* Jobs fallidos.
* Reintentos agotados.

No implementar muestreo avanzado sin pruebas y sin explicar el costo.

---

# FASE 18 — SEGURIDAD Y PRIVACIDAD

## Objetivo

Evitar que Jaeger se convierta en un repositorio de información sensible.

## Prohibido registrar

* Contraseñas.
* Refresh tokens.
* Access tokens.
* API keys.
* Cookies.
* Headers `Authorization`.
* Datos de tarjetas.
* Cuentas bancarias completas.
* Diagnósticos médicos.
* Historias clínicas.
* Resultados médicos.
* Documentos de identidad.
* Direcciones completas.
* Payloads completos.
* Archivos.
* Imágenes.
* SQL con valores sensibles.
* Variables de entorno.
* Secretos.
* Stack traces enviados al cliente.

## Revisar

* Atributos automáticos.
* Headers capturados.
* URLs.
* Query strings.
* Nombres de rutas.
* Logs correlacionados.
* Excepciones.
* Metadata de mensajes.
* Nombres de archivos.
* Atributos de base de datos.

## Crear

```text
docs/observability/04-data-privacy-policy.md
```

Debe incluir:

* Datos permitidos.
* Datos prohibidos.
* Estrategia de redacción.
* Retención.
* Acceso.
* Auditoría.
* Procedimiento ante filtración.
* Responsables operativos.

---

# FASE 19 — PRUEBAS UNITARIAS

## Objetivo

Verificar la lógica propia de observabilidad.

## Probar

### `TracingService`

* Crea span.
* Ejecuta operación.
* Finaliza span.
* Retorna resultado.
* Registra excepción.
* Marca error.
* Relanza excepción.
* Soporta operación síncrona.
* Soporta operación asíncrona.

### Contexto

* Obtiene `trace_id`.
* Obtiene `span_id`.
* Devuelve valores vacíos sin span activo.
* No genera IDs falsos.

### Propagación de mensajes

* Inyecta `traceparent`.
* Extrae contexto.
* Mantiene relación padre-hijo.
* Funciona sin carrier.
* Funciona con metadata incompleta.
* No modifica destructivamente el payload.

### Interceptor

* Agrega `x-trace-id`.
* No falla sin span activo.
* Marca errores 5xx.
* Conserva respuesta.
* Conserva excepción.

## Herramientas

Utilizar:

* `InMemorySpanExporter`.
* `SimpleSpanProcessor`.
* Provider de prueba.
* Mocks solo donde sean necesarios.

No depender de una instancia real de Jaeger para todas las pruebas unitarias.

---

# FASE 20 — PRUEBAS DE INTEGRACIÓN

## Objetivo

Validar la trazabilidad dentro del backend real.

## Casos mínimos

1. Solicitud HTTP exitosa.
2. Solicitud con validación fallida.
3. Solicitud con error interno.
4. Solicitud con consulta PostgreSQL.
5. Solicitud con operación Redis.
6. Solicitud con llamada HTTP externa.
7. API que publica evento.
8. Worker que consume evento.
9. Cron job.
10. Cierre limpio.
11. Jaeger no disponible.
12. Telemetría deshabilitada.

## Validaciones

* El backend sigue respondiendo cuando Jaeger está caído.
* Las trazas no bloquean la solicitud.
* El `trace_id` coincide entre logs y Jaeger.
* Las consultas aparecen como spans hijos.
* Los errores aparecen marcados.
* Los mensajes conservan contexto.
* No aparecen secretos.
* No existen spans huérfanos injustificados.
* No se generan trazas para health checks excluidos.

---

# FASE 21 — PRUEBAS E2E CON JAEGER

## Objetivo

Validar que una traza completa llegue hasta Jaeger.

## Flujo

1. Levantar Jaeger.
2. Levantar dependencias.
3. Levantar backend.
4. Ejecutar una operación real.
5. Obtener `x-trace-id`.
6. Consultar Jaeger.
7. Buscar la traza.
8. Verificar jerarquía.
9. Verificar errores.
10. Verificar ausencia de información sensible.

## Crear script

```text
scripts/verify-jaeger.sh
```

Debe:

* Confirmar disponibilidad de Jaeger.
* Ejecutar una solicitud de prueba.
* Leer `x-trace-id`.
* Confirmar que el servicio aparece en Jaeger.
* Reportar claramente los fallos.
* No depender de herramientas poco comunes sin documentarlas.

---

# FASE 22 — PRUEBAS DE RENDIMIENTO

## Objetivo

Medir el costo real de la instrumentación.

## Comparar

* Telemetría deshabilitada.
* Telemetría habilitada con sampling 100%.
* Telemetría habilitada con sampling de producción.
* Jaeger disponible.
* Jaeger no disponible.
* Collector disponible.
* Collector saturado.

## Métricas

* Latencia promedio.
* p50.
* p95.
* p99.
* Uso de CPU.
* Uso de memoria.
* Throughput.
* Errores.
* Tiempo de arranque.
* Tiempo de cierre.
* Pérdida de spans.
* Uso de red.

## Criterio

No afirmar que la sobrecarga es aceptable sin realizar una medición.

Crear:

```text
docs/observability/05-performance-results.md
```

---

# FASE 23 — DOCUMENTACIÓN PARA DESARROLLADORES

## Objetivo

Permitir que otro desarrollador use y mantenga la solución.

## Crear

```text
docs/observability/README.md
```

Debe explicar:

* Qué es una traza.
* Qué es un span.
* Qué es un contexto.
* Qué es `trace_id`.
* Qué es `span_id`.
* Cómo levantar Jaeger.
* Cómo ejecutar el backend.
* Cómo buscar una traza.
* Cómo crear un span manual.
* Cómo agregar eventos.
* Cómo agregar atributos.
* Qué datos no deben registrarse.
* Cómo instrumentar un worker.
* Cómo instrumentar un cron.
* Cómo validar logs.
* Cómo resolver problemas frecuentes.

## Incluir ejemplos reales del proyecto

No escribir documentación genérica desconectada del código implementado.

---

# FASE 24 — RUNBOOK OPERATIVO

## Objetivo

Permitir diagnosticar fallos de observabilidad en producción.

## Crear

```text
docs/observability/06-operational-runbook.md
```

Debe cubrir:

### Jaeger no recibe trazas

* Verificar variables.
* Verificar DNS.
* Verificar red.
* Verificar puertos.
* Verificar Collector.
* Verificar exportador.
* Verificar sampling.
* Verificar logs internos de OpenTelemetry.

### El backend se vuelve lento

* Revisar sampling.
* Revisar exportador.
* Revisar batching.
* Revisar Collector.
* Revisar instrumentaciones ruidosas.
* Revisar cardinalidad.

### Los logs no tienen `trace_id`

* Verificar contexto activo.
* Verificar integración Pino.
* Verificar ejecución fuera de contexto.
* Verificar procesos worker.

### No se conserva el trace en la cola

* Verificar inyección.
* Verificar metadata.
* Verificar extracción.
* Verificar compatibilidad de mensajes antiguos.

### Existen datos sensibles

* Deshabilitar captura problemática.
* Aplicar redacción.
* Reducir retención.
* Revocar accesos.
* Evaluar eliminación del índice o almacenamiento afectado.
* Documentar incidente.

---

# FASE 25 — REVISIÓN FINAL DE CÓDIGO

## Objetivo

Asegurar que la implementación cumpla clean code y no degrade la arquitectura.

## Revisar

* Archivos menores de 300 líneas.
* Funciones pequeñas.
* Responsabilidad única.
* Nombres claros.
* Tipado estricto.
* Sin `any` injustificado.
* Sin código duplicado.
* Sin dependencias circulares.
* Sin imports innecesarios.
* Sin variables de entorno dispersas.
* Sin secretos.
* Sin logs temporales.
* Sin TODO pendientes.
* Sin código muerto.
* Sin cambios funcionales no relacionados.
* Sin acoplamiento con Jaeger.
* Sin errores de lint.
* Sin errores de TypeScript.
* Sin pruebas rotas.

## Ejecutar

Adapta los comandos al proyecto:

```bash
yarn lint
yarn typecheck
yarn test
yarn test:cov
yarn test:e2e
yarn build
```

Si existe Docker:

```bash
docker compose config
docker compose build
docker compose up -d
```

---

# 5. VARIABLES DE ENTORNO MÍNIMAS

Centraliza y valida variables similares a:

```env
OTEL_ENABLED=true

OTEL_SERVICE_NAME=backend-api
OTEL_SERVICE_NAMESPACE=platform
OTEL_SERVICE_VERSION=1.0.0
OTEL_DEPLOYMENT_ENVIRONMENT=development

OTEL_EXPORTER_OTLP_PROTOCOL=http/protobuf
OTEL_EXPORTER_OTLP_TRACES_ENDPOINT=http://localhost:4318/v1/traces
OTEL_EXPORT_TIMEOUT_MS=10000

OTEL_TRACES_SAMPLER=parentbased_traceidratio
OTEL_TRACES_SAMPLER_ARG=1.0

OTEL_PROPAGATORS=tracecontext,baggage
OTEL_DIAG_LOG_LEVEL=ERROR
```

Debes integrarlas en el sistema de configuración real del backend.

No acceder indiscriminadamente a `process.env` desde múltiples módulos si el proyecto utiliza `ConfigService`.

---

# 6. CRITERIOS DE ACEPTACIÓN FUNCIONALES

La implementación solo se considera completa cuando:

* [ ] Jaeger puede levantarse localmente.
* [ ] El backend arranca con observabilidad habilitada.
* [ ] El backend arranca con observabilidad deshabilitada.
* [ ] El backend funciona cuando Jaeger está caído.
* [ ] Las solicitudes HTTP generan trazas.
* [ ] Los controllers aparecen en el flujo.
* [ ] Las operaciones críticas poseen spans de negocio.
* [ ] PostgreSQL aparece en las trazas.
* [ ] Sequelize aparece correctamente instrumentado.
* [ ] Redis aparece en las trazas.
* [ ] Las llamadas HTTP externas aparecen en las trazas.
* [ ] Los errores quedan marcados.
* [ ] Los logs Pino incluyen `trace_id`.
* [ ] Las respuestas incluyen `x-trace-id`.
* [ ] API y workers conservan la misma traza.
* [ ] Los cron jobs generan trazas raíz.
* [ ] Los health checks están excluidos.
* [ ] No se registran tokens.
* [ ] No se registran contraseñas.
* [ ] No se registran datos sensibles.
* [ ] Las pruebas unitarias pasan.
* [ ] Las pruebas de integración pasan.
* [ ] Las pruebas E2E pasan.
* [ ] El build pasa.
* [ ] El lint pasa.
* [ ] La documentación está completa.
* [ ] Existe un runbook operativo.
* [ ] Existe un diseño de producción.
* [ ] No hay tareas pendientes injustificadas.

---

# 7. ENTREGABLES OBLIGATORIOS

Debes entregar como mínimo:

```text
src/observability/
├── observability.module.ts
├── telemetry.bootstrap.ts
├── telemetry.config.ts
├── tracing.service.ts
├── trace-context.service.ts
├── trace-response.interceptor.ts
└── messaging-trace.service.ts
```

Adapta los nombres al proyecto y evita archivos innecesarios.

También:

```text
docker-compose.jaeger.yml
infra/otel-collector/otel-collector.config.yml
.env.example
scripts/verify-jaeger.sh

docs/observability/
├── 00-current-state-audit.md
├── 01-architecture-design.md
├── 02-business-spans-catalog.md
├── 03-production-topology.md
├── 04-data-privacy-policy.md
├── 05-performance-results.md
├── 06-operational-runbook.md
└── README.md
```

Pruebas:

```text
src/observability/**/*.spec.ts
test/observability/*.e2e-spec.ts
```

Actualizar cuando corresponda:

```text
package.json
yarn.lock
src/main.ts
src/app.module.ts
Dockerfile
docker-compose.yml
README.md
```

---

# 8. FORMATO DEL INFORME FINAL

Al terminar, entrega un informe con esta estructura:

## 1. Resumen ejecutivo

Explica qué se implementó y qué valor proporciona.

## 2. Arquitectura final

Incluye diagrama Mermaid.

## 3. Archivos creados

Lista cada archivo y su responsabilidad.

## 4. Archivos modificados

Explica cada modificación.

## 5. Instrumentaciones activas

Indica qué tecnologías quedaron instrumentadas.

## 6. Spans de negocio

Lista spans, atributos y eventos.

## 7. Correlación de logs

Explica cómo relacionar Pino con Jaeger.

## 8. Workers y propagación

Explica cómo se conserva el contexto.

## 9. Seguridad

Explica qué medidas impiden registrar información sensible.

## 10. Pruebas realizadas

Incluye comandos y resultados reales.

No inventes resultados.

## 11. Rendimiento

Presenta mediciones o indica claramente si no pudieron realizarse.

## 12. Uso local

Incluye comandos completos.

## 13. Producción

Explica la topología recomendada.

## 14. Riesgos restantes

Lista riesgos reales.

## 15. Matriz de cumplimiento

Utiliza una tabla:

| Requisito            |   Estado | Evidencia        |
| -------------------- | -------: | ---------------- |
| Trazas HTTP          | Cumplido | Archivo/prueba   |
| PostgreSQL           | Cumplido | Archivo/prueba   |
| Redis                | Cumplido | Archivo/prueba   |
| Workers              | Cumplido | Archivo/prueba   |
| Logs correlacionados | Cumplido | Archivo/prueba   |
| Seguridad            | Cumplido | Documento/prueba |

## 16. Estado final

Utiliza una de estas clasificaciones:

```text
COMPLETO
COMPLETO CON OBSERVACIONES
INCOMPLETO
BLOQUEADO
```

No declares `COMPLETO` si existen pruebas fallidas, componentes sin validar o tareas pendientes críticas.

---

# 9. PROHIBICIONES

No debes:

* Crear una implementación superficial.
* Instalar Jaeger y considerar concluido el trabajo.
* Usar el cliente Jaeger antiguo.
* Acoplar servicios de negocio a Jaeger.
* Registrar cuerpos completos.
* Registrar headers de autorización.
* Registrar contraseñas.
* Registrar tokens.
* Registrar datos médicos.
* Registrar datos financieros sensibles.
* Generar IDs manuales cuando OpenTelemetry debe hacerlo.
* Utilizar IDs enviados por el cliente como trace ID confiable.
* Crear spans sin finalizarlos.
* Finalizar spans que no fueron creados manualmente.
* Romper la propagación asíncrona.
* Bloquear solicitudes mientras se exportan trazas.
* Hacer fallar el backend cuando Jaeger no esté disponible.
* Usar `latest` en imágenes Docker.
* Cambiar Yarn por npm.
* Omitir pruebas.
* Inventar resultados.
* Dejar archivos temporales.
* Dejar TODO sin explicación.
* Modificar módulos no relacionados.
* Deshabilitar seguridad para facilitar la observabilidad.
* Exponer Jaeger públicamente sin autenticación.
* Publicar OTLP directamente hacia Internet.

---

# 10. ORDEN DE EJECUCIÓN OBLIGATORIO

Ejecuta exactamente en este orden:

```text
Fase 0  → Auditoría
Fase 1  → Diseño
Fase 2  → Dependencias
Fase 3  → Bootstrap
Fase 4  → Instrumentación automática
Fase 5  → Módulo NestJS
Fase 6  → Logs
Fase 7  → Errores
Fase 8  → Spans de negocio
Fase 9  → PostgreSQL
Fase 10 → Redis
Fase 11 → HTTP externo
Fase 12 → Colas y workers
Fase 13 → Cron jobs
Fase 14 → Docker local
Fase 15 → Collector
Fase 16 → Producción
Fase 17 → Sampling
Fase 18 → Seguridad
Fase 19 → Pruebas unitarias
Fase 20 → Integración
Fase 21 → E2E Jaeger
Fase 22 → Rendimiento
Fase 23 → Documentación
Fase 24 → Runbook
Fase 25 → Revisión final
```

Después de cada fase:

```text
1. Compilar.
2. Ejecutar pruebas relevantes.
3. Corregir errores.
4. Documentar.
5. Continuar.
```

---

# 11. INSTRUCCIÓN FINAL

Comienza revisando el repositorio completo.

No escribas código antes de terminar la auditoría inicial.

Toma decisiones técnicas razonables basadas en la arquitectura existente, pero documenta todas las decisiones importantes.

No me preguntes por detalles que puedan determinarse inspeccionando el repositorio.

Cuando existan varias alternativas válidas:

1. Evalúalas.
2. Explica ventajas y riesgos.
3. Selecciona la más compatible con el proyecto.
4. Implementa la decisión.
5. Documenta por qué fue elegida.

El resultado debe ser una implementación funcional, segura, probada, mantenible y lista para evolucionar desde desarrollo hacia producción.
