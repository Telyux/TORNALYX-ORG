# Métricas por puntos de función — hoja de conteo

**Estado:** plantilla pendiente de estimación validada. No se registran totales hasta acordar límites del sistema y revisar pantallas, endpoints y almacenes de datos.

## Alcance propuesto
Límite funcional: aplicación web Tornalyx SGDM. El equipo debe acordar qué servicios externos se consideran dentro o fuera del alcance. Los archivos de infraestructura no son funciones de usuario por sí solos.

## Inventario para conteo
| Tipo | Candidatos a revisar | Cantidad validada |
| --- | --- | --- |
| Entrada externa (EI) | Registro, login, edición de perfil, solicitud de inscripción, carga de resultado, publicación de aviso | Pendiente |
| Salida externa (EO) | Respuestas de confirmación, mensajes de error, reportes/tablas calculadas | Pendiente |
| Consulta externa (EQ) | Listado/detalle de torneos, fixture, resultados, posiciones, perfil público | Pendiente |
| Archivo lógico interno (ILF) | usuarios, torneos, equipos, inscripciones, rondas, partidos, resultados, posiciones, avisos y tablas relacionadas | Pendiente |
| Archivo de interfaz externa (EIF) | Servicios externos consumidos por el sistema, si se confirma alguno como dato externo mantenido | Pendiente |

## Procedimiento
1. Definir alcance y frontera de la aplicación.
2. Eliminar duplicados y contar funciones únicas visibles al usuario.
3. Clasificar complejidad baja/media/alta según DET, FTR y RET aplicables al método seleccionado.
4. Aplicar los pesos de la norma/metodología elegida y documentar las decisiones.
5. Revisar el conteo con un segundo integrante.
6. Registrar puntos de función sin ajustar y, si la asignatura lo solicita, el factor de ajuste con su justificación.

## Registro
- Fecha de conteo:
- Método y tabla de pesos utilizada:
- Personas que estiman/revisan:
- Total calculado:
- Evidencia y versión del sistema:
