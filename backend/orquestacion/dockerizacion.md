# Plan maestro de dockerización, mensajería y optimización de infraestructura

## Rol y responsabilidad

Actúa como arquitecto de software, ingeniero DevOps y especialista en sistemas distribuidos.

Debes auditar, diseñar, implementar, probar y documentar una estrategia integral de contenerización para el proyecto actual.

No debes limitarte a generar archivos `Dockerfile` o `docker-compose.yml`. Debes revisar cómo se ejecuta realmente cada componente, identificar sus dependencias, corregir problemas de arquitectura y dejar un entorno reproducible, seguro, observable, eficiente y preparado para escalar.

La prioridad especial es la infraestructura de mensajería, las colas, los workers y todos los procesos asíncronos.

---

# 1. Objetivo general

Dockerizar correctamente todos los componentes que deban ejecutarse de forma aislada, reproducible y escalable, incluyendo cuando corresponda:

* Backend principal.
* Frontend.
* Workers.
* Procesadores asíncronos.
* Sistema de mensajería.
* Colas.
* Scheduler o tareas programadas.
* Caché.
* Base de datos.
* Migraciones.
* Seeders.
* Almacenamiento de archivos.
* Proxy inverso.
* Servicios de observabilidad.
* Herramientas administrativas.
* Servicios auxiliares.
* Dependencias de desarrollo y pruebas.

El resultado debe permitir levantar el sistema completo mediante comandos documentados, sin configuraciones manuales ocultas ni dependencias instaladas directamente en la máquina anfitriona, salvo Docker y las herramientas estrictamente necesarias.

---

# 2. Principios obligatorios

Toda la implementación deberá cumplir los siguientes principios:

1. No romper funcionalidades existentes.
2. No modificar contratos internos o externos sin una justificación técnica documentada.
3. No dockerizar componentes innecesarios solamente para afirmar que todo se encuentra en contenedores.
4. No agregar servicios por moda o preferencia personal.
5. No asumir que RabbitMQ, Kafka, Redis Streams, NATS o cualquier otra tecnología es automáticamente la mejor opción.
6. No incluir secretos dentro de imágenes, repositorios, capas de Docker o archivos públicos.
7. No dejar servicios ejecutándose como usuario `root` sin una necesidad técnica demostrable.
8. No utilizar imágenes pesadas cuando exista una alternativa segura y estable.
9. No depender de configuraciones manuales no documentadas.
10. No utilizar datos simulados para ocultar integraciones incompletas.
11. No dejar código temporal, archivos duplicados, configuraciones obsoletas ni comentarios pendientes.
12. No declarar una fase como completada sin validar sus criterios de aceptación.
13. Mantener separados los entornos de desarrollo, pruebas, staging y producción.
14. Priorizar seguridad, eficiencia, resiliencia, mantenibilidad, observabilidad y facilidad operativa.
15. Toda decisión importante debe quedar registrada mediante un ADR o documento de decisión técnica.

---

# 3. Resultado esperado

Al finalizar, el proyecto debe disponer de:

* Construcciones Docker reproducibles.
* Imágenes optimizadas.
* Entornos claramente separados.
* Infraestructura local ejecutable mediante Docker Compose.
* Configuración de producción compatible con la plataforma de despliegue actual.
* Mensajería resiliente.
* Workers escalables horizontalmente.
* Procesamiento idempotente.
* Recuperación ante fallos.
* Health checks reales.
* Métricas técnicas y funcionales.
* Logs estructurados.
* Trazabilidad entre solicitudes, mensajes y workers.
* Pruebas de integración y resiliencia.
* Documentación operativa completa.
* Procedimientos de respaldo y recuperación.
* Estrategias de actualización y rollback.
* Evidencias de validación.

---

# 4. Metodología de trabajo

Trabaja por fases consecutivas.

Antes de comenzar una fase:

1. Revisa los entregables de la fase anterior.
2. Identifica riesgos y dependencias.
3. Define los archivos que se modificarán.
4. Establece criterios de aceptación verificables.

Después de cada fase:

1. Ejecuta las validaciones correspondientes.
2. Documenta los resultados.
3. Registra las decisiones técnicas.
4. Actualiza el inventario de riesgos.
5. Corrige los errores antes de continuar.

No avances dejando fallos conocidos sin documentar y resolver, salvo que exista un impedimento externo real y demostrable.

---

# FASE 0. Protección inicial y establecimiento de la línea base

## Objetivo

Conocer el estado real del sistema antes de modificar la infraestructura.

## Actividades

1. Identificar el stack tecnológico completo.
2. Revisar la estructura de carpetas y módulos.
3. Identificar el administrador de paquetes utilizado.
4. Registrar las versiones actuales de:

   * Runtime.
   * Framework.
   * Base de datos.
   * Sistema de caché.
   * Broker de mensajería, si existe.
   * Dependencias críticas.
5. Ejecutar la aplicación sin modificaciones.
6. Ejecutar las pruebas existentes.
7. Registrar:

   * Tiempo de instalación.
   * Tiempo de compilación.
   * Tiempo de arranque.
   * Uso de CPU.
   * Uso de memoria.
   * Tamaño del proyecto instalado.
   * Tamaño de imágenes existentes.
8. Identificar servicios externos y dependencias no declaradas.
9. Verificar el estado del repositorio.
10. Crear una línea base funcional para comparar el resultado final.

## Entregables

* Informe de estado inicial.
* Inventario tecnológico.
* Mapa preliminar de servicios.
* Registro de métricas iniciales.
* Lista de riesgos.
* Lista de dependencias externas.
* Evidencia de pruebas ejecutadas.

## Criterio de aceptación

Debe existir una referencia verificable del comportamiento del sistema antes de la dockerización.

---

# FASE 1. Auditoría integral de arquitectura e infraestructura

## Objetivo

Identificar qué componentes requieren aislamiento y cómo se relacionan.

## Actividades

