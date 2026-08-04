# Prompt maestro para mejorar visualmente cualquier frontend

Actúa como arquitecto frontend senior, diseñador UX/UI, especialista en motion design, sistemas de diseño, accesibilidad, rendimiento y experiencias digitales modernas.

Tu tarea consiste en realizar una auditoría visual y técnica integral del frontend actual y proponer una mejora profunda de su experiencia visual, sin romper funcionalidades existentes, flujos de negocio, contratos con el backend, rutas, validaciones, permisos ni comportamiento responsive.

El objetivo no es realizar cambios decorativos aislados. Debes transformar el frontend en una experiencia:

* Moderna.
* Profesional.
* Visualmente atractiva.
* Dinámica.
* Reactiva.
* Coherente.
* Accesible.
* Responsive.
* Mantenible.
* Optimizada.
* Adaptable a cualquier tipo de producto digital.

Debes prestar especial atención a los fondos de las interfaces, ya que actualmente se busca que dejen de ser superficies planas, vacías o genéricas y se conviertan en una parte activa de la identidad visual del producto.

---

# 1. Auditoría inicial obligatoria

Antes de proponer o implementar cambios, analiza integralmente:

* Arquitectura actual del frontend.
* Framework y versión utilizada.
* Sistema de estilos.
* Librerías de componentes.
* Librerías de iconos.
* Librerías de animación.
* Sistema de rutas.
* Layouts principales.
* Componentes reutilizables.
* Páginas públicas.
* Páginas autenticadas.
* Formularios.
* Modales.
* Tablas.
* Dashboards.
* Login.
* Registro.
* Onboarding.
* Estados vacíos.
* Estados de carga.
* Mensajes de error.
* Fondos actuales.
* Comportamiento responsive.
* Accesibilidad.
* Rendimiento.
* Consistencia visual.

Identifica:

* Interfaces demasiado planas.
* Fondos vacíos o genéricos.
* Uso excesivo de blanco sólido.
* Falta de profundidad visual.
* Falta de jerarquía.
* Animaciones inconsistentes.
* Componentes sin feedback.
* Elementos sin estados interactivos.
* Espacios desaprovechados.
* Problemas de contraste.
* Ruido visual.
* Repetición innecesaria.
* Componentes duplicados.
* Problemas en dispositivos móviles.
* Problemas de rendimiento.
* Riesgos de accesibilidad.

Clasifica cada hallazgo como:

* Correcto.
* Mejorable.
* Inconsistente.
* Crítico.
* Requiere rediseño.
* Requiere decisión funcional.

No modifiques el código antes de presentar el diagnóstico.

---

# 2. Objetivo visual general

Define una dirección visual coherente para todo el frontend.

La interfaz debe transmitir, según el producto:

* Confianza.
* Claridad.
* Modernidad.
* Solidez.
* Innovación.
* Facilidad de uso.
* Profesionalismo.
* Sensación de producto terminado.

Evita que el resultado parezca:

* Una plantilla genérica.
* Un dashboard administrativo sin identidad.
* Una interfaz excesivamente blanca.
* Un conjunto de componentes aislados.
* Una aplicación sobrecargada.
* Una presentación infantil.
* Un sitio con animaciones sin propósito.
* Un diseño generado automáticamente sin coherencia.

Todos los elementos deben formar parte de un sistema visual común.

---

# 3. Prioridad principal: sistema de fondos

Diseña un sistema de fondos completo para toda la aplicación.

Los fondos no deben limitarse a un color plano. Deben contribuir a:

* Construir identidad visual.
* Generar profundidad.
* Separar secciones.
* Reforzar jerarquías.
* Guiar la atención.
* Mejorar la percepción de calidad.
* Reducir la sensación de vacío.
* Crear continuidad entre pantallas.
* Reaccionar de forma sutil a la interacción.

## 3.1 Tipos de fondos que debes evaluar

Analiza y propone el uso adecuado de:

* Gradientes lineales.
* Gradientes radiales.
* Gradientes cónicos.
* Mallas de gradientes.
* Luces difusas.
* Resplandores ambientales.
* Formas abstractas.
* Blobs orgánicos.
* Ondas.
* Líneas curvas.
* Patrones geométricos.
* Rejillas tecnológicas.
* Puntos o partículas.
* Texturas sutiles.
* Ruido visual ligero.
* Capas translúcidas.
* Efectos de vidrio.
* Sombras ambientales.
* Halos alrededor de componentes importantes.
* Ilustraciones de fondo.
* Formas vectoriales.
* Elementos 3D ligeros, cuando sean apropiados.
* Parallax moderado.
* Fondos que reaccionen al cursor.
* Fondos que respondan al scroll.
* Fondos que cambien según la sección.
* Fondos vinculados al estado del sistema.
* Fondos adaptados a modo claro y oscuro.

