# Plan maestro de auditoría, refactorización y optimización integral del frontend con Turbopack

## Rol y responsabilidad

Actúa como arquitecto frontend senior, especialista en experiencia de usuario, diseño de interfaces, accesibilidad, rendimiento web, Next.js, React, TypeScript y Turbopack.

Debes auditar, planificar, refactorizar, implementar, probar y documentar integralmente el frontend actual.

No debes limitarte a realizar recomendaciones, cambiar colores, modificar algunos componentes aislados o crear una nueva apariencia superficial. Debes trabajar directamente sobre el proyecto, conservar las funcionalidades existentes, corregir inconsistencias técnicas y visuales y dejar una aplicación profesional, escalable, mantenible, accesible y optimizada.

La implementación debe realizarse por fases verificables y basarse en el código, las pantallas, los flujos, los contratos y los requerimientos reales del proyecto.

---

# 1. Objetivo general

Refactorizar integralmente el frontend construido con Next.js y Turbopack para conseguir:

* Una experiencia visual moderna y profesional.
* Navegación clara y consistente.
* Diseño responsive real.
* Arquitectura de componentes reutilizables.
* Excelente rendimiento.
* Carga progresiva y eficiente.
* Accesibilidad.
* Estados completos de carga, error, vacío y éxito.
* Formularios confiables.
* Integración estable con el backend.
* Código limpio y mantenible.
* Compatibilidad completa con Turbopack.
* Escalabilidad para nuevas funcionalidades.
* Reducción de duplicación.
* Pruebas automatizadas.
* Documentación técnica y visual.

El resultado final debe sentirse como un producto digital terminado y no como una plantilla genérica o una colección de pantallas independientes.

---

# 2. Alcance obligatorio

Revisa y mejora, cuando existan:

* Página de inicio.
* Login.
* Registro.
* Recuperación de contraseña.
* Verificación de cuenta.
* Autenticación multifactor.
* Dashboard.
* Navegación principal.
* Sidebar.
* Header.
* Breadcrumbs.
* Menús.
* Tablas.
* Formularios.
* Modales.
* Drawers.
* Tarjetas.
* Gráficos.
* Diagramas.
* Listados.
* Buscadores.
* Filtros.
* Paginación.
* Tabs.
* Steps.
* Wizards.
* Notificaciones.
* Alertas.
* Tooltips.
* Confirmaciones.
* Estados vacíos.
* Pantallas de error.
* Pantallas de carga.
* Skeletons.
* Landing pages.
* Perfil.
* Configuración.
* Vistas administrativas.
* Flujos operativos.
* Componentes compartidos.
* Integraciones con APIs.
* Rutas protegidas.
* Manejo de permisos.
* Carga de archivos.
* Descarga de documentos.
* Exportación de información.
* Experiencia móvil.
* Accesibilidad.
* SEO, cuando corresponda.
* Observabilidad y manejo de errores.

---

# 3. Principios obligatorios

Toda la implementación debe respetar estos principios:

1. No romper funcionalidades existentes.
2. No modificar contratos con el backend sin revisar el impacto.
3. No eliminar lógica funcional por razones visuales.
4. No crear una interfaz bonita pero difícil de utilizar.
5. No usar componentes diferentes para resolver el mismo patrón.
6. No duplicar formularios, tablas, modales, filtros o notificaciones.
7. No crear componentes excesivamente grandes.
8. No crear archivos de más de 300 líneas salvo justificación técnica.
9. No utilizar `any` de forma indiscriminada.
10. No ocultar errores de TypeScript.
11. No desactivar reglas de lint para evitar corregir problemas.
12. No introducir dependencias sin justificar su necesidad.
13. No utilizar estilos inline salvo casos estrictamente necesarios.
14. No usar datos simulados para ocultar integraciones incompletas.
15. No introducir animaciones que afecten el rendimiento.
16. No convertir todos los componentes en Client Components.
17. No utilizar `useEffect` para lógica que pueda resolverse de forma declarativa.
18. No realizar solicitudes duplicadas.
19. No almacenar datos sensibles en el navegador.
20. No exponer variables privadas mediante prefijos públicos.
21. No declarar una fase como completada sin validar sus criterios.
22. Documentar toda decisión arquitectónica importante.
23. Priorizar claridad, consistencia, rendimiento y mantenibilidad.
24. Mantener compatibilidad completa con Turbopack.
25. Preservar el comportamiento funcional actual salvo correcciones justificadas.

---

# 4. Resultado esperado

Al finalizar, el frontend debe contar con:

* Sistema de diseño consistente.
* Componentes reutilizables.
* Arquitectura clara.
* Navegación coherente.
* Diseño responsive.
* Accesibilidad.
* Integración estable con el backend.
* Manejo centralizado de errores.
* Formularios validados.
* Estados visuales completos.
* Rendimiento medido y optimizado.
* Compatibilidad con Turbopack.
* Pruebas unitarias.
* Pruebas de integración.
* Pruebas end-to-end.
* Documentación.
* Evidencias visuales.
* Comparación antes y después.
* Registro de decisiones técnicas.
* Inventario de riesgos y pendientes reales.

---

# 5. Metodología de ejecución

Trabaja por fases consecutivas.

Antes de cada fase:

1. Revisa el estado actual.
2. Identifica dependencias.
3. Define los archivos afectados.
4. Establece criterios de aceptación.
5. Identifica riesgos de regresión.
6. Define cómo se validarán los cambios.

Después de cada fase:

1. Ejecuta pruebas.
2. Corrige errores.
3. Documenta decisiones.
4. Actualiza el registro de riesgos.
5. Registra archivos creados y modificados.
6. Comprueba que no existan regresiones.
7. Confirma los criterios de aceptación.

No avances dejando errores evitables sin resolver.

---

# FASE 0. Protección inicial y línea base

## Objetivo

Conocer el estado real del frontend antes de modificarlo.

## Actividades

