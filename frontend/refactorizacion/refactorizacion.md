# Plan Maestro de Documentación Profesional del Frontend

> **Objetivo:** transformar la documentación del frontend en un sistema técnico completo, verificable, automatizado, navegable y preparado para producción, sin romper, sustituir ni alterar silenciosamente el comportamiento existente. La documentación deberá representar fielmente la aplicación real, comenzar por el análisis de Graphify y quedar integrada al ciclo de diseño, desarrollo, pruebas, accesibilidad, seguridad, rendimiento, despliegue y operación.

---

## 1. Mandato de ejecución

Actúa como **Arquitecto Frontend Senior, Technical Writer, especialista en arquitectura de interfaces, sistemas de diseño, accesibilidad, rendimiento web, seguridad del navegador, pruebas automatizadas y operación de aplicaciones productivas**.

Ejecuta este plan de principio a fin con evidencia verificable. No dejes tareas ambiguas, marcadores vacíos, archivos provisionales, secciones incompletas ni documentación desconectada del código real.

### Reglas obligatorias

1. Consultar Graphify y los artefactos de análisis existentes antes de crear o modificar documentación arquitectónica.
2. No asumir framework, estructura, patrones ni comportamiento: comprobarlos en el repositorio, configuración, dependencias, rutas, componentes, hooks, estado, pruebas, build y despliegue.
3. No documentar pantallas, flujos, permisos o integraciones inexistentes como si estuvieran implementados.
4. **No romper nada:** la documentación no autoriza cambios funcionales, visuales, contractuales ni arquitectónicos.
5. Separar expresamente tres tipos de trabajo:
   - `DOCUMENTAL`: no altera ejecución ni comportamiento.
   - `INSTRUMENTACIÓN SEGURA`: añade validaciones o generación documental sin afectar el producto.
   - `CAMBIO DE PRODUCTO`: modifica comportamiento, interfaz, contrato, dependencia o arquitectura y requiere autorización explícita.
6. No cambiar rutas, navegación, contratos API, nombres públicos, estados, permisos, estilos, componentes, almacenamiento, traducciones ni telemetría para hacerlos coincidir con la documentación.
7. Cuando documentación y código difieran, describir primero el comportamiento real y registrar la brecha. No “corregir” el producto silenciosamente.
8. Antes de cualquier modificación autorizada, crear una línea base reproducible y comprobarla después del cambio.
9. Mantener compatibilidad con el gestor de paquetes, versiones de Node, framework, convenciones y pipeline ya utilizados.
10. No actualizar dependencias, lockfiles, compiladores o herramientas principales salvo necesidad demostrada y autorización.
11. Preservar cambios existentes del usuario y no sobrescribir trabajo ajeno.
12. Toda afirmación técnica relevante debe rastrearse a código, configuración, diseño, prueba, contrato o despliegue.
13. La documentación debe versionarse junto al código.
14. Toda ruta, pantalla, flujo, componente compartido, permiso, integración, estado relevante y dependencia crítica debe contar con documentación suficiente.
15. La entrega solo se considera completa cuando pasan las validaciones automáticas y la revisión final de consistencia.

### Política de cero regresiones

Antes de editar cualquier archivo ejecutable:

1. Registrar el estado de Git y los cambios preexistentes.
2. Identificar los archivos exactos que se pretenden modificar.
3. Ejecutar instalación reproducible sin modificar el lockfile.
4. Ejecutar build, lint, type-check y pruebas existentes.
5. Registrar rutas y flujos críticos que funcionan.
6. Capturar evidencia visual de pantallas críticas cuando haya pruebas de navegador disponibles.
7. Verificar contratos consumidos desde el backend.
8. Definir cómo revertir exclusivamente los cambios propios.

Después de cada modificación autorizada:

1. Repetir la misma batería de validación.
2. Comparar resultados con la línea base.
3. Ejecutar pruebas de regresión sobre flujos afectados.
4. Revisar diferencias visuales intencionales y no intencionales.
5. Verificar que el bundle y las métricas críticas no hayan empeorado fuera del presupuesto aprobado.
6. Si aparece una regresión, detener la expansión del cambio, aislar la causa y restaurar únicamente el cambio propio.

Queda prohibido declarar “sin impacto” sin evidencia comparable antes/después.

---

# 2. Resultado esperado

Al finalizar, el frontend debe contar con:

- Portal técnico navegable y compilable.
- Inventario real de rutas, layouts, páginas y flujos.
- Catálogo de componentes, hooks, servicios, stores, providers y utilidades.
- Documentación del sistema de diseño y sus tokens.
- Catálogo de estados de interfaz: carga, vacío, error, éxito, bloqueo y permisos.
- Mapa de contratos e integraciones con backend y terceros.
- Arquitectura documentada mediante C4, dependencias y flujos.
- ADR para decisiones relevantes.
- Guías de desarrollo, pruebas, despliegue y troubleshooting.
- Documentación de accesibilidad conforme al estándar aplicable.
- Presupuestos y medición de rendimiento.
- Modelo de seguridad frontend y privacidad.
- Estrategia de pruebas unitarias, integración, componentes, E2E, visuales y contratos.
- Matriz de trazabilidad entre negocio, ruta, pantalla, componente, API y prueba.
- Validaciones documentales automáticas en CI/CD.
- Informe de preparación para producción.
- Evidencia de cero regresiones provocadas por el trabajo documental.

