DROP SCHEMA IF EXISTS Sanitarios;
CREATE SCHEMA Sanitarios;
USE Sanitarios;

CREATE TABLE paises(
	Id_pais INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Denominacion VARCHAR(50) NOT NULL
);

CREATE TABLE provincias(
	Id_provincia INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Id_pais INT NOT NULL,
    Denominacion VARCHAR(50) NOT NULL,
    FOREIGN KEY (Id_pais) REFERENCES paises(Id_pais)
);

CREATE TABLE localidades(
	Id_localidad INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Id_provincia INT NOT NULL,
    Denominacion VARCHAR(50) NOT NULL,
    FOREIGN KEY (Id_provincia) REFERENCES provincias(Id_provincia)
);

CREATE TABLE clientes(
	Id_cliente INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Id_localidad INT NOT NULL,
    Denominacion VARCHAR(50) NOT NULL,
    Direccion VARCHAR(50) NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    FOREIGN KEY (Id_localidad) REFERENCES localidades(Id_localidad)
);

CREATE TABLE precios_lista(
	Id_precios_lista INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Denominacion VARCHAR(50) NOT NULL,
    Porcentaje DECIMAL(3,2) NOT NULL
);

CREATE TABLE rubros(
	Id_rubro INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Denominacion VARCHAR(50)
);

CREATE TABLE provedores (
    Id_provedor INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Id_localidad INT NOT NULL,
    Denominacion VARCHAR(50) NOT NULL,
	Nombre_empresa varchar(50) not null,
    Cuit varchar(20) not null,
    Direccion varchar(100) not null,
    Telefono varchar(15) not null,
    FOREIGN KEY (Id_localidad) REFERENCES localidades(Id_localidad)
);

