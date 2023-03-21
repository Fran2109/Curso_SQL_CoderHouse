USE Sanitarios;

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