1. Identificar:

   * Versión de Next.js.
   * Versión de React.
   * Versión de TypeScript.
   * Versión de Node.js.
   * Administrador de paquetes.
   * Estado de Turbopack.
   * Librerías visuales.
   * Librerías de formularios.
   * Librerías de estado.
   * Librerías de solicitudes HTTP.
   * Librerías de pruebas.
   * Librerías de gráficos.
   * Librerías de animaciones.
2. Ejecutar la aplicación sin modificaciones.
3. Ejecutar:

   * Build.
   * Lint.
   * Type check.
   * Pruebas existentes.
4. Registrar:

   * Tiempo de instalación.
   * Tiempo de arranque.
   * Tiempo de build.
   * Tamaño de bundles.
   * Errores de consola.
   * Advertencias.
   * Solicitudes duplicadas.
   * Errores de hidratación.
   * Pantallas rotas.
   * Problemas responsive.
5. Capturar evidencia de las pantallas principales.
6. Crear una línea base visual y técnica.
7. Identificar los flujos críticos del sistema.

## Entregables

* Informe inicial.
* Inventario tecnológico.
* Inventario de rutas.
* Inventario de componentes.
* Inventario de dependencias.
* Métricas iniciales.
* Evidencias visuales.
* Lista de errores.
* Lista de riesgos.

## Criterio de aceptación

Debe existir una referencia verificable del comportamiento, diseño y rendimiento previo a la refactorización.

---

# FASE 1. Auditoría funcional completa

## Objetivo

Comprender qué hace cada pantalla y qué necesita el usuario.

## Actividades

Revisa cada módulo y documenta:

* Objetivo funcional.
* Tipo de usuario.
* Acciones disponibles.
* Información mostrada.
* Información solicitada.
* Dependencias del backend.
* Permisos requeridos.
* Estados posibles.
* Errores posibles.
* Navegación de entrada y salida.
* Nivel de criticidad.
* Problemas actuales.

Identifica:

* Funcionalidades incompletas.
* Flujos rotos.
* Botones sin acción.
* Rutas sin protección.
* Acciones duplicadas.
* Formularios inconsistentes.
* Validaciones faltantes.
* Pantallas desconectadas.
* Estados no manejados.
* Errores silenciosos.
* Acciones sin confirmación.
* Flujos confusos.

## Entregables

* Mapa funcional.
* Matriz de módulos.
* Matriz de roles y permisos.
* Inventario de flujos.
* Lista de problemas funcionales.
* Criterios de prioridad.

## Criterio de aceptación

Ninguna pantalla relevante debe quedar sin propósito, usuario, flujo y dependencia identificados.

---

# FASE 2. Auditoría visual y de experiencia de usuario

## Objetivo

Identificar inconsistencias visuales y problemas de usabilidad.

## Revisión obligatoria

Analiza:

* Jerarquía visual.
* Distribución.
* Espaciado.
* Tipografía.
* Colores.
* Contraste.
* Bordes.
* Radios.
* Sombras.
* Iconografía.
* Densidad de información.
* Alineación.
* Navegación.
* Legibilidad.
* Retroalimentación.
* Consistencia.
* Estados interactivos.
* Responsive.
* Uso de espacio.
* Prioridad de acciones.
* Prevención de errores.
* Claridad del lenguaje.

## Estados a revisar

Cada componente interactivo debe considerar:

* Default.
* Hover.
* Focus.
* Active.
* Disabled.
* Loading.
* Success.
* Warning.
* Error.
* Read only.
* Empty.

## Entregables

* Auditoría visual.
* Auditoría UX.
* Inventario de inconsistencias.
* Mapa de problemas por severidad.
* Recomendaciones priorizadas.
* Comparación de patrones repetidos.

## Criterio de aceptación

Debe existir un diagnóstico visual detallado antes de modificar masivamente los componentes.

---

# FASE 3. Definición del sistema de diseño

## Objetivo

Crear una base visual coherente y reutilizable.

## Elementos obligatorios

Define tokens para:

* Colores.
* Tipografías.
* Tamaños.
* Pesos.
* Line heights.
* Espaciados.
* Bordes.
* Radios.
* Sombras.
* Z-index.
* Breakpoints.
* Transiciones.
* Animaciones.
* Opacidades.
* Iconografía.
* Tamaños de controles.
* Densidad de interfaz.

## Paleta

Define como mínimo:

* Primary.
* Secondary.
* Accent.
* Background.
* Surface.
* Muted.
* Border.
* Text.
* Success.
* Warning.
* Error.
* Information.

Cada color debe tener variantes y usos claramente definidos.

## Tipografía

Define:

* Display.
* Heading 1.
* Heading 2.
* Heading 3.
* Heading 4.
* Body.
* Small.
* Caption.
* Label.
* Button.
* Numeric.

## Temas

Evalúa:

* Tema claro.
* Tema oscuro.
* Compatibilidad con tema del sistema.
* Persistencia de preferencias.
* Contraste en ambos temas.

No implementes múltiples temas si la arquitectura o el producto no lo necesitan, pero deja el sistema preparado cuando sea razonable.

## Entregables

* Tokens.
* Tema.
* Guía de uso.
* Convenciones.
* Archivo central de configuración.
* Catálogo visual.

## Criterio de aceptación

Los estilos principales deben provenir del sistema de diseño y no de valores arbitrarios repetidos.

---

# FASE 4. Arquitectura frontend y organización del código

## Objetivo

Crear una estructura escalable y comprensible.

## Revisión

Evalúa la organización actual de:

* `app`.
* `pages`, si existe.
* `features`.
* `components`.
* `hooks`.
* `services`.
* `repositories`.
* `lib`.
* `utils`.
* `types`.
* `schemas`.
* `styles`.
* `providers`.
* `store`.
* `contexts`.
* `assets`.
* `tests`.

## Estructura visual recomendada

Clasifica los componentes en:

* Atoms.
* Molecules.
* Organisms.
* Templates.
* Layouts.
* Features.
* Shared.

