USE Sanitarios;

CREATE OR REPLACE VIEW localidades_de_provincia AS
    (SELECT 
        localidades.Id_localidad,
        provincias.Denominacion AS Nombre_provincia,
        localidades.Denominacion AS Nombre_localidad
    FROM
        localidades
            JOIN
        provincias ON (localidades.Id_provincia = provincias.Id_provincia));
    
SELECT 
    *
FROM
    localidades_de_provincia
WHERE
    Nombre_provincia = 'Buenos Aires';

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
    
SELECT 
    *
FROM
    lista_de_empleados;
    
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
    
SELECT 
    *
FROM
    productos_por_rubro;
    
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
    
SELECT 
    *
FROM
    lista_de_locales;
    
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

SELECT 
    *
FROM
    lista_de_clientes;