---

# 3. Arquitectura documental objetivo

```text
frontend/
├── docs/
│   ├── index.md
│   ├── getting-started/
│   │   ├── prerequisites.md
│   │   ├── local-setup.md
│   │   ├── environment-variables.md
│   │   ├── commands.md
│   │   ├── running-tests.md
│   │   └── troubleshooting.md
│   ├── business/
│   │   ├── business-context.md
│   │   ├── actors-and-roles.md
│   │   ├── capabilities.md
│   │   ├── user-journeys.md
│   │   ├── business-rules.md
│   │   └── glossary.md
│   ├── architecture/
│   │   ├── overview.md
│   │   ├── system-context.md
│   │   ├── containers.md
│   │   ├── frontend-layers.md
│   │   ├── module-dependencies.md
│   │   ├── rendering-strategy.md
│   │   ├── routing-and-navigation.md
│   │   ├── state-management.md
│   │   ├── data-flow.md
│   │   ├── error-boundaries.md
│   │   ├── integration-map.md
│   │   └── diagrams/
│   ├── routes/
│   │   └── <route-or-feature>/
│   │       ├── overview.md
│   │       ├── access-and-permissions.md
│   │       ├── user-flow.md
│   │       ├── states.md
│   │       ├── data-contracts.md
│   │       ├── components.md
│   │       ├── analytics.md
│   │       ├── accessibility.md
│   │       ├── tests.md
│   │       └── operational-notes.md
│   ├── components/
│   │   ├── catalog.md
│   │   ├── composition-rules.md
│   │   ├── props-and-events.md
│   │   ├── forms.md
│   │   ├── tables.md
│   │   ├── modals-and-overlays.md
│   │   ├── notifications.md
│   │   └── deprecation.md
│   ├── design-system/
│   │   ├── principles.md
│   │   ├── tokens.md
│   │   ├── typography.md
│   │   ├── colors.md
│   │   ├── spacing.md
│   │   ├── icons.md
│   │   ├── motion.md
│   │   ├── responsive-design.md
│   │   └── themes.md
│   ├── data-and-state/
│   │   ├── server-state.md
│   │   ├── client-state.md
│   │   ├── forms-and-validation.md
│   │   ├── caching.md
│   │   ├── persistence.md
│   │   ├── optimistic-updates.md
│   │   └── invalidation.md
│   ├── integrations/
│   │   ├── backend-api.md
│   │   ├── authentication.md
│   │   ├── file-storage.md
│   │   ├── realtime.md
│   │   ├── analytics.md
│   │   └── external-services.md
│   ├── accessibility/
│   │   ├── standard-and-scope.md
│   │   ├── keyboard.md
│   │   ├── focus-management.md
│   │   ├── screen-readers.md
│   │   ├── forms-and-errors.md
│   │   ├── color-and-contrast.md
│   │   └── audit-report.md
│   ├── security/
│   │   ├── frontend-security.md
│   │   ├── threat-model.md
│   │   ├── session-and-tokens.md
│   │   ├── browser-storage.md
│   │   ├── content-security-policy.md
│   │   ├── dependencies.md
│   │   ├── privacy.md
│   │   └── incident-response.md
│   ├── performance/
│   │   ├── budgets.md
│   │   ├── core-web-vitals.md
│   │   ├── bundle-analysis.md
│   │   ├── images-and-fonts.md
│   │   ├── rendering.md
│   │   └── monitoring.md
│   ├── observability/
│   │   ├── logging.md
│   │   ├── error-reporting.md
│   │   ├── tracing.md
│   │   ├── web-vitals.md
│   │   ├── analytics-events.md
│   │   └── dashboards-and-alerts.md
│   ├── operations/
│   │   ├── environments.md
│   │   ├── build.md
│   │   ├── deployment.md
│   │   ├── configuration.md
│   │   ├── feature-flags.md
│   │   ├── rollback.md
│   │   ├── cache-and-cdn.md
│   │   └── runbooks/
│   ├── testing/
│   │   ├── strategy.md
│   │   ├── unit-tests.md
│   │   ├── component-tests.md
│   │   ├── integration-tests.md
│   │   ├── e2e-tests.md
│   │   ├── visual-regression.md
│   │   ├── contract-tests.md
│   │   ├── accessibility-tests.md
│   │   └── test-data.md
│   ├── adr/
│   │   ├── index.md
│   │   └── ADR-XXXX-*.md
│   ├── governance/
│   │   ├── ownership.md
│   │   ├── documentation-policy.md
│   │   ├── review-process.md
│   │   ├── change-management.md
│   │   ├── zero-regression-policy.md
│   │   └── traceability-matrix.md
│   └── reports/
│       ├── baseline.md
│       ├── graphify-audit.md
│       ├── documentation-gap-analysis.md
│       ├── accessibility-audit.md
│       ├── performance-audit.md
│       ├── regression-validation.md
│       ├── production-readiness.md
│       └── final-validation.md
├── structurizr/
│   └── workspace.dsl
├── mkdocs.yml
├── storybook/                  # Solo si Storybook existe o se aprueba incorporarlo
└── scripts/
    ├── generate-route-inventory.*
    ├── generate-component-inventory.*
    ├── check-doc-links.*
    ├── check-doc-coverage.*
    ├── check-api-contract-drift.*
    ├── check-bundle-budget.*
    └── generate-doc-report.*
```

