# Implementación de un motor profesional de tutoriales interactivos

Actúa como un **arquitecto de software senior especializado en frontend, experiencia de usuario, accesibilidad y diseño de sistemas configurables**.

Necesito que analices la aplicación actual e implementes un **motor completo de tutoriales interactivos**, similar a un *product tour*, que enseñe paso a paso cómo utilizar cada funcionalidad de la plataforma.

La solución debe integrarse con la arquitectura existente, reutilizar los componentes y estilos actuales y evitar romper cualquier funcionalidad ya implementada.

## Objetivo principal

Construir un sistema de tutoriales que permita que cualquier usuario, incluso sin experiencia previa con la aplicación, pueda comprender:

* Qué puede hacer en cada módulo.
* Para qué sirve cada elemento de la interfaz.
* Qué acciones debe realizar.
* En qué orden debe completar un proceso.
* Qué resultado debería obtener.
* Cómo regresar, repetir o continuar un tutorial.

El sistema debe ofrecer dos modalidades complementarias:

1. **Tour contextual dentro de cada pantalla.**
2. **Centro de tutoriales interactivos en una pestaña adicional de la aplicación.**

---

# 1. Auditoría inicial obligatoria

Antes de escribir código:

1. Analiza la arquitectura completa del frontend.
2. Identifica:

   * Framework y versión.
   * Sistema de rutas.
   * Sistema de autenticación.
   * Roles y permisos.
   * Estado global.
   * Componentes compartidos.
   * Menús y navegación.
   * Sistema de estilos.
   * Componentes de modales, tooltips, popovers y overlays.
   * Módulos principales de la aplicación.
   * Flujos críticos para el usuario.
3. Determina qué librerías ya instaladas pueden reutilizarse.
4. Evita instalar dependencias innecesarias.
5. Documenta brevemente:

   * Situación actual.
   * Decisiones arquitectónicas.
   * Riesgos detectados.
   * Estrategia de implementación.

No comiences creando componentes aislados sin comprender primero la arquitectura existente.

---

# 2. Motor de tours contextuales

Implementa un motor reutilizable que permita mostrar tutoriales directamente sobre la interfaz real.

Cada tutorial deberá estar dividido en pasos pequeños, claros y fáciles de comprender.

Cada paso debe poder incluir:

* Identificador único.
* Título.
* Descripción.
* Elemento de la interfaz que debe resaltarse.
* Posición del mensaje.
* Acción esperada del usuario.
* Ruta donde debe ejecutarse.
* Orden del paso.
* Botón para avanzar.
* Botón para retroceder.
* Botón para omitir.
* Botón para cerrar.
* Validación opcional antes de avanzar.
* Mensaje de error o ayuda.
* Acción automática opcional.
* Tiempo de espera opcional para elementos dinámicos.
* Condiciones por rol o permiso.
* Indicador de progreso.
* Enlace con el siguiente tutorial.

El motor debe soportar elementos que:

* Se carguen de manera asíncrona.
* Aparezcan después de una petición al backend.
* Estén dentro de modales.
* Estén dentro de menús desplegables.
* Se encuentren en tablas.
* Estén dentro de formularios.
* Cambien según el rol del usuario.
* Requieran navegación entre distintas rutas.

Si un elemento objetivo no existe, el sistema no debe bloquearse. Debe manejar el error de forma controlada, registrar el problema y permitir continuar, reintentar o cerrar el tutorial.

---

# 3. Configuración basada en datos

Los tutoriales no deben quedar programados directamente dentro de cada componente.

Diseña una estructura configurable y extensible, por ejemplo:

```typescript
interface TutorialDefinition {
  id: string;
  version: string;
  title: string;
  description: string;
  category: string;
  route?: string;
  roles?: string[];
  estimatedMinutes?: number;
  prerequisites?: string[];
  steps: TutorialStep[];
}
```

La definición exacta debe adaptarse al proyecto, pero debe mantenerse:

* Tipada.
* Validable.
* Modular.
* Escalable.
* Fácil de mantener.
* Independiente de la presentación visual.

Agregar un tutorial nuevo debe requerir principalmente crear una nueva configuración, no modificar el motor central.

