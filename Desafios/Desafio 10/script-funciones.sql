USE Sanitarios;

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
-- SELECT locales_con_mas_ventas(1312053.54) AS total;

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

-- SELECT random_decimal(1000000, 1) AS aleatorio;

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

-- SELECT random_date('2002-01-01', '2003-01-01') AS fecha;

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

-- SELECT ventas_por_dia('2002-03-21') AS ventas;