No fuerces Atomic Design si genera una estructura artificial. Utilízalo para ordenar elementos realmente reutilizables.

## Reglas

* Los componentes de negocio deben vivir dentro de su feature.
* Los componentes compartidos deben ser verdaderamente genéricos.
* Las llamadas al backend no deben dispersarse por toda la interfaz.
* Los tipos deben centralizarse por dominio.
* Los schemas deben poder reutilizarse.
* Los hooks deben tener una responsabilidad clara.
* Evitar dependencias circulares.
* Evitar archivos índice que provoquen importaciones innecesarias.
* Mantener límites entre dominio, UI e infraestructura.

## Entregables

* Propuesta de arquitectura.
* Árbol de carpetas.
* Convenciones.
* Migración gradual.
* ADR de arquitectura.

## Criterio de aceptación

Debe ser posible identificar rápidamente dónde se encuentra cada responsabilidad.

---

# FASE 5. Compatibilidad y optimización con Turbopack

## Objetivo

Garantizar que el proyecto utilice Turbopack correctamente.

## Actividades

1. Verificar la configuración actual.
2. Identificar dependencias incompatibles.
3. Eliminar configuraciones heredadas innecesarias.
4. Revisar:

   * Aliases.
   * Imports.
   * CSS.
   * PostCSS.
   * Tailwind.
   * SVG.
   * Fuentes.
   * Imágenes.
   * Web workers.
   * Variables de entorno.
   * Monorepo, cuando exista.
5. Revisar errores de hot reload.
6. Revisar reconstrucciones innecesarias.
7. Revisar tiempos de arranque.
8. Revisar tiempos de actualización.
9. Verificar compatibilidad en desarrollo y producción.
10. No mantener una configuración paralela de Webpack salvo necesidad real.

## Restricciones

* No utilizar configuraciones experimentales sin documentarlas.
* No ocultar problemas de compatibilidad mediante hacks frágiles.
* No depender de imports dinámicos únicamente para evitar errores de arquitectura.
* No desactivar optimizaciones globales para corregir un componente.

## Entregables

* Informe de compatibilidad.
* Configuración corregida.
* Dependencias reemplazadas, cuando corresponda.
* Métricas antes y después.
* Documentación de Turbopack.

## Criterio de aceptación

El entorno debe iniciar, actualizar y compilar correctamente con Turbopack sin errores críticos.

---

# FASE 6. Refactorización de componentes compartidos

## Objetivo

Eliminar duplicación y consolidar patrones comunes.

## Componentes mínimos a revisar

* Button.
* IconButton.
* Input.
* Textarea.
* Select.
* Combobox.
* Checkbox.
* Radio.
* Switch.
* DatePicker.
* TimePicker.
* FileUpload.
* Label.
* FieldError.
* FormField.
* Card.
* Badge.
* Avatar.
* Tooltip.
* Popover.
* Dropdown.
* Modal.
* Drawer.
* Alert.
* Toast.
* Tabs.
* Accordion.
* Breadcrumb.
* Pagination.
* Table.
* Skeleton.
* Spinner.
* EmptyState.
* ErrorState.
* ConfirmDialog.

## Reglas

Cada componente debe:

* Tener una API clara.
* Ser tipado.
* Permitir variantes.
* Manejar estados.
* Ser accesible.
* Ser responsive.
* Evitar dependencias de negocio.
* Tener ejemplos de uso.
* Ser testeable.
* Respetar el sistema de diseño.

## Entregables

* Biblioteca consolidada.
* Componentes eliminados o fusionados.
* Catálogo.
* Documentación.
* Pruebas.

## Criterio de aceptación

No deben existir múltiples implementaciones incompatibles del mismo patrón visual.

---

# FASE 7. Layouts, navegación y estructura general

## Objetivo

Crear una experiencia de navegación clara y consistente.

## Elementos a revisar

* Layout raíz.
* Layout público.
* Layout autenticado.
* Layout administrativo.
* Sidebar.
* Header.
* Footer.
* Breadcrumbs.
* Menú móvil.
* Navegación contextual.
* Accesos rápidos.
* Indicadores de sección.
* Perfil de usuario.
* Selector de organización, cuando exista.
* Logout.
* Estado de conexión.

## Requisitos

* Sidebar colapsable.
* Navegación móvil.
* Estados activos visibles.
* Soporte de teclado.
* Jerarquía clara.
* Control por permisos.
* Persistencia razonable.
* Evitar saltos de layout.
* Mantener navegación accesible.
* Evitar menús saturados.

## Entregables

* Layouts refactorizados.
* Navegación responsive.
* Menús por rol.
* Breadcrumbs.
* Pruebas de navegación.

## Criterio de aceptación

El usuario debe saber en qué sección se encuentra y cómo regresar o continuar.

---

# FASE 8. Refactorización visual del login y autenticación

## Objetivo

Crear una experiencia de acceso profesional, segura y clara.

## Pantallas

* Login.
* Registro.
* Recuperación.
* Restablecimiento.
* Verificación.
* MFA.
* Sesión expirada.
* Acceso denegado.

## Requisitos visuales

* Fondo moderno.
* Contenedor equilibrado.
* Jerarquía clara.
* Inputs legibles.
* Estados de error visibles.
* Indicador de carga.
* Mostrar u ocultar contraseña.
* Soporte para autocompletado.
* Botón principal destacado.
* Diseño responsive.
* Microinteracciones sutiles.
* Animaciones que no distraigan.

## Requisitos funcionales

* Prevención de envíos duplicados.
* Errores del backend traducidos.
* Manejo de token expirado.
* Redirección segura.
* Recordatorio de sesión, si corresponde.
* No almacenar secretos inseguramente.
* Compatibilidad con gestor de contraseñas.
* Validación accesible.

## Entregables

* Flujo de autenticación refactorizado.
* Estados completos.
* Pruebas.
* Evidencias antes y después.

## Criterio de aceptación

