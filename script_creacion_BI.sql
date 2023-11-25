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
[id_rango_etario] [int] IDENTITY(1,
1) PRIMARY KEY,
[edad_minima] [int],
[edad_maxima] [int],
)

CREATE TABLE [DropTable].[BI_Rango_m2](
[id_rango_m2] [int] IDENTITY(1,
1) PRIMARY KEY,
[metros_minimos] [int],
[metros_maximos] [int],
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
[anio] decimal(12,2) NOT NULL,
[cuatrimestre] int not null,
[mes] int not null
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

CREATE TABLE [DropTable].[BI_Hecho_Anuncio](

    [id_ambiente] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Ambiente]([id_ambiente]),
    [id_tipo_operacion] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Tipo_Operacion]([id_tipo_operacion]),
    [id_tipo_inmueble] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Tipo_inmueble]([id_tipo_inmueble]),
    [id_rango_m2] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Rango_m2]([id_rango_m2]),
    [id_moneda] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Moneda]([id_moneda]),
    [id_sucursal] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Sucursal]([id_sucursal]),
    [id_rango_etario] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Rango_etario]([id_rango_etario]),
    [id_tiempo_publicacion] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Tiempo]([id_tiempo]),
    [id_tiempo_finalizacion] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Tiempo]([id_tiempo]),
    [precio_anuncio] [int],
    [dias_publicado] [int],
    [id_ubicacion] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Ubicacion]([id_Ubicacion])
);

CREATE TABLE [DropTable].[BI_Hecho_Venta](
   
    [id_ambiente] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Ambiente]([id_ambiente]),
    [id_tipo_operacion] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Tipo_Operacion]([id_tipo_operacion]),
    [id_tipo_inmueble] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Tipo_inmueble]([id_tipo_inmueble]),
    [id_rango_m2] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Rango_m2]([id_rango_m2]),
    [id_moneda] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Moneda]([id_moneda]),
    [id_sucursal] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Sucursal]([id_sucursal]),
   -- [id_rango_etario] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Rango_etario]([id_rango_etario]),
    [id_tiempo_venta] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Tiempo]([id_tiempo]),
    [precio] [int],
    [comision_inmobiliaria] [int]
);

CREATE TABLE [DropTable].[BI_Hecho_Alquiler](

    [id_tipo_operacion] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Tipo_Operacion]([id_tipo_operacion]),
    [id_tipo_inmueble] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Tipo_inmueble]([id_tipo_inmueble]),
    [id_rango_m2] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Rango_m2]([id_rango_m2]),
    [id_moneda] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Moneda]([id_moneda]),
    [deposito] [int],
    [id_rango_etario] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Rango_etario]([id_rango_etario]),
    [id_tiempo_inicio] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Tiempo]([id_tiempo]),
    [id_tiempo_fin] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Tiempo]([id_tiempo]),
    [comision] [int],
    [id_tiempo_pago_alquiler] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Tiempo]([id_tiempo]),
    [id_tiempo_inicio_periodo] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Tiempo]([id_tiempo]),
    [id_tiempo_fin_periodo] [int] FOREIGN KEY REFERENCES [DropTable].[BI_Tiempo]([id_tiempo])
);

-- INSERT VALUES 


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

insert into DropTable.BI_Tiempo (anio, cuatrimestre, mes)
SELECT
    Anio,
    Cuatrimestre,
    Mes
FROM
(
    SELECT
        YEAR(fecha) AS Anio,
        DATEPART(QUARTER, fecha) AS Cuatrimestre,
        MONTH(fecha) AS Mes
    FROM
    (
        SELECT fecha_publicacion AS fecha FROM DropTable.Anuncio
        UNION ALL
        SELECT fecha_Finalizacion FROM DropTable.Anuncio
         UNION ALL
        SELECT fecha_venta FROM DropTable.Venta
         UNION ALL
        SELECT fecha_inicio FROM DropTable.Alquiler
         UNION ALL
        SELECT fecha_fin FROM DropTable.Alquiler
         UNION ALL
        SELECT fecha_pago_alquiler FROM DropTable.Pago_Alquiler
         UNION ALL
        SELECT fecha_inicio_periodo FROM DropTable.Pago_Alquiler
         UNION ALL
        SELECT fecha_fin_periodo FROM DropTable.Pago_Alquiler
    ) AS fechas
) AS resultado
GROUP BY
    Anio,
    Cuatrimestre,
    Mes
