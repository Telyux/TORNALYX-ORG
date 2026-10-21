# Política de seguridad del servidor — Tornalyx

## Alcance

Guía para endurecer un servidor AlmaLinux 8.x. Los comandos deben ser aplicados por un administrador durante una ventana de mantenimiento; no se ejecutan automáticamente desde el repositorio.

## Política mínima

- Aplicar actualizaciones y registrar reinicios pendientes.
- Usar cuentas nominativas y SSH con claves; comprobar acceso sudo alternativo antes de modificar SSH.
- Exponer solo los puertos necesarios. MySQL no debe publicarse en Internet.
- Mantener firewalld activo y reglas persistentes.
- Activar Fail2ban para SSH y revisar bloqueos.
- Instalar ClamAV desde repositorios confiables, actualizar firmas y programar análisis.
- Usar HTTPS válido y renovación automática.
- Mantener backups cifrados fuera del servidor y probar restauraciones.
- Monitorear disponibilidad web, disco, memoria, CPU, Apache, MySQL y expiración TLS.
- No guardar claves privadas ni secretos en Git o dentro del DocumentRoot.

## Firewall

Antes de cambiar reglas, confirmar servicio SSH, puerto y zona activa; mantener una sesión abierta:

    sudo systemctl status sshd
    sudo firewall-cmd --get-active-zones
    sudo firewall-cmd --list-all
    sudo systemctl enable --now firewalld
    sudo firewall-cmd --permanent --add-service=ssh
    sudo firewall-cmd --permanent --add-service=http
    sudo firewall-cmd --permanent --add-service=https
    sudo firewall-cmd --reload
    sudo firewall-cmd --list-all

No abrir 3306 públicamente. Si SSH usa otro puerto, agregarlo antes de recargar.

## Fail2ban

    sudo dnf install -y epel-release
    sudo dnf install -y fail2ban
    sudo systemctl enable --now fail2ban

Crear /etc/fail2ban/jail.d/sshd.local:

    [sshd]
    enabled = true
    backend = systemd
    maxretry = 5
    findtime = 10m
    bantime = 1h

Validar con sudo fail2ban-client status sshd.

## ClamAV

Instalar los paquetes disponibles en EPEL para la versión del servidor:

    sudo dnf install -y epel-release
    sudo dnf install -y clamav clamav-update
    sudo freshclam
    sudo clamscan -r --infected /var/www

Confirmar nombres de servicios/timers en el sistema. Programar análisis periódico con log; no borrar automáticamente archivos de producción.

## HTTPS con Certbot

1. Apuntar DNS al servidor y permitir TCP 80/443.
2. Instalar Certbot desde un repositorio compatible con la política local.
3. Configurar Apache con ServerName, DocumentRoot y VirtualHost.
4. Emitir certificado para el dominio real y redirigir HTTP a HTTPS.
5. Probar renovación con certbot renew --dry-run.
6. Verificar expiración y cookies seguras desde el navegador.

Completar dominio y rutas reales durante el despliegue; no usar certificados autofirmados en producción.

## Monitoreo y evidencia

La carpeta monitoring contiene una plantilla Prometheus/Grafana. Mantener paneles en localhost o detrás de proxy autenticado. Guardar evidencias de firewall, Fail2ban, ClamAV, HTTPS, renovación, dashboard y prueba de restauración. Esta política no demuestra que el servidor real ya esté configurado.
