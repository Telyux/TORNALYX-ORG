# Plan de seguridad web — Tornalyx SGDM

**Marco:** OWASP Top 10 y prácticas de desarrollo seguro. Este documento es una guía de revisión, no una auditoría externa ni una certificación.

## Controles a verificar

| Área | Control | Evidencia requerida |
| --- | --- | --- |
| Control de acceso | Autorización del servidor en acciones sensibles | Pruebas con participante, organizador y administrador |
| Contraseñas | Hash con password_hash/bcrypt y verificación segura | Revisar almacenamiento y login negativo |
| OTP | Código de un solo uso, vencimiento, límite de intentos y hash | Probar expiración, reintento y consumo |
| CSRF | Token para operaciones mutables | POST sin token debe fallar |
| Inyección | Consultas PDO preparadas | Revisar SQL dinámico y parámetros |
| XSS | Escape contextual y CSP | Probar HTML en perfil, torneo y aviso |
| Configuración | Cabeceras, errores ocultos y permisos mínimos | Revisar respuesta HTTP y configuración Apache |
| Integridad | Firma RSA/SHA-256 y verificación pública | Ejecutar pruebas de FirmaDigital |
| Secretos | Variables de entorno; claves fuera de Git y DocumentRoot | Revisar .env e historial |
| Disponibilidad | Límite de intentos, timeouts y límites de carga | Prueba controlada en entorno local |

## Acciones prioritarias

1. Las credenciales de Compose son exclusivamente locales. No reutilizarlas en producción.
2. Mantener claves privadas de firma, SMTP y base de datos fuera del repositorio.
3. En producción, habilitar HTTPS válido, redirección HTTP→HTTPS y cookies seguras cuando la topología lo permita.
4. Confirmar que endpoints administrativos verifican rol y propiedad del recurso en backend.
5. Mantener dependencias e imágenes actualizadas y revisar alertas.
6. Nunca cargar el dataset de demostración en producción.

## Procedimiento

Ejecutar composer test y composer lint, realizar los casos manuales del PLAN-TESTING.md, revisar cabeceras con curl -I sobre el dominio real y registrar severidad, evidencia, responsable y corrección. No declarar cumplimiento OWASP solo por tener este documento.