ORDER BY
    Anio,
    Mes;


/*
CREATE FUNCTION [DropTable].CalculoEdad(@fecha_nacimiento date)
RETURNS int
AS
BEGIN
    RETURN DATEDIFF(year,@fecha_nacimiento, GETDATE())
END; 
*/


 INSERT INTO [DropTable].[BI_Hecho_Anuncio] (
    [id_ambiente],
    [id_tipo_inmueble],
    [id_sucursal],
    [id_tipo_operacion],
    [id_rango_m2],
    [id_tiempo_publicacion],
    [id_tiempo_finalizacion],
    [id_ubicacion],
    [precio_anuncio],
    [id_moneda],
    [id_rango_etario],
    [dias_publicado]

   
) SELECT bia.id_ambiente, biTI.id_tipo_inmueble , biS.id_sucursal, biTope.id_tipo_operacion,
bim2.id_rango_m2, biTI2.id_tiempo, biTI1.id_tiempo, biu.id_Ubicacion, a.precio_anuncio , 
biMo.id_moneda, biRE.id_rango_etario, DATEDIFF(DAY, a.fecha_publicacion,a.fecha_Finalizacion) 
FROM [DropTable].[Anuncio] a
INNER JOIN [DropTable].[Tipo_Operacion] tope ON tope.id_tipo_operacion = a.id_tipo_operacion 
INNER JOIN [DropTable].[BI_Tipo_Operacion] biTope ON biTope.nombre = tope.nombre 
INNER JOIN [DropTable].[Agente] ag ON ag.id_agente = a.id_agente 
INNER JOIN [DropTable].[Persona] pe ON ag.id_persona  = pe.id_persona  
INNER JOIN [DropTable].[Sucursal] s ON s.id_sucursal = ag.id_sucursal 
INNER JOIN [DropTable].[Inmueble] i ON i.id_inmueble = a.id_inmueble 
INNER JOIN [DropTable].[Barrio] b ON b.id_barrio = i.id_barrio 
INNER JOIN [DropTable].[Localidad] l ON l.id_localidad  = b.id_localidad 
INNER JOIN [DropTable].[Provincia] p ON p.id_provincia  = l.id_provincia  
INNER JOIN [DropTable].[BI_Ambiente] biA ON biA.cantidad = i.ambientes
INNER JOIN [DropTable].[Tipo_inmueble] ti ON ti.id_tipo_inmueble  = i.id_tipo_inmueble 
INNER JOIN [DropTable].[BI_Tipo_inmueble] biTI ON biTI.nombre = ti.nombre
INNER JOIN [DropTable].[BI_Sucursal] biS ON biS.nombre = s.nombre 
INNER JOIN [DropTable].[BI_Rango_m2] bim2 ON  i.superficie BETWEEN  bim2.metros_minimos AND bim2.metros_maximos 
INNER JOIN [DropTable].[BI_Ubicacion] biU ON biU.provincia = p.nombre AND biu.localidad = l.nombre AND biU.barrio = b.nombre 
INNER JOIN [DropTable].[Moneda] mo ON mo.id_moneda = a.id_moneda 
INNER JOIN [DropTable].[BI_Moneda] biMo ON mo.nombre  = biMo.nombre 
INNER JOIN [DropTable].[BI_Rango_etario] biRE ON DATEDIFF(year,pe.fecha_nacimiento, GETDATE()) BETWEEN biRE.edad_minima  AND biRE.edad_maxima 
INNER JOIN [DropTable].[BI_Tiempo] biTI1 ON biTI1.anio = year(a.fecha_Finalizacion)  AND biTI1.mes = month(a.fecha_Finalizacion)
INNER JOIN [DropTable].[BI_Tiempo] biTI2 ON biTI2.anio = year(a.fecha_publicacion) AND biTI2.mes = month(a.fecha_publicacion)
GROUP BY bia.id_ambiente, biTI.id_tipo_inmueble,  biS.id_sucursal,biTope.id_tipo_operacion,  bim2.id_rango_m2 , biu.id_Ubicacion,biTI2.id_tiempo , biTI1.id_tiempo , biMo.id_moneda ,a.precio_anuncio , biRE.id_rango_etario, a.fecha_publicacion,a.fecha_Finalizacion 

