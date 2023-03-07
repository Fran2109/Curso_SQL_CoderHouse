USE Sanitarios;

START TRANSACTION;

DELETE FROM ventas WHERE Id_venta = 2 OR Id_venta = 5;

SELECT * FROM ventas;

-- ROLLBACK;

-- COMMIT;

START TRANSACTION;

INSERT INTO ventas SET Id_local = 1, Id_cliente = 1, Fecha = random_date('2002-01-01', '2003-01-01'), Total = random_decimal(1000000, 1);
INSERT INTO ventas SET Id_local = 1, Id_cliente = 2, Fecha = random_date('2002-01-01', '2003-01-01'), Total = random_decimal(1000000, 1);
INSERT INTO ventas SET Id_local = 2, Id_cliente = 1, Fecha = random_date('2002-01-01', '2003-01-01'), Total = random_decimal(1000000, 1);
INSERT INTO ventas SET Id_local = 2, Id_cliente = 2, Fecha = random_date('2002-01-01', '2003-01-01'), Total = random_decimal(1000000, 1);

SAVEPOINT guardado1;

INSERT INTO ventas SET Id_local = 1, Id_cliente = 1, Fecha = random_date('2002-01-01', '2003-01-01'), Total = random_decimal(1000000, 1);
INSERT INTO ventas SET Id_local = 1, Id_cliente = 2, Fecha = random_date('2002-01-01', '2003-01-01'), Total = random_decimal(1000000, 1);
INSERT INTO ventas SET Id_local = 2, Id_cliente = 1, Fecha = random_date('2002-01-01', '2003-01-01'), Total = random_decimal(1000000, 1);
INSERT INTO ventas SET Id_local = 2, Id_cliente = 2, Fecha = random_date('2002-01-01', '2003-01-01'), Total = random_decimal(1000000, 1);

SAVEPOINT guardado2;

RELEASE SAVEPOINT guardado1;