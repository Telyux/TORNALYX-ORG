# Análisis FODA — Tornalyx SGDM

Este análisis preliminar deriva de las funciones y la arquitectura del repositorio; el equipo debe revisarlo con datos de entrevistas, pruebas y usuarios.

## Fortalezas
- Centraliza torneos, inscripciones, fixture, resultados y posiciones en una aplicación.
- Incluye formatos de liga, eliminación directa y sistema suizo.
- Usa separación MVC, base relacional y restricciones de integridad.
- Docker facilita reproducir el entorno de desarrollo.
- Se han incorporado pruebas automatizadas, firma digital y documentación operativa.

## Oportunidades
- Probar la plataforma con clubes, centros educativos y organizadores locales.
- Incorporar métricas de uso y encuestas de percepción para priorizar mejoras.
- Automatizar despliegue, respaldos y alertas operativas.
- Mejorar accesibilidad móvil y documentación por rol.

## Debilidades
- El proyecto requiere pruebas de aceptación con usuarios y evidencia de carga/recuperación.
- La configuración productiva depende de credenciales, dominio, correo y base externa.
- Algunas tareas de seguridad (firewall, Fail2ban, ClamAV y TLS) requieren aplicación manual en el servidor.
- La documentación de requisitos, métricas y anexos académicos necesita validación del equipo.

## Amenazas
- Acceso no autorizado si las credenciales o roles se configuran incorrectamente.
- Pérdida de datos por falta de copias verificadas o restauración no probada.
- Indisponibilidad por errores de despliegue, infraestructura o proveedor.
- Dependencias desactualizadas y exposición de servicios administrativos.
- Publicación de datos personales o imágenes sin autorización.

## Estrategias derivadas
- **FO:** usar la portabilidad de Docker para demostrar los flujos de torneo con datos ficticios y pruebas reproducibles.
- **DO:** cerrar documentación y testing con responsables y evidencia antes de promocionar una versión.
- **FA:** reforzar autorización, TLS, respaldos y monitoreo para proteger los datos centralizados.
- **DA:** limitar servicios expuestos, no usar credenciales de desarrollo en producción y ensayar contingencias.