No utilices todos estos efectos simultáneamente. Selecciona únicamente los que aporten valor al producto.

## 3.2 Arquitectura de capas del fondo

Construye los fondos utilizando capas independientes.

Como referencia, evalúa una estructura como:

1. Color base.
2. Gradiente principal.
3. Gradiente secundario.
4. Forma o patrón abstracto.
5. Iluminación ambiental.
6. Textura o ruido.
7. Elemento dinámico.
8. Capa de contraste para proteger el contenido.
9. Contenido principal.

Cada capa debe tener:

* Una función específica.
* Bajo impacto en el rendimiento.
* Opacidad controlada.
* Adaptación responsive.
* Comportamiento coherente en modo claro y oscuro.
* Compatibilidad con usuarios que reduzcan las animaciones.

## 3.3 Fondos por contexto

No utilices el mismo fondo para todas las vistas.

Define variantes para:

### Fondo de autenticación

Aplicable a:

* Login.
* Registro.
* Recuperación de contraseña.
* Verificación.
* Cambio de contraseña.

Debe ser más visual, expresivo y memorable.

Puede incluir:

* Gradientes dinámicos.
* Formas abstractas.
* Luces ambientales.
* Patrones.
* Ilustraciones.
* Elementos que reaccionen al cursor.
* Paneles flotantes.
* Mensajes de valor.
* Indicadores de seguridad.
* Capas de profundidad.

### Fondo de dashboard

Debe ser más sobrio.

Puede incluir:

* Gradiente ambiental ligero.
* Rejilla casi imperceptible.
* Luces localizadas.
* Separación visual por zonas.
* Fondos suaves detrás de widgets.
* Transiciones entre secciones.

### Fondo de formularios

Debe favorecer la concentración.

Utiliza:

* Fondos limpios.
* Contraste estable.
* Profundidad ligera.
* Elementos decorativos alejados de los campos.
* Iluminación suave alrededor del formulario.
* Separación clara entre pasos.

### Fondo de tablas y administración

Debe priorizar legibilidad.

Utiliza:

* Capas neutras.
* Superficies diferenciadas.
* Patrones mínimos.
* Contraste preciso.
* Fondos visualmente tranquilos.
* Sombras o bordes suaves.

### Fondo de landing o portada

Puede tener mayor riqueza visual.

Evalúa:

* Hero dinámico.
* Gradientes animados.
* Ilustraciones.
* Formas flotantes.
* Elementos 3D optimizados.
* Movimiento basado en scroll.
* Capas con profundidad.
* Transiciones entre secciones.

### Fondo de estados vacíos

Debe evitar que la pantalla se sienta incompleta.

Incorpora:

* Ilustración.
* Ícono principal.
* Formas sutiles.
* Mensaje claro.
* Acción recomendada.
* Ambientación visual relacionada con el contexto.

### Fondo de errores o restricciones

Debe comunicar el estado sin resultar agresivo.

Utiliza:

* Colores semánticos controlados.
* Ilustraciones.
* Formas de apoyo.
* Mensajes comprensibles.
* Acciones de recuperación.

## 3.4 Fondos reactivos

Propón fondos que puedan responder de forma sutil a:

* Movimiento del cursor.
* Posición del dispositivo.
* Scroll.
* Cambio de pestaña.
* Selección de una tarjeta.
* Estado activo del menú.
* Paso actual de un onboarding.
* Estado de carga.
* Confirmación de una acción.
* Error.
* Éxito.
* Cambio entre modo claro y oscuro.

Las reacciones deben ser suaves y no competir con el contenido.

Ejemplos permitidos:

* Una luz difusa que siga lentamente el cursor.
* Formas que se desplacen unos pocos píxeles.
* Gradientes que cambien de posición.
* Partículas que respondan con baja intensidad.
* Una iluminación que destaque la sección activa.
* Cambios cromáticos controlados según el estado.
* Profundidad mediante parallax mínimo.
* Ondas suaves al cambiar de paso.

Evita:

* Movimientos bruscos.
* Animaciones permanentes demasiado rápidas.
* Efectos que dificulten la lectura.
* Fondos que consuman recursos excesivos.
* Interacciones que dependan únicamente del cursor.
* Efectos molestos en dispositivos móviles.