Analiza cada componente del sistema y documenta:

* Responsabilidad.
* Proceso de ejecución.
* Puerto utilizado.
* Dependencias.
* Variables de entorno.
* Consumo estimado de recursos.
* Persistencia requerida.
* Dependencias de red.
* Requisitos de escalado.
* Nivel de criticidad.
* Tipo de información manejada.
* Riesgos de seguridad.
* Estrategia de recuperación.

Clasifica cada componente como:

1. Debe ejecutarse en un contenedor independiente.
2. Puede compartir contenedor excepcionalmente.
3. No necesita ser dockerizado.
4. Depende de un servicio administrado externo.
5. Requiere un sidecar o servicio auxiliar.
6. Debe ejecutarse como tarea puntual.
7. Debe ejecutarse como proceso persistente.

## Componentes a revisar obligatoriamente

* API principal.
* Frontend.
* Base de datos.
* Caché.
* Broker de mensajería.
* Workers.
* Scheduler.
* Migraciones.
* Seeders.
* Procesamiento de archivos.
* Generación de reportes.
* Envío de correos.
* Notificaciones.
* Webhooks.
* Auditoría.
* Almacenamiento.
* Proxy.
* TLS.
* Logs.
* Métricas.
* Trazas.
* Copias de seguridad.
* Procesos de mantenimiento.

## Entregables

* Inventario definitivo de servicios.
* Diagrama de contenedores.
* Diagrama de comunicaciones.
* Matriz de dependencias.
* Matriz de puertos.
* Matriz de volúmenes.
* Matriz de variables de entorno.
* Matriz de criticidad.
* Propuesta inicial de redes internas y externas.

## Criterio de aceptación

No debe existir ningún proceso relevante sin una ubicación de ejecución claramente definida.

---

# FASE 2. Evaluación y selección de la tecnología de mensajería

## Objetivo

Elegir la tecnología de mensajería adecuada según las necesidades reales del proyecto.

## Tecnologías mínimas a evaluar

Cuando sean técnicamente aplicables, compara:

* RabbitMQ.
* Redis con BullMQ.
* Redis Streams.
* Apache Kafka.
* NATS JetStream.
* Amazon SQS u otro servicio administrado.
* La solución actualmente existente, si ya existe.

## Criterios de evaluación

Para cada alternativa analiza:

* Volumen de mensajes esperado.
* Mensajes por segundo.
* Latencia aceptable.
* Persistencia.
* Garantías de entrega.
* Ordenamiento.
* Priorización.
* Reintentos.
* Dead-letter queues.
* Delayed jobs.
* Tareas programadas.
* Complejidad operativa.
* Facilidad de desarrollo.
* Escalabilidad.
* Alta disponibilidad.
* Consumo de recursos.
* Costo de infraestructura.
* Costo de mantenimiento.
* Compatibilidad con el stack actual.
* Disponibilidad de métricas.
* Experiencia del equipo.
* Portabilidad.
* Riesgo de dependencia del proveedor.

## Decisión técnica

Genera una matriz comparativa ponderada y selecciona una opción.

La decisión debe responder:

1. ¿Por qué esta solución es la más adecuada?
2. ¿Qué problemas resuelve?
3. ¿Qué limitaciones conserva?
4. ¿Qué volumen puede soportar razonablemente?
5. ¿Cuándo sería necesario migrar a otra tecnología?
6. ¿Cuál sería el costo operativo?
7. ¿Cuál sería la estrategia de recuperación?
8. ¿Cómo se desplegará en desarrollo y producción?

## Restricción

No implementes más de un broker principal salvo que exista una necesidad real y claramente justificada.

## Entregables

* Matriz comparativa.
* ADR de selección.
* Diagrama de mensajería.
* Estimación de capacidad.
* Riesgos y limitaciones.
* Plan de migración, cuando exista un sistema previo.

## Criterio de aceptación

La tecnología seleccionada debe responder a necesidades medibles, no a preferencias personales.

---

# FASE 3. Diseño de la arquitectura de mensajería

## Objetivo

Diseñar un modelo de mensajería desacoplado, resiliente, trazable y escalable.

## Diseño obligatorio

Define:

* Productores.
* Consumidores.
* Exchanges, topics, streams o equivalentes.
* Colas.
* Routing keys.
* Tipos de mensajes.
* Prioridades.
* Reintentos.
* Dead-letter queues.
* Timeouts.
* Concurrencia.
* Prefetch.
* Persistencia.
* Confirmaciones.
* Política de retención.
* Estrategia de reenvío.
* Estrategia de mensajes fallidos.
* Estrategia de recuperación.
* Versionado de contratos.
* Correlation ID.
* Causation ID.
* Trace ID.
* Identificador único de mensaje.
* Fecha de creación.
* Fecha de expiración.
* Número de intento.
* Productor.
* Tipo de evento.
* Versión del esquema.

## Contrato base del mensaje

Todo mensaje debe incluir como mínimo:

```json
{
  "messageId": "uuid",
  "messageType": "domain.event.v1",
  "version": 1,
  "occurredAt": "ISO-8601",
  "correlationId": "uuid",
  "causationId": "uuid-opcional",
  "traceId": "string",
  "producer": "service-name",
  "attempt": 1,
  "payload": {}
}
```

El contrato puede ampliarse según las necesidades, pero no debe perder trazabilidad ni versionado.

## Separación de colas

No utilices una única cola para todo.

Clasifica los trabajos, cuando corresponda, por:

* Envío de correos.
* Notificaciones.
* Procesamiento de archivos.
* Reportes.
* Integraciones externas.
* Webhooks.
* Auditoría.
* Procesamiento intensivo.
* Operaciones críticas.
* Procesos programados.
* Reintentos.
* Mensajes fallidos.

## Entregables

* Topología completa de mensajería.
* Contratos versionados.
* Convención de nombres.
* Diagrama de flujos.
* Política de errores.
* Política de reintentos.
* Política de retención.
* Política de compatibilidad.