El flujo debe ser claro, seguro y funcional en escritorio y móvil.

---

# FASE 9. Formularios y validación

## Objetivo

Unificar todos los formularios.

## Actividades

1. Identificar formularios repetidos.
2. Centralizar schemas.
3. Validar en cliente sin reemplazar la validación del backend.
4. Traducir errores del servidor.
5. Implementar mensajes específicos.
6. Manejar errores por campo y globales.
7. Evitar pérdida accidental de cambios.
8. Implementar confirmación de salida cuando sea necesaria.
9. Manejar estados:

   * Inicial.
   * Modificado.
   * Enviando.
   * Exitoso.
   * Fallido.
   * Deshabilitado.
10. Evitar envíos dobles.
11. Mantener accesibilidad.
12. Mantener valores al fallar.
13. Implementar máscaras solamente cuando aporten valor.
14. Separar presentación y lógica.

## Reglas

* No mostrar errores antes de que el usuario interactúe, salvo necesidad.
* No limpiar el formulario después de un error.
* No ocultar errores del backend.
* No utilizar validaciones contradictorias.
* No construir formularios manualmente cuando exista un patrón común.

## Entregables

* Arquitectura de formularios.
* Campos compartidos.
* Schemas.
* Manejo de errores.
* Pruebas.

## Criterio de aceptación

Todos los formularios deben comportarse de manera consistente.

---

# FASE 10. Tablas, listados y administración de datos

## Objetivo

Crear tablas eficientes, claras y reutilizables.

## Funcionalidades a considerar

* Búsqueda.
* Filtros.
* Ordenamiento.
* Paginación.
* Selección.
* Acciones por fila.
* Acciones masivas.
* Edición.
* Eliminación.
* Confirmación.
* Exportación.
* Columnas configurables.
* Estado vacío.
* Estado de carga.
* Estado de error.
* Responsive.
* Permisos.
* Persistencia de filtros, cuando sea razonable.

## Requisitos

* No cargar todos los registros cuando exista paginación backend.
* Evitar renderizados innecesarios.
* Diferenciar filtros locales y remotos.
* Mostrar cantidad de resultados.
* Mantener filtros al regresar.
* Evitar tablas ilegibles en móvil.
* Utilizar tarjetas o vistas condensadas cuando corresponda.
* Centralizar acciones.
* Evitar iconos sin tooltip.
* Confirmar operaciones destructivas.

## Entregables

* Tabla general reutilizable.
* Arquitectura de filtros.
* Paginación.
* Estados.
* Pruebas de rendimiento.

## Criterio de aceptación

Las tablas deben soportar volúmenes reales sin degradar la experiencia.

---

# FASE 11. Modales, drawers, confirmaciones y notificaciones

## Objetivo

Unificar las interacciones superpuestas.

## Requisitos

Los modales deben:

* Tener título claro.
* Tener descripción cuando corresponda.
* Manejar foco.
* Cerrar con teclado.
* Evitar cierre accidental en operaciones críticas.
* Mostrar acciones claramente.
* Ser responsive.
* Manejar scroll.
* Restaurar el foco al cerrar.
* No abrir múltiples capas innecesarias.

Las notificaciones deben:

* Ser consistentes.
* Tener niveles.
* No duplicarse.
* Desaparecer de forma razonable.
* Permitir acción cuando corresponda.
* Ser accesibles.
* No mostrar errores técnicos al usuario final.

## Entregables

* Sistema centralizado.
* ConfirmDialog.
* Toast provider.
* Catálogo de mensajes.
* Pruebas.

## Criterio de aceptación

Las interacciones deben ser predecibles y no bloquear al usuario innecesariamente.

---

# FASE 12. Estados de carga, error, vacío y éxito

## Objetivo

Eliminar pantallas incompletas y silencios visuales.

## Estados obligatorios

Cada vista de datos debe contemplar:

* Initial.
* Loading.
* Refreshing.
* Empty.
* Error.
* Partial error.
* Success.
* Stale.
* Offline, cuando corresponda.
* Unauthorized.
* Forbidden.
* Not found.

## Requisitos

* Utilizar skeletons en lugar de spinners globales cuando aporten contexto.
* Evitar saltos de layout.
* Permitir reintentar.
* Explicar qué ocurrió.
* Mostrar acciones útiles.
* Diferenciar ausencia de datos y error.
* Evitar pantallas completamente en blanco.

## Entregables

* Componentes compartidos.
* Integración en todas las vistas.
* Catálogo de errores.
* Pruebas.

## Criterio de aceptación

Ningún flujo crítico debe dejar al usuario sin información sobre el estado actual.

---

# FASE 13. Integración con backend y capa de datos

## Objetivo

Centralizar y estabilizar la comunicación con la API.

## Revisión

Analiza:

* Cliente HTTP.
* Base URL.
* Headers.
* Tokens.
* Cookies.
* Timeouts.
* Reintentos.
* Cancelación.
* Errores.
* Serialización.
* Paginación.
* Caché.
* Invalidación.
* Solicitudes duplicadas.
* Race conditions.
* Tipos.
* Contratos.
* WebSockets.
* Server-Sent Events.
* Subida de archivos.

## Requisitos

* Crear una capa de servicios o repositorios.
* Tipar requests y responses.
* Normalizar errores.
* Manejar 401, 403, 404, 409, 422, 429 y 500.
* No reintentar operaciones no idempotentes indiscriminadamente.
* Cancelar solicitudes obsoletas.
* Evitar múltiples refresh simultáneos.
* Manejar expiración de sesión.
* Evitar llamadas desde componentes puramente visuales.
* Mantener contratos centralizados.

## Entregables

* Cliente central.
* Servicios por dominio.
* Tipos.
* Manejo de errores.
* Pruebas de integración.

## Criterio de aceptación

Las llamadas al backend deben ser trazables, tipadas y consistentes.

---

# FASE 14. Estado global, estado local y caché del cliente