La estructura debe adaptarse al repositorio real. No crear carpetas vacías ni introducir Storybook, MkDocs u otra dependencia si su incorporación rompe restricciones existentes o no fue aprobada.

---

# 4. Fase 0 — Preparación, inventario y protección

## Objetivo

Preparar el trabajo sin alterar prematuramente la aplicación y establecer una línea base reproducible.

## Actividades

1. Identificar:
   - framework, versión y estrategia de renderizado;
   - gestor de paquetes y versión de Node;
   - estructura del repositorio o monorepo;
   - rutas, layouts y puntos de entrada;
   - arquitectura por features, capas o atomic design;
   - sistema de estilos y componentes;
   - estado global y estado de servidor;
   - cliente HTTP y contratos;
   - autenticación y autorización;
   - internacionalización;
   - formularios y validación;
   - analítica, logs y captura de errores;
   - pruebas y despliegue.

2. Inspeccionar instrucciones locales, convenciones, README, ADR, configuración y documentación existente.

3. Ejecutar la línea base con comandos reales:
   - instalación limpia y reproducible;
   - build de producción;
   - lint;
   - type-check;
   - pruebas unitarias;
   - pruebas de componentes e integración;
   - pruebas E2E, si existen;
   - auditoría de dependencias;
   - análisis de bundle, si existe;
   - pruebas de accesibilidad y Lighthouse, si existen.

4. Registrar:
   - comando;
   - versión de herramienta;
   - resultado;
   - duración;
   - errores existentes;
   - cobertura disponible;
   - métricas iniciales;
   - cambios preexistentes no atribuibles a este trabajo.

5. Generar `docs/reports/baseline.md`.

6. No continuar silenciosamente ante fallos. Cada fallo debe registrarse como preexistente, corregirse únicamente con autorización o quedar identificado como bloqueo.

## Criterio de salida

- Repositorio instalable o limitación exacta documentada.
- Línea base reproducible.
- Cero archivos funcionales modificados durante el diagnóstico.
- Riesgos y cambios preexistentes diferenciados.

---

# 5. Fase 1 — Graphify como primera fuente de descubrimiento

## Objetivo

Usar Graphify para comprender la estructura real antes de diseñar la documentación definitiva.

## Fuentes mínimas

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

1. Inventariar nodos:
   - rutas y páginas;
   - layouts;
   - features;
   - componentes;
   - hooks;
   - stores;
   - providers y contexts;
   - servicios y clientes API;
   - schemas y tipos;
   - utilidades;
   - assets;
   - pruebas;
   - configuración.

2. Inventariar relaciones:
   - imports;
   - composición;
   - llamadas API;
   - lectura y escritura de estado;
   - navegación;
   - dependencias circulares;
   - componentes de alta centralidad;
   - código huérfano;
   - duplicación relevante.

3. Contrastar Graphify con:
   - árbol real del repositorio;
   - router;
   - manifiestos y configuración del framework;
   - cliente API y OpenAPI del backend;
   - pruebas;
   - sistema de diseño;
   - configuración de build y despliegue.

4. Generar:

```text
docs/reports/graphify-audit.md
docs/architecture/module-dependencies.md
docs/architecture/integration-map.md
docs/governance/traceability-matrix.md
```

## Criterio de salida

Ninguna documentación arquitectónica definitiva se crea sin el informe Graphify. Si Graphify no existe o no soporta adecuadamente el stack, documentar la limitación y complementar con análisis estático reproducible sin modificar producción.

---

# 6. Fase 2 — Inventario funcional del frontend

## Objetivo

Construir una fotografía verificable de lo que el usuario puede ver y hacer.

## Inventarios obligatorios

### Rutas y navegación

Por cada ruta:

- patrón y parámetros;
- layout;
- propósito de negocio;
- acceso público o protegido;
- roles y permisos;
- redirecciones;
- carga diferida;
- fuentes de datos;
- estados de interfaz;
- título, metadatos y SEO cuando corresponda;
- pruebas existentes.

### Pantallas y flujos

Por cada pantalla:

- actor;
- objetivo;
- precondiciones;
- acciones disponibles;
- validaciones;
- estados de carga, vacío, error y éxito;
- comportamiento responsivo;
- accesibilidad;
- endpoints consumidos;
- analítica emitida;
- fallos y recuperación.

