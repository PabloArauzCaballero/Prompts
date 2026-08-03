# Plan Maestro de Documentación Profesional del Backend

> **Objetivo:** transformar la documentación del backend en un sistema técnico completo, verificable, automatizado, navegable y listo para producción. La documentación debe representar fielmente el sistema real, comenzar por el análisis de Graphify y quedar integrada al ciclo de desarrollo, pruebas, seguridad, despliegue y operación.

---

## 1. Mandato de ejecución

Actúa como **Arquitecto de Software Senior, Technical Writer, especialista en OpenAPI, gobierno de APIs, seguridad, observabilidad y operación de sistemas productivos**.

Debes ejecutar este plan de principio a fin sin dejar tareas ambiguas, marcadores vacíos, archivos provisionales, secciones incompletas ni documentación desconectada del código real.

### Reglas obligatorias

1. **Consultar Graphify antes de modificar o crear documentación.**
2. No asumir la arquitectura: comprobarla en el repositorio, configuración, Graphify, ORM, rutas, módulos, pruebas y despliegue.
3. No documentar funcionalidades inexistentes como si estuvieran implementadas.
4. Cuando exista una brecha, corregir el código o registrar claramente la deuda bloqueante antes del cierre.
5. No usar texto genérico que pudiera pertenecer a cualquier proyecto.
6. Cada afirmación técnica relevante debe poder rastrearse a código, configuración, prueba, migración, contrato o decisión arquitectónica.
7. La documentación debe versionarse junto al código.
8. Los cambios incompatibles deben quedar identificados y gobernados.
9. Todo endpoint, evento, entidad crítica, permiso, proceso operativo y dependencia debe tener documentación suficiente.
10. La entrega se considera completa únicamente cuando pasan todas las validaciones automáticas y la revisión final de consistencia.

---

# 2. Resultado esperado

Al finalizar, el backend debe contar con:

* Contrato OpenAPI completo y validado.
* Referencia interactiva profesional mediante Scalar.
* Gobierno y linting mediante Redocly CLI.
* Portal técnico mediante MkDocs Material.
* Arquitectura documentada con modelo C4.
* ADR para decisiones relevantes.
* AsyncAPI cuando existan eventos o mensajería.
* Catálogo de módulos, endpoints, entidades, permisos, errores y dependencias.
* Guías de integración para frontend y otros consumidores.
* Runbooks operativos y procedimientos de incidentes.
* Documentación de seguridad y amenazas.
* Documentación de observabilidad, logs, métricas y trazas.
* Matriz de trazabilidad entre negocio, código, API, datos y pruebas.
* Validaciones automáticas en CI/CD.
* Criterios objetivos de aceptación y cierre.

---

# 3. Arquitectura documental objetivo