## Criterio de aceptación

Debe poder identificarse el recorrido de cualquier mensaje desde su creación hasta su procesamiento final o fallo definitivo.

---

# FASE 4. Refactorización de procesos síncronos y asíncronos

## Objetivo

Extraer del ciclo síncrono las tareas que no deban bloquear solicitudes.

## Actividades

Identifica procesos que:

* Tarden demasiado.
* Dependan de APIs externas.
* Puedan reintentarse.
* Consuman CPU.
* Consuman memoria.
* Procesen archivos.
* Generen documentos.
* Envíen correos.
* Generen notificaciones.
* Actualicen sistemas externos.
* Ejecuten lotes.
* No necesiten responder inmediatamente al usuario.

Clasifica cada proceso como:

1. Síncrono obligatorio.
2. Asíncrono recomendado.
3. Asíncrono obligatorio.
4. Programado.
5. Evento de dominio.
6. Proceso intensivo.
7. Proceso crítico.

## Reglas

* No conviertas operaciones críticas en asíncronas sin analizar consistencia.
* Define qué ocurre cuando la publicación del mensaje falla.
* Evita actualizar la base de datos y publicar un mensaje como operaciones separadas sin protección.
* Evalúa el patrón Transactional Outbox cuando exista consistencia entre base de datos y mensajería.
* Evalúa Inbox Pattern para deduplicación del consumidor.
* Evita transacciones distribuidas innecesarias.
* Diseña compensaciones cuando no pueda garantizarse atomicidad.

## Entregables

* Inventario de procesos.
* Clasificación síncrono/asíncrono.
* Refactorización implementada.
* Diagrama antes y después.
* Decisiones sobre Outbox, Inbox y compensación.

## Criterio de aceptación

Las solicitudes del backend no deben quedar bloqueadas por tareas que puedan procesarse de forma segura en segundo plano.

---

# FASE 5. Implementación de productores, consumidores y workers

## Objetivo

Implementar correctamente el procesamiento asíncrono.

## Productores

Cada productor debe:

* Validar el mensaje.
* Asignar identificadores.
* Incluir trazabilidad.
* Manejar errores de publicación.
* Confirmar la recepción cuando la tecnología lo soporte.
* Evitar publicaciones silenciosamente fallidas.
* Aplicar timeout.
* Registrar métricas.
* No publicar información sensible innecesaria.

## Consumidores

Cada consumidor debe:

* Validar el esquema.
* Ser idempotente.
* Manejar duplicados.
* Manejar errores transitorios.
* Manejar errores permanentes.
* Aplicar timeout.
* Aplicar reintentos con backoff.
* Mover mensajes irrecuperables a una DLQ.
* Registrar duración y resultado.
* Finalizar correctamente durante un apagado.
* Limitar su concurrencia.
* No confirmar mensajes antes de finalizar el trabajo.
* Evitar ciclos de reintento infinitos.

## Idempotencia

Implementa una estrategia explícita mediante alguna de estas opciones:

* Tabla de mensajes procesados.
* Clave idempotente.
* Restricción única.
* Inbox Pattern.
* Operación naturalmente idempotente.
* Bloqueo distribuido cuando sea estrictamente necesario.

Documenta:

* Tiempo de retención de las claves.
* Limpieza de registros.
* Comportamiento ante mensajes duplicados.
* Comportamiento ante concurrencia.

## Reintentos

Diferencia:

* Error transitorio.
* Error permanente.
* Error de validación.
* Error externo.
* Timeout.
* Error de infraestructura.
* Error de lógica.

Define para cada tipo:

* Número máximo de intentos.
* Backoff.
* Jitter.
* Cola de reintento.
* DLQ.
* Alerta.
* Acción manual.

## Entregables

* Productores implementados.
* Consumidores implementados.
* Workers independientes.
* Pruebas de duplicados.
* Pruebas de reintentos.
* Pruebas de DLQ.
* Pruebas de apagado controlado.
* Documentación de escalado.

## Criterio de aceptación

Un reinicio, duplicado o error transitorio no debe provocar pérdida de información ni ejecuciones inconsistentes.

---

# FASE 6. Dockerización del backend

## Objetivo

Crear una imagen segura, ligera y reproducible para el backend.

## Requisitos

* Utilizar una imagen base compatible y mantenida.
* Fijar versiones relevantes.
* Utilizar multi-stage build.
* Separar instalación, compilación y runtime.
* Instalar únicamente dependencias de producción en la imagen final.
* Utilizar el archivo de bloqueo del proyecto.
* Evitar copiar archivos innecesarios.
* Crear `.dockerignore`.
* Ejecutar como usuario no privilegiado.
* Incluir señales y apagado correcto.
* Configurar health check.
* Evitar almacenar secretos.
* Exponer únicamente el puerto necesario.
* Mantener compatibilidad con la versión de Node o runtime definida por el proyecto.
* No ejecutar migraciones automáticamente en cada réplica de la API.
* Evitar que varias instancias ejecuten seeders simultáneamente.

## Revisión adicional

Analiza:

* Dependencias nativas.
* Certificados.
* Zona horaria.
* Locales.
* Escritura en disco.
* Directorios temporales.
* Logs.
* Límites de memoria.
* Manejo de señales.
* Configuración de proxy.
* Conexiones persistentes.
* Pool de base de datos.

## Entregables

* `Dockerfile` del backend.
* `.dockerignore`.
* Scripts de arranque.
* Health check.
* Documentación de construcción.
* Comparación de tamaño y tiempo de build.

## Criterio de aceptación

La imagen final debe contener únicamente lo necesario para ejecutar el backend en producción.

---

# FASE 7. Dockerización de workers y procesos auxiliares

## Objetivo

Separar los workers del backend y permitir su escalado independiente.

## Requisitos

Cada tipo de worker debe:

* Tener un comando de ejecución independiente.
* Poder utilizar la misma imagen base cuando sea razonable.
* Poder escalar sin modificar la API.
* Tener límites propios de recursos.
* Tener health check o mecanismo equivalente.
* Exponer métricas.
* Manejar señales.
* Finalizar trabajos activos de forma controlada.
* Dejar de consumir mensajes antes de apagarse.
* Tener concurrencia configurable.
* No compartir estado local entre réplicas.

Evalúa separar workers por:

* Tipo de carga.
* Prioridad.
* Dependencia externa.
* Consumo de CPU.
* Consumo de memoria.
* Criticidad.
* Tiempo máximo de ejecución.

## Entregables

* Comandos independientes.
* Servicios Docker por worker.
* Configuración de concurrencia.
* Estrategia de escalado.
* Límites de recursos.
* Pruebas de escalado horizontal.

## Criterio de aceptación

Debe ser posible aumentar o reducir la cantidad de workers sin reiniciar ni modificar el backend principal.

---

# FASE 8. Dockerización del frontend

## Objetivo

Preparar el frontend para desarrollo y producción de forma eficiente.

## Requisitos

Cuando el frontend forme parte del repositorio:

* Crear una imagen de desarrollo compatible con hot reload.
* Crear una construcción optimizada para producción.
* Utilizar multi-stage build.
* No incluir dependencias de desarrollo en producción.
* Evitar exponer variables privadas al navegador.
* Definir correctamente variables públicas y privadas.
* Optimizar assets.
* Revisar caché.
* Configurar proxy hacia el backend cuando corresponda.
* Implementar health check.
* Ejecutar como usuario no privilegiado.
* Mantener compatibilidad con la herramienta de construcción utilizada.

## Entregables

* `Dockerfile` de desarrollo.
* `Dockerfile` o etapa de producción.
* `.dockerignore`.
* Configuración de variables.
* Configuración de proxy.
* Prueba de construcción.

## Criterio de aceptación

La aplicación debe compilar y ejecutarse correctamente sin filtrar secretos hacia el cliente.

---

# FASE 9. Base de datos, migraciones y seeders

## Objetivo

Garantizar persistencia, inicialización controlada y seguridad de datos.

## Requisitos

* Definir volumen persistente.
* Configurar health check real.
* No exponer el puerto públicamente salvo necesidad.
* Definir red privada.
* Configurar credenciales mediante secretos o variables seguras.
* Separar migraciones del arranque normal del backend.
* Crear un servicio o tarea específica para migraciones.
* Crear un servicio o tarea específica para seeders.
* Evitar ejecución concurrente.
* Garantizar que los seeders sean idempotentes.
* Documentar rollback.
* Documentar backup y restore.
* Revisar el pool de conexiones.
* Considerar la cantidad de réplicas de API y workers.
* Evitar agotar conexiones.

## Entregables

* Servicio de base de datos para desarrollo.
* Servicio de migración.
* Servicio de seeding.
* Scripts de backup.
* Scripts de restore.
* Documentación de recuperación.
* Configuración de pool.

## Criterio de aceptación

La pérdida o recreación de un contenedor no debe implicar la pérdida del volumen persistente.

---

# FASE 10. Caché, Redis y almacenamiento temporal

## Objetivo

Definir correctamente el uso de caché y estado temporal.

## Actividades

Identifica si Redis u otro sistema se utiliza para:

* Caché.
* Sesiones.
* Rate limiting.
* Colas.
* Locks.
* Pub/Sub.
* Idempotencia.
* Tokens temporales.
* Datos efímeros.

Para cada uso define:

* Persistencia.
* TTL.
* Política de expulsión.
* Límites de memoria.
* Recuperación ante reinicio.
* Impacto de pérdida de datos.
* Separación lógica o física.
* Riesgos de mezclar caché y mensajería.

## Restricción

No utilices una única instancia Redis para cargas críticas incompatibles sin justificarlo.

## Entregables

* Matriz de usos.
* Configuración de memoria.
* Política de persistencia.
* Estrategia de separación.
* Health check.
* Pruebas de expiración y recuperación.

## Criterio de aceptación

Debe conocerse el impacto exacto de reiniciar o perder el servicio de caché.

---

# FASE 11. Docker Compose para desarrollo

## Objetivo

Permitir que un desarrollador levante el proyecto completo de forma sencilla.

## Requisitos

Crear una estructura clara, por ejemplo:

* `compose.yml`
* `compose.dev.yml`
* `compose.test.yml`
* `compose.observability.yml`
* Archivos adicionales solamente cuando aporten claridad.

La composición de desarrollo debe incluir:

* Redes internas.
* Volúmenes.
* Health checks.
* Dependencias saludables.
* Variables de entorno.
* Perfiles opcionales.
* Hot reload cuando corresponda.
* Persistencia de base de datos.
* Persistencia de broker cuando sea necesaria.
* Herramientas administrativas opcionales.
* Puertos mínimos.
* Nombres claros.
* Políticas de reinicio razonables.

## Restricciones

* No utilizar `latest`.
* No depender únicamente de `depends_on` sin health checks.
* No utilizar `network_mode: host` salvo justificación.
* No montar todo el sistema de archivos innecesariamente.
* No ocultar dependencias faltantes mediante sleeps arbitrarios.
* No codificar contraseñas reales.

## Experiencia de desarrollo

Debe ser posible ejecutar comandos equivalentes a:

```bash
docker compose up --build
docker compose down
docker compose down -v
docker compose logs -f
docker compose ps
docker compose exec api <comando>
docker compose run --rm migrations
docker compose run --rm seed
```

Adapta los comandos al proyecto real.

## Entregables

* Archivos Compose.
* Perfiles.
* Documentación.
* Comandos operativos.
* Verificación de inicio limpio.

## Criterio de aceptación

Un desarrollador nuevo debe poder levantar el entorno siguiendo únicamente la documentación.

---

# FASE 12. Preparación para producción