insert into [DropTable].[BI_Hecho_venta](
    [id_ambiente],
    [id_tipo_operacion],
    [id_tipo_inmueble],
    [id_rango_m2],
    [id_moneda],
    [id_sucursal],
   -- [id_rango_etario] ,
    [id_tiempo_venta] ,
    [precio] ,
    [comision_inmobiliaria]

) Select   bia.id_ambiente, biTope.id_Tipo_Operacion ,biTI.id_tipo_inmueble, bim2.id_rango_m2, bm.id_moneda, biS.id_sucursal ,biTI1.id_tiempo ,v.precio_venta,v.comision_inmobiliaria    from [DropTable].[Venta] v 
inner join [DropTable].[moneda] m on v.id_moneda = m.id_moneda
inner join [DropTable].[BI_Moneda] bm on m.nombre = bm.nombre --tengo modeda
inner join [DropTable].[Anuncio] a on v.id_anuncio = a.id_anuncio 
INNER JOIN [DropTable].[Tipo_Operacion] tope ON tope.id_tipo_operacion = a.id_tipo_operacion 
INNER JOIN [DropTable].[BI_Tipo_Operacion] biTope ON biTope.nombre = tope.nombre --tengo tipo operacion
INNER JOIN [DropTable].[Inmueble] i ON i.id_inmueble = a.id_inmueble --Me traigo inmueble para ir a buscar tipo inmueble despues
INNER JOIN [DropTable].[Tipo_inmueble] ti ON ti.id_tipo_inmueble  = i.id_tipo_inmueble 
INNER JOIN [DropTable].[BI_Tipo_inmueble] biTI ON biTI.nombre = ti.nombre --tengo tipo inmueble
INNER JOIN [DropTable].[BI_Rango_m2] bim2 ON  i.superficie BETWEEN  bim2.metros_minimos AND bim2.metros_maximos  --tengo m2
INNER JOIN [DropTable].[BI_Ambiente] biA ON biA.cantidad = i.ambientes --tengo ambientes
INNER JOIN [DropTable].[Agente] ag ON ag.id_agente = a.id_agente -- voy a buscar agente para sucursal
INNER JOIN [DropTable].[Sucursal] s ON s.id_sucursal = ag.id_sucursal 
INNER JOIN [DropTable].[BI_Sucursal] biS ON biS.nombre = s.nombre
INNER JOIN [DropTable].[BI_Tiempo] biTI1 ON biTI1.anio = year(v.fecha_venta)  AND biTI1.mes = month(v.fecha_venta)
group by bia.id_ambiente, biTope.id_Tipo_Operacion ,biTI.id_tipo_inmueble, bim2.id_rango_m2, bm.id_moneda, biS.id_sucursal ,biTI1.id_tiempo ,v.precio_venta,v.comision_inmobiliaria  