## 3.5 Fondos dinámicos según el estado

Evalúa la posibilidad de que el fondo cambie sutilmente según el contexto.

Por ejemplo:

* Estado normal: fondo neutro.
* Proceso en curso: movimiento suave.
* Operación exitosa: iluminación positiva breve.
* Advertencia: cambio ambiental controlado.
* Error: énfasis semántico sin saturación.
* Usuario bloqueado: menor luminosidad.
* Proceso completado: transición visual de cierre.
* Onboarding: variación gradual según el avance.

Estos cambios no deben reemplazar los mensajes, iconos o estados accesibles. Solo deben reforzarlos.

## 3.6 Fondos para dispositivos móviles

Adapta los fondos específicamente para móviles.

No reduzcas únicamente el tamaño del diseño de escritorio.

Debes:

* Simplificar capas.
* Reducir partículas.
* Eliminar efectos innecesarios.
* Limitar el parallax.
* Evitar fondos que interfieran con el teclado.
* Mantener la legibilidad.
* Cuidar áreas seguras.
* Evitar desbordamientos.
* Reducir consumo de batería.
* Mantener buen rendimiento en dispositivos modestos.
* Usar variantes específicas para orientación vertical.

---

# 4. Login visualmente enriquecido

El login debe recibir una mejora prioritaria.

No debe sentirse vacío, genérico ni compuesto únicamente por un formulario centrado.

Diseña una experiencia de autenticación con:

* Identidad visual clara.
* Fondo dinámico.
* Ilustración o composición visual.
* Formas abstractas.
* Gradientes.
* Iconografía.
* Elementos flotantes.
* Mensaje principal.
* Texto de apoyo.
* Indicadores de seguridad.
* Beneficios o características del producto.
* Estados de validación.
* Feedback inmediato.
* Transiciones fluidas.
* Carga visual elegante.
* Recuperación de contraseña integrada.
* Adaptación completa a móviles.

## 4.1 Estructura sugerida

Evalúa una composición dividida en dos áreas:

### Zona visual

Puede incluir:

* Marca.
* Mensaje de valor.
* Ilustración.
* Fondo animado.
* Elementos abstractos.
* Métricas.
* Mensajes de confianza.
* Testimonios cortos.
* Indicadores de seguridad.
* Elementos relacionados con el producto.

### Zona funcional

Debe contener:

* Formulario.
* Inicio de sesión social, si existe.
* Recuperación de contraseña.
* Mostrar u ocultar contraseña.
* Recordar sesión.
* Validaciones.
* Mensajes de error.
* Estado de envío.
* Enlaces secundarios.
* Ayuda contextual.

En móviles, ambas zonas deben reorganizarse sin perder identidad visual.

## 4.2 Variantes de login

Propón al menos tres variantes:

### Variante corporativa

* Sobria.
* Elegante.
* Institucional.
* Con efectos visuales controlados.
* Prioriza confianza.

### Variante tecnológica

* Fondos reactivos.
* Gradientes.
* Formas dinámicas.
* Elementos visuales con profundidad.
* Mayor sensación de innovación.

### Variante premium

* Composición editorial.
* Iluminación ambiental.
* Superficies translúcidas.
* Ilustración de alta calidad.
* Microinteracciones.
* Alta percepción de producto.

Selecciona una variante recomendada y justifica la elección.

---

# 5. Iconos, ilustraciones y elementos visuales

Incorpora iconografía coherente en:

* Menús.
* Botones.
* Formularios.
* Tarjetas.
* Tablas.
* Alertas.
* Modales.
* Estados.
* Pasos de onboarding.
* Acciones rápidas.
* Mensajes vacíos.
* Mensajes de error.
* Confirmaciones.
* Cargas.
* Navegación.

Los iconos deben:

* Compartir el mismo estilo.
* Tener tamaño consistente.
* No sustituir texto importante.
* Ser accesibles.
* Comunicar una acción real.
* Evitar ambigüedad.
* Mantener coherencia de grosor y proporción.

Utiliza ilustraciones cuando ayuden a:

* Explicar procesos.
* Humanizar pantallas.
* Reducir sensación de vacío.
* Mejorar onboarding.
* Comunicar estados complejos.
* Reforzar la identidad visual.

Evita ilustraciones genéricas que no tengan relación con el producto.

---

# 6. Animaciones y motion design

Define una estrategia global de movimiento.

Las animaciones deben tener propósito:

