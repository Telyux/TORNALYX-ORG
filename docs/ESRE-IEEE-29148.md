# ESRE — Especificación de Requisitos de Software
**Sistema:** Tornalyx / Sistema de Gestión Deportiva Modular (SGDM)  
**Versión:** borrador para revisión del equipo · **Norma de referencia:** ISO/IEC/IEEE 29148

## 1. Propósito
Especificar los requisitos verificables para la plataforma web de gestión de torneos. Este borrador se deriva de la estructura actual del repositorio y debe contrastarse con las entrevistas, formularios y decisiones aprobadas por el equipo.

## 2. Alcance
El sistema permite consultar torneos públicos, registrar usuarios, mantener perfiles, gestionar torneos e inscripciones, generar emparejamientos, registrar resultados y consultar posiciones. La aplicación usa frontend web, backend PHP organizado en MVC y base MySQL.

## 3. Actores y permisos
- Visitante: consulta información pública.
- Participante: administra su perfil y solicita inscripción.
- Organizador de torneo: gestiona torneos asignados, participantes, rondas y resultados.
- Administrador: administra usuarios y funciones globales autorizadas.

La autorización se aplica en el servidor. La tabla de permisos definitiva debe revisarse con la matriz RBAC del documento de Ciberseguridad.

## 4. Requisitos funcionales
| ID | Requisito | Prioridad | Criterio de aceptación |
| --- | --- | --- | --- |
| RF-01 | El sistema permitirá registrar una cuenta con datos obligatorios y correo único. | Alta | Un registro válido crea una cuenta; un correo duplicado se rechaza. |
| RF-02 | El sistema permitirá autenticar usuarios y validar credenciales. | Alta | Credenciales inválidas no crean sesión autenticada. |
| RF-03 | El sistema permitirá reforzar el acceso mediante OTP cuando esté configurado. | Alta | Un código vencido, incorrecto o ya consumido se rechaza. |
| RF-04 | El participante podrá consultar y editar los campos permitidos de su perfil. | Media | No puede modificar el perfil de otro usuario. |
| RF-05 | El visitante podrá consultar torneos publicados y sus datos básicos. | Alta | Los torneos no públicos no se muestran como públicos. |
| RF-06 | El organizador autorizado podrá crear y actualizar sus torneos. | Alta | La operación rechaza usuarios sin permisos sobre el torneo. |
| RF-07 | El usuario podrá solicitar inscripción cuando el torneo acepte inscripciones. | Alta | No se duplican inscripciones del mismo usuario al torneo. |
| RF-08 | El organizador podrá gestionar solicitudes y equipos según el formato. | Alta | El cambio de estado se persiste y respeta reglas del torneo. |
| RF-09 | El sistema podrá generar fixture de liga, eliminación directa y suizo. | Alta | Los emparejamientos cumplen reglas del formato y no generan autoenfrentamientos. |
| RF-10 | El organizador podrá cargar resultados autorizados. | Alta | Los valores inválidos se rechazan y los resultados válidos se guardan. |
| RF-11 | El sistema podrá mostrar resultados y posiciones actualizadas. | Alta | La vista refleja los resultados persistidos. |
| RF-12 | El sistema podrá publicar avisos relacionados con torneos. | Media | El aviso se muestra al público permitido y registra su autor cuando corresponde. |
| RF-13 | El sistema permitirá firmar y verificar archivos de documentación desde la herramienta administrativa CLI. | Media | La firma válida se verifica; una modificación del contenido invalida la firma. |
| RF-14 | El sistema de desarrollo podrá inicializar una base con datos ficticios reproducibles. | Alta | Una base vacía carga el esquema y al menos 50 registros por tabla funcional. |

## 5. Requisitos no funcionales
- RNF-01 Seguridad: contraseñas con hash adaptativo; secretos fuera del repositorio.
- RNF-02 Autorización: operaciones sensibles se validan en backend, no solo en la interfaz.
- RNF-03 Integridad: relaciones y restricciones de la base deben impedir duplicados inválidos.
- RNF-04 Portabilidad: el entorno de desarrollo debe arrancar con Docker Compose.
- RNF-05 Mantenibilidad: lógica de dominio separada de vistas/controladores y pruebas automatizadas.
- RNF-06 Usabilidad: interfaz responsive con foco en móvil y mensajes de error comprensibles.
- RNF-07 Disponibilidad: respaldos periódicos y procedimiento documentado de restauración.
- RNF-08 Observabilidad: logs de aplicación/servidor y métricas operativas.
- RNF-09 Privacidad: datos de demostración ficticios; no cargar información real sin autorización.
- RNF-10 Rendimiento: las listas deben paginar/limitar resultados cuando el volumen lo requiera; el umbral debe medirse.

## 6. Restricciones y supuestos
- PHP 8.2+, Apache, MySQL 8 y Docker para desarrollo.
- La disponibilidad de correo/OTP depende de credenciales SMTP o del proveedor configurado.
- El despliegue productivo, el dominio y los límites de recursos deben confirmarse para cada entorno.
- Los requisitos derivados de encuestas/entrevistas deben incorporarse tras revisar la evidencia original.

## 7. Trazabilidad
Relacionar cada RF/RNF con controlador, modelo, prueba automatizada o caso manual. La matriz de trazabilidad queda pendiente de revisión contra el código y de aprobación del equipo.
