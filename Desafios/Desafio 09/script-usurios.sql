USE mysql;

DROP USER IF EXISTS 'lectura@localhost';
CREATE USER 'lectura@localhost' IDENTIFIED BY 'lectura-123';
GRANT SELECT ON sanitarios.* TO 'lectura@localhost';
SHOW GRANTS FOR 'lectura@localhost';

DROP USER IF EXISTS 'escriEdiLec@localhost';
CREATE USER 'escriEdiLec@localhost' IDENTIFIED BY 'escriEdiLec-123';
GRANT SELECT, INSERT, UPDATE ON sanitarios.* TO 'escriEdiLec@localhost';
SHOW GRANTS FOR 'escriEdiLec@localhost';

SELECT * FROM USER;