INSERT INTO[DropTable].[BI_Hecho_Alquiler]
(
deposito,
comision,
id_moneda,
id_rango_m2,
id_tipo_inmueble,
id_tipo_operacion,
id_rango_etario,
id_tiempo_inicio,
id_tiempo_fin,
id_tiempo_pago_alquiler,
id_tiempo_inicio_periodo,
id_tiempo_fin_periodo
)
SELECT a.deposito , a.comision , bm.id_moneda ,bim2.id_rango_m2 , biTII.id_tipo_inmueble , biTIO.id_tipo_operacion, biRE.id_rango_etario  , biTI1.id_tiempo ,  biTI2.id_tiempo, biTI3.id_tiempo ,biTI4.id_tiempo, biTI5.id_tiempo FROM [DropTable].[Alquiler] a
INNER JOIN [DropTable].[Anuncio] a2 ON a2.id_anuncio = a.id_anuncio 
INNER JOIN [DropTable].[Inmueble] i ON i.id_inmueble = a2.id_inmueble
INNER join [DropTable].[Moneda] m ON a2.id_moneda  = m.id_moneda
INNER join [DropTable].[BI_Moneda] bm ON m.nombre = bm.nombre 
INNER JOIN [DropTable].[Pago_Alquiler] pa ON pa.id_alquiler  = a.id_alquiler 
INNER JOIN [DropTable].[BI_Tiempo] biTI1 ON biTI1.anio = year(a.fecha_inicio)  AND biTI1.mes = month(a.fecha_inicio)
INNER JOIN [DropTable].[BI_Tiempo] biTI2 ON biTI2.anio = year(a.fecha_fin)  AND biTI2.mes = month(a.fecha_fin)
INNER JOIN [DropTable].[BI_Tiempo] biTI3 ON biTI3.anio = year(pa.fecha_pago_alquiler)  AND biTI3.mes = month(pa.fecha_pago_alquiler)
INNER JOIN [DropTable].[BI_Tiempo] biTI4 ON biTI4.anio = year(pa.fecha_inicio_periodo)  AND biTI4.mes = month(pa.fecha_inicio_periodo)
INNER JOIN [DropTable].[BI_Tiempo] biTI5 ON biTI5.anio = year(pa.fecha_fin_periodo)  AND biTI5.mes = month(pa.fecha_fin_periodo)
INNER JOIN [DropTable].[BI_Tipo_Inmueble] biTII ON biTII.id_tipo_inmueble = i.id_tipo_inmueble 
INNER JOIN [DropTable].[BI_Tipo_Operacion] biTIO ON biTIO.id_tipo_operacion = a2.id_tipo_operacion 
INNER JOIN [DropTable].[BI_Rango_m2] bim2 ON  i.superficie BETWEEN  bim2.metros_minimos AND bim2.metros_maximos 
INNER JOIN [DropTable].[Inquilino] inq ON inq.id_alquiler = a.id_alquiler 
INNER JOIN [DropTable].[Persona] pe ON inq.id_persona  = pe.id_persona  
INNER JOIN [DropTable].[BI_Rango_etario] biRE ON DATEDIFF(year,pe.fecha_nacimiento, GETDATE()) BETWEEN biRE.edad_minima  AND biRE.edad_maxima 
group by a.deposito , a.comision , bm.id_moneda ,bim2.id_rango_m2 , biTII.id_tipo_inmueble , biTIO.id_tipo_operacion, biRE.id_rango_etario  , biTI1.id_tiempo ,  biTI2.id_tiempo, biTI3.id_tiempo ,biTI4.id_tiempo, biTI5.id_tiempo




-- VIEWS


-- 1 

CREATE VIEW DropTable.vista1 AS
SELECT
    c.anio,
    c.cuatrimestre,
    ISNULL(AVG(a.dias_publicado),0) AS [Promedio en dias],
    a.Ambientes as [Ambientes],
    a.Barrio as [Barrio],
    a.Tipo_Operacion as [ Tipo Operacion]
FROM
    DropTable.BI_Tiempo c
LEFT JOIN
    (
        SELECT
        	bt.cuatrimestre as cuatrimestre,
        	bt2.cuatrimestre as cuatrimestre2,
        	biTo.nombre as Tipo_Operacion,
            biAm.cantidad AS Ambientes,
            biU.barrio AS Barrio,
            biA.dias_publicado
        FROM
            [DropTable].[BI_Hecho_Anuncio] biA 
            INNER JOIN [DropTable].[BI_Tiempo] bt ON bt.id_tiempo = biA.id_tiempo_publicacion
            INNER JOIN [DropTable].[BI_Tiempo] bt2 ON bt2.id_tiempo = biA.id_tiempo_finalizacion
            INNER JOIN [DropTable].[BI_Ambiente] biAm on biAm.id_ambiente  = biA.id_ambiente  
            INNER JOIN [DropTable].[BI_Ubicacion] biU on biU.id_Ubicacion = biA.id_ubicacion 
            INNER JOIN [DropTable].[BI_Tipo_Operacion] biTo on biTo.id_tipo_operacion = biA.id_tipo_operacion
            
    ) a ON c.cuatrimestre = a.cuatrimestre2 AND c.cuatrimestre = a.cuatrimestre
GROUP BY
    c.anio,
    c.cuatrimestre,
    a.Ambientes,
    a.Barrio,
    a.Tipo_Operacion;


SELECT * FROM DropTable.vista1



