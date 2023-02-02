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