### Componentes compartidos

Inventariar formularios, tablas, modales, campos, botones, navegación, notificaciones, overlays, loaders, empty states, errores y otros elementos repetidos. Registrar reutilización real sin moverlos ni refactorizarlos durante esta fase.

## Entregables

```text
docs/routes/route-catalog.md
docs/business/user-journeys.md
docs/components/catalog.md
docs/reports/frontend-inventory.md
```

## Criterio de salida

El inventario cubre el 100 % de rutas registradas y diferencia claramente lo implementado, lo inaccesible, lo obsoleto y lo planificado.

---

# 7. Fase 3 — Análisis de brechas documentales

Crear `docs/reports/documentation-gap-analysis.md` con:

| ID | Área | Elemento real | Evidencia | Estado | Brecha | Riesgo | Acción documental | ¿Cambia producto? | Validación | Estado final |
|---|---|---|---|---|---|---|---|---|---|---|

## Áreas mínimas

- Negocio y journeys.
- Rutas y navegación.
- Arquitectura.
- Componentes y diseño.
- Datos y estado.
- Integraciones.
- Accesibilidad.
- Seguridad y privacidad.
- Rendimiento.
- Pruebas.
- Observabilidad.
- Operación y despliegue.
- Gobierno.

## Clasificación

- `BLOCKER`: impide afirmar preparación productiva.
- `CRITICAL`: riesgo alto de seguridad, acceso, pérdida de flujo o integración.
- `HIGH`: ausencia relevante de trazabilidad o mantenibilidad.
- `MEDIUM`: mejora necesaria no bloqueante.
- `LOW`: optimización editorial o visual.

Toda acción que cambie producto debe quedar como propuesta separada, con impacto, pruebas requeridas y autorización pendiente. La documentación puede completarse describiendo el comportamiento actual sin ejecutar esa propuesta.

---

# 8. Fase 4 — Arquitectura, límites y dependencias

## Objetivo

Explicar cómo está organizado el frontend y cómo circulan navegación, datos y eventos.

## Documentar

- contexto del sistema;
- aplicación, CDN, navegador, backend y terceros;
- capas reales;
- límites por dominio o feature;
- ciclo de renderizado;
- Server Components y Client Components, si aplica;
- SSR, SSG, ISR, CSR y streaming, si aplican;
- routing y layouts;
- autenticación y guardas de navegación;
- estado local, global y remoto;
- formularios y validación;
- manejo de errores y error boundaries;
- carga diferida y división de código;
- dependencias circulares y excepciones.

## Diagramas mínimos

1. Contexto C4.
2. Contenedores.
3. Componentes por dominio crítico.
4. Flujo de navegación.
5. Flujo de autenticación.
6. Flujo de datos navegador–frontend–backend.
7. Manejo de errores.
8. Despliegue y entrega de assets.

Usar Structurizr DSL como fuente oficial y Mermaid para secuencias. Los diagramas deben coincidir con Graphify y el código.

---

# 9. Fase 5 — Catálogo de componentes y sistema de diseño

## Objetivo

Documentar la interfaz reutilizable sin forzar una refactorización.

## Por cada componente compartido

- nombre y ubicación;
- nivel real: átomo, molécula, organismo, template o feature, si el proyecto usa atomic design;
- propósito;
- props y tipos;
- valores por defecto;
- eventos y callbacks;
- slots o composición;
- dependencias;
- variantes;
- estados visuales;
- comportamiento responsivo;
- requisitos de accesibilidad;
- ejemplos válidos;
- usos actuales;
- pruebas;
- estado: activo, legado, experimental u obsoleto.

## Sistema de diseño

Documentar tokens, colores, tipografía, espaciado, bordes, sombras, iconos, breakpoints, temas, movimiento y reglas de contraste.

## Storybook o catálogo equivalente

- Reutilizarlo si ya existe.
- Si no existe, proponer su incorporación por separado.
- No instalarlo ni modificar el build sin aprobación y prueba aislada.
- Las stories no deben depender de datos productivos ni secretos.

## Criterio de salida

Los componentes compartidos críticos están catalogados y sus variantes principales pueden comprenderse sin inspeccionar toda la aplicación.

---

# 10. Fase 6 — Rutas, journeys y estados de interfaz

## Por cada journey crítico

Documentar:

1. Problema de negocio.
2. Actor y rol.
3. Punto de entrada.
4. Precondiciones.
5. Secuencia de pantallas.
6. Acciones y decisiones.
7. Reglas y validaciones.
8. Datos leídos o modificados.
9. APIs involucradas.
10. Estados de carga, vacío, error, éxito y reintento.
11. Permisos y redirecciones.
12. Persistencia local.
13. Eventos analíticos.
14. Accesibilidad.
15. Pruebas y evidencia.

No inferir journeys desde nombres de archivos únicamente. Verificarlos mediante rutas, código, pruebas y, cuando sea seguro, ejecución local.

---

# 11. Fase 7 — Contratos con backend e integraciones

