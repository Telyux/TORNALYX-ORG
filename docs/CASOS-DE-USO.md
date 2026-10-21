# Casos de uso — Tornalyx SGDM

Estos casos se basan en funciones observables del sistema y deben validarse con el equipo y la versión desplegada.

## Actores
Visitante, Participante, Organizador de torneo y Administrador.

## UC-01 — Consultar torneos públicos
**Actor principal:** Visitante.  
**Precondición:** aplicación disponible.  
**Flujo:** abrir listado → elegir torneo → consultar disciplina, formato, fechas, estado, fixture y resultados disponibles.  
**Alternativa:** si el torneo no es público, no se muestra en el listado público.  
**Postcondición:** no se modifica información.

## UC-02 — Registrar cuenta e iniciar sesión
**Actor:** Visitante.  
**Flujo:** completar registro → validar campos y correo único → crear cuenta → iniciar sesión → completar OTP si está habilitado.  
**Alternativas:** datos inválidos, correo duplicado, credenciales incorrectas, OTP vencido o límite de intentos alcanzado.  
**Postcondición:** solo credenciales válidas crean sesión autenticada.

## UC-03 — Solicitar inscripción
**Actor:** Participante.  
**Precondiciones:** sesión activa, torneo visible y periodo de inscripción abierto.  
**Flujo:** abrir torneo → solicitar inscripción → validar cupo/reglas → guardar solicitud → consultar estado.  
**Alternativas:** inscripción duplicada, torneo cerrado o falta de cupo.  
**Postcondición:** una única inscripción por usuario y torneo.

## UC-04 — Administrar torneo
**Actor:** Organizador autorizado.  
**Flujo:** abrir panel → seleccionar torneo asignado → revisar inscripciones/equipos → aprobar o rechazar solicitudes → generar ronda → revisar emparejamientos.  
**Alternativa:** si el actor no tiene permiso sobre el torneo, el backend rechaza la operación.  
**Postcondición:** estados y rondas persistidos.

## UC-05 — Registrar resultado
**Actor:** Organizador autorizado.  
**Precondición:** partido existente y permiso sobre el torneo.  
**Flujo:** abrir partido → introducir resultado válido → confirmar → recalcular posiciones → consultar tabla actualizada.  
**Alternativa:** valores inválidos o resultado ya cargado se tratan según reglas de la aplicación.  
**Postcondición:** resultado guardado y tabla coherente.

## UC-06 — Firmar y verificar documento
**Actor:** administrador técnico autorizado.  
**Precondición:** acceso a archivo y clave privada almacenada fuera de Git; la clave pública está disponible para verificar.  
**Flujo:** configurar variable de entorno → ejecutar la utilidad CLI en modo firma → guardar archivo de firma → verificar con clave pública.  
**Alternativa:** contenido modificado, firma mal formada o clave incorrecta devuelve error.  
**Postcondición:** integridad del contenido verificada respecto de la clave pública.

## Diagrama resumido
`mermaid
flowchart LR
  Visitante --> Publico[Consultar torneos públicos]
  Visitante --> Registro[Registrarse e iniciar sesión]
  Participante --> Inscripcion[Solicitar inscripción]
  Organizador --> Gestion[Gestionar torneo y rondas]
  Organizador --> Resultado[Registrar resultados]
  Admin[Administrador] --> Usuarios[Administrar usuarios]
  Admin --> Firma[Firmar y verificar archivos]
  Gestion --> BD[(MySQL)]
  Resultado --> BD
  Inscripcion --> BD
`

## Trazabilidad con pruebas
Vincular UC-01 a M-01/M-06, UC-02 a M-02/M-03/M-04, UC-03 a pruebas de duplicado y estado de torneo, UC-04/UC-05 a pruebas del motor y permisos, y UC-06 a FirmaDigitalTest. Los casos que requieren interfaz deben probarse manualmente en la versión desplegada.
