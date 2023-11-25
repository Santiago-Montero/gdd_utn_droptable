USE GD2C2023;
DECLARE @SchemaName NVARCHAR(128) = 'DropTable';
DECLARE @SQL NVARCHAR(MAX);

IF NOT EXISTS (
	SELECT
	1
	FROM
	sys.schemas
	WHERE
	name = @SchemaName)
	BEGIN
	SET
	@SQL = 'CREATE SCHEMA ' + QUOTENAME(@SchemaName);

	PRINT 'El esquema ' + QUOTENAME(@SchemaName) + ' ha sido creado.';

EXEC sp_executesql @SQL;
	END
	ELSE
	BEGIN
		PRINT 'El esquema ' + QUOTENAME(@SchemaName) + ' ya existía.';
	END;
--Se crea el esquema a utilizar
USE GD2C2023;



USE [GD2C2023]
SET
ANSI_NULLS ON
SET
QUOTED_IDENTIFIER ON

CREATE TABLE [DropTable].[BI_Sucursal](
[id_sucursal] [int] IDENTITY(1,
1) PRIMARY KEY,
[nombre] VARCHAR(100) NOT NULL,
[codigo] VARCHAR(100) NOT NULL
)

CREATE TABLE [DropTable].[BI_Rango_etario](
[rango_id] [int] IDENTITY(1,
1) PRIMARY KEY,
[edad_minima] [int] NOT NULL,
[edad_maxima] [int] NOT NULL,
)

CREATE TABLE [DropTable].[BI_Rango_m2](
[rango_m2] [int] IDENTITY(1,
1) PRIMARY KEY,
[metros_minimos] [int] NOT NULL,
[metros_maximos] [int] NOT NULL,
)


CREATE TABLE [DropTable].[BI_Moneda](
[id_moneda] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[nombre] [varchar](100) NOT NULL,
)

CREATE TABLE [DropTable].[BI_Tipo_Operacion](
[id_tipo_operacion] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[nombre] [varchar](100) NOT NULL,
)

CREATE TABLE [DropTable].[BI_Tipo_inmueble](
[id_tipo_inmueble] [int] IDENTITY(1,
1) primary key,
[nombre] VARCHAR(100) NOT NULL
)

CREATE TABLE [DropTable].[BI_Tiempo](
[id_tiempo] [int] IDENTITY(1,
1) primary key,
[anio] date NOT NULL,
[cuatrimestre] date not null,
[mes] date not null

)
CREATE TABLE [DropTable].[BI_Ambiente](
[id_ambiente] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
[cantidad] [varchar](100) NOT NULL,
)

create table [DropTable].[BI_Ubicacion](
    [id_Ubicacion] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [provincia] varchar(255) not null,
    [localidad] varchar(255) not null,
    [barrio] varchar(255) not null
)
CREATE TABLE BI_Ambiente (
    id_ambientes INT PRIMARY KEY,
    cantidad VARCHAR(100)
);



INSERT INTO DropTable.BI_Rango_etario([edad_minima], [edad_maxima]) values (0,25)
INSERT INTO DropTable.BI_Rango_etario([edad_minima], [edad_maxima]) values (26,35)
INSERT INTO DropTable.BI_Rango_etario([edad_minima], [edad_maxima]) values (36,50)
INSERT INTO DropTable.BI_Rango_etario([edad_minima], [edad_maxima]) values (51,null)


INSERT INTO DropTable.BI_Rango_m2([metros_minimos], [metros_maximos]) values (0,35)
INSERT INTO DropTable.BI_Rango_m2([metros_minimos], [metros_maximos]) values (36,55)
INSERT INTO DropTable.BI_Rango_m2([metros_minimos], [metros_maximos]) values (56,75)
INSERT INTO DropTable.BI_Rango_m2([metros_minimos], [metros_maximos]) values (76,100)
INSERT INTO DropTable.BI_Rango_m2([metros_minimos], [metros_maximos]) values (101,null)

INSERT
	INTO
	[DropTable].[BI_Moneda] (nombre)
select
	DISTINCT(nombre)
from
	[DropTable].[moneda] 
where
	nombre is not null


 Insert
	into [DropTable].[BI_Tipo_Operacion] (nombre)
	select distinct (nombre)
	from [DropTable].[Tipo_Operacion]  
	where nombre is not null


	Insert into [DropTable].[BI_Tipo_Inmueble] (nombre)
	select distinct (nombre)
	from [DropTable].[Tipo_Inmueble]
	where nombre is not null


INSERT INTO DropTable.BI_Ambiente (cantidad)
SELECT DISTINCT i.ambientes FROM DropTable.Inmueble i


INSERT INTO DropTable.BI_Ubicacion (provincia, localidad, barrio)
SELECT p.nombre, l.nombre, b.nombre  FROM DropTable.Barrio b
INNER JOIN DropTable.Localidad l ON l.id_localidad  = b.id_localidad  
INNER JOIN DropTable.Provincia p ON p.id_provincia  = l.id_provincia  



insert into DropTable.BI_Sucursal (nombre,codigo)
SELECT s.nombre,s.codigo FROM DropTable.Sucursal s


