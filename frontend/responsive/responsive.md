# PROMPT MAESTRO — AUDITORÍA Y MEJORA INTEGRAL DEL DISEÑO RESPONSIVO DEL FRONTEND

## Rol

Actúa como un **arquitecto frontend senior especializado en diseño responsivo, UX/UI, accesibilidad, sistemas de diseño, rendimiento web y refactorización segura de aplicaciones en producción**.

Debes analizar y mejorar integralmente el diseño responsivo de este frontend.

No debes limitarte a corregir algunas pantallas visibles. Tu trabajo consiste en convertir todo el proyecto en una aplicación verdaderamente adaptable, consistente, accesible y mantenible para teléfonos, tablets, laptops, monitores grandes y dispositivos con características especiales.

Trabaja directamente sobre el repositorio proporcionado.

---

# 1. Objetivo principal

Realiza una auditoría completa y mejora el diseño responsivo de todo el frontend, garantizando que:

* Ninguna pantalla produzca desplazamiento horizontal accidental.
* Ningún contenido quede cortado, oculto o superpuesto.
* Formularios, tablas, modales, menús, gráficos y tarjetas funcionen correctamente en todos los tamaños.
* La navegación sea cómoda tanto con mouse como con pantalla táctil.
* Los componentes reutilizables tengan un comportamiento responsivo consistente.
* El sistema pueda crecer sin depender de correcciones individuales por cada página.
* Los cambios no rompan la lógica, el estado, las rutas, las validaciones ni las integraciones existentes.
* La interfaz conserve su identidad visual.
* El resultado sea apto para producción.

El enfoque debe ser **mobile-first**, pero sin perjudicar las versiones de escritorio.

---

# 2. Reglas estrictas

## 2.1. No romper funcionalidades

No elimines, simules ni reemplaces funcionalidades existentes.

Antes de modificar un componente, identifica:

* Qué función cumple.
* En qué pantallas se utiliza.
* Qué propiedades recibe.
* Qué estados maneja.
* Qué acciones ejecuta.
* Qué dependencias tiene.
* Qué otros componentes pueden verse afectados.

Mantén intactos:

* Flujos de negocio.
* Validaciones.
* Peticiones HTTP.
* Estados globales y locales.
* Rutas.
* Autenticación y autorización.
* Permisos por rol.
* Formularios.
* Eventos.
* Integraciones.
* Traducciones.
* Analítica.
* Pruebas existentes.

Una mejora visual no puede alterar el comportamiento funcional.

---

## 2.2. No aplicar parches aislados

No resuelvas el problema agregando media queries desordenadas en cada pantalla.

Primero identifica patrones compartidos y luego centraliza las soluciones mediante:

* Componentes comunes.
* Contenedores responsivos.
* Tokens de diseño.
* Utilidades reutilizables.
* Variantes de componentes.
* Hooks responsivos cuando sean realmente necesarios.
* Clases o mixins compartidos.
* Configuración centralizada de breakpoints.

Evita duplicar lógica responsiva.

---

## 2.3. No adivinar

No inventes requisitos de negocio ni elimines elementos porque parezcan innecesarios.

Cuando una decisión visual no pueda inferirse con seguridad:

1. Conserva el comportamiento actual.
2. Elige la alternativa menos destructiva.
3. Documenta la suposición.
4. Evita bloquear el trabajo por detalles menores.

Temperatura de trabajo: **TEMP 0**.

---

## 2.4. Código mantenible

* Evita archivos mayores a 300 líneas, excepto cuando exista una justificación técnica real.
* Divide componentes excesivamente grandes.
* No mezcles lógica de negocio con lógica puramente visual.
* No agregues dependencias innecesarias.
* Respeta la arquitectura y las convenciones existentes.
* Reutiliza el sistema de estilos ya instalado.
* No migres de framework, librería UI o sistema CSS salvo que sea imprescindible y esté técnicamente justificado.
* No reemplaces componentes estables únicamente por preferencia personal.

---

# 3. Primera fase: diagnóstico técnico

Antes de modificar código, inspecciona el proyecto completo.