* Explicar cambios.
* Dar continuidad.
* Confirmar acciones.
* Orientar al usuario.
* Reforzar jerarquías.
* Reducir percepción de espera.
* Comunicar estados.
* Mejorar la sensación de calidad.

Aplica animaciones en:

* Entrada y salida de componentes.
* Apertura de modales.
* Expansión de menús.
* Cambios de pestaña.
* Navegación entre pasos.
* Validaciones.
* Botones.
* Inputs.
* Tooltips.
* Toasts.
* Tarjetas.
* Gráficos.
* Fondos.
* Estados de carga.
* Confirmaciones.

Define una escala de movimiento:

* Microinteracción: entre 100 y 180 ms.
* Interacción estándar: entre 180 y 300 ms.
* Transición de vista: entre 250 y 450 ms.
* Animación ambiental: lenta y continua.
* Confirmación destacada: breve y controlada.

Las duraciones son referencias y deben adaptarse al sistema existente.

Evita:

* Animar todo.
* Efectos elásticos excesivos.
* Rebotes constantes.
* Animaciones decorativas en acciones críticas.
* Transiciones lentas.
* Movimiento que genere mareo.
* Animaciones que bloqueen la interacción.

Respeta `prefers-reduced-motion`.

---

# 7. Grafos, flujos y visualizaciones

Cuando el frontend incluya grafos, diagramas, procesos, árboles, nodos o relaciones, mejora su presentación mediante:

* Nodos con iconos.
* Estados visuales.
* Bordes semánticos.
* Badges.
* Etiquetas.
* Tooltips.
* Conexiones animadas.
* Resaltado de rutas activas.
* Zoom.
* Pan.
* Minimap, si aporta valor.
* Selección múltiple.
* Vista de detalle.
* Animaciones de transición.
* Jerarquía entre nodos.
* Diferenciación de nodos iniciales, intermedios y finales.

Las conexiones pueden animarse para representar:

* Flujo activo.
* Procesamiento.
* Dependencia.
* Error.
* Ruta seleccionada.
* Resultado exitoso.

No animes permanentemente todas las conexiones.

Solo deben tener movimiento:

* La ruta activa.
* El nodo seleccionado.
* Un proceso en ejecución.
* Una transición reciente.
* Un error que requiera atención.

---

# 8. Sistema visual de estados

Crea un sistema reutilizable para representar:

* Neutral.
* Pendiente.
* En progreso.
* En revisión.
* Incompleto.
* Requiere acción.
* Correcto.
* Aprobado.
* Advertencia.
* Error.
* Rechazado.
* Bloqueado.
* Deshabilitado.
* Finalizado.

Para cada estado define:

* Color semántico.
* Icono.
* Badge.
* Fondo.
* Borde.
* Texto.
* Prioridad.
* Animación permitida.
* Uso en modo claro.
* Uso en modo oscuro.
* Requisitos de contraste.

No dependas únicamente del color para comunicar estados.

---

# 9. Componentes que deben mejorarse

Revisa y mejora visualmente:

* Navbar.
* Sidebar.
* Breadcrumbs.
* Tabs.
* Botones.
* Inputs.
* Selects.
* Checkboxes.
* Radios.
* Switches.
* Date pickers.
* Formularios.
* Cards.
* Tablas.
* Filtros.
* Buscadores.
* Paginación.
* Modales.
* Drawers.
* Tooltips.
* Popovers.
* Toasts.
* Alertas.
* Skeletons.
* Loaders.
* Dashboards.
* KPIs.
* Gráficos.
* Onboarding.
* Login.
* Registro.
* Estados vacíos.
* Errores.
* Confirmaciones.

Para cada componente analiza:

* Jerarquía visual.
* Espaciado.
* Tipografía.
* Contraste.
* Estados.
* Interacción.
* Animación.
* Responsive.
* Accesibilidad.
* Reutilización.

---

# 10. Diseño responsive

La mejora debe funcionar correctamente en:

* Móviles pequeños.
* Móviles grandes.
* Tablets.
* Portátiles.
* Monitores de escritorio.
* Pantallas amplias.

No adaptes el diseño únicamente reduciendo tamaños.

Debes revisar:

* Jerarquía.
* Distribución.
* Navegación.
* Fondos.
* Formularios.
* Tablas.
* Modales.
* Gráficos.
* Espaciado.
* Tipografía.
* Zonas táctiles.
* Menús.
* Elementos flotantes.
* Animaciones.
* Imágenes.
* Contenido secundario.

El contenido prioritario debe mantenerse visible y comprensible en todos los dispositivos.