CREATE TABLE [DropTable].[BI_Hecho_Anuncio]( 
    [id_ambiente] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Ambiente]([id_ambiente]),
    [id_tipo_operacion] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Tipo_Operacion]([id_tipo_operacion]),
    [id_tipo_inmueble] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Tipo_inmueble]([id_tipo_inmueble]),
    [id_rango_m2] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Rango_m2]([rango_m2]),
    [id_moneda] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Moneda]([id_moneda]),
    [id_sucursal] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Sucursal]([id_sucursal]),
    [id_rango_etario] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Rango_etario]([rango_id]),
    [fecha_publicacion] [date] NOT NULL,
    [fecha_finalizacion] [date],
    [precio_anuncio] [int] NOT NULL,
    [id_ubicacion] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Ubicacion]([id_Ubicacion])
);
CREATE TABLE [DropTable].[BI_Hecho_Venta](    
    [id_ambiente] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Ambiente]([id_ambiente]),
    [id_tipo_operacion] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Tipo_Operacion]([id_tipo_operacion]),
    [id_tipo_inmueble] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Tipo_inmueble]([id_tipo_inmueble]),
    [id_rango_m2] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Rango_m2]([rango_m2]),
    [id_moneda] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Moneda]([id_moneda]),
    [id_sucursal] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Sucursal]([id_sucursal]),
    [id_rango_etario] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Rango_etario]([rango_id]),
    [fecha_venta] [date] NOT NULL,
    [precio] [int] NOT NULL,
    [comision_inmobiliaria] [int] NOT NULL
);


CREATE TABLE [DropTable].[BI_Hecho_Alquiler](
    [id_tipo_operacion] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Tipo_Operacion]([id_tipo_operacion]),
    [id_tipo_inmueble] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Tipo_inmueble]([id_tipo_inmueble]),
    [id_rango_m2] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Rango_m2]([rango_m2]),
    [id_moneda] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Moneda]([id_moneda]),
    [deposito] [int] NOT NULL,
    [id_rango_etario] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Rango_etario]([rango_id]),
    [fecha_inicio] [date] NOT NULL,
    [fecha_fin] [date] NOT NULL,
    [comision] [int] NOT NULL
);



CREATE FUNCTION [DROP_TABLE].CalculoEdad(@fecha_nacimiento date)
RETURNS int
AS
BEGIN
    RETURN DATEDIFF(year,@fecha_nacimiento, GETDATE())
END; 



 INSERT INTO [DROP_TABLE].[Hecho_Anuncio] (
    [id_ambiente],
    [id_tipo_operacion],
    [id_tipo_inmueble],
    [id_rango_m2],
    [id_moneda],
    [id_sucursal],
    [fecha_publicacion],
    [fecha_finalizacion],
    [precio_anuncio],
    [id_ubicacion]
) SELECT bia.id_ambiente, biTI.id_tipo_inmueble , biS.id_sucursal, biTope.id_tipo_operacion, bim2.rango_m2, a.fecha_publicacion, a.fecha_Finalizacion, biu.id_Ubicacion, a.precio_anuncio , biMo.id_moneda, biRE.rango_id  FROM [DROP_TABLE].[Anuncio] a
INNER JOIN [DROP_TABLE].[Tipo_Operacion] tope ON tope.id_tipo_operacion = a.id_tipo_operacion 
INNER JOIN [DROP_TABLE].[BI_Tipo_Operacion] biTope ON biTope.nombre = tope.nombre 
INNER JOIN [DROP_TABLE].[Agente] ag ON ag.id_agente = a.id_agente 
INNER JOIN [DROP_TABLE].[Persona] pe ON ag.id_persona  = pe.id_persona  
INNER JOIN [DROP_TABLE].[Sucursal] s ON s.id_sucursal = ag.id_sucursal 
INNER JOIN [DROP_TABLE].[Inmueble] i ON i.id_inmueble = a.id_inmueble 
INNER JOIN [DROP_TABLE].[Barrio] b ON b.id_barrio = i.id_barrio 
INNER JOIN [DROP_TABLE].[Localidad] l ON l.id_localidad  = b.id_localidad 
INNER JOIN [DROP_TABLE].[Provincia] p ON p.id_provincia  = l.id_provincia  
INNER JOIN [DROP_TABLE].[BI_Ambiente] biA ON biA.cantidad = i.ambientes
INNER JOIN [DROP_TABLE].[Tipo_inmueble] ti ON ti.id_tipo_inmueble  = i.id_tipo_inmueble 
INNER JOIN [DROP_TABLE].[BI_Tipo_inmueble] biTI ON biTI.nombre = ti.nombre
INNER JOIN [DROP_TABLE].[BI_Sucursal] biS ON biS.nombre = s.nombre 
INNER JOIN [DROP_TABLE].[BI_Rango_m2] bim2 ON  i.superficie BETWEEN  bim2.metros_minimos AND bim2.metros_maximos 
INNER JOIN [DROP_TABLE].[BI_Ubicacion] biU ON biU.provincia = p.nombre AND biu.localidad = l.nombre AND biU.barrio = b.nombre 
INNER JOIN [DROP_TABLE].[Moneda] mo ON mo.id_moneda = a.id_moneda 
INNER JOIN [DROP_TABLE].[BI_Moneda] biMo ON mo.nombre  = biMo.nombre 
INNER JOIN [DROP_TABLE].[BI_Rango_etario] biRE ON [DROP_TABLE].CalculoEdad(pe.fecha_nacimiento) BETWEEN biRE.edad_minima  AND biRE.edad_maxima 
GROUP BY bia.id_ambiente, biTI.id_tipo_inmueble,  biS.id_sucursal,biTope.id_tipo_operacion,  bim2.rango_m2 , biu.id_Ubicacion, a.fecha_publicacion, a.fecha_Finalizacion, biMo.id_moneda ,a.precio_anuncio , biRE.rango_id 