## 3.1. Detectar automáticamente el stack

Identifica y documenta:

* Framework principal.
* Versión del framework.
* Sistema de rutas.
* Sistema de estilos.
* Librería de componentes.
* Sistema de iconos.
* Gestor de estado.
* Herramientas de formularios.
* Librerías de tablas.
* Librerías de gráficos.
* Sistema de testing.
* Herramientas de linting y formateo.
* Scripts disponibles.
* Sistema de construcción.
* Componentes compartidos.
* Layouts principales.
* Estructura de carpetas.
* Convenciones existentes.

No supongas que el proyecto utiliza React, Tailwind o cualquier tecnología específica. Debes detectarlo directamente desde el repositorio.

---

## 3.2. Construir un inventario de interfaces

Localiza todas las rutas y pantallas del sistema.

Clasifica los elementos encontrados:

* Layout principal.
* Encabezados.
* Barras laterales.
* Navegación inferior.
* Breadcrumbs.
* Pestañas.
* Formularios.
* Tablas.
* Listados.
* Tarjetas.
* Modales.
* Drawers.
* Popovers.
* Tooltips.
* Selectores.
* Autocompletados.
* Calendarios.
* Gráficos.
* Dashboards.
* Mapas.
* Editores.
* Flujos paso a paso.
* Notificaciones.
* Estados vacíos.
* Estados de carga.
* Estados de error.
* Vistas de detalle.
* Pantallas de autenticación.
* Pantallas administrativas.
* Componentes reutilizables.

Debes inspeccionar también las pantallas menos evidentes, no solamente la página inicial.

---

## 3.3. Detectar problemas responsivos

Busca sistemáticamente:

* Anchos fijos innecesarios.
* Alturas fijas que cortan contenido.
* Uso incorrecto de `100vw`.
* Elementos absolutamente posicionados sin adaptación.
* Contenedores con `min-width` excesivo.
* Texto desbordado.
* Imágenes deformadas.
* Tablas imposibles de utilizar en móvil.
* Modales más grandes que la pantalla.
* Menús que salen del viewport.
* Formularios con columnas demasiado estrechas.
* Botones difíciles de tocar.
* Barras laterales que cubren contenido.
* Encabezados saturados.
* Pestañas que no caben.
* Gráficos ilegibles.
* Tarjetas con contenido superpuesto.
* Elementos ocultos sin alternativa móvil.
* Scroll horizontal accidental.
* Uso excesivo de valores mágicos.
* Breakpoints inconsistentes.
* Componentes que dependen directamente de `window.innerWidth`.
* Efectos que funcionan con hover, pero no con touch.
* Texto demasiado pequeño.
* Espaciado insuficiente.
* Controles sin áreas táctiles adecuadas.
* Problemas en orientación horizontal.
* Problemas cuando aumenta el tamaño de fuente.
* Problemas con textos largos, traducciones o datos reales.
* Problemas al abrir el teclado virtual.
* Problemas con barras del navegador móvil.
* Problemas con áreas seguras en dispositivos con notch.

---

# 4. Matriz obligatoria de evaluación

Prueba el frontend como mínimo en los siguientes anchos:

| Categoría           | Ancho aproximado |
| ------------------- | ---------------: |
| Móvil muy pequeño   |           320 px |
| Móvil pequeño       |           360 px |
| Móvil estándar      |           390 px |
| Móvil grande        |           430 px |
| Tablet vertical     |           768 px |
| Tablet horizontal   |          1024 px |
| Laptop              |          1280 px |
| Escritorio          |          1440 px |
| Escritorio grande   |          1920 px |
| Pantalla ultraancha |          2560 px |

No diseñes únicamente para estos valores exactos. Comprueba también anchos intermedios para detectar puntos donde el contenido se rompe.

Los breakpoints deben decidirse según el momento en que el contenido necesita reorganizarse, no solamente según nombres de dispositivos.

Prueba también:

* Orientación vertical.
* Orientación horizontal.
* Zoom del navegador al 200 %.
* Fuentes aumentadas.
* Textos extensos.
* Datos vacíos.
* Datos numerosos.
* Errores de validación.
* Carga lenta.
* Menús abiertos.
* Modales abiertos.
* Teclado virtual activo.
* Diferentes roles de usuario cuando existan.

