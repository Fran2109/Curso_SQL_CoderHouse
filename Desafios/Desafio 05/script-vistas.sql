USE Sanitarios;

CREATE OR REPLACE VIEW localidades_de_provincia AS
	(SELECT localidades.Id_localidad, provincias.Denominacion AS Nombre_provincia, localidades.Denominacion AS Nombre_localidad 
    FROM localidades 
    JOIN provincias ON (localidades.Id_provincia = provincias.Id_provincia));
    
SELECT * FROM localidades_de_provincia WHERE Nombre_provincia = "Buenos Aires";

CREATE OR REPLACE VIEW lista_de_empleados AS 
	(SELECT 
    FROM empleados
    JOIN 
    
/* Id_posicion_empleado, Id_localidad, Nombre, Apellido, Edad, DNI, Fecha_nacimiento, Direccion, Telefono */
    
SELECT * FROM lista_de_empleados;