--PROBLEMA 1 - CRUD 
CREATE OR REPLACE PROCEDURE sp_crud_evento (
    accion IN VARCHAR2, 
    pidEvento IN EVENTO.idEvento%TYPE, 
    pfecha_evento IN EVENTO.fecha_evento%TYPE, 
    ptipo_evento IN EVENTO.tipo_evento%TYPE, 
    pidGrupo IN EVENTO.idGrupo%TYPE, 
    mensaje OUT VARCHAR2
)
AS
    existe NUMBER;
    empalme NUMBER;
BEGIN
    IF accion NOT IN ('INSERT', 'UPDATE', 'DELETE', 'READ') THEN
        mensaje := 'Acción no válida. Use INSERT, UPDATE, DELETE o READ.';
        RETURN;
    END IF;

    IF accion IN ('INSERT', 'UPDATE') THEN
        SELECT COUNT(*) INTO existe
        FROM evento
        WHERE idEvento = pidEvento;

        SELECT COUNT(*) INTO empalme
        FROM evento
        WHERE idGrupo = pidGrupo
        AND fecha_evento = pfecha_evento
        AND (accion = 'UPDATE' OR idEvento != pidEvento);
    END IF;

    IF accion = 'INSERT' THEN
        IF existe > 0 THEN
            mensaje := 'Error: El idEvento ya existe.';
        ELSIF empalme > 0 THEN
            mensaje := 'Error: El evento se empalma con otro evento del mismo grupo.';
        ELSE
            INSERT INTO evento (idEvento, fecha_evento, tipo_evento, idGrupo)
            VALUES (pidEvento, pfecha_evento, ptipo_evento, pidGrupo);
            mensaje := 'Evento insertado correctamente.';
        END IF;

    ELSIF accion = 'UPDATE' THEN
        IF existe = 0 THEN
            mensaje := 'Error: El idEvento no existe.';
        ELSIF empalme > 0 THEN
            mensaje := 'Error: El evento se empalma con otro evento del mismo grupo.';
        ELSE
            UPDATE evento
            SET fecha_evento = pfecha_evento, tipo_evento = ptipo_evento, idGrupo = pidGrupo
            WHERE idEvento = pidEvento;
            mensaje := 'Evento actualizado correctamente.';
        END IF;

    ELSIF accion = 'DELETE' THEN
        IF existe = 0 THEN
            mensaje := 'Error: El idEvento no existe.';
        ELSE
            DELETE FROM evento WHERE idEvento = pidEvento;
            mensaje := 'Evento eliminado correctamente.';
        END IF;

    ELSIF accion = 'READ' THEN
        mensaje := 'Consulta realizada.';
    END IF;
END;

--PRUEBA DEL CRUD PROBLEMA 1
--READ
DECLARE
    v_mensaje VARCHAR2(100);
BEGIN
    sp_crud_evento(
        accion => 'DELETE',
        pidEvento => 1,
        pfecha_evento => NULL,
        ptipo_evento => NULL,
        pidGrupo => NULL,
        mensaje => v_mensaje
    );
    DBMS_OUTPUT.PUT_LINE(v_mensaje);
END;

--INSERT
DECLARE
    v_mensaje VARCHAR2(100);
BEGIN
    sp_crud_evento(
        accion => 'INSERT',
        pidEvento => 1, 
        pfecha_evento => TO_DATE('2024-12-25', 'YYYY-MM-DD'),
        ptipo_evento => 'Fiesta',
        pidGrupo => 1,
        mensaje => v_mensaje
    );
    DBMS_OUTPUT.PUT_LINE(v_mensaje);
END;

--UPDATE
DECLARE
    v_mensaje VARCHAR2(100);
BEGIN
    sp_crud_evento(
        accion => 'UPDATE',
        pidEvento => 1,
        pfecha_evento => TO_DATE('2025-01-01', 'YYYY-MM-DD'),
        ptipo_evento => 'Reunión',
        pidGrupo => 2,
        mensaje => v_mensaje
    );
    DBMS_OUTPUT.PUT_LINE(v_mensaje);
END;

--DELETE
DECLARE
    v_mensaje VARCHAR2(100);