---

# 5. Plan de implementación obligatorio

Antes de realizar cambios importantes, crea un documento:

```text
docs/RESPONSIVE_AUDIT_AND_IMPLEMENTATION_PLAN.md
```

Debe contener:

1. Resumen ejecutivo.
2. Stack detectado.
3. Inventario de rutas.
4. Inventario de componentes críticos.
5. Problemas encontrados.
6. Nivel de severidad de cada problema.
7. Componentes afectados.
8. Estrategia de solución.
9. Riesgos de regresión.
10. Orden de implementación.
11. Criterios de aceptación.
12. Pruebas necesarias.
13. Decisiones que deben conservarse.
14. Suposiciones realizadas.

Clasifica los problemas como:

* Crítico.
* Alto.
* Medio.
* Bajo.

No te detengas después de crear el plan. Continúa con la implementación.

---

# 6. Sistema responsivo global

Construye o mejora una base responsiva centralizada.

## 6.1. Contenedores

Implementa una estrategia consistente para:

* Ancho máximo de contenido.
* Márgenes automáticos.
* Padding lateral adaptable.
* Secciones de ancho completo.
* Secciones de contenido restringido.
* Espaciado entre bloques.
* Distribución vertical.
* Áreas con scroll controlado.

Evita que cada pantalla defina arbitrariamente sus propios anchos.

---

## 6.2. Breakpoints

Utiliza una escala coherente de breakpoints.

Antes de crear nuevos breakpoints:

* Revisa los existentes.
* Reutilízalos cuando sean adecuados.
* Elimina duplicaciones.
* Documenta cualquier breakpoint nuevo.
* Evita media queries separadas por diferencias mínimas.

Los componentes deben adaptarse al contenido y no depender de detectar un modelo específico de dispositivo.

---

## 6.3. Tokens de diseño

Centraliza cuando corresponda:

* Espaciados.
* Tamaños tipográficos.
* Alturas de controles.
* Radios.
* Sombras.
* Z-index.
* Anchos máximos.
* Breakpoints.
* Tamaños de iconos.
* Áreas táctiles.
* Duraciones de animación.

No cambies innecesariamente la identidad visual existente.

---

## 6.4. Tipografía fluida

Revisa:

* Tamaños mínimos legibles.
* Altura de línea.
* Longitud máxima de párrafos.
* Escalado entre móvil y escritorio.
* Títulos demasiado grandes.
* Cortes de palabra.
* Truncamiento.
* Textos dinámicos.
* Etiquetas extensas.
* Mensajes de error.

Usa funciones como `clamp()` cuando aporten una mejora real y sean compatibles con el sistema actual.

No reduzcas excesivamente el texto para hacerlo caber.

---

# 7. Tratamiento obligatorio por componente

## 7.1. Navegación

La navegación debe:

* Adaptarse a móvil sin saturación.
* Mantener acceso a todas las rutas permitidas.
* Mostrar claramente el elemento activo.
* Ser operable con teclado.
* Ser utilizable con touch.
* Manejar correctamente menús anidados.
* Evitar cubrir el contenido.
* Bloquear correctamente el scroll cuando corresponda.
* Restaurar el scroll al cerrar.
* Gestionar foco al abrir y cerrar.
* Cerrar con Escape cuando corresponda.
* Tener textos accesibles para iconos.

Cuando exista sidebar:

* En escritorio puede permanecer visible.
* En tablet puede compactarse.
* En móvil debe transformarse en drawer u otra solución equivalente.
* Su apertura no debe desplazar o cortar incorrectamente el contenido.
* Debe manejar correctamente el área segura del dispositivo.

---

## 7.2. Formularios

Todos los formularios deben:

* Tener una columna en pantallas estrechas.
* Usar varias columnas solo cuando haya espacio real.
* Mantener etiquetas legibles.
* Mostrar errores sin alterar destructivamente el layout.
* Evitar campos excesivamente pequeños.
* Tener botones alcanzables.
* Permitir el crecimiento de textareas.
* Adaptar grupos de radio y checkbox.
* Evitar que selectores y calendarios salgan del viewport.
* Mostrar acciones principales y secundarias con jerarquía clara.
* Funcionar con teclado virtual.
* Conservar valores y validaciones existentes.

No cambies nombres de campos, payloads ni reglas de validación.

---

## 7.3. Tablas

No soluciones todas las tablas únicamente con scroll horizontal.

Evalúa cada tabla según su finalidad.

Puedes aplicar, según corresponda:

* Scroll horizontal controlado.
* Columnas prioritarias.
* Ocultamiento progresivo de columnas secundarias.
* Vista de tarjetas en móvil.
* Filas expandibles.
* Encabezados fijos.
* Primera columna fija.
* Acciones agrupadas.
* Menú contextual.
* Resumen por fila.
* Indicadores para mostrar que existe contenido desplazable.

La información crítica nunca debe desaparecer sin una alternativa para consultarla.

Las tablas deben conservar:

* Ordenamiento.
* Filtros.
* Paginación.
* Selección.
* Acciones.
* Exportación.
* Estados.
* Permisos.
* Navegación por teclado cuando exista.

---

## 7.4. Modales y drawers

Los modales deben:

* Tener ancho máximo razonable.
* No superar la altura del viewport.
* Permitir scroll interno.
* Mantener visibles las acciones importantes cuando sea conveniente.
* Adaptarse a pantalla completa en móviles pequeños cuando sea necesario.
* Respetar las áreas seguras.
* No quedar detrás del teclado virtual.
* Mantener el foco dentro del modal.
* Devolver el foco al elemento que lo abrió.
* Cerrar correctamente.
* No generar scroll doble accidental.

---

## 7.5. Tarjetas y grids

Los grids deben adaptarse progresivamente:

* Una columna en móvil cuando sea necesario.
* Dos columnas en tablet cuando exista espacio.
* Más columnas únicamente si el contenido mantiene legibilidad.
* Espaciado consistente.
* Alturas flexibles.
* Acciones visibles.
* Textos largos controlados.
* Imágenes con proporción adecuada.

No fuerces el mismo número de columnas en todas las resoluciones.

---

## 7.6. Gráficos y dashboards

Los gráficos deben:

* Redimensionarse según el contenedor.
* Evitar etiquetas superpuestas.
* Ofrecer leyendas adaptables.
* Permitir scroll o cambio de presentación cuando sea necesario.
* Mantener tooltips accesibles.
* Evitar depender únicamente de hover.
* Mostrar estados vacíos.
* Mostrar unidades y contexto.
* Conservar la interpretación correcta de los datos.

Los dashboards deben reorganizar métricas y paneles según prioridad, no simplemente reducirlos proporcionalmente.

---

## 7.7. Imágenes y contenido multimedia

Garantiza:

* `max-width: 100%` cuando corresponda.
* Proporción correcta.
* Uso apropiado de `object-fit`.
* Prevención de layout shifts.
* Carga diferida cuando sea apropiada.
* Resoluciones adecuadas.
* Texto alternativo.
* Contenedores responsivos para videos, mapas e iframes.

---

## 7.8. Botones y acciones

Los controles interactivos deben:

* Tener un área táctil adecuada.
* Conservar separación suficiente.
* No depender únicamente de iconos ambiguos.
* Mostrar estados hover, focus, active y disabled.
* Tener alternativa para interacciones que antes dependían solo de hover.
* Reorganizarse o apilarse en pantallas pequeñas.
* Mantener visible la acción principal.

No reduzcas los botones hasta volverlos difíciles de utilizar.

---

# 8. Accesibilidad obligatoria

Cumple, como mínimo, principios equivalentes a WCAG 2.2 nivel AA cuando sea técnicamente posible.

Revisa:

* Contraste.
* Orden del foco.
* Navegación por teclado.
* Indicadores visibles de foco.
* Etiquetas de formularios.
* Mensajes de error.
* Roles ARIA.
* Nombres accesibles.
* Encabezados semánticos.
* Botones frente a enlaces.
* Diálogos.
* Menús.
* Elementos expandibles.
* Tablas.
* Contenido dinámico.
* Reducción de movimiento.
* Zoom al 200 %.
* Texto alternativo.

