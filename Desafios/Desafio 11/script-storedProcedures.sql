USE Sanitarios;

DELIMITER //
DROP PROCEDURE IF EXISTS obtener_empleados;
//

DELIMITER //
CREATE PROCEDURE obtener_empleados(IN ordenamiento CHAR(100), IN sentido CHAR(5))
BEGIN
	-- Si el ordenamiento esta vacio no me importa lo que tenga sentido, Si ordenamiento no esta vacio armo el order by
	IF ordenamiento <> "" THEN
		SET @orden = concat(" ORDER BY ", ordenamiento);
        -- Si el sentido no es vacio lo paso agregar al orden
        IF sentido <> "" THEN
			SET @orden = concat(@orden, " ", sentido);
		END IF;
	ELSE
		SET @orden = "";
	END IF;
    SET @consulta = concat("SELECT * FROM empleados ",@orden);
    PREPARE runSQL FROM @consulta;
    EXECUTE runSQL;
	DEALLOCATE PREPARE runSQL;
END;
//

DELIMITER //
CALL obtener_empleados("Id_localidad", "ASC");
//
DELIMITER //
CALL obtener_empleados("Id_localidad", "DESC");
//
DELIMITER //
CALL obtener_empleados("Nombre", "ASC");
//
DELIMITER //
CALL obtener_empleados("Nombre", "DESC");
//


DELIMITER //
DROP PROCEDURE IF EXISTS insertar_empleado;
//

DELIMITER //
CREATE PROCEDURE insertar_empleado(IN Id_posicion_empleado INT, IN Id_localidad INT, IN Nombre VARCHAR(50), IN Apellido VARCHAR(50), IN Edad INT, IN DNI VARCHAR(20), IN Fecha_nacimiento DATE, IN Direccion VARCHAR(100), IN Telefono VARCHAR(20))
BEGIN
	SET @consulta = concat('INSERT INTO empleados (Id_posicion_empleado, Id_localidad, Nombre, Apellido, Edad, DNI, Fecha_nacimiento, Direccion, Telefono) VALUES (', Id_posicion_empleado, ', ', Id_localidad, ', "', Nombre, '", "', Apellido, '", ', Edad, ', "', DNI, '", "', Fecha_nacimiento, '", "', Direccion, '", "', Telefono, '")');
    PREPARE runSQL FROM @consulta;
    EXECUTE runSQL;
	DEALLOCATE PREPARE runSQL;
END;
//

CALL insertar_empleado(1, 2, "Osvaldo", "Filosi", 52, "35436445", "1970-09-1", "Santa Maria 352", "11-43563463");