```text
backend/
├── docs/
│   ├── index.md
│   ├── getting-started/
│   │   ├── prerequisites.md
│   │   ├── local-setup.md
│   │   ├── environment-variables.md
│   │   ├── database-setup.md
│   │   ├── running-tests.md
│   │   └── troubleshooting.md
│   ├── business/
│   │   ├── business-context.md
│   │   ├── actors-and-roles.md
│   │   ├── capabilities.md
│   │   ├── critical-workflows.md
│   │   ├── business-rules.md
│   │   └── glossary.md
│   ├── architecture/
│   │   ├── overview.md
│   │   ├── system-context.md
│   │   ├── containers.md
│   │   ├── components.md
│   │   ├── module-dependencies.md
│   │   ├── request-lifecycle.md
│   │   ├── background-processing.md
│   │   ├── integration-map.md
│   │   └── diagrams/
│   ├── modules/
│   │   └── <module-name>/
│   │       ├── overview.md
│   │       ├── responsibilities.md
│   │       ├── use-cases.md
│   │       ├── endpoints.md
│   │       ├── domain-rules.md
│   │       ├── data-model.md
│   │       ├── dependencies.md
│   │       ├── permissions.md
│   │       ├── errors.md
│   │       ├── tests.md
│   │       └── operational-notes.md
│   ├── api/
│   │   ├── conventions.md
│   │   ├── authentication.md
│   │   ├── authorization.md
│   │   ├── versioning.md
│   │   ├── pagination.md
│   │   ├── filtering-and-sorting.md
│   │   ├── idempotency.md
│   │   ├── error-model.md
│   │   ├── rate-limits.md
│   │   ├── deprecation-policy.md
│   │   └── integration-examples.md
│   ├── data/
│   │   ├── data-architecture.md
│   │   ├── entity-catalog.md
│   │   ├── relationships.md
│   │   ├── data-dictionary.md
│   │   ├── constraints-and-indexes.md
│   │   ├── migrations.md
│   │   ├── seeds.md
│   │   ├── retention.md
│   │   ├── classification.md
│   │   └── backup-and-restore.md
│   ├── events/
│   │   ├── overview.md
│   │   ├── event-catalog.md
│   │   ├── delivery-semantics.md
│   │   ├── retries-and-dlq.md
│   │   └── consumer-guidelines.md
│   ├── security/
│   │   ├── security-architecture.md
│   │   ├── threat-model.md
│   │   ├── secrets-management.md
│   │   ├── access-control.md
│   │   ├── tenant-isolation.md
│   │   ├── auditability.md
│   │   ├── dependency-security.md
│   │   └── incident-response.md
│   ├── observability/
│   │   ├── logging.md
│   │   ├── metrics.md
│   │   ├── tracing.md
│   │   ├── dashboards.md
│   │   ├── alerts.md
│   │   └── service-level-objectives.md
│   ├── operations/
│   │   ├── environments.md
│   │   ├── deployment.md
│   │   ├── configuration.md
│   │   ├── health-checks.md
│   │   ├── scaling.md
│   │   ├── rollback.md
│   │   ├── disaster-recovery.md
│   │   ├── maintenance.md
│   │   └── runbooks/
│   ├── testing/
│   │   ├── strategy.md
│   │   ├── unit-tests.md
│   │   ├── integration-tests.md
│   │   ├── e2e-tests.md
│   │   ├── contract-tests.md
│   │   ├── performance-tests.md
│   │   └── test-data.md
│   ├── adr/
│   │   ├── index.md
│   │   └── ADR-XXXX-*.md
│   ├── governance/
│   │   ├── ownership.md
│   │   ├── documentation-policy.md
│   │   ├── review-process.md
│   │   ├── change-management.md
│   │   └── traceability-matrix.md
│   └── reports/
│       ├── graphify-audit.md
│       ├── documentation-gap-analysis.md
│       ├── production-readiness.md
│       └── final-validation.md
├── openapi/
│   ├── openapi.yaml
│   ├── examples/
│   └── overlays/
├── asyncapi/
│   └── asyncapi.yaml
├── structurizr/
│   └── workspace.dsl
├── mkdocs.yml
├── redocly.yaml
└── scripts/
    ├── generate-openapi.*
    ├── validate-openapi.*
    ├── check-doc-links.*
    ├── check-doc-coverage.*
    └── generate-doc-report.*
```

---

# 4. Fase 0 — Preparación, inventario y protección

## Objetivo

Preparar el trabajo sin alterar prematuramente el sistema y establecer una línea base reproducible.

## Actividades

1. Identificar:

   * Framework y versión.
   * Gestor de paquetes.
   * Estructura del repositorio.
   * Módulos principales.
   * ORM y motores de datos.
   * Sistemas de colas o eventos.
   * Integraciones externas.
   * Proveedor de autenticación.
   * Infraestructura y ambientes.
   * Herramientas actuales de pruebas, logs y despliegue.

2. Ejecutar la línea base:

   * Instalación limpia.
   * Compilación.
   * Lint.
   * Pruebas unitarias.
   * Pruebas de integración.
   * Pruebas E2E.
   * Generación actual de OpenAPI, si existe.
   * Auditoría de dependencias.

3. Registrar resultados en:

```text
docs/reports/baseline.md
```

4. No continuar silenciosamente ante errores. Cada fallo debe:

   * corregirse; o
   * registrarse como bloqueo con causa, impacto y solución concreta.

## Criterio de salida

* Repositorio instalable y evaluado.
* Estado actual registrado.
* Comandos reales documentados.
* Riesgos iniciales identificados.

---

# 5. Fase 1 — Graphify como primera fuente de descubrimiento

## Objetivo

Usar Graphify para entender el sistema real antes de diseñar la documentación definitiva.