## Objetivo

Crear una configuración segura y operable para el entorno productivo.

## Actividades

Adapta la infraestructura a la plataforma real utilizada, como:

* Docker Compose.
* Docker Swarm.
* Coolify.
* Kubernetes.
* ECS.
* Cloud Run.
* Render.
* Vercel para frontend.
* Servicios administrados.

No fuerces Kubernetes si la escala del proyecto no lo justifica.

## Requisitos

* Imágenes inmutables.
* Versionado por tag.
* Registro de imágenes.
* Despliegue por digest cuando sea posible.
* Configuración externa.
* Secretos seguros.
* Red privada.
* TLS.
* Proxy inverso.
* Límites de recursos.
* Réplicas.
* Estrategia de actualización.
* Estrategia de rollback.
* Health checks.
* Readiness.
* Liveness cuando aplique.
* Grace period.
* Backups.
* Logs.
* Métricas.
* Alertas.

## Estrategias de despliegue a evaluar

* Rolling update.
* Blue-green.
* Canary.
* Recreate controlado.

Selecciona la opción apropiada y justifica.

## Entregables

* Diseño de producción.
* Archivos de despliegue.
* Estrategia de actualización.
* Estrategia de rollback.
* Manual de despliegue.
* Manual de recuperación.

## Criterio de aceptación

Debe ser posible desplegar y revertir una versión sin improvisar comandos durante una incidencia.

---

# FASE 13. Redes y exposición de servicios

## Objetivo

Reducir la superficie de ataque y organizar las comunicaciones.

## Diseño mínimo

Evalúa redes separadas para:

* Entrada pública.
* Aplicación.
* Datos.
* Mensajería.
* Observabilidad.
* Herramientas administrativas.

## Reglas

* La base de datos no debe ser pública.
* El broker no debe ser público.
* Redis no debe ser público.
* Las interfaces administrativas deben estar restringidas.
* Solamente el proxy o servicio de entrada debe exponerse cuando corresponda.
* Deben documentarse todos los puertos.
* Los servicios deben comunicarse mediante nombres internos.
* No utilizar `localhost` para comunicación entre contenedores.

## Entregables

* Diagrama de redes.
* Matriz de exposición.
* Lista de puertos.
* Controles de acceso.
* Validación de servicios no expuestos.

## Criterio de aceptación

Únicamente los servicios estrictamente necesarios deben estar accesibles desde el exterior.

---

# FASE 14. Gestión de configuración y secretos

## Objetivo

Eliminar configuraciones inseguras y dependencias ocultas.

## Requisitos

* Crear `.env.example`.
* Documentar cada variable.
* Validar variables al iniciar.
* Diferenciar variables obligatorias y opcionales.
* No utilizar valores inseguros por defecto.
* No copiar archivos `.env` dentro de imágenes.
* No registrar secretos en logs.
* No pasar secretos mediante argumentos de construcción.
* Utilizar secretos de la plataforma en producción.
* Rotar credenciales comprometidas.
* Revisar historial Git cuando exista riesgo de filtración.

## Clasificación

Clasifica cada configuración como:

* Pública.
* Interna.
* Sensible.
* Secreta.
* Específica del entorno.
* Configurable en runtime.
* Necesaria en build time.

## Entregables

* `.env.example`.
* Esquema de validación.
* Catálogo de variables.
* Procedimiento de rotación.
* Informe de posibles exposiciones.

## Criterio de aceptación

Ninguna credencial real debe quedar incluida en el repositorio o en una capa de imagen.

---

# FASE 15. Seguridad de imágenes y contenedores

## Objetivo

Reducir vulnerabilidades y privilegios innecesarios.

## Requisitos

* Usuario no root.
* Sistema de archivos de solo lectura cuando sea viable.
* Capabilities mínimas.
* `no-new-privileges`.
* Directorios temporales controlados.
* Dependencias actualizadas.
* Imágenes oficiales o verificadas.
* Versiones fijadas.
* Escaneo de vulnerabilidades.
* Revisión de licencias.
* SBOM.
* Firma de imágenes cuando la plataforma lo permita.
* No incluir herramientas de compilación en runtime.
* No incluir shells o utilidades innecesarias cuando sea viable.
* Evitar secretos en historial de capas.

## Herramientas posibles

Evalúa el uso de:

* Docker Scout.
* Trivy.
* Grype.
* Syft.
* Hadolint.
* Dockle.

Selecciona las necesarias sin incorporar complejidad inútil.

## Entregables

* Informe de vulnerabilidades.
* SBOM.
* Correcciones aplicadas.
* Riesgos aceptados.
* Política de actualización.

## Criterio de aceptación

No deben quedar vulnerabilidades críticas conocidas sin corrección o justificación explícita.

---

# FASE 16. Observabilidad integral

## Objetivo

Permitir diagnosticar la aplicación, la infraestructura y la mensajería.

## Logs

Implementa logs estructurados con:

* Timestamp.
* Nivel.
* Servicio.
* Entorno.
* Versión.
* Correlation ID.
* Trace ID.
* Message ID.
* Worker.
* Tipo de trabajo.
* Duración.
* Resultado.
* Código de error.

No registrar:

* Contraseñas.
* Tokens.
* Credenciales.
* Información sensible completa.
* Payloads privados innecesarios.

## Métricas mínimas

### API

* Solicitudes.
* Latencia.
* Errores.
* Timeouts.
* Saturación.
* Conexiones.
* Pool de base de datos.

### Mensajería

* Mensajes publicados.
* Mensajes consumidos.
* Mensajes pendientes.
* Mensajes activos.
* Mensajes completados.
* Mensajes fallidos.
* Reintentos.
* DLQ.
* Antigüedad del mensaje más antiguo.
* Duración por tipo de trabajo.
* Throughput.
* Concurrencia.

### Infraestructura

* CPU.
* Memoria.
* Disco.
* Reinicios.
* Estado de contenedores.
* Uso de volúmenes.
* Conexiones.
* Saturación.