## Objetivo

Eliminar estados duplicados e inconsistentes.

## Actividades

Clasifica cada dato como:

* Estado local.
* Estado de formulario.
* Estado de URL.
* Estado global.
* Estado del servidor.
* Estado persistido.
* Preferencia del usuario.

## Reglas

* No duplicar en un store datos que ya administra la caché del servidor.
* Utilizar la URL para filtros y navegación cuando aporte valor.
* Evitar Context global para datos de alta frecuencia.
* Evitar stores gigantes.
* Dividir por dominio.
* No persistir información sensible.
* Definir política de invalidación.
* Evitar sincronizaciones manuales frágiles.

## Entregables

* Mapa de estado.
* Refactorización.
* Eliminación de duplicados.
* Documentación.

## Criterio de aceptación

Debe existir una única fuente de verdad para cada dato relevante.

---

# FASE 15. Server Components y Client Components

## Objetivo

Utilizar correctamente la arquitectura de Next.js.

## Actividades

Revisa cada componente marcado con `"use client"` y determina si realmente lo necesita.

Clasifica:

* Server Component.
* Client Component.
* Server Action.
* Route Handler.
* Componente compartido.
* Componente dinámico.

## Reglas

* Mantener componentes de servidor por defecto.
* Limitar los límites de cliente.
* No pasar datos innecesarios al navegador.
* No ejecutar lógica sensible en cliente.
* Evitar componentes cliente gigantes.
* Evitar hydration innecesaria.
* Separar interactividad de presentación.
* Utilizar Suspense cuando corresponda.
* No convertir todo el árbol en cliente por un provider mal ubicado.

## Entregables

* Auditoría de límites.
* Componentes migrados.
* Métricas.
* Documentación.

## Criterio de aceptación

La aplicación debe utilizar componentes cliente únicamente donde exista interactividad real.

---

# FASE 16. Renderizado, caché y estrategia de datos

## Objetivo

Seleccionar la estrategia adecuada para cada ruta.

## Evalúa

* Static rendering.
* Dynamic rendering.
* Streaming.
* Suspense.
* Revalidation.
* Cache.
* No-store.
* Server fetch.
* Client fetch.
* Server Actions.
* Incremental Static Regeneration.

## Reglas

* No cachear datos sensibles.
* No desactivar globalmente la caché sin analizar.
* No utilizar contenido estático para información dinámica crítica.
* No ejecutar la misma consulta en varias capas.
* Documentar la estrategia por ruta.
* Invalidar correctamente después de mutaciones.

## Entregables

* Matriz de rutas.
* Estrategia de renderizado.
* Política de caché.
* Pruebas.

## Criterio de aceptación

Cada ruta debe utilizar una estrategia acorde a la naturaleza de sus datos.

---

# FASE 17. Diseño responsive y experiencia móvil

## Objetivo

Garantizar una experiencia real en dispositivos pequeños.

## Breakpoints a validar

* Móvil pequeño.
* Móvil grande.
* Tablet.
* Laptop.
* Desktop.
* Pantallas amplias.

## Revisión

* Menús.
* Sidebar.
* Tablas.
* Formularios.
* Modales.
* Drawers.
* Tarjetas.
* Gráficos.
* Botones.
* Tipografía.
* Espaciado.
* Inputs.
* Teclado móvil.
* Scroll horizontal.
* Áreas táctiles.
* Navegación.
* Orientación.

## Reglas

* No ocultar funciones importantes en móvil.
* No reducir elementos hasta volverlos ilegibles.
* Evitar scroll horizontal global.
* Mantener controles táctiles adecuados.
* Optimizar formularios para teclado móvil.
* Utilizar navegación adaptada.
* Probar contenido real y largo.

## Entregables

* Vistas responsive.
* Evidencias por breakpoint.
* Correcciones.
* Pruebas.

## Criterio de aceptación

Los flujos críticos deben completarse desde un dispositivo móvil.

---

# FASE 18. Accesibilidad

## Objetivo

Cumplir buenas prácticas de accesibilidad y aproximarse a WCAG 2.2 AA.

## Requisitos

* HTML semántico.
* Labels.
* Roles correctos.
* Estados ARIA.
* Navegación por teclado.
* Orden de tabulación.
* Focus visible.
* Contraste.
* Mensajes de error accesibles.
* Modales accesibles.
* Anuncios de cambios.
* Textos alternativos.
* Encabezados jerárquicos.
* Targets táctiles.
* `prefers-reduced-motion`.
* Compatibilidad con zoom.
* No depender exclusivamente del color.

## Pruebas

* Navegación sin ratón.
* Screen reader básico.
* Axe.
* Lighthouse.
* Contraste.
* Zoom al 200 %.
* Reduced motion.

## Entregables

* Informe.
* Correcciones.
* Pruebas.
* Riesgos residuales.

## Criterio de aceptación

Los flujos principales deben poder utilizarse mediante teclado y tecnologías de asistencia.

---

# FASE 19. Animaciones y microinteracciones

## Objetivo

Mejorar la percepción de calidad sin afectar el rendimiento.

## Aplicaciones posibles

* Cambios de página.
* Menús.
* Botones.
* Hover.
* Modales.
* Drawers.
* Tooltips.
* Tabs.
* Expansiones.
* Estados de carga.
* Confirmaciones.
* Actualizaciones de datos.

## Reglas

* Mantener animaciones cortas.
* No animar propiedades costosas cuando pueda evitarse.
* Respetar reduced motion.
* No bloquear interacciones.
* No utilizar animaciones decorativas excesivas.
* No causar mareo.
* No introducir dependencias pesadas para efectos simples.
* Medir impacto.

## Entregables

* Catálogo de transiciones.
* Implementación.
* Validación de rendimiento.

## Criterio de aceptación

Las animaciones deben aportar claridad y no convertirse en distracciones.

---

# FASE 20. Rendimiento y Core Web Vitals

## Objetivo

Optimizar el frontend con métricas reales.