## Objetivo

Evitar que el frontend dependa de contratos implícitos.

## Documentar por operación consumida

- endpoint o canal;
- método;
- servicio o función cliente;
- pantallas consumidoras;
- autenticación;
- parámetros;
- request;
- response;
- modelo de error;
- cancelación y timeout;
- reintentos;
- cache e invalidación;
- transformación de datos;
- manejo de respuestas parciales;
- fallback;
- tipos generados o manuales;
- prueba de contrato.

## Reglas

1. Comparar clientes y tipos con el OpenAPI real del backend cuando esté disponible.
2. No modificar backend ni frontend para ocultar divergencias.
3. Registrar drift contractual con severidad e impacto.
4. No incluir tokens, secretos, datos personales ni hosts internos en ejemplos.
5. Documentar WebSockets, SSE, polling, subida de archivos y proveedores externos cuando existan.

## Criterio de salida

Cada integración crítica puede rastrearse desde la pantalla hasta el contrato y su prueba.

---

# 12. Fase 8 — Estado, formularios y flujo de datos

## Documentar

- estado local;
- contextos y providers;
- store global;
- estado remoto;
- claves de consulta;
- cache;
- invalidación;
- optimistic updates;
- rollback de mutaciones;
- persistencia en storage;
- hidratación;
- valores derivados;
- formularios;
- schemas de validación;
- errores de campo y formulario;
- prevención de envíos duplicados;
- datos intermedios y temporales.

## Por cada store o contexto crítico

- responsabilidad;
- estado inicial;
- acciones;
- selectores;
- consumidores;
- persistencia;
- datos sensibles;
- reinicio de sesión;
- concurrencia;
- pruebas.

La documentación debe diferenciar estado del servidor, estado del cliente, estado de URL y estado temporal de formulario.

---

# 13. Fase 9 — Accesibilidad

## Objetivo

Documentar y verificar accesibilidad sin alterar el diseño de manera no autorizada.

## Estándar

Usar WCAG 2.2 nivel AA o el estándar contractual aplicable. Registrar cualquier excepción.

## Revisar

- estructura semántica;
- navegación por teclado;
- orden de foco;
- focus traps y restauración de foco;
- nombres accesibles;
- formularios y mensajes de error;
- contraste;
- zoom y reflow;
- lectores de pantalla;
- contenido dinámico y live regions;
- movimiento reducido;
- targets táctiles;
- tablas y gráficos;
- modales, popovers y menús;
- internacionalización.

## Evidencias

- auditoría automatizada;
- revisión manual de teclado;
- pruebas de componentes críticos;
- lista de incumplimientos reales;
- severidad;
- propuesta de corrección separada.

No realizar rediseños silenciosos para mejorar métricas. Toda corrección que altere UI o comportamiento requiere validación funcional y visual.

---

# 14. Fase 10 — Rendimiento y experiencia de carga

## Documentar

- estrategia de renderizado;
- Core Web Vitals;
- tamaño de bundles;
- división de código;
- waterfalls de red;
- cache del navegador y CDN;
- imágenes;
- fuentes;
- scripts de terceros;
- hidratación;
- listas extensas;
- memoización justificada;
- precarga y prefetch;
- skeletons y estados de carga.

## Presupuestos

Definir objetivos basados en la línea base y necesidades del proyecto para:

- LCP;
- INP;
- CLS;
- JavaScript inicial;
- CSS inicial;
- peso de imágenes;
- número de solicitudes críticas;
- tiempo de build.

No “optimizar” eliminando funcionalidad, accesibilidad, validaciones o telemetría obligatoria. Las recomendaciones deben priorizar impacto medido.

---

# 15. Fase 11 — Seguridad frontend y privacidad

## Contenido obligatorio

- activos y datos sensibles;
- fronteras de confianza;
- autenticación;
- renovación y expiración de sesión;
- almacenamiento de tokens;
- autorización en interfaz y aclaración de que el backend es la autoridad;
- XSS y renderizado de contenido;
- CSRF cuando aplique;
- CSP;
- CORS desde la perspectiva del cliente;
- clickjacking;
- open redirects;
- dependencias y supply chain;
- source maps;
- variables públicas y privadas;
- subida y descarga de archivos;
- enlaces externos;
- privacidad y consentimiento;
- redacción de logs y analítica.

## Modelo de amenazas

Usar STRIDE o metodología equivalente y registrar amenaza, activo, probabilidad, impacto, mitigación, evidencia y riesgo residual.

Nunca mover secretos al frontend ni documentar como seguras restricciones puramente visuales. Ocultar un botón no reemplaza autorización del servidor.

---

# 16. Fase 12 — Observabilidad y analítica

## Documentar

- captura de excepciones;
- error boundaries;
- errores de red;
- contexto de release y ambiente;
- correlación con backend;
- web vitals;
- navegación y journeys;
- eventos analíticos;
- consentimiento;
- reglas de datos personales;
- sampling;
- dashboards y alertas.

## Catálogo de eventos analíticos

Por evento:

- nombre;
- propósito;
- disparador;
- propiedades;
- tipos;
- datos prohibidos;
- consentimiento requerido;
- consumidor;
- prueba;
- propietario.

No añadir telemetría nueva como parte implícita de la documentación.

---

# 17. Fase 13 — Estrategia de pruebas

## Capas

- unitarias para lógica pura;
- hooks y stores;
- componentes;
- integración de features;
- E2E de journeys críticos;
- contratos API;
- regresión visual;
- accesibilidad;
- rendimiento;
- smoke de despliegue.

## Matriz obligatoria

| Journey | Ruta | Componentes | API | Roles | Unitarias | Integración | E2E | Visual | A11y | Estado |
|---|---|---|---|---|---|---|---|---|---|---|

## Reglas

1. No reescribir pruebas para ocultar fallos.
2. No actualizar snapshots masivamente sin inspección.
3. Diferenciar baseline preexistente de regresiones nuevas.
4. Usar datos sintéticos y deterministas.
5. No llamar servicios productivos desde pruebas.
6. Probar estados negativos, latencia, errores, permisos y expiración de sesión.

## Criterio de salida

Cada journey crítico tiene al menos una validación E2E o una justificación formal, y los componentes compartidos críticos tienen cobertura suficiente.

---

# 18. Fase 14 — Operación, despliegue y runbooks

## Documentar

- ambientes;
- variables;
- build y artefactos;
- despliegue;
- CDN y cache;
- dominios;
- headers;
- source maps;
- feature flags;
- migración de configuración;
- rollback;
- smoke post-despliegue;
- compatibilidad de navegadores;
- mantenimiento.

## Runbooks mínimos

- aplicación no carga;
- pantalla en blanco;
- chunks desactualizados o fallidos;
- backend no disponible;
- autenticación en bucle;
- CORS bloqueando solicitudes;
- assets o imágenes no disponibles;
- variables de entorno incorrectas;
- error de hidratación;
- aumento de errores del navegador;
- degradación de Core Web Vitals;
- rollback de release.

Cada runbook debe incluir síntoma, impacto, diagnóstico seguro, evidencia, mitigación, rollback y escalamiento.

---

# 19. Fase 15 — ADR y gobierno de decisiones

## ADR mínimos cuando correspondan

- framework y versión;
- routing;
- renderizado;
- organización por features o capas;
- atomic design;
- sistema de estilos;
- design system;
- estado global;
- server state;
- cliente API y generación de tipos;
- formularios y validación;
- autenticación;
- internacionalización;
- pruebas;
- observabilidad;
- despliegue;
- compatibilidad de navegadores;
- estrategia de deprecación.

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

No crear ADR retroactivos con razonamientos inventados. Si no existe evidencia histórica, indicar que documenta el estado observado.

---

# 20. Fase 16 — Portal técnico y referencia viva

## Objetivo

Unificar documentación para desarrollo, QA, diseño, seguridad, producto y operaciones.

## MkDocs Material o equivalente

- Reutilizar la herramienta existente cuando la haya.
- Proponer incorporación aislada si no existe.
- Navegación jerárquica.
- Búsqueda.
- Mermaid.
- enlaces a Storybook o catálogo equivalente;
- enlaces al OpenAPI/Scalar del backend;
- validación estricta de enlaces;
- buen comportamiento móvil;
- versión y propietario visibles.

## Página inicial

- propósito del producto;
- stack verificado;
- journeys principales;
- diagrama de contexto;
- inicio local;
- catálogo de rutas;
- componentes;
- integraciones;
- pruebas;
- despliegue;
- incidentes;
- propietarios;
- versión documentada.

El portal documental debe construirse de forma separada al bundle productivo salvo decisión arquitectónica explícita.

---

# 21. Fase 17 — CI/CD documental y controles de cambio

## Pipeline mínimo

```text
Instalación reproducible
  → verificación de lockfile
  → lint
  → type-check
  → pruebas
  → build de producción
  → inventario de rutas y componentes
  → verificación de drift API
  → pruebas de accesibilidad
  → presupuesto de bundle
  → construcción de diagramas
  → construcción documental estricta
  → revisión de enlaces
  → análisis de secretos
  → smoke de artefacto
  → publicación
```

## Controles de cambio

- Cambios en rutas, props públicas, componentes compartidos, stores, contratos, permisos, eventos analíticos o variables deben actualizar documentación asociada.
- Añadir checklist documental a pull requests.
- Asignar propietarios con CODEOWNERS cuando exista ese mecanismo.
- Detectar breaking changes en componentes y contratos.
- Evitar que la generación documental reescriba código fuente.
- Ejecutar herramientas nuevas en modo no destructivo y con versiones fijadas.
- No hacer que CI falle por deuda preexistente sin una estrategia de adopción acordada; sí impedir nuevas regresiones.

## Criterio de salida

El pipeline detecta desactualización documental y regresiones nuevas sin bloquear el equipo por hallazgos históricos no gobernados.

---

# 22. Fase 18 — Experiencia visual y editorial