## Trazas

Implementa o prepara trazabilidad distribuida mediante OpenTelemetry cuando sea compatible.

La traza debe conectar:

1. Solicitud HTTP.
2. Operación de negocio.
3. Publicación del mensaje.
4. Consumo.
5. Llamadas externas.
6. Resultado final.

## Entregables

* Configuración de logs.
* Métricas.
* Dashboards.
* Trazas.
* Alertas.
* Manual de diagnóstico.

## Criterio de aceptación

Debe ser posible determinar por qué falló un trabajo sin revisar manualmente cada contenedor de forma aislada.

---

# FASE 17. Health checks, readiness y apagado controlado

## Objetivo

Detectar fallos reales y evitar pérdidas durante reinicios.

## Health checks

No utilices comprobaciones superficiales que únicamente verifiquen que un proceso existe.

Evalúa:

* Estado del proceso.
* Disponibilidad de dependencias críticas.
* Conexión con base de datos.
* Conexión con broker.
* Estado del consumidor.
* Saturación.
* Bloqueo prolongado.
* Capacidad de recibir tráfico.

Diferencia cuando corresponda:

* Liveness.
* Readiness.
* Startup.
* Health general.

## Apagado controlado

Cada servicio debe:

1. Recibir la señal.
2. Dejar de aceptar nuevo trabajo.
3. Dejar de consumir mensajes.
4. Finalizar trabajos activos dentro de un límite.
5. Confirmar o devolver mensajes correctamente.
6. Cerrar conexiones.
7. Vaciar logs.
8. Finalizar con código apropiado.

## Entregables

* Endpoints o comandos de health.
* Configuración Docker.
* Manejo de señales.
* Pruebas de apagado.
* Documentación de tiempos de gracia.

## Criterio de aceptación

Reiniciar un worker no debe perder ni confirmar incorrectamente mensajes en ejecución.

---

# FASE 18. Optimización de imágenes y builds

## Objetivo

Reducir tamaño, tiempo de construcción y consumo operativo.

## Actividades

* Analizar capas.
* Optimizar orden de instrucciones.
* Aprovechar caché.
* Utilizar BuildKit.
* Utilizar cache mounts cuando corresponda.
* Evitar copiar archivos antes de instalar dependencias.
* Limpiar cachés.
* Eliminar artefactos de compilación innecesarios.
* Separar dependencias de desarrollo.
* Evaluar imágenes Alpine, slim o distroless según compatibilidad.
* Evitar Alpine cuando provoque problemas con dependencias nativas.
* Medir tiempos antes y después.
* Medir tamaños antes y después.

## Entregables

* Comparativa de imágenes.
* Comparativa de builds.
* Justificación de imagen base.
* Configuración de caché.
* Optimización implementada.

## Criterio de aceptación

La optimización debe basarse en métricas, no únicamente en cambios estéticos del Dockerfile.

---

# FASE 19. Límites de recursos y escalabilidad

## Objetivo

Evitar saturación y preparar crecimiento controlado.

## Actividades

Define para cada servicio:

* CPU mínima.
* CPU máxima.
* Memoria mínima.
* Memoria máxima.
* Concurrencia.
* Réplicas.
* Límites de conexiones.
* Tiempo máximo de ejecución.
* Criterios de escalado.
* Riesgo de OOM.
* Comportamiento ante saturación.

## Workers

El escalado debe considerar:

* Profundidad de cola.
* Antigüedad del trabajo.
* Tiempo promedio.
* CPU.
* Memoria.
* Límite de APIs externas.
* Conexiones de base de datos.
* Rate limits.
* Ordenamiento requerido.

## Restricción

No escales workers sin revisar el impacto sobre:

* Base de datos.
* Broker.
* Servicios externos.
* Pool de conexiones.
* Locks.
* Procesos idempotentes.

## Entregables

* Tabla de recursos.
* Estrategia de escalado.
* Pruebas de carga.
* Límites configurados.
* Riesgos de saturación.

## Criterio de aceptación

El sistema debe degradarse de forma controlada en lugar de colapsar silenciosamente.

---

# FASE 20. Pruebas funcionales e integración

## Objetivo

Verificar que la contenerización no altere el comportamiento del sistema.

## Pruebas obligatorias

* Construcción limpia.
* Arranque desde cero.
* Inicialización de base de datos.
* Migraciones.
* Seeders.
* Comunicación frontend-backend.
* Comunicación backend-base de datos.
* Comunicación backend-broker.
* Comunicación worker-broker.
* Procesamiento de mensajes.
* Envío de respuestas.
* Integraciones externas.
* Health checks.
* Apagado.
* Reinicio.
* Persistencia.
* Manejo de errores.

## Criterio de aceptación

Todas las funcionalidades críticas existentes deben seguir funcionando dentro del entorno contenerizado.

---

# FASE 21. Pruebas de resiliencia y recuperación

## Objetivo

Demostrar que el sistema responde correctamente ante fallos.

## Escenarios mínimos

1. Reiniciar el backend.
2. Reiniciar un worker.
3. Reiniciar el broker.
4. Reiniciar Redis.
5. Reiniciar la base de datos.
6. Detener una dependencia externa.
7. Provocar un timeout.
8. Publicar un mensaje duplicado.
9. Publicar un mensaje inválido.
10. Forzar un error transitorio.
11. Forzar un error permanente.
12. Saturar una cola.
13. Detener todos los consumidores.
14. Reanudar consumidores.
15. Simular falta de memoria.
16. Simular pérdida temporal de red.
17. Verificar la DLQ.
18. Reprocesar un mensaje fallido.
19. Ejecutar restore de base de datos.
20. Ejecutar rollback de una versión.

## Validaciones

Para cada escenario registra:

* Comportamiento esperado.
* Comportamiento observado.
* Pérdida de datos.
* Duplicados.
* Tiempo de recuperación.
* Logs generados.
* Métricas generadas.
* Alertas generadas.
* Acción correctiva.