## Métricas

* LCP.
* INP.
* CLS.
* FCP.
* TTFB.
* Tamaño de JavaScript.
* Tamaño de CSS.
* Número de solicitudes.
* Tiempo de hidratación.
* Tiempo de interacción.
* Uso de memoria.
* Renderizados.

## Actividades

* Analizar bundles.
* Eliminar dependencias innecesarias.
* Optimizar imports.
* Aplicar lazy loading.
* Dividir código.
* Optimizar imágenes.
* Optimizar fuentes.
* Reducir Client Components.
* Evitar cálculos en render.
* Memoizar solamente cuando aporte valor.
* Virtualizar listas grandes.
* Evitar layout shifts.
* Reducir scripts de terceros.
* Priorizar recursos críticos.
* Revisar prefetch.
* Revisar hydration.

## Entregables

* Informe antes y después.
* Bundle analysis.
* Mejoras aplicadas.
* Riesgos.
* Métricas.

## Criterio de aceptación

Toda mejora debe demostrarse mediante métricas, no únicamente mediante apreciación visual.

---

# FASE 21. Imágenes, fuentes, iconos y recursos

## Objetivo

Optimizar todos los recursos visuales.

## Requisitos

* Utilizar el componente de imagen cuando corresponda.
* Definir tamaños.
* Evitar imágenes sobredimensionadas.
* Utilizar formatos modernos.
* Configurar dominios autorizados.
* Implementar placeholders cuando aporte valor.
* Evitar íconos duplicados.
* Centralizar iconografía.
* Optimizar SVG.
* Cargar fuentes de forma eficiente.
* Evitar cambios de layout.
* No cargar múltiples variantes innecesarias.

## Entregables

* Inventario.
* Recursos optimizados.
* Convenciones.
* Comparación de peso.

## Criterio de aceptación

Los recursos no deben provocar cargas innecesarias ni desplazamientos visuales.

---

# FASE 22. Seguridad frontend

## Objetivo

Reducir riesgos en el navegador.

## Revisión

* XSS.
* Inyección de HTML.
* Manejo de tokens.
* Cookies.
* LocalStorage.
* SessionStorage.
* CSRF.
* Redirects.
* Archivos.
* URLs externas.
* Dependencias.
* Variables de entorno.
* Contenido dinámico.
* Permisos.
* Rutas protegidas.
* Información sensible.

## Reglas

* No confiar en permisos únicamente del frontend.
* No almacenar secretos permanentes.
* No utilizar `dangerouslySetInnerHTML` sin sanitización.
* No exponer variables privadas.
* Validar archivos.
* Evitar redirects abiertos.
* Sanitizar URLs.
* Aplicar headers cuando corresponda.
* Revisar dependencias vulnerables.
* Evitar información sensible en logs.

## Entregables

* Informe.
* Correcciones.
* Dependencias revisadas.
* Riesgos residuales.

## Criterio de aceptación

No deben quedar vulnerabilidades críticas conocidas sin corregir o justificar.

---

# FASE 23. SEO y metadata

## Objetivo

Optimizar las rutas públicas.

## Requisitos

Cuando corresponda:

* Títulos.
* Descripciones.
* Canonical.
* Open Graph.
* Twitter cards.
* Robots.
* Sitemap.
* Datos estructurados.
* Imágenes sociales.
* Metadata dinámica.
* URLs legibles.
* Semántica.
* Rendimiento.

No aplicar SEO a áreas privadas o administrativas sin necesidad.

## Entregables

* Configuración.
* Metadata por ruta.
* Sitemap.
* Pruebas.

## Criterio de aceptación

Las rutas públicas deben tener metadata válida y consistente.

---

# FASE 24. Manejo de errores y observabilidad

## Objetivo

Detectar, registrar y diagnosticar problemas.

## Implementar

* Error boundaries.
* Errores por ruta.
* Página global de error.
* Página 404.
* Página 403.
* Manejo de promesas.
* Registro estructurado.
* Correlation ID.
* Captura de errores del cliente.
* Contexto de usuario no sensible.
* Contexto de ruta.
* Versión de la aplicación.
* Errores de red.
* Errores de renderizado.

## Reglas

* No mostrar stack traces al usuario.
* No ocultar errores críticos.
* No registrar datos sensibles.
* Evitar notificaciones duplicadas.
* Diferenciar error recuperable y fatal.
* Permitir reintento cuando corresponda.

## Entregables

* Arquitectura de errores.
* Integración de monitoreo.
* Catálogo de mensajes.
* Manual de diagnóstico.

## Criterio de aceptación

Debe ser posible identificar dónde y por qué ocurrió un error importante.

---

# FASE 25. Pruebas unitarias

## Objetivo

Validar componentes y lógica aislada.

## Prioridades

* Utilidades.
* Hooks.
* Schemas.
* Transformadores.
* Componentes compartidos.
* Formularios.
* Permisos.
* Manejo de errores.
* Cálculos.
* Estados.

## Reglas

* Probar comportamiento.
* Evitar snapshots gigantes.
* No probar detalles internos innecesarios.
* Cubrir casos normales y límites.
* Mantener pruebas deterministas.
* No depender de servicios externos reales.

## Entregables

* Suite unitaria.
* Cobertura.
* Casos críticos.

## Criterio de aceptación

La lógica crítica debe tener pruebas automatizadas confiables.

---

# FASE 26. Pruebas de integración

## Objetivo

Validar la interacción entre módulos.

## Escenarios

* Formulario y API.
* Tabla y paginación.
* Filtros.
* Autenticación.
* Rutas protegidas.
* Permisos.
* Modales.
* Upload.
* Manejo de errores.
* Invalidación de caché.
* Sesión expirada.

## Entregables

* Pruebas.
* Mocks contractuales.
* Resultados.

## Criterio de aceptación

Los componentes principales deben comunicarse correctamente con sus dependencias.

---

# FASE 27. Pruebas end-to-end

