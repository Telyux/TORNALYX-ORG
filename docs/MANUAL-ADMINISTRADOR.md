# Manual de administrador — Tornalyx SGDM

## Responsabilidades

Administrar cuentas y permisos con mínimo privilegio, supervisar torneos, revisar logs, proteger datos, mantener respaldos y coordinar actualizaciones. No usar cuentas administrativas para operaciones cotidianas.

## Administración funcional

1. Acceder con cuenta autorizada y autenticación reforzada cuando esté configurada.
2. Revisar solicitudes de acceso a documentación y aprobar solo a usuarios que lo necesiten.
3. Revisar cuentas suspendidas, reportes y actividad sospechosa.
4. Antes de cambiar roles o propiedad de torneos, confirmar identidad y registrar motivo.
5. Antes de eliminar datos, verificar impacto en inscripciones, partidos y resultados.

## Despliegue local

Requisitos: Docker Engine y Docker Compose v2.

    docker compose up --build -d
    docker compose ps
    docker compose logs -f app db

Abrir http://localhost:8080. La primera inicialización de un volumen vacío carga esquema y datos de demostración.

Reiniciar sin borrar datos:

    docker compose down
    docker compose up --build -d

Borrar datos locales y volver a sembrar desde cero (destructivo):

    docker compose down -v
    docker compose up --build -d

No ejecutar down -v si se necesita conservar información.

## Pruebas y producción

    composer install
    composer test
    composer lint

El script de integración de base de datos escribe y elimina datos ficticios. Ejecutarlo solo con una base descartable y APP_ENV distinto de production.

En producción: no usar credenciales de Compose, configurar secretos por variables de entorno, usar HTTPS válido, no publicar MySQL, aplicar migraciones en ventana controlada con respaldo previo, ocultar errores y probar restauraciones. Consultar POLITICA-SEGURIDAD-SERVIDOR.md antes de aplicar reglas de firewall en AlmaLinux.

## Incidentes

Registrar hora, URL, usuario afectado y error sin guardar contraseñas/tokens. Preservar logs, limitar acceso comprometido, rotar credenciales, restaurar desde copia validada si corresponde y documentar causa, impacto y prevención.
