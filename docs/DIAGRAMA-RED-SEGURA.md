# Esquema de red con controles de seguridad

**Estado:** arquitectura de referencia; ajustar a la topología real del servidor antes de presentarla como desplegada.

```mermaid
flowchart TB
  U[Usuarios de Internet] -->|HTTPS 443| TLS[Proxy / Apache con certificado válido]
  U -. HTTP 80 redirige a HTTPS .-> TLS
  TLS --> APP[Aplicación PHP Tornalyx]
  APP -->|Red privada / TLS cuando esté soportado| DB[(MySQL)]
  ADMIN[Administrador autorizado] -->|SSH con clave + Fail2ban| HOST[Servidor AlmaLinux]
  HOST --> FW[firewalld: solo puertos necesarios]
  HOST --> MON[Prometheus / Grafana restringidos a localhost o proxy autenticado]
  HOST --> AV[ClamAV: análisis y logs]
  HOST --> BK[Backups externos cifrados]
```

## Controles
- No exponer el puerto MySQL a Internet.
- Restringir SSH por identidad y firewall; conservar acceso de recuperación.
- Exponer paneles de monitoreo solo a administradores.
- Registrar alertas y proteger los logs.
- Separar secretos y claves privadas del código y del directorio público.
- Validar TLS y renovación del certificado con el dominio real.

El diagrama representa el diseño objetivo; adjuntar capturas de configuración y pruebas para demostrar la implementación real.