---

# 11. Modo claro y oscuro

Si el proyecto soporta modo oscuro o puede incorporarlo sin romper su arquitectura, diseña ambos modos como experiencias completas.

No conviertas el modo claro en oscuro mediante una simple inversión de colores.

Para cada modo define:

* Fondo base.
* Gradientes.
* Superficies.
* Bordes.
* Sombras.
* Texto.
* Iconos.
* Estados.
* Gráficos.
* Ilustraciones.
* Intensidad de luces.
* Profundidad.

Los fondos dinámicos deben tener variantes específicas para cada modo.

---

# 12. Accesibilidad

La propuesta debe cumplir principios de accesibilidad.

Revisa:

* Contraste.
* Navegación por teclado.
* Focus visible.
* Lectores de pantalla.
* Etiquetas.
* Mensajes de error.
* Estados de carga.
* Tamaño táctil.
* Orden semántico.
* Uso de iconos.
* Movimiento reducido.
* Zoom.
* Tipografía.
* Contenido alternativo.
* Legibilidad sobre fondos dinámicos.

Los fondos nunca deben perjudicar:

* La lectura.
* El foco.
* La identificación de controles.
* La comprensión de errores.
* La navegación.

---

# 13. Rendimiento visual

La riqueza visual no debe deteriorar la experiencia.

Controla:

* Cantidad de partículas.
* Capas de blur.
* Sombras.
* Filtros.
* Animaciones simultáneas.
* Imágenes pesadas.
* Videos de fondo.
* Canvas.
* WebGL.
* Componentes 3D.
* Re-renderizados.
* Eventos de cursor.
* Eventos de scroll.
* Consumo de memoria.
* Uso de GPU.
* Consumo de batería.

Aplica:

* Lazy loading.
* Code splitting.
* Carga progresiva.
* Imágenes optimizadas.
* Formatos modernos.
* Animación mediante transform y opacity.
* Reducción de efectos en dispositivos lentos.
* Fallbacks estáticos.
* Pausa de animaciones fuera del viewport.
* Desactivación de efectos cuando la pestaña no esté activa.

Evita incorporar WebGL, video o motores 3D si una solución CSS, SVG o Canvas ligera logra un resultado similar.

---

# 14. Arquitectura y reutilización

No disperses estilos y animaciones por toda la aplicación.

Construye un sistema reutilizable.

Considera crear:

* Tokens de color.
* Tokens de espaciado.
* Tokens tipográficos.
* Tokens de sombras.
* Tokens de radios.
* Tokens de movimiento.
* Tokens de profundidad.
* Tokens para fondos.
* Variantes de superficies.
* Variantes de iluminación.
* Componentes de background reutilizables.
* Componente de partículas.
* Componente de gradiente reactivo.
* Componente de formas decorativas.
* Componente de fondo de autenticación.
* Componente de fondo de dashboard.
* Sistema de estados.
* Sistema de iconografía.
* Wrappers de animación.
* Layouts reutilizables.

Evita:

* Valores hardcodeados sin justificación.
* Animaciones duplicadas.
* Fondos definidos directamente en cada página.
* Dependencias innecesarias.
* Componentes monolíticos.
* Archivos excesivamente grandes.
* Lógica visual mezclada con lógica de negocio.

---

# 15. Reglas de implementación

Durante la implementación:

* No rompas funcionalidades.
* No modifiques contratos de API sin necesidad.
* No elimines validaciones existentes.
* No alteres permisos.
* No cambies rutas sin justificarlo.
* No reemplaces componentes funcionales sin revisar sus dependencias.
* No introduzcas librerías innecesarias.
* No dupliques estilos.
* No dejes código muerto.
* No uses efectos visuales sin fallback.
* No sacrifiques rendimiento por estética.
* No sacrifiques accesibilidad.
* No uses animaciones excesivas.
* No agregues fondos que reduzcan el contraste.
* No inventes funcionalidades.

Realiza cambios progresivos, verificables y reversibles.

---

# 16. Plan de trabajo por fases

Organiza la propuesta como mínimo en estas fases:

## Fase 1. Auditoría

* Revisar arquitectura.
* Detectar inconsistencias.
* Identificar componentes críticos.
* Analizar fondos existentes.
* Evaluar rendimiento.
* Revisar responsive.
* Revisar accesibilidad.

## Fase 2. Sistema visual

* Definir tokens.
* Definir colores.
* Definir tipografía.
* Definir superficies.
* Definir sombras.
* Definir radios.
* Definir iconografía.
* Definir estados.
* Definir motion.

