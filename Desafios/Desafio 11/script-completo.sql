DROP SCHEMA IF EXISTS Sanitarios;
CREATE SCHEMA Sanitarios;
USE Sanitarios;

-- Creacion

DROP TABLE IF EXISTS paises;
CREATE TABLE paises (
    Id_pais INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Denominacion VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS provincias;
CREATE TABLE provincias (
    Id_provincia INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Id_pais INT NOT NULL,
    Denominacion VARCHAR(50) NOT NULL,
    FOREIGN KEY (Id_pais)
        REFERENCES paises (Id_pais)
);

DROP TABLE IF EXISTS localidades;
CREATE TABLE localidades (
    Id_localidad INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Id_provincia INT NOT NULL,
    Denominacion VARCHAR(50) NOT NULL,
    FOREIGN KEY (Id_provincia)
        REFERENCES provincias (Id_provincia)
);

DROP TABLE IF EXISTS clientes;
CREATE TABLE clientes (
    Id_cliente INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Id_localidad INT NOT NULL,
    Denominacion VARCHAR(50) NOT NULL,
    Direccion VARCHAR(50) NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    FOREIGN KEY (Id_localidad)
        REFERENCES localidades (Id_localidad)
);

DROP TABLE IF EXISTS precios_lista;
CREATE TABLE precios_lista (
    Id_precio_lista INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Denominacion VARCHAR(50) NOT NULL,
    Porcentaje DECIMAL(3 , 2 ) NOT NULL
);

DROP TABLE IF EXISTS rubros;
CREATE TABLE rubros (
    Id_rubro INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Denominacion VARCHAR(50)
);

DROP TABLE IF EXISTS proveedores;
CREATE TABLE proveedores (
    Id_proveedor INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Id_localidad INT NOT NULL,
    Denominacion VARCHAR(50) NOT NULL,
    Nombre_empresa VARCHAR(50) NOT NULL,
    Cuit VARCHAR(20) NOT NULL,
    Direccion VARCHAR(100) NOT NULL,
    Telefono VARCHAR(15) NOT NULL,
    FOREIGN KEY (Id_localidad)
        REFERENCES localidades (Id_localidad)
);

DROP TABLE IF EXISTS productos;
CREATE TABLE productos (
    Id_producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Id_rubro INT NOT NULL,
    Id_proveedor INT NOT NULL,
    Denominacion VARCHAR(50) NOT NULL,
    Stock_minimo INT NOT NULL,
    Stock_real INT NOT NULL,
    Precio_unitario DECIMAL(8 , 2 ) NOT NULL,
    FOREIGN KEY (Id_rubro)
        REFERENCES rubros (Id_rubro),
    FOREIGN KEY (Id_proveedor)
        REFERENCES proveedores (Id_proveedor)
);

DROP TABLE IF EXISTS pedidos;
CREATE TABLE pedidos (
    Id_pedido INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Id_producto INT NOT NULL,
    Id_proveedor INT NOT NULL,
    Cantidad INT NOT NULL,
    Precio_final DECIMAL(8 , 2 ) NOT NULL,
    Fecha DATE NOT NULL,
    FOREIGN KEY (Id_producto)
        REFERENCES productos (Id_producto),
    FOREIGN KEY (Id_proveedor)
        REFERENCES proveedores (Id_proveedor)
);

DROP TABLE IF EXISTS posiciones_empleados;
CREATE TABLE posiciones_empleados (
    Id_posicion_empleado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Denominacion VARCHAR(50) NOT NULL,
    Salario DECIMAL(10 , 2 ) NOT NULL
);

DROP TABLE IF EXISTS empleados;
CREATE TABLE empleados (
    Id_empleado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Id_posicion_empleado INT NOT NULL,
    Id_localidad INT NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Edad INT NOT NULL,
    DNI VARCHAR(20) NOT NULL,
    Fecha_nacimiento DATE NOT NULL,
    Direccion VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    FOREIGN KEY (Id_posicion_empleado)
        REFERENCES posiciones_empleados (Id_posicion_empleado),
    FOREIGN KEY (Id_localidad)
        REFERENCES localidades (Id_localidad)
);

DROP TABLE IF EXISTS locales;
CREATE TABLE locales (
    Id_local INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Id_localidad INT NOT NULL,
    Id_empleado INT NOT NULL,
    Direccion VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    FOREIGN KEY (Id_localidad)
        REFERENCES localidades (Id_localidad),
    FOREIGN KEY (Id_empleado)
        REFERENCES empleados (Id_empleado)
);

DROP TABLE IF EXISTS presupuestos_cabecera;
CREATE TABLE presupuestos_cabecera (
    Id_presupuesto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Id_cliente INT NOT NULL,
    Id_local INT NOT NULL,
    FOREIGN KEY (Id_cliente)
        REFERENCES clientes (Id_cliente),
    FOREIGN KEY (Id_local)
        REFERENCES locales (Id_local)
);

DROP TABLE IF EXISTS presupuestos_cuerpo;
CREATE TABLE presupuestos_cuerpo (
    Id_presupuesto_cuerpo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Id_presupuesto INT NOT NULL,
    Id_producto INT NOT NULL,
    Id_precio_lista INT NOT NULL,
    Precio_real DECIMAL(10 , 2 ) NOT NULL,
    Porcentaje_real DECIMAL(5 , 2 ) NOT NULL,
    Cantidad INT DEFAULT 1,
    FOREIGN KEY (Id_presupuesto)
        REFERENCES presupuestos_cabecera (Id_presupuesto),
    FOREIGN KEY (Id_producto)
        REFERENCES productos (Id_producto),
    FOREIGN KEY (Id_precio_lista)
        REFERENCES precios_lista (Id_precio_lista)
);

DROP TABLE IF EXISTS encargos_cabecera;
CREATE TABLE encargos_cabecera (
    Id_encargo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Id_cliente INT NOT NULL,
    Id_local INT NOT NULL,
    FOREIGN KEY (Id_cliente)
        REFERENCES clientes (Id_cliente),
    FOREIGN KEY (Id_local)
        REFERENCES locales (Id_local)
);

DROP TABLE IF EXISTS encargos_cuerpo;
CREATE TABLE encargos_cuerpo (
    Id_encargo_cuerpo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Id_encargo INT NOT NULL,
    Id_producto INT NOT NULL,
    Id_precio_lista INT NOT NULL,
    Precio_real DECIMAL(10 , 2 ) NOT NULL,
    Porcentaje_real DECIMAL(5 , 2 ) NOT NULL,
    Cantidad INT DEFAULT 1,
    FOREIGN KEY (Id_encargo)
        REFERENCES encargos_cabecera (Id_encargo),
    FOREIGN KEY (Id_producto)
        REFERENCES productos (Id_producto),
    FOREIGN KEY (Id_precio_lista)
        REFERENCES precios_lista (Id_precio_lista)
);

DROP TABLE IF EXISTS ventas;
CREATE TABLE ventas (
	Id_venta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Id_local INT NOT NULL,
    Id_cliente INT NOT NULL,
    Fecha DATE NOT NULL,
    Total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (Id_local)
		REFERENCES locales (Id_local),
	FOREIGN KEY (Id_cliente)
		REFERENCES clientes (Id_cliente)
);

DROP TABLE IF EXISTS before_ventas_log;
CREATE TABLE before_ventas_log(
	id_before_ventas_log INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_registro INT,
    nombre_usuario CHAR(60),
    fecha DATE,
    hora TIME,
    operacion CHAR(20)
);

DROP TABLE IF EXISTS after_ventas_log;
CREATE TABLE after_ventas_log(
	id_before_ventas_log INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_registro INT,
    nombre_usuario CHAR(60),
    fecha DATE,
    hora TIME,
    operacion CHAR(20)
);

-- Funciones

DELIMITER //
DROP FUNCTION IF EXISTS locales_con_mas_ventas;
//

DELIMITER //
CREATE FUNCTION locales_con_mas_ventas (minimo DECIMAL(10, 2)) 
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE cantidad_de_locales INT;
    SET cantidad_de_locales = (SELECT COUNT(Id_local) AS cantidad FROM (SELECT Id_local, SUM(Total) AS Total_local FROM ventas GROUP BY Id_local HAVING Total_local >= minimo) AS temp1);
    RETURN cantidad_de_locales;
END;
//

DELIMITER //
DROP FUNCTION IF EXISTS random_decimal;
//

DELIMITER //
CREATE FUNCTION random_decimal (min INT, max INT) RETURNS DECIMAL(20,2)
NO SQL
BEGIN
	DECLARE numero_aleatorio DECIMAL(20,2);
    SET numero_aleatorio = (RAND() * (max - min)) + min;
	RETURN numero_aleatorio;
END;
//

DELIMITER //
DROP FUNCTION IF EXISTS random_date;
//

DELIMITER //
CREATE FUNCTION random_date (min DATE, max DATE) RETURNS DATE
NO SQL
BEGIN
	DECLARE fecha_aleatoria DATE;
    SET fecha_aleatoria = (SELECT FROM_UNIXTIME(RAND() * (UNIX_TIMESTAMP(min) - UNIX_TIMESTAMP(max)) + UNIX_TIMESTAMP(max)));
	RETURN fecha_aleatoria;
END;
//

DELIMITER //
DROP FUNCTION IF EXISTS ventas_por_dia;
//

DELIMITER //
CREATE FUNCTION ventas_por_dia (dia DATE) RETURNS DECIMAL(20,2)
READS SQL DATA
BEGIN
	DECLARE total_del_dia DECIMAL(20,2);
    SET total_del_dia = 0;
    SET total_del_dia = (SELECT SUM(Total) AS Total_dia FROM ventas WHERE Fecha = dia);
	RETURN total_del_dia;
END;
//

-- Triggers

DELIMITER ;

DROP TRIGGER IF EXISTS before_ventas_insert;

CREATE TRIGGER before_ventas_insert
BEFORE INSERT ON ventas
FOR EACH ROW
INSERT INTO before_ventas_log SET id_registro = NEW.Id_venta, nombre_usuario = USER(), fecha = CURDATE(), hora = CURTIME(), operacion = "Insert";

DROP TRIGGER IF EXISTS before_ventas_update;
CREATE TRIGGER before_ventas_update
BEFORE UPDATE ON ventas
FOR EACH ROW
INSERT INTO before_ventas_log SET id_registro = NEW.Id_venta, nombre_usuario = USER(), fecha = CURDATE(), hora = CURTIME(), operacion = "Update";

DROP TRIGGER IF EXISTS before_ventas_delete;
CREATE TRIGGER before_ventas_delete
BEFORE DELETE ON ventas
FOR EACH ROW
INSERT INTO before_ventas_log SET id_registro = OLD.Id_venta, nombre_usuario = USER(), fecha = CURDATE(), hora = CURTIME(), operacion = "Delete";

DROP TRIGGER IF EXISTS after_ventas_insert;
CREATE TRIGGER after_ventas_insert
AFTER INSERT ON ventas
FOR EACH ROW
INSERT INTO after_ventas_log SET id_registro = NEW.Id_venta, nombre_usuario = USER(), fecha = CURDATE(), hora = CURTIME(), operacion = "Insert";

DROP TRIGGER IF EXISTS after_ventas_update;
CREATE TRIGGER after_ventas_update
AFTER UPDATE ON ventas
FOR EACH ROW
INSERT INTO after_ventas_log SET id_registro = NEW.Id_venta, nombre_usuario = USER(), fecha = CURDATE(), hora = CURTIME(), operacion = "Update";

DROP TRIGGER IF EXISTS after_ventas_delete;
CREATE TRIGGER after_ventas_delete
AFTER DELETE ON ventas
FOR EACH ROW
INSERT INTO after_ventas_log SET id_registro = OLD.Id_venta, nombre_usuario = USER(), fecha = CURDATE(), hora = CURTIME(), operacion = "Delete";

-- Insercion

INSERT INTO paises (Denominacion) VALUES 
	("Argentina"),
    ("Brazil"),
    ("Uruguay"),
    ("Peru");

INSERT INTO provincias (Id_pais, Denominacion) VALUES
	(1, "Buenos Aires"),
    (1, "Cordoba"),
    (1, "San Juan"),
    (1, "Mendoza"),
    (2, "Rio de Janeiro"),
    (2, "Florianopolis");

INSERT INTO localidades (Id_provincia, Denominacion) VALUES
	(1, "Tortuguitas"),
    (1, "Boulogne"),
    (1, "Pilar"),
    (2, "Malagueño"),
    (2, "Cordoba Capital");
    
insert into clientes (Id_localidad, Denominacion, Direccion, Telefono) VALUES
	(1, "Nicolas Collia", "Santa Maria 340", "11-35463346"),
    (2, "Leandro Garcia", "Centenario 243",  "11-43635476"),
    (1, "Osvaldo Garcia", "Calle Falsa 123", "11-63457345"),
    (2, "Monica Filosi",  "Santa Maria 352", "11-53436434");

INSERT INTO precios_lista (Denominacion, Porcentaje) VALUES 
	("Mayorista",  0.8),
    ("Intermedio", 0.9),
    ("Minorista",  1.0);

INSERT INTO rubros (Denominacion) VALUES
	("AGUA"),
    ("BOMBAS"),
    ("ACCESORIOS POLIETILENO"),
    ("FLOTANTES ROTOPLAS");

INSERT INTO proveedores (Id_localidad, Denominacion, Nombre_empresa, Cuit, Direccion, Telefono) VALUES
	(1 , "Proveedor 1", "Sanitarios express 1", "32532523", "Calle Falsa 123", "11-45353464)"), 
    (2 , "Proveedor 2", "Sanitarios express 2", "63465764", "Calle Falsa 123", "11-76585623)"),
    (1 , "Proveedor 3", "Sanitarios express 3", "52345765", "Calle Falsa 123", "11-54746531)"),
    (2 , "Proveedor 4", "Sanitarios express 4", "45756986", "Calle Falsa 123", "11-34637665)");

INSERT INTO productos (Id_rubro, Id_proveedor, Denominacion, Stock_minimo, Stock_real, Precio_unitario) VALUES
	(1, 1, "Bomba Sumergible", 50,  200, 5500.00),
    (1, 2, "Termocupla", 	   100, 180, 3850.00),
    (1, 3, "Flotante", 		   20,  150, 2500.00),
    (2, 1, "Solapas",          150, 200, 300.00),
    (2, 2, "Manguera 50mts",   10,  20,  6500.00);

INSERT INTO  pedidos(Id_producto, Id_proveedor, Cantidad, Precio_final, Fecha) VALUES
	(1, 1, 100, 25000.00,  random_date('2002-01-01', '2003-01-01')),
    (1, 2, 150, 15000.00,  random_date('2002-01-01', '2003-01-01')),
    (2, 1, 250, 40000.00,  random_date('2002-01-01', '2003-01-01')),
    (1, 3, 100, 10000.00,  random_date('2002-01-01', '2003-01-01'));
    
INSERT INTO posiciones_empleados (Denominacion, Salario) VALUES
	("Gerente",  180000.00),
    ("Vendedor", 120000.00),
    ("Cadete",   100000.00);

INSERT INTO empleados (Id_posicion_empleado, Id_localidad, Nombre, Apellido, Edad, DNI, Fecha_nacimiento, Direccion, Telefono) VALUES
	(2, 1, "Francisco", "Filosi", 21, "43675464", '2001-01-21', "Santa Maria 365", "11-56459865"),
    (1, 2, "Nicolas",   "Collia", 19, "54764323", '2003-01-27', "Santa Maria 234", "11-78768695"),
    (1, 1, "Monica",    "Collia", 32, "45684354", '1980-08-10', "Santa Julia 675", "11-15645345");

INSERT INTO locales (Id_localidad, Id_empleado, Direccion, Telefono) VALUES
	(1, 2, "Centenario 123",  "11-34647456"),
    (2, 1, "Santa Maria 123", "11-47986467"),
    (1, 1, "Drago 456",       "11-58708904"),
    (2, 2, "Centenario 634",  "11-56990856");

INSERT INTO presupuestos_cabecera (Id_cliente, Id_local) VALUES
	(1, 2),
    (2, 1),
    (2, 2);
    
INSERT INTO presupuestos_cuerpo (Id_presupuesto, Id_producto, Id_precio_lista, Precio_real, Porcentaje_real) VALUES
	(1, 2, 1, 2500.00, 0.9),
    (1, 1, 2, 3500.00, 1.0),
    (2, 2, 2, 4500.00, 1.0);

INSERT INTO encargos_cabecera (Id_cliente, Id_local) VALUES
	(1, 2),
    (2, 1),
    (2, 2);
    
INSERT INTO encargos_cuerpo (Id_encargo, Id_producto, Id_precio_lista, Precio_real, Porcentaje_real) VALUES
	(1, 2, 1, 2500.00, 0.9),
    (1, 1, 2, 3500.00, 1.0),
    (2, 2, 2, 4500.00, 1.0);

INSERT INTO ventas (Id_local, Id_cliente, Fecha, Total) VALUES
	(1, 1, random_date('2002-01-01', '2003-01-01'), random_decimal(1000000, 1)),
    (1, 2, random_date('2002-01-01', '2003-01-01'), random_decimal(1000000, 1)),
    (1, 3, random_date('2002-01-01', '2003-01-01'), random_decimal(1000000, 1)),
    (2, 1, random_date('2002-01-01', '2003-01-01'), random_decimal(1000000, 1)),
    (2, 2, random_date('2002-01-01', '2003-01-01'), random_decimal(1000000, 1)),
    (2, 3, random_date('2002-01-01', '2003-01-01'), random_decimal(1000000, 1)),
    (3, 1, random_date('2002-01-01', '2003-01-01'), random_decimal(1000000, 1)),
    (3, 2, random_date('2002-01-01', '2003-01-01'), random_decimal(1000000, 1)),
    (3, 3, random_date('2002-01-01', '2003-01-01'), random_decimal(1000000, 1));

-- Vistas

CREATE OR REPLACE VIEW localidades_de_provincia AS
    (SELECT 
        localidades.Id_localidad,
        provincias.Denominacion AS Nombre_provincia,
        localidades.Denominacion AS Nombre_localidad
    FROM
        localidades
            JOIN
        provincias ON (localidades.Id_provincia = provincias.Id_provincia));

CREATE OR REPLACE VIEW lista_de_empleados AS
    (SELECT 
        CONCAT(empleados.Nombre,
                ' ',
                empleados.Apellido) AS Nombre_completo,
        posiciones_empleados.Denominacion AS Cargo,
        posiciones_empleados.Salario,
        CONCAT(paises.Denominacion,
                ', ',
                provincias.Denominacion,
                ', ',
                localidades.Denominacion,
                ', ',
                empleados.Direccion) AS Domicilio,
        Telefono,
        Fecha_nacimiento
    FROM
        empleados
            JOIN
        posiciones_empleados ON (empleados.Id_posicion_empleado = posiciones_empleados.Id_posicion_empleado)
            JOIN
        localidades ON (empleados.Id_localidad = localidades.Id_localidad)
            JOIN
        provincias ON (localidades.Id_provincia = provincias.Id_provincia)
            JOIN
        paises ON (provincias.Id_pais = paises.Id_pais));
    
CREATE OR REPLACE VIEW productos_por_rubro AS
    (SELECT 
        productos.Denominacion AS Nombre_del_producto,
        rubros.Denominacion AS Rubro,
        proveedores.Nombre_empresa AS Proveedor,
        Stock_minimo,
        Stock_real,
        Precio_unitario
    FROM
        productos
            JOIN
        rubros ON (productos.Id_rubro = rubros.Id_rubro)
            JOIN
        proveedores ON (productos.Id_proveedor = proveedores.Id_proveedor));
    
CREATE OR REPLACE VIEW lista_de_locales AS
    (SELECT 
        CONCAT(empleados.Nombre,
                ' ',
                empleados.Apellido) AS Nombre_gerente,
        CONCAT(paises.Denominacion,
                ', ',
                provincias.Denominacion,
                ', ',
                localidades.Denominacion,
                ', ',
                empleados.Direccion) AS Ubicacion,
        locales.Telefono
    FROM
        locales
            JOIN
        empleados ON (locales.Id_empleado = empleados.Id_empleado)
            JOIN
        localidades ON (locales.Id_localidad = localidades.Id_localidad)
            JOIN
        provincias ON (localidades.Id_provincia = provincias.Id_provincia)
            JOIN
        paises ON (provincias.Id_pais = paises.Id_pais));
    
CREATE OR REPLACE VIEW lista_de_clientes AS
    (SELECT 
        clientes.Denominacion AS Nombre,
        CONCAT(paises.Denominacion,
                ', ',
                provincias.Denominacion,
                ', ',
                localidades.Denominacion,
                ', ',
                clientes.Direccion) AS Ubicacion,
        Telefono
    FROM
        clientes
            JOIN
        localidades ON (clientes.Id_localidad = localidades.Id_localidad)
            JOIN
        provincias ON (localidades.Id_provincia = provincias.Id_provincia)
            JOIN
        paises ON (provincias.Id_pais = paises.Id_pais));

-- Users

DROP USER IF EXISTS 'lectura@localhost';
CREATE USER 'lectura@localhost' IDENTIFIED BY 'lectura-123';
GRANT SELECT ON sanitarios.* TO 'lectura@localhost';

DROP USER IF EXISTS 'escriEdiLec@localhost';
CREATE USER 'escriEdiLec@localhost' IDENTIFIED BY 'escriEdiLec-123';
GRANT SELECT, INSERT, UPDATE ON sanitarios.* TO 'escriEdiLec@localhost';

-- Stored Procedures

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