## Entregables

* Matriz de resiliencia.
* Evidencias.
* Errores corregidos.
* Riesgos residuales.
* Procedimientos de recuperación.

## Criterio de aceptación

El sistema debe recuperarse sin pérdida silenciosa de trabajos ni corrupción de estado.

---

# FASE 22. Pruebas de carga y rendimiento

## Objetivo

Evaluar capacidad y detectar cuellos de botella.

## Escenarios

* Carga normal.
* Pico de solicitudes.
* Pico de publicación de mensajes.
* Pico de consumo.
* Acumulación de cola.
* Trabajos lentos.
* Varias réplicas.
* Base de datos saturada.
* API externa lenta.
* Procesamiento concurrente.

## Métricas

* Throughput.
* Latencia promedio.
* P95.
* P99.
* Tasa de errores.
* CPU.
* Memoria.
* Conexiones.
* Tiempo en cola.
* Tiempo de procesamiento.
* Crecimiento de backlog.
* Velocidad de recuperación.
* Reinicios.
* OOM.
* Mensajes duplicados.
* Mensajes perdidos.

## Entregables

* Informe de rendimiento.
* Cuellos de botella.
* Capacidad estimada.
* Optimizaciones.
* Límites recomendados.
* Configuración de concurrencia.

## Criterio de aceptación

Debe existir una capacidad estimada y un punto conocido de saturación.

---

# FASE 23. CI/CD y control de calidad

## Objetivo

Automatizar la validación y construcción de imágenes.

## Pipeline mínimo

1. Instalar dependencias.
2. Validar formato.
3. Ejecutar linter.
4. Ejecutar análisis estático.
5. Ejecutar pruebas unitarias.
6. Ejecutar pruebas de integración.
7. Construir imágenes.
8. Validar Dockerfiles.
9. Escanear vulnerabilidades.
10. Generar SBOM.
11. Publicar imágenes versionadas.
12. Desplegar al entorno correspondiente.
13. Ejecutar smoke tests.
14. Permitir rollback.

## Reglas

* No publicar imágenes si fallan pruebas críticas.
* No reutilizar tags ambiguos.
* No depender exclusivamente de `latest`.
* Asociar cada imagen a un commit.
* Evitar exponer secretos en logs del pipeline.
* Utilizar caché de manera segura.
* Documentar el proceso de promoción entre entornos.

## Entregables

* Pipeline CI/CD.
* Estrategia de tags.
* Registro de imágenes.
* Escaneo automático.
* Smoke tests.
* Proceso de rollback.

## Criterio de aceptación

Cada imagen desplegada debe poder relacionarse con su código fuente, pruebas y reporte de seguridad.

---

# FASE 24. Documentación operativa

## Objetivo

Permitir que otra persona pueda operar el sistema sin depender del autor.

## Documentación obligatoria

### Desarrollo

* Requisitos.
* Instalación.
* Variables.
* Levantamiento.
* Detención.
* Reinicio.
* Logs.
* Pruebas.
* Migraciones.
* Seeders.
* Limpieza.
* Resolución de errores frecuentes.

### Producción

* Construcción.
* Publicación.
* Despliegue.
* Actualización.
* Rollback.
* Backups.
* Restore.
* Rotación de secretos.
* Escalado.
* Reprocesamiento.
* Recuperación de DLQ.
* Diagnóstico.
* Respuesta ante incidentes.

### Arquitectura

* Diagrama de servicios.
* Diagrama de redes.
* Diagrama de mensajería.
* Flujos principales.
* Dependencias.
* Decisiones técnicas.
* Riesgos.

## Runbooks mínimos

Crea procedimientos para:

* API caída.
* Worker detenido.
* Cola acumulada.
* Broker no disponible.
* Base de datos no disponible.
* Redis no disponible.
* DLQ creciendo.
* Mensajes duplicados.
* Consumo excesivo de memoria.
* Disco lleno.
* Restore de base de datos.
* Rollback de despliegue.
* Rotación de credenciales.

## Criterio de aceptación

Una persona con conocimientos técnicos del proyecto debe poder ejecutar los procedimientos siguiendo únicamente la documentación.

---

# FASE 25. Limpieza, consolidación y revisión final

## Objetivo

Eliminar residuos y garantizar coherencia.

## Actividades

* Eliminar Dockerfiles obsoletos.
* Eliminar configuraciones duplicadas.
* Eliminar scripts no utilizados.
* Eliminar variables obsoletas.
* Eliminar imágenes o servicios innecesarios.
* Revisar nombres.
* Revisar comentarios.
* Revisar documentación.
* Revisar permisos.
* Revisar puertos.
* Revisar volúmenes.
* Revisar secretos.
* Revisar versiones.
* Revisar dependencias.
* Ejecutar todas las pruebas nuevamente.
* Comparar métricas iniciales y finales.

## Entregables

* Informe final.
* Comparación antes y después.
* Lista de optimizaciones.
* Lista de riesgos residuales.
* Registro de decisiones.
* Evidencias de pruebas.
* Checklist final firmado técnicamente.

## Criterio de aceptación

No deben quedar archivos temporales, configuraciones contradictorias ni servicios sin propósito documentado.

---

# 5. Estructura sugerida de archivos

Adapta la estructura al proyecto real sin duplicar archivos innecesarios:

```text
/
├── Dockerfile
├── Dockerfile.dev
├── .dockerignore
├── compose.yml
├── compose.dev.yml
├── compose.test.yml
├── compose.observability.yml
├── docker/
│   ├── api/
│   ├── frontend/
│   ├── workers/
│   ├── database/
│   ├── messaging/
│   ├── proxy/
│   └── scripts/
├── scripts/
│   ├── docker-start.sh
│   ├── wait-for-service.sh
│   ├── migrate.sh
│   ├── seed.sh
│   ├── backup.sh
│   ├── restore.sh
│   └── smoke-test.sh
├── docs/
│   ├── docker/
│   │   ├── architecture.md
│   │   ├── development.md
│   │   ├── production.md
│   │   ├── troubleshooting.md
│   │   ├── messaging.md
│   │   ├── security.md
│   │   └── disaster-recovery.md
│   └── adr/
└── .env.example
```