Implementa validaciones para detectar:

* Identificadores duplicados.
* Pasos sin elemento objetivo.
* Orden incorrecto.
* Rutas inexistentes.
* Tutoriales vacíos.
* Referencias inválidas.
* Dependencias circulares.
* Configuraciones incompatibles con determinados roles.

---

# 4. Pestaña adicional: Centro de Tutoriales

Agrega una nueva pestaña o sección principal llamada:

**Tutoriales**, **Centro de ayuda** o un nombre coherente con el lenguaje actual de la aplicación.

Esta pestaña debe contener un centro de aprendizaje interactivo con:

* Listado de tutoriales disponibles.
* Tutoriales recomendados.
* Tutoriales obligatorios.
* Tutoriales completados.
* Tutoriales pendientes.
* Tutoriales en progreso.
* Porcentaje general de avance.
* Categorías o módulos.
* Buscador.
* Filtros.
* Tiempo estimado.
* Nivel de dificultad.
* Descripción de cada tutorial.
* Botón para comenzar.
* Botón para continuar.
* Botón para reiniciar.
* Botón para repetir.
* Indicador de requisitos previos.

Cada tutorial abierto desde esta pestaña debe ejecutar el recorrido sobre la interfaz real de la aplicación.

Cuando el tutorial necesite visitar otra pantalla, el sistema deberá navegar automáticamente o guiar al usuario de forma segura.

---

# 5. Tutorial interactivo paso a paso

Además del recorrido visual, cada tutorial debe funcionar como una guía práctica.

Debe poder exigir que el usuario realice una acción antes de avanzar, por ejemplo:

* Abrir un menú.
* Presionar un botón.
* Completar un campo.
* Seleccionar una opción.
* Crear un registro.
* Aplicar un filtro.
* Navegar a otra pantalla.
* Confirmar una operación.

La validación debe ser segura y no debe provocar cambios reales peligrosos.

Cuando sea necesario trabajar con ejemplos, utiliza:

* Datos de demostración.
* Entornos de prueba.
* Acciones simuladas.
* Registros temporales claramente identificados.

No ejecutes automáticamente operaciones destructivas, pagos, eliminaciones definitivas ni acciones sensibles.

---

# 6. Experiencia de usuario

La experiencia debe sentirse moderna, natural y no invasiva.

Incluye:

* Overlay visual.
* Resaltado del elemento activo.
* Flecha o indicador hacia el elemento.
* Animaciones discretas.
* Transiciones suaves.
* Barra o contador de progreso.
* Textos breves y comprensibles.
* Diseño responsive.
* Compatibilidad con modo claro y oscuro, si existen.
* Botón para cerrar.
* Confirmación antes de abandonar un tutorial en progreso.
* Opción de no volver a mostrar un tutorial introductorio.
* Opción para repetir cualquier tutorial desde el centro de ayuda.

Evita textos excesivamente técnicos.

Cada paso debe explicar una sola acción principal.

No bloquees innecesariamente toda la interfaz cuando el usuario necesite interactuar con un elemento concreto.

---

# 7. Persistencia del progreso

Guarda el avance de cada usuario.

Como mínimo, registra:

* Tutorial iniciado.
* Tutorial completado.
* Tutorial omitido.
* Paso actual.
* Fecha de inicio.
* Fecha de finalización.
* Última interacción.
* Versión del tutorial.
* Cantidad de repeticiones.

Primero analiza si esta información debe persistirse en:

* Backend.
* Base de datos.
* Estado global.
* Almacenamiento local.

Prioriza la persistencia en backend cuando el usuario tenga una cuenta autenticada, para que pueda continuar desde otro dispositivo.

El almacenamiento local puede utilizarse como respaldo temporal, pero no debe ser la única fuente de verdad cuando exista infraestructura de backend disponible.

Cuando cambie la versión de un tutorial, define una estrategia para decidir si el usuario debe repetirlo.

---

# 8. Roles, permisos y contexto

Los tutoriales deben respetar completamente los permisos actuales.

Un usuario no debe ver tutoriales de:

* Módulos a los que no tiene acceso.
* Acciones que su rol no puede ejecutar.
* Funciones deshabilitadas.
* Funciones no disponibles para su organización o plan.

La lista de tutoriales y sus pasos debe filtrarse según:

* Rol.
* Permisos.
* Estado de la cuenta.
* Módulos habilitados.
* Contexto organizacional.
* Configuración del sistema.

Nunca utilices el tutorial para evadir una validación de permisos.

---

# 9. Accesibilidad

La implementación debe cumplir buenas prácticas de accesibilidad:

* Navegación mediante teclado.
* Manejo correcto del foco.
* Uso adecuado de ARIA.
* Contraste suficiente.
* Compatibilidad razonable con lectores de pantalla.
* Cierre mediante la tecla Escape.
* Avance mediante teclado cuando corresponda.
* Restauración del foco al finalizar.
* Respeto por la preferencia `prefers-reduced-motion`.

La solución no debe depender exclusivamente del color para comunicar el estado.

---

# 10. Arquitectura esperada

Organiza la solución en responsabilidades separadas.

Como referencia, podrían existir piezas equivalentes a:

* `TutorialEngine`
* `TutorialRegistry`
* `TutorialService`
* `TutorialState`
* `TutorialOverlay`
* `TutorialTooltip`
* `TutorialProgress`
* `TutorialCenter`
* `TutorialCard`
* `TutorialLauncher`
* `TutorialStorageAdapter`
* `TutorialAnalyticsAdapter`
* `TutorialTargetDirective` o equivalente
* Configuraciones por módulo

Los nombres y la estructura final deben adaptarse a la arquitectura real del proyecto.

Evita:

* Componentes gigantes.
* Archivos innecesariamente extensos.
* Condicionales repetidos.
* Configuraciones duplicadas.
* Dependencias circulares.
* Lógica de negocio dentro de componentes visuales.
* Uso excesivo de valores mágicos.
* Selectores frágiles basados únicamente en clases CSS.

Para identificar elementos del tutorial, utiliza atributos estables, por ejemplo:

```html
data-tutorial-id="create-user-button"
```

o una solución equivalente apropiada para el framework.

---

# 11. Integración con el backend

Analiza si el backend ya cuenta con infraestructura para almacenar preferencias o progreso del usuario.

Cuando sea necesario, implementa o documenta los contratos requeridos para:

* Obtener tutoriales disponibles.
* Obtener progreso del usuario.
* Iniciar un tutorial.
* Actualizar el paso actual.
* Marcar un tutorial como completado.
* Omitir un tutorial.
* Reiniciar el progreso.

Las operaciones deben ser idempotentes cuando corresponda.

Incluye validación de entrada, autorización, manejo de errores y contratos tipados.

No expongas información sensible ni permitas que un usuario modifique el progreso de otro.

---

# 12. Tutoriales iniciales

Después de construir el motor, crea tutoriales funcionales para los flujos más importantes de la aplicación.

Como mínimo, identifica e implementa:

1. Introducción general a la plataforma.
2. Navegación principal.
3. Uso del perfil.
4. Flujo principal del negocio.
5. Creación del registro más importante del sistema.
6. Consulta o búsqueda de información.
7. Uso de filtros y tablas.
8. Configuración básica.
9. Acceso al centro de ayuda.
10. Tutorial específico para cada rol principal.

No inventes funcionalidades inexistentes. Los tutoriales deben basarse en los flujos reales encontrados durante la auditoría.

---

# 13. Pruebas obligatorias

Implementa pruebas para:

* Registro de tutoriales.
* Inicio y finalización.
* Avance y retroceso.
* Persistencia.
* Reinicio.
* Filtrado por rol.
* Navegación entre rutas.
* Elementos que aparecen de forma asíncrona.
* Elementos inexistentes.
* Cierre anticipado.
* Reanudación.
* Cambio de versión.
* Uso mediante teclado.
* Vista responsive.
* Tutoriales dentro de modales.
* Prevención de duplicados.
* Validación de configuraciones.

Incluye:

* Pruebas unitarias.
* Pruebas de integración.
* Pruebas end-to-end para los recorridos principales.
* Pruebas básicas de accesibilidad.