No agregues atributos ARIA innecesarios cuando el HTML semántico sea suficiente.

---

# 9. Rendimiento

Las mejoras responsivas no deben degradar el rendimiento.

Evita:

* Observadores globales innecesarios.
* Múltiples listeners de resize.
* Recalcular layouts en cada render.
* Duplicar árboles completos para móvil y escritorio sin justificación.
* Ocultar con CSS grandes estructuras que siguen ejecutando lógica costosa.
* Importar librerías completas para resolver un problema pequeño.
* Animaciones que produzcan reflow constante.
* Imágenes excesivamente pesadas.

Prioriza CSS responsivo sobre JavaScript cuando la decisión sea puramente visual.

Utiliza JavaScript solamente cuando el comportamiento no pueda resolverse correctamente con CSS o cuando la lógica realmente dependa del entorno.

---

# 10. Pruebas obligatorias

## 10.1. Pruebas existentes

Ejecuta y corrige, sin desactivar reglas:

* Instalación de dependencias.
* Type checking.
* Lint.
* Build de producción.
* Pruebas unitarias.
* Pruebas de integración.
* Pruebas end-to-end, si existen.

No silencies errores con:

* `any` innecesario.
* Comentarios para desactivar lint.
* Eliminación de pruebas.
* Exclusión de archivos.
* Capturas vacías de excepciones.
* Condiciones que oculten el problema.

---

## 10.2. Pruebas responsivas

Agrega o mejora pruebas para los flujos principales.

Incluye como mínimo:

* Navegación móvil.
* Apertura y cierre del menú.
* Formularios críticos.
* Tablas críticas.
* Modales.
* Pestañas.
* Dashboard principal.
* Pantallas con mayor densidad de contenido.
* Ausencia de overflow horizontal.
* Elementos interactivos visibles.
* Acciones principales accesibles.

Cuando el proyecto tenga Playwright, Cypress u otra herramienta E2E, reutilízala.

Si no existe testing visual, implementa únicamente lo necesario y compatible con la arquitectura. No introduzcas una infraestructura excesiva sin justificación.

---

## 10.3. Regresión visual

Genera capturas comparativas de las rutas principales en diferentes viewports.

Organízalas por:

* Ruta.
* Resolución.
* Estado.
* Antes.
* Después.

Verifica especialmente:

* Alineación.
* Desbordamiento.
* Superposición.
* Elementos cortados.
* Cambios inesperados de color o tipografía.
* Diferencias entre móvil y escritorio.
* Modales.
* Menús.
* Formularios con errores.
* Tablas con muchos datos.

---

# 11. Estrategia de implementación por fases

## Fase 1 — Auditoría y mapa de riesgos

* Detectar stack.
* Inventariar rutas.
* Inventariar componentes.
* Encontrar problemas.
* Clasificar severidad.
* Crear el plan de implementación.
* Identificar componentes compartidos.

## Fase 2 — Fundamentos responsivos

* Normalizar contenedores.
* Corregir overflow global.
* Centralizar breakpoints.
* Revisar tipografía.
* Revisar espaciados.
* Corregir imágenes y multimedia.
* Revisar layouts principales.

## Fase 3 — Navegación y estructura

* Corregir header.
* Corregir sidebar.
* Corregir navegación móvil.
* Corregir breadcrumbs.
* Corregir pestañas.
* Corregir distribución general.

## Fase 4 — Componentes compartidos

* Formularios.
* Botones.
* Tarjetas.
* Modales.
* Drawers.
* Tablas.
* Filtros.
* Paginación.
* Estados de carga.
* Estados vacíos.
* Mensajes de error.

## Fase 5 — Pantallas específicas

* Corregir cada ruta.
* Reutilizar los componentes mejorados.
* Evitar estilos locales redundantes.
* Validar los flujos de negocio.
* Revisar casos de datos reales.