## Fuentes mínimas a revisar

Buscar y analizar, cuando existan:

```text
graphify-out/graph.json
graphify-out/graph.html
graphify-out/GRAPH_REPORT.md
graphify-out/manifest.json
graphify-out/cache/stat-index.json
graphify-out/**/.graphify_labels.json
graphify-out/<fecha>/graph.json
graphify-out/<fecha>/GRAPH_REPORT.md
```

## Análisis obligatorio

1. Inventariar nodos por tipo:

   * módulos;
   * controladores;
   * servicios;
   * repositorios;
   * entidades;
   * DTO;
   * guards;
   * interceptores;
   * middlewares;
   * workers;
   * eventos;
   * adaptadores;
   * dependencias externas.

2. Inventariar relaciones:

   * llamadas;
   * imports;
   * inyección de dependencias;
   * acceso a datos;
   * publicación y consumo de eventos;
   * dependencias circulares;
   * módulos excesivamente acoplados;
   * componentes huérfanos.

3. Detectar:

   * nodos sin documentación;
   * módulos críticos;
   * rutas de alto impacto;
   * puntos de entrada;
   * flujos de datos;
   * zonas con complejidad elevada;
   * inconsistencias entre Graphify y el código.

4. Contrastar Graphify con:

   * árbol real del repositorio;
   * configuración del framework;
   * rutas registradas;
   * migraciones y entidades;
   * pruebas;
   * especificación OpenAPI existente;
   * infraestructura.

5. Generar:

```text
docs/reports/graphify-audit.md
docs/architecture/module-dependencies.md
docs/architecture/integration-map.md
docs/governance/traceability-matrix.md
```

## Contenido mínimo de `graphify-audit.md`

* Fecha y versión analizada.
* Archivos Graphify consultados.
* Resumen ejecutivo.
* Inventario cuantitativo.
* Módulos y componentes críticos.
* Dependencias circulares.
* Componentes huérfanos.
* Componentes con alta centralidad.
* Flujos principales.
* Diferencias entre grafo y código.
* Riesgos documentales.
* Riesgos arquitectónicos.
* Acciones ejecutadas.
* Evidencias.

## Criterio de salida

Ninguna documentación arquitectónica definitiva se crea sin que exista primero el informe de auditoría de Graphify.

---

# 6. Fase 2 — Análisis de brechas documentales

## Objetivo

Comparar el estado real con el estándar objetivo y convertir cada diferencia en una tarea verificable.

## Matriz obligatoria

Crear `docs/reports/documentation-gap-analysis.md` con columnas equivalentes a:

| ID | Área | Elemento real | Evidencia | Estado actual | Brecha | Riesgo | Acción | Responsable técnico | Validación | Estado final |
| -- | ---- | ------------- | --------- | ------------- | ------ | ------ | ------ | ------------------- | ---------- | ------------ |

## Áreas mínimas

* Negocio.
* Arquitectura.
* API HTTP.
* Eventos.
* Datos.
* Seguridad.
* Pruebas.
* Observabilidad.
* Operación.
* Integraciones.
* Gobierno.
* Despliegue.
* Recuperación.

## Clasificación

* `BLOCKER`: impide afirmar que está listo para producción.
* `CRITICAL`: riesgo alto de integración, seguridad u operación.
* `HIGH`: ausencia relevante de claridad o trazabilidad.
* `MEDIUM`: mejora necesaria pero no bloqueante.
* `LOW`: optimización editorial o visual.

## Criterio de salida

* Cero brechas sin clasificación.
* Cero tareas vagas como “mejorar documentación”.
* Cada acción debe señalar archivo, resultado esperado y validación.

---

# 7. Fase 3 — Contrato OpenAPI como fuente de verdad

## Objetivo

Construir un contrato de API completo, estable y verificable.

## Estándar recomendado

* OpenAPI 3.1.x, salvo incompatibilidad demostrada con el ecosistema actual.
* Usar nombres estables y consistentes.
* Mantener el contrato generado de forma reproducible.

## Cada operación debe incluir

* `operationId` único y estable.
* `summary` precisa.
* `description` orientada al consumidor.
* Etiquetas coherentes.
* Autenticación requerida.
* Permisos o roles aplicables.
* Parámetros de ruta.
* Parámetros de consulta.
* Encabezados relevantes.
* Cuerpo de solicitud.
* Reglas de validación.
* Ejemplo válido.
* Respuesta exitosa.
* Respuestas de error relevantes.
* Modelo de error estándar.
* Consideraciones de idempotencia.
* Paginación, filtrado y ordenamiento cuando corresponda.
* Efectos secundarios relevantes.
* Estado de deprecación cuando aplique.

## Componentes reutilizables

Centralizar:

* errores;
* paginación;
* metadatos;
* identificadores;
* fechas;
* auditoría;
* autenticación;
* respuestas comunes;
* parámetros compartidos.

## Modelo de error obligatorio

Definir una respuesta consistente, por ejemplo:

```json
{
  "statusCode": 400,
  "code": "VALIDATION_ERROR",
  "message": "La solicitud contiene datos inválidos",
  "details": [
    {
      "field": "email",
      "reason": "Debe contener un correo válido"
    }
  ],
  "correlationId": "01H...",
  "timestamp": "2026-07-29T13:00:00.000Z",
  "path": "/api/v1/example"
}
```

Adaptar el ejemplo al contrato real; no copiarlo si el backend utiliza otro modelo.

## Validaciones

* Contrato sintácticamente válido.
* Cero operaciones sin `operationId`.
* Cero esquemas anónimos innecesarios.
* Cero respuestas exitosas sin esquema.
* Cero errores críticos sin documentar.
* Ejemplos compatibles con sus esquemas.
* Seguridad definida globalmente o por operación.

## Criterio de salida

El contrato describe todos los endpoints públicos y privados expuestos por el backend y coincide con su comportamiento probado.

---

# 8. Fase 4 — Scalar como referencia interactiva

## Objetivo

Publicar una experiencia moderna de documentación y prueba de API.

## Implementación

1. Integrar Scalar con el documento OpenAPI generado.
2. Exponer una ruta controlada, por ejemplo:

```text
/docs
/docs/openapi.json
```

3. Configurar:

   * título del producto;
   * versión;
   * servidores por ambiente;
   * autenticación;
   * orden de etiquetas;
   * ejemplos;
   * tema consistente con la identidad del proyecto;
   * enlace al portal técnico;
   * advertencia visible en ambientes no productivos.

4. Proteger la documentación cuando el contexto de seguridad lo exija.

5. Evitar exposición de secretos, credenciales, hosts internos o ejemplos sensibles.

## Criterio de salida

Un consumidor puede descubrir, comprender y probar la API sin revisar el código fuente.

---

# 9. Fase 5 — Redocly y gobierno automático del contrato

## Objetivo

Impedir que OpenAPI se degrade con cambios futuros.

## Implementación

Crear `redocly.yaml` con reglas para:

* `operationId` obligatorio.
* Descripciones obligatorias.
* Etiquetas válidas.
* Esquemas definidos.
* Convenciones de nombres.
* Errores documentados.
* Seguridad declarada.
* Ejemplos válidos.
* Prohibición de propiedades ambiguas.
* Control de deprecación.

## Scripts sugeridos

```json
{
  "scripts": {
    "docs:openapi:generate": "...",
    "docs:openapi:lint": "redocly lint openapi/openapi.yaml",
    "docs:openapi:bundle": "redocly bundle openapi/openapi.yaml -o dist/openapi.yaml",
    "docs:validate": "...",
    "docs:serve": "mkdocs serve",
    "docs:build": "mkdocs build --strict"
  }
}
```

Adaptar los comandos al gestor de paquetes y estructura reales.

## Criterio de salida

Una modificación contractual inválida o incompleta hace fallar CI.

---

# 10. Fase 6 — Portal MkDocs Material

## Objetivo

Crear un portal técnico unificado para negocio, ingeniería, seguridad, QA y operaciones.

## Configuración mínima

* Navegación jerárquica.
* Búsqueda.
* Índices por área.
* Mermaid.
* Bloques de código.
* Versionado o estrategia equivalente.
* Enlaces a Scalar.
* Validación estricta de enlaces.
* Diseño sobrio y legible.
* Buen comportamiento móvil.

## Página inicial

Debe incluir:

* propósito del backend;
* capacidades principales;
* diagrama de contexto;
* enlaces rápidos;
* cómo ejecutar localmente;
* cómo consumir la API;
* cómo desplegar;
* cómo responder a incidentes;
* propietarios técnicos;
* versión documentada.

## Criterio de salida

Toda persona técnica nueva puede ubicarse rápidamente y encontrar el nivel de detalle que necesita.

---

# 11. Fase 7 — Documentación de negocio y flujos reales

## Objetivo

Explicar por qué existe cada parte del sistema y cómo soporta el negocio.

## Por cada capacidad crítica

Documentar:

1. Problema de negocio.
2. Actor principal.
3. Precondiciones.
4. Flujo principal.
5. Flujos alternativos.
6. Reglas de negocio.
7. Estados y transiciones.
8. Validaciones.
9. Datos utilizados.
10. Endpoints involucrados.
11. Eventos producidos o consumidos.
12. Permisos.
13. Fallos posibles.
14. Evidencia en pruebas.
15. Métricas operativas.

## Criterio de salida

Cada módulo importante tiene una justificación de negocio y una explicación técnica conectadas entre sí.

---

# 12. Fase 8 — Arquitectura C4 y dependencias

## Objetivo

Representar los límites, responsabilidades y relaciones del sistema sin generar diagramas decorativos.

## Diagramas obligatorios

1. Contexto del sistema.
2. Contenedores.
3. Componentes por dominio crítico.
4. Despliegue.
5. Flujo de solicitud.
6. Integraciones externas.
7. Procesamiento asíncrono.
8. Flujo de autenticación y autorización.
9. Flujo de datos sensibles.

## Herramientas

* Structurizr DSL como fuente de arquitectura oficial.
* Mermaid para secuencias y flujos dentro de Markdown.
* PlantUML únicamente cuando aporte precisión adicional.

## Reglas

* Diagramas generados desde código o texto versionable.
* Evitar imágenes imposibles de mantener.
* Cada elemento debe tener nombre y responsabilidad.
* Señalar protocolos, límites de confianza y almacenes.
* Mantener consistencia con Graphify.

## Criterio de salida

Los diagramas y Graphify describen el mismo sistema, con diferencias justificadas explícitamente.

---

# 13. Fase 9 — ADR de decisiones arquitectónicas

## Objetivo

Conservar el razonamiento detrás de las decisiones importantes.

## ADR mínimos

Crear ADR para decisiones como:

* framework principal;
* ORM;
* motor de datos;
* estrategia de autenticación;
* autorización y RBAC/ABAC;
* multi-tenancy;
* eventos o colas;
* cache;
* almacenamiento de archivos;
* observabilidad;
* versionado de API;
* estrategia de errores;
* idempotencia;
* despliegue;
* secretos;
* migraciones;
* seeds;
* consistencia transaccional;
* patrón outbox, cuando aplique.

## Plantilla

```markdown
# ADR-XXXX: Título

## Estado
Propuesto | Aceptado | Reemplazado | Rechazado | Obsoleto

## Contexto

## Fuerzas y restricciones

## Opciones consideradas

## Decisión

## Consecuencias positivas

## Consecuencias negativas

## Riesgos

## Evidencia

## Plan de revisión
```

## Criterio de salida

Las decisiones estructurales no dependen de memoria oral o conversaciones aisladas.

---

# 14. Fase 10 — Datos y catálogo técnico

## Objetivo

Documentar el modelo de datos desde el punto de vista técnico y de negocio.

## Por cada entidad o tabla

* Nombre técnico.
* Nombre de negocio.
* Propósito.
* Justificación de existencia.
* Propietario del dato.
* Fuente.
* Campos.
* Tipos.
* Nulabilidad.
* Valores permitidos.
* Claves.
* Relaciones.
* Restricciones.
* Índices.
* Reglas de integridad.
* Ciclo de vida.
* Retención.
* Clasificación de sensibilidad.
* Operaciones que la utilizan.
* Ejemplo de uso.
* Riesgos.
* Migración que la creó.

## Validación

Contrastar catálogo contra:

* entidades ORM;
* migraciones;
* esquema real;
* índices reales;
* constraints reales;
* seeds;
* consultas críticas.

## Criterio de salida

