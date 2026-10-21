# Factibilidad y plan de contingencias — Tornalyx

## 1. Factibilidad técnica
**Evaluación preliminar:** viable para un proyecto educativo y un volumen inicial acotado. El repositorio contiene aplicación PHP, Apache, MySQL, Docker Compose y un modelo de datos relacional. Las pruebas automatizadas y el monitoreo deben ejecutarse para confirmar estabilidad; esta evaluación no equivale a una prueba de carga.

## 2. Factibilidad operativa
La aplicación cubre consultas públicas, cuentas, torneos, inscripciones, resultados y posiciones. El equipo debe definir responsables de soporte, gestión de accesos, respaldos y respuesta a incidentes. La aceptación operativa depende de probar los flujos con usuarios representativos.

## 3. Factibilidad económica
La solución utiliza herramientas de software libre y puede ejecutarse localmente con Docker. El costo real de producción depende de alojamiento, dominio, correo, almacenamiento, respaldos y tiempo de mantenimiento. No se asignan importes sin cotizaciones verificables.

## 4. Análisis costo-beneficio cualitativo

| Costos/esfuerzos | Beneficios esperados |
| --- | --- |
| Desarrollo, pruebas y mantenimiento | Menos gestión manual de torneos |
| Alojamiento, dominio y correo | Acceso centralizado para participantes y organizadores |
| Respaldos, seguridad y monitoreo | Menor riesgo de pérdida de datos y detección más rápida de fallos |
| Capacitación y documentación | Procedimientos repetibles y menor dependencia de una sola persona |

La cuantificación monetaria queda pendiente de cotizaciones y estimación de horas del equipo.

## 5. Plan de contingencias

| Incidente | Detección | Respuesta inicial | Recuperación |
| --- | --- | --- | --- |
| Aplicación no responde | Comprobación HTTP y logs Apache | Revisar estado de contenedor/servicio y logs | Reiniciar tras identificar causa; validar endpoints críticos |
| Base no responde | Healthcheck, errores PDO y métricas | Revisar disco, servicio, conexiones y logs | Restaurar servicio o copia validada |
| Pérdida/corrupción de datos | Fallos de integridad o reporte | Detener cambios que agraven la pérdida y preservar logs | Restaurar respaldo probado y reconciliar cambios |
| Cuenta comprometida | Alertas o reporte | Revocar sesiones y restringir cuenta | Rotar credenciales y revisar registros |
| Certificado TLS vencido | Alerta de expiración/navegador | Verificar DNS, renovación y logs Certbot | Renovar certificado y validar HTTPS |
| Malware sospechoso | ClamAV/alerta | Aislar archivo sin borrarlo automáticamente; preservar evidencia | Analizar, limpiar con autorización y restaurar desde origen confiable |
| Error de despliegue | CI falla o smoke test falla | No promover la versión | Volver a la versión anterior y repetir pruebas |

## 6. Pruebas del plan
Realizar simulaciones controladas de caída de app, indisponibilidad de base y restauración en entorno de pruebas. Registrar responsable, hora, duración, impacto y resultado. No afirmar que el plan fue ensayado hasta adjuntar evidencia.