## Objetivo

Validar los flujos reales del usuario.

## Flujos mínimos

* Login.
* Logout.
* Recuperación.
* Navegación.
* Creación.
* Edición.
* Eliminación.
* Búsqueda.
* Filtros.
* Paginación.
* Carga de archivos.
* Manejo de sesión expirada.
* Permisos.
* Responsive.
* Error de backend.
* Flujo crítico de negocio.

## Requisitos

* Utilizar datos controlados.
* No depender de estados manuales.
* Capturar evidencias.
* Ejecutar en CI.
* Evitar pruebas frágiles.
* Utilizar selectores estables.

## Entregables

* Suite E2E.
* Evidencias.
* Reportes.
* Flujos cubiertos.

## Criterio de aceptación

Los principales recorridos del usuario deben completarse automáticamente.

---

# FASE 28. Pruebas visuales y responsive

## Objetivo

Detectar regresiones de interfaz.

## Actividades

* Capturas por pantalla.
* Capturas por breakpoint.
* Comparación visual.
* Validación de temas.
* Contenido largo.
* Datos vacíos.
* Errores.
* Modales.
* Menús.
* Formularios.
* Tablas.

## Entregables

* Evidencias antes y después.
* Pruebas visuales.
* Correcciones.

## Criterio de aceptación

Los cambios futuros no deben romper silenciosamente la apariencia.

---

# FASE 29. Pruebas de rendimiento

## Objetivo

Validar que la refactorización no degrade la aplicación.

## Escenarios

* Dashboard.
* Tabla grande.
* Formulario complejo.
* Navegación.
* Cambio de filtros.
* Apertura de modales.
* Carga inicial.
* Red lenta.
* CPU limitada.
* Dispositivo móvil.

## Métricas

* Tiempo de render.
* Solicitudes.
* Memoria.
* FPS.
* JavaScript cargado.
* Interacción.
* Core Web Vitals.

## Entregables

* Informe.
* Comparación.
* Cuellos de botella.
* Correcciones.

## Criterio de aceptación

La mejora visual no debe aumentar injustificadamente el costo de ejecución.

---

# FASE 30. CI/CD y validación automática

## Objetivo

Evitar que errores lleguen a producción.

## Pipeline mínimo

1. Instalación con lockfile.
2. Formato.
3. Lint.
4. Type check.
5. Pruebas unitarias.
6. Pruebas de integración.
7. Build con Turbopack.
8. Pruebas E2E.
9. Pruebas visuales.
10. Análisis de dependencias.
11. Auditoría de seguridad.
12. Validación de bundle.
13. Despliegue de preview.
14. Smoke tests.
15. Despliegue de producción.
16. Rollback.

## Reglas

* No desplegar si fallan pruebas críticas.
* No ignorar errores TypeScript.
* No permitir secretos en logs.
* Asociar despliegues a commits.
* Mantener previews por rama o PR.
* Documentar promoción entre entornos.

## Entregables

* Pipeline.
* Scripts.
* Configuración.
* Estrategia de despliegue.
* Rollback.

## Criterio de aceptación

Cada versión desplegada debe estar relacionada con código, pruebas y evidencias.

---

# FASE 31. Documentación técnica y visual

## Objetivo

Permitir que otra persona mantenga el frontend.

## Documentación obligatoria

### Arquitectura

* Estructura.
* Features.
* Componentes.
* Estado.
* Datos.
* Rutas.
* Permisos.
* Servicios.

### Sistema de diseño

* Tokens.
* Colores.
* Tipografía.
* Componentes.
* Variantes.
* Estados.
* Accesibilidad.
* Uso correcto.

### Desarrollo

* Instalación.
* Variables.
* Turbopack.
* Comandos.
* Pruebas.
* Build.
* Diagnóstico.
* Convenciones.

### Integración

* Cliente HTTP.
* Errores.
* Tipos.
* Contratos.
* Caché.
* Autenticación.

## Entregables

* README actualizado.
* Documentación arquitectónica.
* Sistema de diseño.
* Guía de contribución.
* Manual de pruebas.
* Troubleshooting.

## Criterio de aceptación

Un nuevo desarrollador debe comprender cómo trabajar con el frontend sin depender del autor.

---

# FASE 32. Limpieza y consolidación final

## Objetivo

Eliminar residuos y dejar un proyecto coherente.

## Actividades

* Eliminar componentes obsoletos.
* Eliminar estilos duplicados.
* Eliminar imports no utilizados.
* Eliminar dependencias innecesarias.
* Eliminar mocks no autorizados.
* Eliminar comentarios pendientes.
* Eliminar archivos temporales.
* Eliminar tipos duplicados.
* Eliminar hooks redundantes.
* Eliminar configuraciones incompatibles.
* Revisar nombres.
* Revisar rutas.
* Revisar permisos.
* Revisar variables.
* Revisar documentación.
* Ejecutar todas las pruebas.
* Ejecutar build final.
* Comparar métricas iniciales y finales.

## Entregables

* Informe final.
* Comparación antes y después.
* Inventario de componentes consolidados.
* Dependencias eliminadas.
* Métricas finales.
* Riesgos residuales.
* Evidencias.

## Criterio de aceptación

No deben quedar implementaciones duplicadas, configuraciones contradictorias ni código temporal.

---

# 6. Estructura sugerida

Adapta la organización al proyecto real:

```text
src/
├── app/
│   ├── (public)/
│   ├── (auth)/
│   ├── (dashboard)/
│   ├── api/
│   ├── error.tsx
│   ├── loading.tsx
│   ├── not-found.tsx
│   ├── layout.tsx
│   └── providers.tsx
├── components/
│   ├── atoms/
│   ├── molecules/
│   ├── organisms/
│   ├── layouts/
│   └── shared/
├── features/
│   ├── auth/
│   ├── users/
│   ├── notifications/
│   └── ...
├── hooks/
├── lib/
├── services/
├── repositories/
├── schemas/
├── types/
├── utils/
├── styles/
├── config/
├── providers/
├── store/
└── tests/

docs/
├── frontend/
│   ├── architecture.md
│   ├── design-system.md
│   ├── accessibility.md
│   ├── performance.md
│   ├── testing.md
│   ├── turbopack.md
│   └── troubleshooting.md
└── adr/
```