## Fase 6 — Accesibilidad y touch

* Navegación por teclado.
* Gestión de foco.
* Áreas táctiles.
* Contraste.
* Semántica.
* Reducción de movimiento.
* Zoom y texto aumentado.

## Fase 7 — Pruebas y estabilización

* Lint.
* Type checking.
* Build.
* Pruebas.
* E2E.
* Capturas.
* Matriz de dispositivos.
* Corrección de regresiones.

## Fase 8 — Documentación final

* Cambios realizados.
* Componentes creados.
* Componentes modificados.
* Breakpoints.
* Decisiones.
* Riesgos pendientes.
* Evidencias de prueba.
* Instrucciones para mantener el sistema.

No declares finalizada una fase sin verificar sus criterios de aceptación.

---

# 12. Criterios de aceptación

El trabajo estará completo solamente cuando:

* Todas las rutas importantes hayan sido revisadas.
* No exista scroll horizontal accidental en los viewports evaluados.
* Los componentes críticos sean utilizables desde 320 px.
* Las tablas tengan una estrategia móvil clara.
* Los formularios sean legibles y operables.
* Los modales entren correctamente en la pantalla.
* La navegación móvil permita acceder a todas las rutas autorizadas.
* Los componentes táctiles tengan dimensiones adecuadas.
* La aplicación funcione con zoom al 200 %.
* Las imágenes no se deformen.
* Los textos largos no rompan el layout.
* Los estados de carga, vacío y error sean responsivos.
* No se hayan roto flujos funcionales.
* El lint termine correctamente.
* El type checking termine correctamente.
* El build de producción termine correctamente.
* Las pruebas existentes continúen pasando.
* Se hayan documentado los cambios.
* Se hayan incluido evidencias de validación.

---

# 13. Entregables obligatorios

Entrega:

```text
docs/RESPONSIVE_AUDIT_AND_IMPLEMENTATION_PLAN.md
docs/RESPONSIVE_DESIGN_SYSTEM.md
docs/RESPONSIVE_TEST_MATRIX.md
docs/RESPONSIVE_IMPLEMENTATION_REPORT.md
```

El informe final debe incluir:

1. Resumen de cambios.
2. Problemas detectados.
3. Problemas resueltos.
4. Archivos modificados.
5. Componentes creados.
6. Componentes refactorizados.
7. Breakpoints utilizados.
8. Estrategias aplicadas a tablas.
9. Estrategias aplicadas a navegación.
10. Estrategias aplicadas a formularios.
11. Mejoras de accesibilidad.
12. Pruebas ejecutadas.
13. Resultados de build, lint y type checking.
14. Evidencias visuales.
15. Riesgos o limitaciones restantes.
16. Recomendaciones de mantenimiento.

---

# 14. Forma de trabajar

Durante la ejecución:

* Avanza por fases.
* Informa los hallazgos importantes.
* Corrige primero los problemas estructurales.
* Evita cambios cosméticos sin impacto responsivo.
* Revisa el alcance de cada cambio.
* Ejecuta pruebas después de cada grupo significativo de modificaciones.
* No acumules una gran cantidad de cambios sin comprobarlos.
* No dejes código temporal.
* No dejes componentes duplicados.
* No dejes comentarios pendientes sin una explicación.
* No declares que algo funciona sin haberlo verificado.

Cuando detectes un problema, explica:

```text
Problema:
Causa:
Impacto:
Solución:
Archivos afectados:
Riesgo:
Prueba realizada:
Resultado:
```

---

# 15. Resultado esperado

El resultado debe sentirse como una única aplicación diseñada desde el principio para todos los tamaños de pantalla, no como una versión de escritorio reducida a la fuerza.

La interfaz final debe ser:

* Clara.
* Consistente.
* Cómoda.
* Accesible.
* Rápida.
* Escalable.
* Fácil de mantener.
* Adaptable a nuevos módulos.
* Segura frente a regresiones.
* Preparada para producción.

Comienza inspeccionando el repositorio completo, detecta el stack real, genera el diagnóstico y el plan, y luego ejecuta todas las fases sin detenerte después del análisis.