## Reglas

- Español técnico claro o idioma oficial del proyecto.
- Términos consistentes con la interfaz real.
- Glosario común entre frontend y backend.
- Capturas actualizadas solo cuando aporten información.
- Ejemplos reales, seguros y reproducibles.
- Diagramas con propósito.
- Cero texto de relleno.
- Separar comportamiento actual, decisión, riesgo y recomendación.
- Añadir versión y fecha de evidencia.
- No usar capturas con datos personales, tokens o ambientes internos.
- Proporcionar texto alternativo a imágenes documentales.

La documentación no debe rediseñar el producto. Las propuestas visuales pertenecen a un backlog separado.

---

# 23. Fase 19 — Auditoría final de preparación para producción

Crear:

```text
docs/reports/regression-validation.md
docs/reports/production-readiness.md
docs/reports/final-validation.md
```

## Checklist obligatorio

### Protección

- [ ] Se registró el estado inicial del repositorio.
- [ ] Se preservaron cambios preexistentes.
- [ ] No se modificó comportamiento sin autorización.
- [ ] Build, lint, tipos y pruebas posteriores son iguales o mejores que la línea base.
- [ ] Toda diferencia visual fue revisada y autorizada.
- [ ] No se actualizaron dependencias ni lockfiles innecesariamente.
- [ ] Existe evidencia de rollback de los cambios propios.

### Graphify y arquitectura

- [ ] Se consultaron artefactos relevantes.
- [ ] Rutas, componentes y dependencias fueron inventariados.
- [ ] Se revisaron ciclos, huérfanos y alta centralidad.
- [ ] Diagramas y código son coherentes.

### Producto y rutas

- [ ] El 100 % de rutas registradas está documentado.
- [ ] Journeys críticos están documentados.
- [ ] Roles, permisos y redirecciones están descritos.
- [ ] Estados de carga, vacío, error y éxito están cubiertos.

### Componentes y diseño

- [ ] Componentes compartidos críticos están catalogados.
- [ ] Props, eventos, variantes y estados están documentados.
- [ ] Tokens y reglas responsivas están documentados.
- [ ] Componentes legados u obsoletos están identificados.

### Integraciones y estado

- [ ] APIs consumidas están trazadas.
- [ ] Drift contractual fue verificado.
- [ ] Stores, providers, cache e invalidación están documentados.
- [ ] Datos sensibles en storage están identificados.

### Calidad

- [ ] Pruebas críticas pasan.
- [ ] Accesibilidad fue auditada.
- [ ] Rendimiento tiene línea base y presupuesto.
- [ ] Regresión visual fue revisada cuando aplica.
- [ ] No existen enlaces documentales rotos.
- [ ] No hay páginas vacías ni TODO/TBD en la entrega final.

### Seguridad y operación

- [ ] Modelo de amenazas completado.
- [ ] Tokens, almacenamiento, CSP y privacidad documentados.
- [ ] Despliegue, cache y rollback documentados.
- [ ] Runbooks críticos disponibles.
- [ ] Observabilidad y correlación con backend documentadas.

---

# 24. Definición de terminado

El proyecto documental se considera terminado únicamente cuando:

1. La línea base fue registrada sin alterar el producto.
2. Graphify fue analizado y contrastado con el repositorio.
3. El 100 % de rutas registradas está inventariado.
4. Journeys, estados y permisos críticos están documentados.
5. Componentes compartidos y sistema de diseño están catalogados.
6. Arquitectura, renderizado, routing y estado coinciden con el sistema real.
7. Integraciones y contratos consumidos son trazables.
8. Accesibilidad, seguridad, privacidad y rendimiento tienen auditoría.
9. Pruebas, despliegue, observabilidad y runbooks están documentados.
10. Existe trazabilidad entre negocio, ruta, componente, API y prueba.
11. CI/CD impide nuevas regresiones documentales.
12. El portal compila sin enlaces rotos.
13. No quedan TODO, TBD, “pendiente” ni secciones vacías.
14. Toda limitación real está formalmente registrada.
15. No existe regresión atribuible al trabajo ejecutado.

---

# 25. Métricas de calidad

| Métrica | Objetivo |
|---|---:|
| Rutas registradas documentadas | 100 % |
| Journeys críticos documentados | 100 % |
| Pantallas críticas con estados documentados | 100 % |
| Componentes compartidos críticos catalogados | 100 % |
| Integraciones críticas trazadas | 100 % |
| Stores/providers críticos documentados | 100 % |
| Flujos críticos con prueba | 100 % o excepción formal |
| Incumplimientos críticos de accesibilidad abiertos | 0 para declarar aptitud |
| Riesgos críticos de seguridad abiertos | 0 para declarar aptitud |
| Regresiones nuevas de build, tipos, lint o pruebas | 0 |
| Regresiones visuales no aprobadas | 0 |
| Drift contractual crítico sin registrar | 0 |
| Enlaces internos válidos | 100 % |
| Errores de compilación documental | 0 |
| Marcadores TODO/TBD | 0 |
| Runbooks críticos disponibles | 100 % |