No crees esta estructura de forma mecánica. Utilízala únicamente cuando mejore la organización real del proyecto.

---

# 6. Convenciones obligatorias

## Imágenes

* No utilizar tags flotantes.
* Fijar versiones compatibles.
* Mantener imágenes pequeñas.
* No incluir código fuente innecesario en runtime.
* No incluir secretos.
* Usar usuario no root.
* Definir labels útiles.
* Mantener reproducibilidad.

## Servicios

* Nombres claros.
* Un propósito principal por servicio.
* Health checks reales.
* Logs a `stdout` y `stderr`.
* Configuración externa.
* Cierre controlado.
* Límites de recursos.
* Redes mínimas necesarias.

## Mensajes

* Identificador único.
* Versionado.
* Trazabilidad.
* Validación.
* Idempotencia.
* Política de reintentos.
* DLQ.
* Observabilidad.
* Compatibilidad hacia atrás.

## Código

* Evitar clases o archivos excesivamente grandes.
* Separar responsabilidades.
* No duplicar lógica de publicación o consumo.
* Centralizar configuración.
* Implementar adaptadores para evitar acoplamiento directo al broker.
* Facilitar pruebas unitarias.
* Mantener independencia del proveedor cuando sea razonable.

---

# 7. Criterios globales de aceptación

La implementación solamente se considerará terminada cuando se compruebe que:

1. Todas las imágenes se construyen desde cero.
2. El entorno completo se levanta sin pasos manuales ocultos.
3. Los servicios se comunican correctamente.
4. Los puertos internos no están expuestos innecesariamente.
5. No existen secretos en imágenes ni repositorio.
6. Los contenedores no se ejecutan como root sin justificación.
7. Los health checks funcionan.
8. Los workers escalan independientemente.
9. Los mensajes se procesan correctamente.
10. Los mensajes duplicados no provocan efectos duplicados.
11. Los errores transitorios se reintentan.
12. Los errores permanentes terminan en DLQ.
13. Los reinicios no provocan pérdida silenciosa.
14. Los procesos cierran correctamente.
15. Las migraciones se ejecutan de forma controlada.
16. Los seeders son idempotentes.
17. Los volúmenes persisten.
18. Los backups y restores han sido probados.
19. Las pruebas unitarias pasan.
20. Las pruebas de integración pasan.
21. Las pruebas end-to-end pasan.
22. Las pruebas de resiliencia pasan.
23. Las pruebas de carga tienen resultados documentados.
24. Las imágenes han sido escaneadas.
25. Existe documentación operativa.
26. Existe estrategia de rollback.
27. Existe trazabilidad entre API, broker y workers.
28. Se han comparado las métricas antes y después.
29. No quedan componentes simulados o incompletos.
30. No quedan pendientes evitables.

---

# 8. Formato obligatorio de reporte por fase

Al terminar cada fase, presenta:

```markdown
## Fase N — Nombre

### Estado
COMPLETADA | PARCIAL | BLOQUEADA

### Diagnóstico inicial
Descripción del estado encontrado.

### Cambios realizados
Detalle exacto de las modificaciones.

### Archivos creados
Lista de archivos.

### Archivos modificados
Lista de archivos.

### Decisiones técnicas
Decisiones tomadas y justificación.

### Pruebas ejecutadas
Comandos y resultados.

### Métricas
Comparación cuando corresponda.

### Riesgos
Riesgos detectados y mitigaciones.

### Criterios de aceptación
- [x] Cumplido
- [ ] No cumplido

### Pendientes reales
Solamente impedimentos externos o trabajos no realizables con el acceso disponible.

### Próxima fase
Descripción del siguiente paso.
```

No indiques que una fase está completada si algún criterio obligatorio permanece sin validar.

---

# 9. Forma de ejecución

No entregues únicamente recomendaciones.

Debes:

1. Inspeccionar el repositorio.
2. Crear un plan basado en el código real.
3. Implementar los cambios.
4. Construir las imágenes.
5. Levantar los servicios.
6. Ejecutar migraciones.
7. Ejecutar seeders cuando corresponda.
8. Probar los flujos.
9. Simular fallos.
10. Medir resultados.
11. Corregir errores.
12. Documentar la solución.
13. Realizar una revisión final completa.

Cuando existan varias alternativas válidas, selecciona la más apropiada según el contexto actual y documenta la decisión. No detengas innecesariamente la implementación para solicitar decisiones menores.

---

# 10. Restricciones finales

* No rompas la arquitectura existente.
* No sustituyas tecnologías funcionales sin demostrar una mejora concreta.
* No introduzcas complejidad operativa innecesaria.
* No agregues Kubernetes si no existe una justificación real.
* No conviertas todos los procesos en workers indiscriminadamente.
* No utilices una única cola para todos los trabajos.
* No confirmes mensajes antes de completar el procesamiento.
* No implementes reintentos infinitos.
* No ignores mensajes fallidos.
* No expongas base de datos, Redis o broker públicamente.
* No ejecutes migraciones desde todas las réplicas.
* No utilices tiempos de espera arbitrarios para resolver dependencias.
* No ocultes errores mediante mocks.
* No declares pruebas que no se hayan ejecutado.
* No dejes secretos en archivos, logs o capas.
* No dejes configuraciones temporales.
* No dejes documentación desactualizada.
* No dejes pendientes que puedan resolverse con el acceso disponible.

El resultado final debe ser una infraestructura profesional, reproducible, segura, eficiente, observable, resiliente y preparada para crecer sin obligar a reescribir el sistema completo.
