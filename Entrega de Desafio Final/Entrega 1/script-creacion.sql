DROP SCHEMA IF EXISTS Sanitarios;
CREATE SCHEMA Sanitarios;
USE Sanitarios;

CREATE TABLE paises (
    Id_pais INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Denominacion VARCHAR(50) NOT NULL
);

CREATE TABLE provincias (
    Id_provincia INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Id_pais INT NOT NULL,
    Denominacion VARCHAR(50) NOT NULL,
    FOREIGN KEY (Id_pais)
        REFERENCES paises (Id_pais)
);

CREATE TABLE localidades (
    Id_localidad INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Id_provincia INT NOT NULL,
    Denominacion VARCHAR(50) NOT NULL,
    FOREIGN KEY (Id_provincia)
        REFERENCES provincias (Id_provincia)
);

CREATE TABLE clientes (
    Id_cliente INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Id_localidad INT NOT NULL,
    Denominacion VARCHAR(50) NOT NULL,
    Direccion VARCHAR(50) NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    FOREIGN KEY (Id_localidad)
        REFERENCES localidades (Id_localidad)
);

CREATE TABLE precios_lista (
    Id_precio_lista INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Denominacion VARCHAR(50) NOT NULL,
    Porcentaje DECIMAL(3 , 2 ) NOT NULL
);

CREATE TABLE rubros (
    Id_rubro INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Denominacion VARCHAR(50)
);

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

CREATE TABLE pedidos (
    Id_pedido INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Id_producto INT NOT NULL,
    Cantidad INT NOT NULL,
    Precio_final DECIMAL(8 , 2 ) NOT NULL,
    Fecha DATE NOT NULL,
    FOREIGN KEY (Id_producto)
        REFERENCES productos (Id_producto)
);

CREATE TABLE posiciones_empleados (
    Id_posicion_empleado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Denominacion VARCHAR(50) NOT NULL,
    Salario DECIMAL(10 , 2 ) NOT NULL
);

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

CREATE TABLE presupuestos_cabecera (
    Id_presupuesto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Id_cliente INT NOT NULL,
    Id_local INT NOT NULL,
    FOREIGN KEY (Id_cliente)
        REFERENCES clientes (Id_cliente),
    FOREIGN KEY (Id_local)
        REFERENCES locales (Id_local)
);

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

CREATE TABLE encargos_cabecera (
    Id_encargo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Id_cliente INT NOT NULL,
    Id_local INT NOT NULL,
    FOREIGN KEY (Id_cliente)
        REFERENCES clientes (Id_cliente),
    FOREIGN KEY (Id_local)
        REFERENCES locales (Id_local)
);

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

INSERT INTO paises (Denominacion) VALUES 
	("Argentina"),
    ("Brazil"),
    ("Uruguay");

INSERT INTO provincias (Id_pais, Denominacion) VALUES
	(1, "Buenos Aires"),
    (1, "Cordoba"),
    (1, "San Juan"),
    (2, "Florianopolis");

INSERT INTO localidades (Id_provincia, Denominacion) VALUES
	(1, "Tortuguitas"),
    (3, "sdafrs");
    
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

INSERT INTO  pedidos(Id_producto, Cantidad, Precio_final, Fecha) VALUES
	(1, 100, 25000.00,  CURDATE()),
    (1, 150, 15000.00,  CURDATE()),
    (2, 250, 40000.00,  CURDATE()),
    (1, 100, 10000.00,  CURDATE());
    
INSERT INTO posiciones_empleados (Denominacion, Salario) VALUES
	("Gerente",  180000.00),
    ("Vendedor", 120000.00),
    ("Cadete",   100000.00);

INSERT INTO empleados (Id_posicion_empleado, Id_localidad, Nombre, Apellido, Edad, DNI, Fecha_nacimiento, Direccion, Telefono) VALUES
	(2, 1, "Francisco", "Filosi", 21, "43675464", STR_TO_DATE('21-01-2001', '%d-%m-%Y'), "Santa Maria 365", "11-56459865"),
    (1, 2, "Nicolas",   "Collia", 19, "54764323", STR_TO_DATE('27-01-2003', '%d-%m-%Y'), "Santa Maria 234", "11-78768695"),
    (1, 1, "Monica",    "Collia", 32, "45684354", STR_TO_DATE('10-08-1980', '%d-%m-%Y'), "Santa Julia 675", "11-15645345");

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