No existe entidad persistente relevante sin propósito, definición y trazabilidad.

---

# 15. Fase 11 — AsyncAPI y catálogo de eventos

## Condición

Aplicar cuando el backend publique o consuma mensajes, eventos, WebSockets o trabajos asíncronos.

## Documentar

* nombre del evento;
* productor;
* consumidores;
* canal;
* esquema;
* versión;
* semántica de entrega;
* orden;
* idempotencia;
* reintentos;
* dead-letter queue;
* correlación;
* seguridad;
* compatibilidad;
* observabilidad.

## Criterio de salida

Los consumidores pueden implementar integraciones asíncronas sin deducir contratos desde el código.

---

# 16. Fase 12 — Seguridad y modelo de amenazas

## Objetivo

Documentar y verificar cómo se protege el sistema.

## Contenido obligatorio

* Activos críticos.
* Fronteras de confianza.
* Actores.
* Superficie de ataque.
* Autenticación.
* Autorización.
* Manejo de sesiones y tokens.
* Rotación de secretos.
* Cifrado en tránsito y reposo.
* Datos personales y sensibles.
* Validación de entradas.
* Rate limiting.
* Protección contra abuso.
* Auditoría.
* Dependencias vulnerables.
* Gestión de incidentes.
* Backup y recuperación.
* Aislamiento de tenants, cuando aplique.

## Modelo de amenazas

Usar STRIDE o una metodología equivalente y registrar:

* amenaza;
* activo afectado;
* probabilidad;
* impacto;
* mitigación;
* evidencia;
* riesgo residual.

## Criterio de salida

No se declara listo para producción con amenazas críticas sin mitigación o aceptación formal documentada.

---

# 17. Fase 13 — Observabilidad y operación

## Objetivo

Permitir detectar, investigar y resolver fallos reales.

## Logs

Documentar:

* formato estructurado;
* niveles;
* campos obligatorios;
* `correlationId`;
* `requestId`;
* actor;
* tenant;
* operación;
* latencia;
* resultado;
* error normalizado;
* reglas de redacción de datos sensibles.

## Métricas

* tasa de solicitudes;
* latencia;
* errores;
* saturación;
* conexiones;
* colas;
* trabajos fallidos;
* base de datos;
* cache;
* integraciones externas;
* métricas de negocio críticas.

## Trazas

Documentar propagación de contexto entre:

* HTTP;
* base de datos;
* cache;
* colas;
* servicios externos.

## Runbooks mínimos

* API no disponible.
* Aumento de errores 5xx.
* Base de datos degradada.
* Migración fallida.
* Cola detenida.
* Integración externa caída.
* Tokens o autenticación fallando.
* Consumo elevado de recursos.
* Recuperación desde backup.
* Rollback de despliegue.

## Criterio de salida

Un operador puede responder a incidentes siguiendo documentación reproducible.

---

# 18. Fase 14 — Estrategia de pruebas y contratos

## Objetivo

Demostrar que la documentación coincide con el comportamiento.

## Capas

* Unitarias.
* Integración.
* E2E.
* Contrato.
* Seguridad.
* Rendimiento.
* Resiliencia.
* Migraciones.
* Smoke de producción.

## Validaciones documentales automatizadas

1. Toda ruta real aparece en OpenAPI.
2. Toda operación OpenAPI tiene prueba de humo o contrato.
3. Los ejemplos cumplen el esquema.
4. Los códigos de error reales están documentados.
5. Los enlaces del portal son válidos.
6. No hay páginas huérfanas.
7. Los diagramas compilan.
8. MkDocs compila en modo estricto.
9. Redocly no presenta errores.
10. El contrato generado no contiene secretos.

## Criterio de salida

La documentación crítica está respaldada por pruebas y validaciones automáticas.

---

# 19. Fase 15 — CI/CD documental

## Objetivo

Convertir la documentación en una parte obligatoria del producto.

## Pipeline mínimo

```text
Instalación limpia
  → lint de código
  → compilación
  → pruebas
  → generación OpenAPI
  → lint Redocly
  → detección de breaking changes
  → pruebas de contrato
  → validación de ejemplos
  → construcción de diagramas
  → construcción MkDocs --strict
  → revisión de enlaces
  → análisis de secretos
  → publicación de artefactos
```