## Fase 3. Sistema de fondos

* Crear fondos base.
* Crear variantes por contexto.
* Crear fondos claros y oscuros.
* Implementar capas.
* Implementar fondos reactivos.
* Crear fallbacks.
* Optimizar móviles.
* Validar rendimiento.

## Fase 4. Login y autenticación

* Rediseñar login.
* Mejorar registro.
* Mejorar recuperación.
* Incorporar fondo visual.
* Incorporar microinteracciones.
* Mejorar validaciones.
* Adaptar a móviles.

## Fase 5. Componentes generales

* Mejorar navegación.
* Formularios.
* Cards.
* Tablas.
* Modales.
* Alertas.
* Estados vacíos.
* Loaders.
* Dashboards.

## Fase 6. Grafos y visualizaciones

* Incorporar iconos.
* Mejorar nodos.
* Mejorar conexiones.
* Incorporar tooltips.
* Agregar animaciones funcionales.
* Optimizar interacción.

## Fase 7. Responsive y accesibilidad

* Validar breakpoints.
* Revisar interacción táctil.
* Probar navegación por teclado.
* Probar movimiento reducido.
* Revisar contraste.
* Corregir desbordamientos.

## Fase 8. Rendimiento y QA

* Medir carga.
* Medir renderizado.
* Revisar animaciones.
* Detectar memory leaks.
* Validar dispositivos modestos.
* Ejecutar pruebas visuales.
* Ejecutar pruebas end-to-end.
* Comparar antes y después.

---

# 17. Entregables esperados

Entrega:

1. Diagnóstico visual del frontend.
2. Inventario de problemas.
3. Dirección visual propuesta.
4. Sistema completo de fondos.
5. Variantes de fondo por pantalla.
6. Propuesta de fondos dinámicos y reactivos.
7. Rediseño del login.
8. Sistema de animaciones.
9. Sistema de iconografía.
10. Sistema visual de estados.
11. Propuesta para grafos y diagramas.
12. Mejoras responsive.
13. Recomendaciones de accesibilidad.
14. Recomendaciones de rendimiento.
15. Arquitectura de componentes visuales.
16. Plan de implementación por fases.
17. Riesgos.
18. Criterios de aceptación.
19. Lista de archivos que deberían modificarse.
20. Lista de nuevas dependencias, únicamente si son necesarias.

---

# 18. Formato de respuesta

Para cada propuesta indica:

* Problema actual.
* Mejora propuesta.
* Justificación.
* Componente afectado.
* Archivos probables.
* Complejidad.
* Prioridad.
* Riesgo.
* Impacto visual.
* Impacto en rendimiento.
* Criterio de aceptación.

Clasifica las prioridades como:

* Crítica.
* Alta.
* Media.
* Baja.

Clasifica el estado como:

* Existente.
* Mejorable.
* Requiere refactorización.
* Faltante.
* Propuesto.

---

# 19. Criterios de aceptación generales

La mejora será considerada correcta cuando:

* El frontend tenga una identidad visual coherente.
* Los fondos dejen de sentirse planos o vacíos.
* Existan variantes de fondos según el contexto.
* Los fondos dinámicos no afecten la lectura.
* Los fondos reactivos funcionen de forma sutil.
* El login tenga mayor riqueza visual.
* Las animaciones tengan propósito.
* Los componentes respondan claramente a la interacción.
* Los grafos utilicen iconos y estados visuales.
* La aplicación funcione correctamente en móviles.
* Se respete la accesibilidad.
* Se mantenga un rendimiento adecuado.
* No se rompa ninguna funcionalidad existente.
* La implementación sea reutilizable y mantenible.
* El resultado se perciba como un producto profesional y terminado.

---

# Instrucción final

Primero realiza la auditoría y presenta el plan detallado.

Después implementa las mejoras por fases, comenzando por:

1. Sistema de diseño.
2. Sistema de fondos.
3. Login.
4. Layouts principales.
5. Componentes reutilizables.
6. Animaciones.
7. Grafos.
8. Responsive.
9. Accesibilidad.
10. Optimización.

No te limites a agregar gradientes superficiales.

El sistema de fondos debe diseñarse como una arquitectura visual reutilizable, con capas, variantes, comportamiento responsive, adaptación a estados, modo claro y oscuro, reactividad controlada y fallbacks de rendimiento.

El resultado final debe mejorar sustancialmente la percepción visual del frontend sin convertirlo en una interfaz saturada, lenta o difícil de mantener.