Las métricas deben automatizarse cuando sea viable, sin introducir inestabilidad al producto.

---

# 26. Orden obligatorio de ejecución

```text
1. Protección del repositorio y línea base
2. Auditoría Graphify
3. Inventario de rutas, pantallas y componentes
4. Análisis de brechas
5. Arquitectura y dependencias
6. Journeys y estados de interfaz
7. Componentes y sistema de diseño
8. Contratos e integraciones
9. Estado, formularios y flujo de datos
10. Accesibilidad
11. Rendimiento
12. Seguridad y privacidad
13. Observabilidad y analítica
14. Pruebas y trazabilidad
15. Operación, despliegue y runbooks
16. ADR y gobierno
17. Portal técnico
18. CI/CD documental
19. Revisión editorial
20. Regresión completa y auditoría final
```

No alterar este orden sin justificarlo. Las correcciones funcionales detectadas no forman parte automática de este plan: deben proponerse, autorizarse, implementarse de manera aislada y validarse por separado.

---

# 27. Entregables finales

1. Portal documental compilable.
2. Informe de línea base.
3. Auditoría Graphify.
4. Inventario de rutas, páginas, layouts y journeys.
5. Catálogo de componentes y sistema de diseño.
6. Arquitectura C4 y diagramas de flujo.
7. Documentación de estado y datos.
8. Mapa de contratos e integraciones.
9. Informe de accesibilidad.
10. Informe y presupuestos de rendimiento.
11. Modelo de amenazas y privacidad.
12. Catálogo de observabilidad y analítica.
13. Estrategia y matriz de pruebas.
14. Runbooks de operación.
15. ADR.
16. Matriz de trazabilidad.
17. Scripts de validación no destructivos.
18. Pipeline documental.
19. Informe de regresión.
20. Informe final de preparación productiva.

---

# 28. Formato del informe final

```markdown
# Informe final de documentación del frontend

## 1. Resumen ejecutivo
## 2. Alcance y política de cero regresiones
## 3. Estado inicial
## 4. Hallazgos de Graphify
## 5. Inventario de rutas y journeys
## 6. Arquitectura documentada
## 7. Componentes y sistema de diseño
## 8. Datos, estado y formularios
## 9. Contratos e integraciones
## 10. Accesibilidad
## 11. Rendimiento
## 12. Seguridad y privacidad
## 13. Observabilidad y analítica
## 14. Pruebas y CI/CD
## 15. Operación y despliegue
## 16. Validación de regresiones
## 17. Métricas finales
## 18. Evidencias de comandos
## 19. Riesgos residuales
## 20. Declaración de preparación para producción
```

La declaración final debe ser una de estas:

- **APTO PARA PRODUCCIÓN**, con evidencia verificable y cero regresiones atribuibles al trabajo.
- **NO APTO PARA PRODUCCIÓN**, indicando exactamente los requisitos bloqueantes.

No utilizar estados ambiguos ni afirmar aptitud basándose solamente en que el build finaliza.

---

# 29. Instrucción ejecutiva lista para usar

```text
Ejecuta el Plan Maestro de Documentación Profesional del Frontend completo.

Tu prioridad absoluta es documentar el sistema real sin romper nada. Comienza con una línea base reproducible y con el análisis de Graphify. No asumas framework, arquitectura, rutas, contratos, componentes, roles ni comportamiento. Compruébalos en el repositorio y deja evidencia.

Por defecto, realiza únicamente cambios documentales y validaciones no destructivas. No cambies comportamiento, UI, rutas, navegación, contratos API, permisos, estado, estilos, dependencias, lockfiles, configuración productiva ni pruebas para hacerlas pasar. Si detectas una brecha funcional o arquitectónica, regístrala como propuesta separada con impacto, riesgo, archivos afectados, pruebas necesarias y plan de rollback. No la implementes sin autorización explícita.

Preserva todos los cambios preexistentes del repositorio. Antes y después de cada cambio autorizado, ejecuta la misma batería de build, lint, type-check y pruebas. Compara resultados, revisa regresiones visuales y contractuales, y documenta la evidencia. Si introduces una regresión, detente y revierte exclusivamente tu cambio.

Completa todos los entregables, valida enlaces y cobertura, elimina contenido provisional y concluye únicamente con APTO PARA PRODUCCIÓN o NO APTO PARA PRODUCCIÓN, sustentado en evidencia verificable.
```

---

# 30. Principio rector

La meta no es producir más páginas ni reorganizar el frontend por apariencia. La meta es crear documentación que:

- refleje el producto real;
- explique el valor de cada flujo;
- haga visibles rutas, estados, permisos y dependencias;
- conecte interfaz, API y pruebas;
- mejore accesibilidad, seguridad y operación mediante evidencia;
- detecte desactualización automáticamente;
- preserve decisiones;
- y no introduzca regresiones.

**Documentar primero. Proponer por separado. Modificar únicamente con autorización. Validar siempre antes y después.**