## Controles de cambio

* Pull requests que cambien rutas, DTO, entidades, permisos, eventos o configuración deben actualizar documentación asociada.
* Agregar plantilla de PR con casilla documental.
* Agregar CODEOWNERS para áreas críticas.
* Detectar breaking changes del contrato.
* Publicar versión de documentación correspondiente a cada release.

## Criterio de salida

No puede integrarse un cambio que rompa o deje desactualizada la documentación crítica.

---

# 20. Fase 16 — Experiencia visual y editorial de máxima calidad

## Objetivo

Lograr documentación clara, consistente y profesional, no solamente extensa.

## Reglas editoriales

* Español técnico claro o idioma oficial definido para el proyecto.
* Frases directas.
* Términos consistentes.
* Glosario común.
* Ejemplos reales y seguros.
* Tablas solo cuando mejoren comparación.
* Diagramas con propósito.
* Cero párrafos de relleno.
* Cero referencias vagas como “esto”, “aquello” o “el sistema” sin contexto.
* Explicar siglas en su primera aparición.
* Separar explícitamente comportamiento actual, decisión y recomendación.

## Elementos visuales

* Identidad consistente.
* Portada profesional.
* Navegación predecible.
* Iconografía sobria.
* Diagramas legibles.
* Admonitions para riesgos, decisiones y advertencias.
* Fragmentos de código probados.
* Indicadores de versión y ambiente.

## Criterio de salida

La documentación debe resultar útil para dirección técnica, desarrolladores, QA, seguridad, operaciones e integradores externos.

---

# 21. Fase 17 — Auditoría final de preparación para producción

## Objetivo

Cerrar el trabajo con evidencia objetiva y sin pendientes ocultos.

## Informe final

Crear:

```text
docs/reports/production-readiness.md
docs/reports/final-validation.md
```

## Checklist obligatorio

### Graphify

* [ ] Se consultaron todos los artefactos relevantes.
* [ ] Se documentaron módulos y relaciones.
* [ ] Se revisaron ciclos y componentes huérfanos.
* [ ] Los diagramas son coherentes con el grafo.

### API

* [ ] Todos los endpoints están documentados.
* [ ] Todos tienen `operationId`.
* [ ] Todos tienen seguridad declarada.
* [ ] Solicitudes y respuestas tienen esquemas.
* [ ] Los errores relevantes están documentados.
* [ ] Los ejemplos son válidos.
* [ ] Redocly pasa sin errores.
* [ ] Scalar funciona.

### Arquitectura

* [ ] Existe C4 completo.
* [ ] Dependencias críticas explicadas.
* [ ] Flujos principales documentados.
* [ ] Integraciones documentadas.
* [ ] ADR completos.

### Datos

* [ ] Entidades catalogadas.
* [ ] Relaciones y restricciones comprobadas.
* [ ] Índices documentados.
* [ ] Migraciones y seeds explicados.
* [ ] Retención y sensibilidad definidas.

### Seguridad

* [ ] Threat model realizado.
* [ ] Secretos y permisos documentados.
* [ ] Riesgos críticos resueltos.
* [ ] Datos sensibles protegidos en ejemplos y logs.

### Operación

* [ ] Health checks documentados.
* [ ] Logs, métricas y trazas definidos.
* [ ] Alertas y SLO definidos.
* [ ] Runbooks disponibles.
* [ ] Backup, restauración y rollback comprobados.

### Calidad

* [ ] MkDocs compila en modo estricto.
* [ ] No existen enlaces rotos.
* [ ] No existen marcadores TODO/FIXME en documentación final.
* [ ] No existen páginas vacías.
* [ ] No existen contradicciones conocidas.
* [ ] CI/CD documental está activo.

---

# 22. Definición de terminado

El proyecto documental se considera terminado únicamente cuando:

1. Graphify fue analizado y contrastado con el código.
2. La arquitectura documentada coincide con el sistema real.
3. El 100 % de endpoints expuestos está cubierto por OpenAPI.
4. Scalar presenta correctamente la referencia.
5. Redocly valida el contrato sin errores.
6. MkDocs compila estrictamente sin enlaces rotos.
7. Los módulos críticos tienen contexto de negocio y técnico.
8. Las entidades persistentes relevantes tienen catálogo.
9. Los eventos tienen contrato cuando corresponda.
10. Seguridad y amenazas están documentadas.
11. Observabilidad y runbooks están documentados.
12. Existe trazabilidad entre negocio, código, contrato, datos y pruebas.
13. CI/CD impide regresiones documentales.
14. No quedan `TODO`, `TBD`, `pendiente`, contenido provisional ni secciones vacías.
15. Toda limitación real restante está formalmente registrada, justificada y aceptada; de lo contrario, no puede declararse cierre.

---

# 23. Métricas de calidad

Registrar como mínimo:

| Métrica                            |              Objetivo |
| ---------------------------------- | --------------------: |
| Endpoints documentados             |                 100 % |
| Operaciones con `operationId`      |                 100 % |
| Operaciones con seguridad definida |                 100 % |
| Esquemas con descripción           | 100 % de los públicos |
| Ejemplos válidos                   |                 100 % |
| Módulos críticos documentados      |                 100 % |
| Entidades relevantes catalogadas   |                 100 % |
| Eventos relevantes documentados    |                 100 % |
| Enlaces internos válidos           |                 100 % |
| Reglas Redocly con error           |                     0 |
| Errores de compilación MkDocs      |                     0 |
| Marcadores TODO/TBD                |                     0 |
| Riesgos críticos abiertos          |                     0 |
| Runbooks críticos disponibles      |                 100 % |

Las métricas deben calcularse automáticamente cuando sea viable.

---

# 24. Orden obligatorio de ejecución

```text
1. Línea base
2. Auditoría Graphify
3. Inventario del sistema
4. Análisis de brechas
5. Corrección de inconsistencias bloqueantes
6. OpenAPI
7. Scalar
8. Redocly
9. MkDocs
10. Negocio y módulos
11. C4 y ADR
12. Datos
13. AsyncAPI
14. Seguridad
15. Observabilidad y operación
16. Pruebas y trazabilidad
17. CI/CD
18. Revisión visual y editorial
19. Auditoría final
20. Cierre con evidencia
```

No alterar este orden sin documentar el motivo mediante ADR o informe técnico.

---

# 25. Entregables finales

1. Portal MkDocs completamente compilable.
2. OpenAPI completo.
3. Scalar integrado.
4. Configuración Redocly.
5. AsyncAPI, cuando corresponda.
6. Workspace Structurizr.
7. ADR.
8. Catálogo de datos.
9. Catálogo de eventos.
10. Modelo de amenazas.
11. Runbooks.
12. Matriz de trazabilidad.
13. Scripts de validación.
14. Pipeline CI/CD documental.
15. Informe Graphify.
16. Informe de brechas.
17. Informe de preparación productiva.
18. Informe final con evidencias y resultados de cada comando.

---

# 26. Formato del informe final de ejecución

El informe final debe incluir:

```markdown
# Informe final de documentación del backend

## 1. Resumen ejecutivo
## 2. Estado inicial
## 3. Hallazgos de Graphify
## 4. Cambios realizados
## 5. Arquitectura documental implementada
## 6. Cobertura OpenAPI
## 7. Validaciones Redocly
## 8. Portal MkDocs
## 9. Arquitectura C4 y ADR
## 10. Catálogo de datos y eventos
## 11. Seguridad
## 12. Observabilidad y operación
## 13. Pruebas y CI/CD
## 14. Métricas finales
## 15. Evidencias de comandos ejecutados
## 16. Riesgos residuales
## 17. Declaración de preparación para producción
```

La declaración final debe ser una de estas dos:

* **APTO PARA PRODUCCIÓN**, con evidencia verificable.
* **NO APTO PARA PRODUCCIÓN**, señalando exactamente qué requisito bloquea el cierre.

No utilizar estados intermedios ambiguos.

---

# 27. Principio rector

La meta no es producir la mayor cantidad de páginas. La meta es crear una documentación que:

* refleje el sistema real;
* reduzca incertidumbre;
* acelere integración y mantenimiento;
* preserve decisiones;
* permita operar el backend;
* detecte desactualización automáticamente;
* y sea una parte inseparable de la calidad del producto.

**No declarar finalización por apariencia. Declarar finalización únicamente por cobertura, consistencia, automatización y evidencia.**
