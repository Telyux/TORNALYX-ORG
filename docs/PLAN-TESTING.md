# Plan de testing — Tornalyx SGDM

**Entrega:** tercera entrega. **Entorno:** desarrollo local aislado. La matriz es un plan; los casos no deben marcarse aprobados sin evidencia de ejecución.

## Pruebas automatizadas

Requisitos: PHP 8.2+, Composer, PDO y OpenSSL. Desde la raíz:

    composer install
    composer test
    composer lint

La suite PHPUnit cubre calendario de liga con campos pares e impares, eliminación directa, emparejamientos suizos, nombres de ronda, firma RSA/SHA-256 y detección de contenido modificado.

El script de integración existente escribe y elimina datos de demostración; solo usar con base descartable:

    APP_ENV=development php SGDM/backend/database/probar_motor.php

Nunca ejecutarlo contra producción.

## Matriz de pruebas manuales

| ID | Caso | Resultado esperado |
| --- | --- | --- |
| M-01 | Abrir portada en móvil de 320–430 px | Sin desplazamiento horizontal ni controles superpuestos |
| M-02 | Registro con campos vacíos o correo inválido | Validación; no se crea usuario |
| M-03 | Contraseña incorrecta repetida | Rechazo y límite de intentos |
| M-04 | POST sin token CSRF válido | Rechazo sin modificar datos |
| M-05 | Participante abre ruta administrativa | 403 o redirección autorizada |
| M-06 | Crear torneo con datos válidos | Se guarda y aparece en el listado |
| M-07 | Liga con cuatro participantes | Tres rondas y seis enfrentamientos |
| M-08 | Eliminación directa | Ganadores avanzan correctamente |
| M-09 | Suizo con rivales previos | Se priorizan rivales no repetidos |
| M-10 | Resultado con valores negativos o texto | Validación rechaza los datos |
| M-11 | Firmar documento y cambiar un byte | Firma válida antes e inválida después |
| M-12 | Reiniciar contenedores sin borrar volumen | Se conservan datos |
| M-13 | Crear base nueva y levantar Compose | Esquema y datos demo se cargan automáticamente |

## Criterios de salida

Todas las pruebas PHPUnit y lint deben pasar. Registrar fecha, responsable, entorno, resultado y evidencia de cada caso. No declarar aprobación sin ejecutar el caso en la versión desplegada.
