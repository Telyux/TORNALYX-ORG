# Herramientas AlmaLinux

Estas plantillas requieren revisión y ejecución manual; no se ejecutan durante el despliegue de Tornalyx.

- firewall-hardening.sh: requiere root, pide confirmación y agrega SSH/HTTP/HTTPS sin abrir MySQL. Verificá SSH no estándar y conservá una segunda sesión.
- fail2ban-sshd.local: copiar a /etc/fail2ban/jail.d/sshd.local después de instalar Fail2ban; validar con fail2ban-client.
- clamav-scan.sh: actualiza firmas y analiza el directorio indicado; registra resultados y nunca elimina archivos automáticamente.

Consultar docs/POLITICA-SEGURIDAD-SERVIDOR.md para instalación y evidencia. Probar primero en una VM.