BEGIN
    sp_crud_evento(
        accion => 'DELETE',
        pidEvento => 1,
        pfecha_evento => NULL,
        ptipo_evento => NULL,
        pidGrupo => NULL,
        mensaje => v_mensaje
    );
    DBMS_OUTPUT.PUT_LINE(v_mensaje);
END;


--PROBLEMA 2 - REPORTE DE GRUPOS ARTISTICOS
CREATE OR REPLACE PROCEDURE sp_reporte_eventos_mensuales_directo (
    p_anio IN NUMBER,
    p_tipo_evento IN VARCHAR2,
    cursor_reporte OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN cursor_reporte FOR
    SELECT
        ga.nombre_grupo,
        COUNT(CASE WHEN EXTRACT(MONTH FROM e.fecha_evento) = 1 THEN 1 END) AS ene,
        COUNT(CASE WHEN EXTRACT(MONTH FROM e.fecha_evento) = 2 THEN 1 END) AS feb,
        COUNT(CASE WHEN EXTRACT(MONTH FROM e.fecha_evento) = 3 THEN 1 END) AS mar,
        COUNT(CASE WHEN EXTRACT(MONTH FROM e.fecha_evento) = 4 THEN 1 END) AS abr,
        COUNT(CASE WHEN EXTRACT(MONTH FROM e.fecha_evento) = 5 THEN 1 END) AS may,
        COUNT(CASE WHEN EXTRACT(MONTH FROM e.fecha_evento) = 6 THEN 1 END) AS jun,
        COUNT(CASE WHEN EXTRACT(MONTH FROM e.fecha_evento) = 7 THEN 1 END) AS jul,
        COUNT(CASE WHEN EXTRACT(MONTH FROM e.fecha_evento) = 8 THEN 1 END) AS ago,
        COUNT(CASE WHEN EXTRACT(MONTH FROM e.fecha_evento) = 9 THEN 1 END) AS sep,
        COUNT(CASE WHEN EXTRACT(MONTH FROM e.fecha_evento) = 10 THEN 1 END) AS oct,
        COUNT(CASE WHEN EXTRACT(MONTH FROM e.fecha_evento) = 11 THEN 1 END) AS nov,
        COUNT(CASE WHEN EXTRACT(MONTH FROM e.fecha_evento) = 12 THEN 1 END) AS dic,
        COUNT(*) AS total
    FROM
        GRUPO_ARTISTICO ga
        JOIN EVENTO e ON ga.idGrupo = e.idGrupo
    WHERE
        EXTRACT(YEAR FROM e.fecha_evento) = p_anio
        AND (p_tipo_evento = 'AMBOS' OR e.tipo_evento = p_tipo_evento)
    GROUP BY
        ga.nombre_grupo
    ORDER BY
        ga.nombre_grupo;
END;

--LLAMAR AL PROCEDIMIENTO DEL PROBLEMA 2
DECLARE
    cursor_reporte SYS_REFCURSOR;
    v_nombre_grupo VARCHAR2(200);
    v_ene NUMBER;
    v_feb NUMBER;
    v_mar NUMBER;
    v_abr NUMBER;
    v_may NUMBER;
    v_jun NUMBER;
    v_jul NUMBER;
    v_ago NUMBER;
    v_sep NUMBER;
    v_oct NUMBER;
    v_nov NUMBER;
    v_dic NUMBER;
    v_total NUMBER;
BEGIN
    sp_reporte_eventos_mensuales_directo(2024, 'Local', cursor_reporte);
    
    DBMS_OUTPUT.PUT_LINE('Nombre del Grupo     | Ene | Feb | Mar | Abr | May | Jun | Jul | Ago | Sep | Oct | Nov | Dic | Total');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------------------------------------');
    
    LOOP
        FETCH cursor_reporte INTO v_nombre_grupo, v_ene, v_feb, v_mar, v_abr, v_may, v_jun, v_jul, v_ago, v_sep, v_oct, v_nov, v_dic, v_total;
        EXIT WHEN cursor_reporte%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(RPAD(v_nombre_grupo, 20) || ' | ' || 
                             LPAD(v_ene, 3) || ' | ' || 
                             LPAD(v_feb, 3) || ' | ' || 
                             LPAD(v_mar, 3) || ' | ' || 
                             LPAD(v_abr, 3) || ' | ' || 
                             LPAD(v_may, 3) || ' | ' || 
                             LPAD(v_jun, 3) || ' | ' || 
                             LPAD(v_jul, 3) || ' | ' || 
                             LPAD(v_ago, 3) || ' | ' || 
                             LPAD(v_sep, 3) || ' | ' || 
                             LPAD(v_oct, 3) || ' | ' || 
                             LPAD(v_nov, 3) || ' | ' || 
                             LPAD(v_dic, 3) || ' | ' || 
                             LPAD(v_total, 5));
    END LOOP;
    
    CLOSE cursor_reporte;
END;


--PROBLEMA 3 - PROCEDIMIENTO INFORMACION DE EVENTOS CORRESPONDIENTES
CREATE OR REPLACE PROCEDURE sp_informacion_eventos (
    p_idGrupo IN NUMBER,
    p_idPatrocinador IN NUMBER,
    cursor_resultado OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN cursor_resultado FOR
    SELECT
        ga.idGrupo,
        ga.nombre_grupo,
        p.idPatrocinador,
        p.nombre_patrocinador,
        e.idEvento,
        e.tipo_evento,
        e.fecha_evento,
        COALESCE(ep.monto_patrocinado, 0) AS monto_patrocinado
    FROM
        EVENTO e
        JOIN GRUPO_ARTISTICO ga ON e.idGrupo = ga.idGrupo
        LEFT JOIN EVENTO_PATROCINIO ep ON e.idEvento = ep.idEvento
        LEFT JOIN PATROCINADOR p ON ep.idPatrocinador = p.idPatrocinador
    WHERE
        (p_idGrupo = -99 OR e.idGrupo = p_idGrupo) AND
        (p_idPatrocinador = -99 OR p.idPatrocinador = p_idPatrocinador)
    ORDER BY
        ga.nombre_grupo, e.fecha_evento;
END;

--LLAMAR AL PROCEDIMIENTO DE PROBLEMA 3
DECLARE
    cursor_resultado SYS_REFCURSOR;
    v_idGrupo NUMBER;
    v_nombre_grupo VARCHAR2(200);
    v_idPatrocinador NUMBER;
    v_nombre_patrocinador VARCHAR2(200);
    v_idEvento NUMBER;
    v_tipo_evento VARCHAR2(200);
    v_fecha_evento DATE;
    v_monto_patrocinado NUMBER;
BEGIN
    sp_informacion_eventos(-99, -99, cursor_resultado);
    
    DBMS_OUTPUT.PUT_LINE('ID Grupo | Nombre Grupo      | ID Patrocinador | Nombre Patrocinador | ID Evento | Tipo Evento | Fecha Evento | Monto Patrocinado');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------------------------------------------------');
    
    LOOP
        FETCH cursor_resultado INTO v_idGrupo, v_nombre_grupo, v_idPatrocinador, v_nombre_patrocinador, v_idEvento, v_tipo_evento, v_fecha_evento, v_monto_patrocinado;
        EXIT WHEN cursor_resultado%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(LPAD(v_idGrupo, 8) || ' | ' ||
                             RPAD(v_nombre_grupo, 18) || ' | ' ||
                             LPAD(v_idPatrocinador, 15) || ' | ' ||
                             RPAD(v_nombre_patrocinador, 20) || ' | ' ||
                             LPAD(v_idEvento, 9) || ' | ' ||
                             RPAD(v_tipo_evento, 12) || ' | ' ||
                             TO_CHAR(v_fecha_evento, 'YYYY-MM-DD') || ' | ' ||
                             LPAD(v_monto_patrocinado, 16));
    END LOOP;
    
    CLOSE cursor_resultado;
END;


--PROBLEMA 4 
CREATE OR REPLACE FUNCTION generar_password (
    p_nombre VARCHAR2,
    p_id_empleado NUMBER,
    p_fecha_nacimiento DATE
) RETURN VARCHAR2
IS
    v_consonante CHAR(1);
    v_vocal CHAR(1);
    v_id_empleado_format VARCHAR2(5);
    v_dia_nacimiento VARCHAR2(2);
    v_password VARCHAR2(50);
BEGIN
    FOR i IN 1..LENGTH(p_nombre) LOOP
        IF SUBSTR(p_nombre, i, 1) IN ('b','c','d','f','g','h','j','k','l','m','n','p','q','r','s','t','v','w','x','y','z','B','C','D','F','G','H','J','K','L','M','N','P','Q','R','S','T','V','W','X','Y','Z') THEN
            v_consonante := LOWER(SUBSTR(p_nombre, i, 1));
            EXIT;
        END IF;
    END LOOP;

    FOR i IN 1..LENGTH(p_nombre) LOOP
        IF SUBSTR(p_nombre, i, 1) IN ('a','e','i','o','u','A','E','I','O','U') THEN
            v_vocal := UPPER(SUBSTR(p_nombre, i, 1));
            EXIT;
        END IF;
    END LOOP;

    v_id_empleado_format := LPAD(TO_CHAR(p_id_empleado), 5, '0');

    v_dia_nacimiento := TO_CHAR(p_fecha_nacimiento, 'DD');

    v_password := v_consonante || v_vocal || v_id_empleado_format || v_dia_nacimiento || '*';

    RETURN v_password;
END;

--LLAMAR A LA FUNCION DE PROBLEMA 4
DECLARE
    v_password VARCHAR2(50);
BEGIN
    v_password := generar_password('Carlos', 10, TO_DATE('1985-03-18', 'YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('Generated Password: ' || v_password);
END;

--PROBLEMA 5
CREATE OR REPLACE FUNCTION generar_password_excepcion (
    p_nombre VARCHAR2,
    p_id_empleado NUMBER,
    p_fecha_nacimiento DATE
) RETURN VARCHAR2
IS
    v_consonante CHAR(1);
    v_vocal CHAR(1);
    v_id_empleado_format VARCHAR2(5);
    v_dia_nacimiento VARCHAR2(2);
    v_password VARCHAR2(50);
BEGIN
    IF p_nombre IS NULL OR LENGTH(p_nombre) = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El nombre no puede estar vacío.');
    END IF;
    
    IF p_id_empleado <= 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'El ID del empleado debe ser un número positivo.');
    END IF;
    
    IF p_fecha_nacimiento IS NULL THEN
        RAISE_APPLICATION_ERROR(-20003, 'La fecha de nacimiento no puede estar vacía.');
    END IF;
    
    FOR i IN 1..LENGTH(p_nombre) LOOP
        IF SUBSTR(p_nombre, i, 1) IN ('b','c','d','f','g','h','j','k','l','m','n','p','q','r','s','t','v','w','x','y','z','B','C','D','F','G','H','J','K','L','M','N','P','Q','R','S','T','V','W','X','Y','Z') THEN
            v_consonante := LOWER(SUBSTR(p_nombre, i, 1));
            EXIT;
        END IF;
    END LOOP;

    FOR i IN 1..LENGTH(p_nombre) LOOP
        IF SUBSTR(p_nombre, i, 1) IN ('a','e','i','o','u','A','E','I','O','U') THEN
            v_vocal := UPPER(SUBSTR(p_nombre, i, 1));
            EXIT;
        END IF;
    END LOOP;

    IF v_consonante IS NULL THEN
        RAISE_APPLICATION_ERROR(-20004, 'No se encontró ninguna consonante en el nombre.');
    END IF;
    IF v_vocal IS NULL THEN
        RAISE_APPLICATION_ERROR(-20005, 'No se encontró ninguna vocal en el nombre.');
    END IF;

    v_id_empleado_format := LPAD(TO_CHAR(p_id_empleado), 5, '0');

    v_dia_nacimiento := TO_CHAR(p_fecha_nacimiento, 'DD');

    v_password := v_consonante || v_vocal || v_id_empleado_format || v_dia_nacimiento || '*';

    RETURN v_password;

EXCEPTION
    WHEN OTHERS THEN
        RETURN 'Error: ' || SQLERRM;
END;

--LLAMAR FUNCION DE EXCEPCION DE PROBLEMA 5
DECLARE
    v_password VARCHAR2(50);
BEGIN
    v_password := generar_password('Carlos', 10, TO_DATE('1985-03-18', 'YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('Generated Password: ' || v_password);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;