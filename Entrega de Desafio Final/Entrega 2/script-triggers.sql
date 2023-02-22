USE Sanitarios;

DROP TABLE IF EXISTS before_ventas_log;
CREATE TABLE before_ventas_log(
	id_before_ventas_log INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_registro INT,
    nombre_usuario CHAR(60),
    fecha DATE,
    hora TIME,
    operacion CHAR(20)
);

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


DROP TABLE IF EXISTS after_ventas_log;
CREATE TABLE after_ventas_log(
	id_before_ventas_log INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_registro INT,
    nombre_usuario CHAR(60),
    fecha DATE,
    hora TIME,
    operacion CHAR(20)
);

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