Las pruebas no deben depender de temporizadores frágiles. Utiliza condiciones explícitas y esperas controladas.

---

# 14. Documentación

Genera documentación técnica en Markdown que explique:

* Arquitectura del motor.
* Flujo de ejecución.
* Estructura de un tutorial.
* Cómo crear un tutorial nuevo.
* Cómo agregar pasos.
* Cómo asociar elementos de la interfaz.
* Cómo validar acciones.
* Cómo manejar rutas y modales.
* Cómo restringir tutoriales por rol.
* Cómo versionar tutoriales.
* Cómo ejecutar las pruebas.
* Cómo diagnosticar errores.
* Decisiones tomadas.
* Limitaciones conocidas.

Incluye un ejemplo completo y funcional de configuración.

---

# 15. Plan de implementación

Trabaja por fases:

## Fase 1: análisis

* Auditoría de la aplicación.
* Inventario de módulos y flujos.
* Revisión de dependencias.
* Propuesta de arquitectura.
* Identificación de riesgos.

## Fase 2: núcleo

* Modelos y contratos.
* Registro de tutoriales.
* Estado del motor.
* Navegación entre pasos.
* Identificación de elementos.
* Manejo de errores.

## Fase 3: interfaz

* Overlay.
* Tooltip.
* Controles.
* Indicador de progreso.
* Animaciones.
* Accesibilidad.
* Responsive.

## Fase 4: Centro de Tutoriales

* Nueva pestaña.
* Listado.
* Buscador.
* Filtros.
* Estados de progreso.
* Inicio, continuación y reinicio.

## Fase 5: persistencia

* Integración con usuario.
* Almacenamiento del progreso.
* Versionado.
* Sincronización.
* Manejo offline temporal, cuando corresponda.

## Fase 6: tutoriales reales

* Tutorial introductorio.
* Tutoriales por módulo.
* Tutoriales por rol.
* Validaciones interactivas.

## Fase 7: calidad

* Pruebas.
* Accesibilidad.
* Revisión responsive.
* Optimización.
* Documentación.

---

# 16. Criterios de aceptación

La tarea se considerará terminada únicamente cuando:

* Exista un motor reutilizable y configurable.
* Los tutoriales estén desacoplados de los componentes visuales.
* Se pueda crear un tutorial nuevo sin modificar el núcleo.
* Exista una pestaña adicional con el Centro de Tutoriales.
* El usuario pueda iniciar, pausar, continuar, repetir y reiniciar tutoriales.
* El progreso se mantenga correctamente.
* Los tutoriales respeten roles y permisos.
* Los recorridos funcionen entre distintas rutas.
* Los elementos dinámicos se manejen sin errores.
* La experiencia sea responsive y accesible.
* Existan tutoriales funcionales sobre los flujos reales.
* Las pruebas principales estén aprobadas.
* La documentación esté completa.
* No se hayan roto funcionalidades existentes.
* No queden errores de compilación, tipado, lint ni pruebas.

---

# 17. Reglas de ejecución

* No realices una implementación superficial.
* No dejes componentes de demostración desconectados.
* No reemplaces la arquitectura existente sin justificación.
* No dupliques componentes ya disponibles.
* No uses datos ficticios Sen producción.
* No ignores los roles y permisos.
* No ocultes errores con bloques `try/catch` vacíos.
* No utilices `any` salvo justificación excepcional.
* No dejes tareas críticas pendientes.
* Mantén archivos y clases con responsabilidades claras.
* Reutiliza el sistema visual actual.
* Conserva compatibilidad con las funcionalidades existentes.
* Ejecuta compilación, lint, pruebas y revisión final.

Al terminar, presenta:

1. Resumen de la auditoría.
2. Arquitectura implementada.
3. Archivos creados y modificados.
4. Tutoriales agregados.
5. Pruebas ejecutadas.
6. Resultados obtenidos.
7. Decisiones técnicas.
8. Riesgos o limitaciones reales.
9. Instrucciones para agregar nuevos tutoriales.
10. Evidencia de que el proyecto compila y funciona correctamente.