No generes carpetas vacías ni una estructura artificial. Cada carpeta debe responder a una necesidad real.

---

# 7. Reglas obligatorias de código

* TypeScript estricto.
* Evitar `any`.
* Evitar componentes mayores a 300 líneas.
* Mantener funciones pequeñas.
* Separar lógica y presentación.
* Evitar estados duplicados.
* Evitar efectos innecesarios.
* Evitar props excesivas.
* Utilizar composición.
* Mantener nombres claros.
* Eliminar código muerto.
* Evitar dependencias circulares.
* Centralizar tipos.
* Centralizar schemas.
* Mantener imports consistentes.
* No desactivar reglas sin justificación.
* Documentar decisiones no evidentes.
* Utilizar comentarios únicamente cuando expliquen una decisión y no lo que el código ya expresa.

---

# 8. Criterios globales de aceptación

La implementación solamente podrá considerarse finalizada cuando:

1. El proyecto inicie correctamente con Turbopack.
2. El build de producción finalice sin errores.
3. TypeScript no presente errores.
4. El linter no presente errores críticos.
5. No existan errores de hidratación.
6. No existan errores críticos en consola.
7. Todas las rutas principales funcionen.
8. La autenticación funcione correctamente.
9. Los permisos se respeten.
10. Los formularios validen correctamente.
11. Los errores del backend sean manejados.
12. Las tablas funcionen.
13. Los filtros funcionen.
14. La paginación funcione.
15. Los modales sean accesibles.
16. Los estados de carga estén implementados.
17. Los estados vacíos estén implementados.
18. Los estados de error estén implementados.
19. El frontend sea responsive.
20. Los flujos críticos funcionen en móvil.
21. La navegación por teclado sea posible.
22. El contraste sea adecuado.
23. Las pruebas unitarias pasen.
24. Las pruebas de integración pasen.
25. Las pruebas E2E pasen.
26. Las pruebas visuales no presenten regresiones.
27. El rendimiento haya sido medido.
28. El bundle haya sido analizado.
29. No se expongan secretos.
30. No existan dependencias innecesarias.
31. No existan componentes duplicados.
32. Exista un sistema de diseño documentado.
33. Exista documentación técnica.
34. Exista evidencia antes y después.
35. No queden pendientes evitables.

---

# 9. Formato obligatorio del reporte por fase

Al finalizar cada fase, entrega:

```markdown
## Fase N — Nombre

### Estado
COMPLETADA | PARCIAL | BLOQUEADA

### Diagnóstico inicial
Descripción del estado encontrado.

### Problemas identificados
Lista priorizada.

### Cambios realizados
Detalle de la implementación.

### Archivos creados
Lista de archivos.

### Archivos modificados
Lista de archivos.

### Componentes creados
Lista y propósito.

### Componentes eliminados o consolidados
Lista y justificación.

### Decisiones técnicas
Decisiones y motivos.

### Evidencias visuales
Comparación antes y después.

### Pruebas ejecutadas
Comandos y resultados.

### Métricas
Resultados antes y después.

### Riesgos
Riesgos y mitigaciones.

### Criterios de aceptación
- [x] Cumplido
- [ ] No cumplido

### Pendientes reales
Únicamente impedimentos externos.

### Próxima fase
Descripción del siguiente paso.
```

No declares una fase como completada si existen criterios obligatorios sin validar.

---

# 10. Forma de ejecución

No entregues únicamente una auditoría o una lista de recomendaciones.

Debes:

1. Inspeccionar el repositorio.
2. Ejecutar el frontend actual.
3. Comprender los módulos.
4. Identificar los flujos críticos.
5. Auditar la interfaz.
6. Definir el sistema de diseño.
7. Diseñar el plan de refactorización.
8. Implementar los cambios por fases.
9. Probar cada modificación.
10. Corregir regresiones.
11. Medir rendimiento.
12. Validar responsive.
13. Validar accesibilidad.
14. Ejecutar pruebas.
15. Ejecutar el build con Turbopack.
16. Documentar decisiones.
17. Comparar antes y después.
18. Eliminar código obsoleto.
19. Realizar una revisión integral final.

Cuando existan varias alternativas válidas, selecciona la que mejor se adapte a la arquitectura real y documenta la decisión.

No interrumpas la ejecución para solicitar decisiones menores que puedan resolverse analizando el proyecto.

---

# 11. Restricciones finales

* No rompas funcionalidades existentes.
* No cambies contratos del backend sin justificación.
* No rehagas todo desde cero si la base actual puede refactorizarse.
* No generes una interfaz genérica.
* No utilices una única plantilla para todas las pantallas.
* No sacrifiques usabilidad por estética.
* No introduzcas animaciones excesivas.
* No introduzcas librerías pesadas sin necesidad.
* No conviertas todo en Client Components.
* No ocultes errores de TypeScript.
* No desactives reglas para evitar corregir problemas.
* No uses mocks en producción.
* No dejes botones sin comportamiento.
* No dejes pantallas sin estados.
* No dejes formularios sin validación.
* No dejes tablas sin manejo de carga y error.
* No expongas secretos.
* No almacenes tokens de forma insegura.
* No ignores accesibilidad.
* No ignores dispositivos móviles.
* No declares pruebas que no fueron ejecutadas.
* No dejes documentación desactualizada.
* No dejes componentes duplicados.
* No dejes código temporal.
* No dejes pendientes que puedan resolverse con el acceso disponible.

El resultado debe ser un frontend profesional, visualmente sobresaliente, intuitivo, rápido, accesible, responsive, mantenible y totalmente compatible con Next.js y Turbopack.
