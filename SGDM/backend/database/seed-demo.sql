-- Local development fixture. Loaded only on first initialization of a fresh Docker DB volume.
-- 100 disabled demo users and at least 50 rows in each business table.
-- Sessions and OTPs are expired. Never load this dataset into production.
USE tornalyx_db;
DELIMITER $$
DROP PROCEDURE IF EXISTS seed_tornalyx_demo$$
CREATE PROCEDURE seed_tornalyx_demo()
BEGIN
  DECLARE i INT DEFAULT 1;
  WHILE i <= 100 DO
    INSERT INTO usuarios (id,nombre,apellido,nickname,tag,email,password,fecha_nac,rol,estado,bio,ubicacion)
    VALUES (i,CONCAT('Demo',i),'Tornalyx',CONCAT('demo',i),LPAD(MOD(i,99999),5,'0'),
      CONCAT('demo',LPAD(i,3,'0'),'@tornalyx.test'),'!DEMO_ACCOUNT_DISABLED!','1995-01-01',
      'participante','activo','Cuenta ficticia de pruebas; no representa a una persona real.','Entorno local');
    SET i=i+1;
  END WHILE;
  SET i=1;
  WHILE i<=50 DO
    INSERT INTO torneos (id,organizador_id,nombre,descripcion,reglamento,disciplina,formato,requiere_equipos,estado,max_participantes,publico,fecha_inicio,fecha_fin)
    VALUES (i,i,CONCAT('Torneo demo ',LPAD(i,3,'0')),'Registro ficticio para pruebas locales.','Reglamento de demostración.',
      ELT(MOD(i-1,4)+1,'Fútbol','Ajedrez','eSports','Básquetbol'),ELT(MOD(i-1,3)+1,'liga','eliminacion_directa','suizo'),
      0,'inscripcion',100,1,'2026-10-01','2026-12-31');
    INSERT INTO equipos (id,capitan_id,torneo_id,nombre,estado) VALUES (i,i,i,CONCAT('Equipo demo ',LPAD(i,3,'0')),'aprobado');
    INSERT INTO inscripciones (id,usuario_id,torneo_id,equipo_id,estado) VALUES (i,i,i,i,'aprobada');
    INSERT INTO rondas (id,torneo_id,numero,nombre,estado) VALUES (i,i,1,'Ronda 1','pendiente');
    INSERT INTO partidos (id,torneo_id,ronda_id,local_id,visitante_id,tipo_contendiente,estado,lugar)
      VALUES (i,i,i,i,i+50,'usuario','pendiente','Cancha demo');
    INSERT INTO resultados (id,partido_id,goles_local,goles_visitante,ganador_id,observaciones,cargado_por)
      VALUES (i,i,MOD(i,5),MOD(i+2,5),NULL,'Resultado ficticio; no corresponde a un partido real.',i);
    INSERT INTO posiciones (id,torneo_id,contendiente_id,tipo,pj,pg,pe,pp,gf,gc,dg,pts)
      VALUES (i,i,i,'usuario',0,0,0,0,0,0,0,0);
    INSERT INTO sesiones (id,usuario_id,ip,user_agent,expires_at)
      VALUES (CONCAT('demo-session-',LPAD(i,4,'0')),i,'127.0.0.1','Tornalyx demo seed','2020-01-01 00:00:00');
    INSERT INTO login_otps (usuario_id,code_hash,expires_at,attempts,last_sent_at)
      VALUES (i,'not-a-valid-password-hash-for-demo-only','2020-01-01 00:00:00',5,'2020-01-01 00:00:00');
    INSERT INTO doc_acceso (id,usuario_id,materia,estado,solicitado_at)
      VALUES (i,i,CONCAT('demo-materia-',i),'pendiente','2020-01-01 00:00:00');
    INSERT INTO asistencias (partido_id,usuario_id,estado) VALUES (i,i,IF(MOD(i,2)=0,'confirmada','ausente'));
    INSERT INTO avisos (id,torneo_id,autor_id,tipo,titulo,cuerpo)
      VALUES (i,i,i,ELT(MOD(i-1,5)+1,'novedad','fixture','resultado','inscripcion','horario'),
        CONCAT('Aviso demo ',LPAD(i,3,'0')),'Contenido ficticio para verificar listados y paginación.');
    INSERT INTO avisos_leidos (aviso_id,usuario_id,leido_at) VALUES (i,i,'2020-01-01 00:00:00');
    INSERT INTO doc_otps (usuario_id,materia,code_hash,expires_at,attempts,last_sent_at)
      VALUES (i,CONCAT('demo-materia-',i),'not-a-valid-password-hash-for-demo-only','2020-01-01 00:00:00',5,'2020-01-01 00:00:00');
    SET i=i+1;
  END WHILE;
END$$
DELIMITER ;
CALL seed_tornalyx_demo();
DROP PROCEDURE seed_tornalyx_demo;
-- schema_migrations is intentionally excluded so fake records cannot skip real migrations.
