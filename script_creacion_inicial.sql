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

USE GD2C2023;

SELECT
	name
FROM
	sys.schemas;

USE [GD2C2023]
SET
ANSI_NULLS ON
SET
QUOTED_IDENTIFIER ON

CREATE TABLE [DropTable].[Disposicion](
[id_disposicion] [int] IDENTITY(1,
1) primary key,
[nombre] VARCHAR(100) NOT NULL,
)
CREATE TABLE [DropTable].[Orientacion](
[id_orientacion] [int] IDENTITY(1,
1) primary key,
[nombre] VARCHAR(100) NOT NULL
)
CREATE TABLE [DropTable].[Tipo_inmueble](
[id_tipo_inmueble] [int] IDENTITY(1,
1) primary key,
[nombre] VARCHAR(100) NOT NULL
)
CREATE TABLE [DropTable].[Inmueble_estado](
[id_inmueble_estado] [int] IDENTITY(1,
1) primary key,
[nombre] VARCHAR(100) NOT NULL
)

CREATE TABLE [DropTable].[Estado_anuncio](
[id_estado_anuncio] [int] IDENTITY(1,
1) primary key,
[nombre] VARCHAR(100) NOT NULL
)

CREATE TABLE [DropTable].[Provincia](
[id_provincia] [int] IDENTITY(1,
1) PRIMARY KEY,
[nombre] VARCHAR(100) NOT NULL,
);

CREATE TABLE [DropTable].[Localidad](
[id_localidad] [int] IDENTITY(1,
1) PRIMARY KEY,
[nombre] VARCHAR(100) NOT NULL,
[id_provincia] [int],
CONSTRAINT fk_localidad_provincia FOREIGN KEY ([id_provincia]) REFERENCES [DropTable].[Provincia]([id_provincia])

);
CREATE TABLE [DropTable].[Barrio](
[id_barrio] [int] IDENTITY(1,
1) PRIMARY KEY,
[nombre] VARCHAR(100) NOT NULL,
[id_localidad] [int],
CONSTRAINT fk_barrio_localidad FOREIGN KEY ([id_localidad]) REFERENCES [DropTable].[Localidad]([id_localidad])
);



CREATE TABLE [DropTable].[Inmueble](
[id_inmueble] [int] IDENTITY(1,
1) PRIMARY KEY,
[nombre] VARCHAR(100) NOT NULL,
[descripcion] VARCHAR(100),
[direccion] VARCHAR(100) NOT NULL,
[expensas] int,
[codigo] int,
[ambientes] nvarchar(100),
[superficie] int,
[antiguedad] int,
[id_disposicion] [int],
CONSTRAINT fk_disposicion FOREIGN KEY ([id_disposicion]) REFERENCES [DropTable].[Disposicion]([id_disposicion]),
[id_orientacion] [int],
CONSTRAINT fk_orientacion FOREIGN KEY ([id_orientacion]) REFERENCES [DropTable].[Orientacion]([id_orientacion]),
[id_tipo_inmueble] [int],
CONSTRAINT fk_tipo_inmueble FOREIGN KEY ([id_tipo_inmueble]) REFERENCES [DropTable].[Tipo_inmueble]([id_tipo_inmueble]),
[id_inmueble_estado] [int],
CONSTRAINT fk_inmueble_estado FOREIGN KEY ([id_inmueble_estado]) REFERENCES [DropTable].[Inmueble_estado]([id_inmueble_estado]),
[id_barrio] [int],
CONSTRAINT fk_barrio FOREIGN KEY ([id_barrio]) REFERENCES [DropTable].[Barrio]([id_barrio]),
)
CREATE TABLE [DropTable].[Caracteristicas](
[id_caracteristicas] [int] IDENTITY(1,
1) primary key,
[caracteristica] VARCHAR(100) NOT NULL
)
CREATE TABLE [DropTable].[Caracteristicas_por_inmueble](
[id_caracteristicas_por_inmueble] [int] IDENTITY(1,
1) primary key,
[id_inmueble] [int],
CONSTRAINT fk_inmueble FOREIGN KEY ([id_inmueble]) REFERENCES [DropTable].[Inmueble]([id_inmueble]),
[id_caracteristicas] [int],
CONSTRAINT fk_caracteristicas FOREIGN KEY ([id_caracteristicas]) REFERENCES [DropTable].[Caracteristicas]([id_caracteristicas])
)



CREATE TABLE [DropTable].[Sucursal](
[id_sucursal] [int] IDENTITY(1,
1) PRIMARY KEY,
[nombre] VARCHAR(100) NOT NULL,
[codigo] VARCHAR(100) NOT NULL,
[telefono] int,
[direccion] VARCHAR(100) NOT NULL
);

CREATE TABLE [DropTable].[Moneda](
[id_moneda] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[nombre] [varchar](100) NOT NULL,
)

CREATE TABLE [DropTable].[Tipo_Operacion](
[id_tipo_operacion] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[nombre] [varchar](100) NOT NULL,
)




CREATE TABLE [DropTable].[Persona](
[id_persona] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[nombre] [varchar](100) NOT NULL,
[apellido] [varchar](100) NOT NULL,
[dni] int not null,
[telefono] [int] ,
[mail] [varchar](255) NOT NULL,
[fecha_alta] [date] ,
[fecha_nacimiento] [date]
)

CREATE TABLE [DropTable].[Agente](
[id_agente] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[id_persona] [int] ,
CONSTRAINT fk_agente_persona FOREIGN KEY ([id_persona]) REFERENCES [DropTable].[Persona]([id_persona]),
[id_sucursal] [int] ,
CONSTRAINT fk_agente_sucursal FOREIGN KEY ([id_sucursal]) REFERENCES [DropTable].[Sucursal]([id_sucursal])
)

CREATE TABLE [DropTable].[Medio_Pago](
[id_medio_pago] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[nombre] [varchar](100) NOT NULL,
)

CREATE TABLE [DropTable].[Anuncio](
[id_anuncio] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[fecha_publicacion] [date] ,
[precio_anuncio] [int] ,
[codigo] VARCHAR(100) NOT NULL,
[costoPublicacion] [int] ,
[fecha_Finalizacion] [date] ,
[id_agente] [int] ,
CONSTRAINT fk_anuncio_agente FOREIGN KEY ([id_agente]) REFERENCES [DropTable].[Agente]([id_agente]),
[id_inmueble] [int] ,
CONSTRAINT fk_anuncio_inmueble FOREIGN KEY ([id_inmueble]) REFERENCES [DropTable].Inmueble([id_inmueble]),
[id_moneda] [int] ,
CONSTRAINT fk_moneda_anuncio FOREIGN KEY ([id_moneda]) REFERENCES [DropTable].[Moneda]([id_moneda]),
[id_tipo_operacion] [int] ,
CONSTRAINT fk_tipo_operacion FOREIGN KEY ([id_tipo_operacion]) REFERENCES [DropTable].[Tipo_Operacion]([id_tipo_operacion]),
[id_estado_anuncio] [int] ,
CONSTRAINT fk_estado_anuncio FOREIGN KEY ([id_estado_anuncio]) REFERENCES [DropTable].[Estado_Anuncio]([id_estado_anuncio])
)
CREATE TABLE [DropTable].[Alquiler_Estado](
[id_estado_alquiler] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[nombre] [varchar](100) NOT NULL,
);

CREATE TABLE [DropTable].[Alquiler](
[id_alquiler] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[fecha_inicio] [date] ,
[fecha_fin] [date] ,
[deposito] [int] ,
[comision] [int] ,
[gastos] [int] ,
[codigo] [int] ,
[id_anuncio] [int] ,
CONSTRAINT fk_alquiler_anuncio FOREIGN KEY ([id_anuncio]) REFERENCES [DropTable].Anuncio([id_anuncio]),
[id_estado_alquiler] [int] ,
CONSTRAINT fk_estado_alquiler FOREIGN KEY ([id_estado_alquiler]) REFERENCES [DropTable].[Alquiler_Estado]([id_estado_alquiler])
);

CREATE TABLE [DropTable].[Detalle_Importe_Alquiler](
[id_detalle_alquiler] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[numero_inicio_periodo] [int] ,
[numero_fin_periodo] [int] ,
[importe] [int] NOT NULL ,
[id_alquiler] [int] ,
CONSTRAINT fk_alquiler_detalle_importe_alquiler FOREIGN KEY ([id_alquiler]) REFERENCES [DropTable].[Alquiler]([id_alquiler])
)

CREATE TABLE [DropTable].[Inquilino](
[id_inquilino] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[id_persona] [int] ,
CONSTRAINT fk_persona_inquilino FOREIGN KEY ([id_persona]) REFERENCES [DropTable].[Persona]([id_persona]),
[id_alquiler] [int] ,
CONSTRAINT fk_alquiler_inquilino FOREIGN KEY ([id_alquiler]) REFERENCES [DropTable].[Alquiler]([id_alquiler])
)




CREATE TABLE [DropTable].[Pago_Alquiler](
[id_pago_alquiler] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[fecha_pago_alquiler] [date] NOT NULL ,
[fecha_inicio_periodo] [date] ,
[fecha_fin_periodo] [date] ,
[codigo] [int] ,
[descripcion] [varchar](100) NOT NULL,
[nro_periodo] [int] ,
[importe] [int] NOT NULL ,
[id_alquiler] [int] ,
CONSTRAINT fk_alquiler_pago_alquiler FOREIGN KEY ([id_alquiler]) REFERENCES [DropTable].[Alquiler]([id_alquiler]),
[id_medio_pago] [int] ,
CONSTRAINT fk_medio_pago_alquiler FOREIGN KEY ([id_medio_pago]) REFERENCES [DropTable].[Medio_Pago]([id_medio_pago])
)




CREATE TABLE [DropTable].[Propietario](
[id_propietario] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[id_persona] [int] NULL,
CONSTRAINT fk_propietario_persona FOREIGN KEY ([id_persona]) REFERENCES [DropTable].[Persona]([id_persona]),
[id_inmueble] [int] NULL,
CONSTRAINT fk_propietario_inmueble FOREIGN KEY ([id_inmueble]) REFERENCES [DropTable].[Inmueble]([id_inmueble])
)

CREATE TABLE [DropTable].[Venta](
[id_venta] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[fecha_venta] [date] ,
[precio_venta] [int] ,
[comision_inmobiliaria] [int] ,
[codigo] [int] ,
[id_moneda] [int],
CONSTRAINT fk_moneda_venta FOREIGN KEY ([id_moneda]) REFERENCES [DropTable].Moneda([id_moneda]),
[id_anuncio] [int] ,
CONSTRAINT fk_anuncio_venta FOREIGN KEY ([id_anuncio]) REFERENCES [DropTable].Anuncio([id_anuncio])
)

CREATE TABLE [DropTable].[Comprador](
[id_comprador] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[id_persona] [int] NULL,
CONSTRAINT fk_comprador_persona FOREIGN KEY ([id_persona]) REFERENCES [DropTable].[Persona]([id_persona]),
[id_venta] [int] NULL,
CONSTRAINT fk_venta_inmueble FOREIGN KEY ([id_venta]) REFERENCES [DropTable].[Venta]([id_venta])
)

CREATE TABLE [DropTable].[Pago_Venta](
[id_pago_venta] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[importe] [int] NOT NULL ,
[cotizacion] [int] NOT NULL ,
[id_medio_pago] [int] ,
CONSTRAINT fk_medio_pago_venta FOREIGN KEY ([id_medio_pago]) REFERENCES [DropTable].[Medio_Pago]([id_medio_pago]),
[id_moneda] [int] ,
CONSTRAINT fk_moneda_pago_venta FOREIGN KEY ([id_moneda]) REFERENCES [DropTable].[Moneda]([id_moneda]),
[id_venta] [int] ,
CONSTRAINT fk_venta_pago_venta FOREIGN KEY ([id_venta]) REFERENCES [DropTable].[Venta]([id_venta])
)



INSERT
	INTO
	[DropTable].[Tipo_inmueble] (nombre)
select
	DISTINCT(INMUEBLE_TIPO_INMUEBLE)
from
	gd_esquema.Maestra
where
	INMUEBLE_TIPO_INMUEBLE is not null


INSERT
	INTO
	[DropTable].[Inmueble_estado] (nombre)
select
	DISTINCT(INMUEBLE_ESTADO)
from
	gd_esquema.Maestra
where
	INMUEBLE_ESTADO is not null

INSERT
	INTO
	[DropTable].[Tipo_Operacion] (nombre)
select
	DISTINCT(ANUNCIO_TIPO_OPERACION)
from
	gd_esquema.Maestra
where
	ANUNCIO_TIPO_OPERACION is not null

INSERT
	INTO
	[DropTable].[Medio_Pago] (nombre)
SELECT
	DISTINCT medio_pago
FROM
	(
	SELECT
		PAGO_ALQUILER_MEDIO_PAGO AS medio_pago
	FROM
		gd_esquema.Maestra
	WHERE
		PAGO_ALQUILER_MEDIO_PAGO IS NOT NULL
UNION ALL
	SELECT
		PAGO_VENTA_MEDIO_PAGO AS medio_pago
	FROM
		gd_esquema.Maestra
	WHERE
		PAGO_VENTA_MEDIO_PAGO IS NOT NULL
) AS MediosPago;

INSERT
	INTO
	[DropTable].[Orientacion] (nombre)
select
	DISTINCT(INMUEBLE_ORIENTACION)
from
	gd_esquema.Maestra
where
	INMUEBLE_ORIENTACION is not null

INSERT
	INTO
	[DropTable].[Moneda] (nombre)
SELECT
	DISTINCT moneda
FROM
	(
	SELECT
		ANUNCIO_MONEDA AS moneda
	FROM
		gd_esquema.Maestra
	WHERE
		ANUNCIO_MONEDA IS NOT NULL
UNION ALL
	SELECT
		VENTA_MONEDA AS moneda
	FROM
		gd_esquema.Maestra
	WHERE
		VENTA_MONEDA IS NOT NULL
UNION ALL
	SELECT
		PAGO_VENTA_MONEDA AS moneda
	FROM
		gd_esquema.Maestra
	WHERE
		PAGO_VENTA_MONEDA IS NOT NULL
) AS Monedas;


INSERT
	INTO
	[DropTable].[Provincia] (nombre) (
	select
		DISTINCT(INMUEBLE_PROVINCIA)
		--localidad.id_localidad
	from
		gd_esquema.Maestra maestra
	-- inner join [DropTable].[Localidad] localidad on
	--	maestra.INMUEBLE_LOCALIDAD = localidad.nombre
	where
		INMUEBLE_PROVINCIA is not null
union
	select
		DISTINCT(SUCURSAL_PROVINCIA)
		--localidad.id_localidad
	from
		gd_esquema.Maestra maestra
	--inner join [DropTable].[Localidad] localidad on
	--	maestra.INMUEBLE_LOCALIDAD = localidad.nombre
	where
		SUCURSAL_PROVINCIA is not null)
		
		
		INSERT
	INTO
	[DropTable].[Localidad] (nombre,
	id_provincia)
SELECT
	DISTINCT localidad,
	id_provincia 
FROM
	(
	SELECT
		INMUEBLE_LOCALIDAD AS localidad,
		provincia.id_provincia 
	FROM
		gd_esquema.Maestra maestra
	INNER JOIN [DropTable].[Provincia] provincia ON
		maestra.INMUEBLE_PROVINCIA  = provincia.nombre
	WHERE
		INMUEBLE_LOCALIDAD IS NOT NULL
UNION ALL
	SELECT
		SUCURSAL_LOCALIDAD AS localidad,
		provincia.id_provincia 
	FROM
		gd_esquema.Maestra maestra
	INNER JOIN [DropTable].[Provincia] provincia ON
		maestra.SUCURSAL_PROVINCIA = provincia.nombre
	WHERE
		SUCURSAL_LOCALIDAD IS NOT NULL
) AS Localidades;

INSERT
	INTO
	[DropTable].[Barrio] (nombre, id_localidad)
SELECT
	DISTINCT barrio,
	id_localidad  
FROM
	(
	SELECT
		INMUEBLE_BARRIO AS barrio,
		localidad.id_localidad 
	FROM
		gd_esquema.Maestra maestra
	INNER JOIN [DropTable].[Localidad] localidad ON
		maestra.INMUEBLE_LOCALIDAD   = localidad.nombre
	WHERE
		INMUEBLE_BARRIO IS NOT NULL
) AS Barrios;



INSERT
	INTO
	[DropTable].[Sucursal] (codigo,
	direccion,
	nombre,
	telefono)
select
	DISTINCT 
	SUCURSAL_CODIGO,
	SUCURSAL_DIRECCION,
	SUCURSAL_NOMBRE,
	SUCURSAL_TELEFONO
	--barrio.id_barrio
from
	gd_esquema.Maestra maestra
inner join [DropTable].[Provincia] provincia on
	maestra.SUCURSAL_PROVINCIA = provincia.nombre
inner join [DropTable].[Localidad] localidad on
	maestra.SUCURSAL_LOCALIDAD = localidad.nombre
--inner join [DropTable].[Barrio] barrio on
	--barrio.id_localidad = localidad.id_localidad 
where
	SUCURSAL_CODIGO is not null
	


INSERT
	INTO
	[DropTable].[Disposicion] (nombre)
select
	DISTINCT(INMUEBLE_DISPOSICION)
from
	gd_esquema.Maestra
where
	INMUEBLE_DISPOSICION is not null


INSERT
	INTO
	[DropTable].[Persona] (dni,
	nombre,
	telefono,
	mail,
	fecha_nacimiento,
	fecha_alta,
	apellido)
SELECT
	DISTINCT dni,
	nombre,
	telefono,
	mail,
	fecha_registro,
	fecha_nac,
	apellido
FROM
	(
	SELECT
		PROPIETARIO_DNI AS dni,
		PROPIETARIO_NOMBRE AS nombre,
		PROPIETARIO_TELEFONO AS telefono,
		PROPIETARIO_MAIL AS mail,
		PROPIETARIO_FECHA_REGISTRO AS fecha_registro,
		PROPIETARIO_FECHA_NAC AS fecha_nac,
		PROPIETARIO_APELLIDO AS apellido
	FROM
		gd_esquema.Maestra
	WHERE
		PROPIETARIO_DNI IS NOT NULL
UNION
	SELECT
		AGENTE_DNI AS dni,
		AGENTE_NOMBRE AS nombre,
		AGENTE_TELEFONO AS telefono,
		AGENTE_MAIL AS mail,
		AGENTE_FECHA_REGISTRO AS fecha_registro,
		AGENTE_FECHA_NAC AS fecha_nac,
		AGENTE_APELLIDO AS apellido
	FROM
		gd_esquema.Maestra
	WHERE
		AGENTE_DNI IS NOT NULL
UNION
	SELECT
		COMPRADOR_DNI AS dni,
		COMPRADOR_NOMBRE AS nombre,
		COMPRADOR_TELEFONO AS telefono,
		COMPRADOR_MAIL AS mail,
		COMPRADOR_FECHA_REGISTRO AS fecha_registro,
		COMPRADOR_FECHA_NAC AS fecha_nac,
		COMPRADOR_APELLIDO AS apellido
	FROM
		gd_esquema.Maestra
	WHERE
		COMPRADOR_DNI IS NOT NULL
UNION
	SELECT
		INQUILINO_DNI AS dni,
		INQUILINO_NOMBRE AS nombre,
		INQUILINO_TELEFONO AS telefono,
		INQUILINO_MAIL AS mail,
		INQUILINO_FECHA_REGISTRO AS fecha_registro,
		INQUILINO_FECHA_NAC AS fecha_nac,
		INQUILINO_APELLIDO AS apellido
	FROM
		gd_esquema.Maestra
	WHERE
		INQUILINO_DNI IS NOT NULL) As PERSONAS





INSERT INTO [DropTable].[Inmueble] (codigo, nombre, descripcion, direccion, superficie, antiguedad, expensas, ambientes, id_inmueble_estado, id_tipo_inmueble, id_disposicion, id_orientacion, id_barrio)
SELECT DISTINCT 
INMUEBLE_CODIGO, 
INMUEBLE_NOMBRE,
INMUEBLE_DESCRIPCION,
INMUEBLE_DIRECCION, 
INMUEBLE_SUPERFICIETOTAL,
INMUEBLE_ANTIGUEDAD, 
INMUEBLE_EXPESAS, 
INMUEBLE_CANT_AMBIENTES,
ie.id_inmueble_estado, ti.id_tipo_inmueble, d.id_disposicion, o.id_orientacion,
b.id_barrio
FROM gd_esquema.Maestra
INNER JOIN [DropTable].[Inmueble_estado] ie ON ie.nombre = INMUEBLE_ESTADO
INNER JOIN [DropTable].[Tipo_inmueble] ti ON ti.nombre = INMUEBLE_TIPO_INMUEBLE
INNER JOIN [DropTable].[Disposicion] d ON d.nombre = INMUEBLE_DISPOSICION
INNER JOIN [DropTable].[Orientacion] o ON o.nombre = INMUEBLE_ORIENTACION
INNER JOIN [DropTable].[Barrio] b ON b.nombre = INMUEBLE_BARRIO
INNER JOIN [DropTable].[Localidad]  l ON l.nombre  = INMUEBLE_LOCALIDAD and b.id_localidad = l.id_localidad 
INNER JOIN [DropTable].[Provincia] p ON p.nombre  = INMUEBLE_PROVINCIA and p.id_provincia  = l.id_provincia  




INSERT INTO [DropTable].[Caracteristicas] (caracteristica) VALUES
('Wifi'),
('Cable'),
('Calefacción'),
('Gas')



INSERT INTO [DropTable].[Caracteristicas_por_inmueble] (id_inmueble, id_caracteristicas)
SELECT inmueble.id_inmueble, c.id_caracteristicas
FROM gd_esquema.Maestra m
INNER JOIN [DropTable].[Inmueble] inmueble ON m.INMUEBLE_CODIGO = inmueble.codigo
LEFT JOIN [DropTable].[Caracteristicas] c ON
    (m.INMUEBLE_CARACTERISTICA_WIFI = 1 AND c.caracteristica = 'Wifi') OR
    (m.INMUEBLE_CARACTERISTICA_CABLE = 1 AND c.caracteristica = 'Cable') OR
    (m.INMUEBLE_CARACTERISTICA_CALEFACCION = 1 AND c.caracteristica = 'Calefacción') OR
    (m.INMUEBLE_CARACTERISTICA_GAS = 1 AND c.caracteristica = 'Gas')
WHERE
    m.INMUEBLE_CODIGO IS NOT NULL
    AND (m.INMUEBLE_CARACTERISTICA_WIFI = 1 OR m.INMUEBLE_CARACTERISTICA_CABLE = 1 OR m.INMUEBLE_CARACTERISTICA_CALEFACCION = 1 OR m.INMUEBLE_CARACTERISTICA_GAS = 1)

INSERT
	INTO
	[DropTable].[Alquiler_Estado] (nombre)
select
	DISTINCT(ALQUILER_ESTADO)
from
	gd_esquema.Maestra
where
	ALQUILER_ESTADO is not null
	
	INSERT
	INTO
	[DropTable].[Estado_anuncio] (nombre)
select
	DISTINCT(ANUNCIO_ESTADO)
from
	gd_esquema.Maestra
where
	 ANUNCIO_ESTADO is not null
	 
	 INSERT INTO [DropTable].[Agente] (id_persona , id_sucursal)
SELECT DISTINCT p.id_persona , S.id_sucursal
FROM gd_esquema.Maestra m 
INNER JOIN [DropTable].[Persona] p ON p.dni = m.AGENTE_DNI 
INNER JOIN [DropTable].[Sucursal] s ON s.codigo  = m.SUCURSAL_CODIGO 
WHERE m.SUCURSAL_CODIGO IS NOT NULL and m.AGENTE_DNI IS NOT NULL

INSERT INTO [DropTable].[Propietario] (id_persona , id_inmueble)
SELECT DISTINCT p.id_persona , i.id_inmueble 
FROM gd_esquema.Maestra m 
INNER JOIN [DropTable].[Persona] p ON p.dni = m.PROPIETARIO_DNI  
INNER JOIN [DropTable].[Inmueble] i ON i.codigo  = m.INMUEBLE_CODIGO  
WHERE m.PROPIETARIO_DNI IS NOT NULL and m.INMUEBLE_CODIGO IS NOT NULL



INSERT INTO [DropTable].[Anuncio] (
codigo,
fecha_publicacion,
precio_anuncio,
costoPublicacion,
fecha_Finalizacion,
id_agente,
id_inmueble,
id_moneda,
id_tipo_operacion,
id_estado_anuncio)
SELECT DISTINCT 
m.ANUNCIO_CODIGO ,
m.ANUNCIO_FECHA_PUBLICACION, m.ANUNCIO_PRECIO_PUBLICADO, m.ANUNCIO_COSTO_ANUNCIO,
m.ANUNCIO_FECHA_FINALIZACION, a.id_agente, i.id_inmueble, mo.id_moneda, to2.id_tipo_operacion, ea.id_estado_anuncio
FROM gd_esquema.Maestra m 
INNER JOIN [DropTable].[Persona] p on p.dni  = m.AGENTE_DNI 
INNER JOIN [DropTable].[Agente] a on a.id_persona  = p.id_persona 
INNER JOIN [DropTable].[Inmueble] i on i.codigo  = m.INMUEBLE_CODIGO
INNER JOIN [DropTable].[Moneda] mo on mo.nombre  = m.ANUNCIO_MONEDA 
INNER JOIN [DropTable].[Tipo_Operacion] to2 on to2.nombre  = m.ANUNCIO_TIPO_OPERACION 
INNER JOIN [DropTable].[Estado_anuncio] ea on ea.nombre  = m.ANUNCIO_ESTADO 
WHERE m.ANUNCIO_CODIGO  IS NOT NULL and m.AGENTE_DNI is not null and m.INMUEBLE_CODIGO is not NULL
and  m.ANUNCIO_MONEDA  IS NOT NULL
and m.ANUNCIO_TIPO_OPERACION  IS NOT NULL
and  m.ANUNCIO_ESTADO  IS NOT NULL



INSERT INTO [DropTable].[Alquiler] (
fecha_inicio,
fecha_fin,
deposito,
comision,
gastos,
codigo,
id_anuncio,
id_estado_alquiler
)
SELECT DISTINCT m.ALQUILER_FECHA_INICIO, m.ALQUILER_FECHA_FIN, m.ALQUILER_DEPOSITO, m.ALQUILER_COMISION, m.ALQUILER_GASTOS_AVERIGUA, m.ALQUILER_CODIGO,
a.id_anuncio, ea.id_estado_alquiler
FROM gd_esquema.Maestra m
INNER JOIN [DropTable].[Anuncio] a ON a.codigo  = m.ANUNCIO_CODIGO 
INNER JOIN [DropTable].[Alquiler_Estado] ea ON ea.nombre  = m.ALQUILER_ESTADO 
WHERE m.ANUNCIO_CODIGO IS NOT NULL and m.ALQUILER_ESTADO IS NOT NULL

INSERT INTO [DropTable].[Inquilino] (id_persona , id_alquiler)
SELECT DISTINCT p.id_persona , a.id_alquiler
FROM gd_esquema.Maestra m 
INNER JOIN [DropTable].[Persona] p ON p.dni = m.INQUILINO_DNI
INNER JOIN [DropTable].[Alquiler] a ON a.codigo  = m.ALQUILER_CODIGO
WHERE m.ALQUILER_CODIGO IS NOT NULL and m.INQUILINO_DNI IS NOT NULL



INSERT INTO [DropTable].[Pago_Alquiler] (
codigo,
descripcion,
fecha_pago_alquiler,
fecha_inicio_periodo,
fecha_fin_periodo,
nro_periodo,
importe,
id_alquiler,
id_medio_pago
)
SELECT DISTINCT m.PAGO_ALQUILER_CODIGO, m.PAGO_ALQUILER_DESC, m.PAGO_ALQUILER_FECHA, m.PAGO_ALQUILER_FEC_INI, m.PAGO_ALQUILER_FEC_FIN, m.PAGO_ALQUILER_NRO_PERIODO, m.PAGO_ALQUILER_IMPORTE,
a.id_alquiler, mp.id_medio_pago
FROM gd_esquema.Maestra m
INNER JOIN [DropTable].[Alquiler] a ON a.codigo  = m.ALQUILER_CODIGO  
INNER JOIN [DropTable].[Medio_Pago] mp ON mp.nombre  = m.PAGO_ALQUILER_MEDIO_PAGO  
WHERE m.ALQUILER_CODIGO IS NOT NULL and m.PAGO_ALQUILER_MEDIO_PAGO IS NOT NULL and  m.PAGO_ALQUILER_CODIGO IS NOT NULL

INSERT INTO [DropTable].[Detalle_Importe_Alquiler] (
importe,
numero_inicio_periodo,
numero_fin_periodo,
id_alquiler
)
SELECT DISTINCT m.DETALLE_ALQ_PRECIO, m.DETALLE_ALQ_NRO_PERIODO_INI, m.DETALLE_ALQ_NRO_PERIODO_FIN,
a.id_alquiler
FROM gd_esquema.Maestra m
INNER JOIN [DropTable].[Alquiler] a ON a.codigo  = m.ALQUILER_CODIGO   
WHERE m.ALQUILER_CODIGO IS NOT NULL and m.DETALLE_ALQ_PRECIO is not null


INSERT INTO [DropTable].[Venta] (
fecha_venta,
precio_venta,
comision_inmobiliaria,
codigo,
id_moneda,
id_anuncio
)
SELECT DISTINCT m.VENTA_FECHA , m.VENTA_PRECIO_VENTA , m.VENTA_COMISION , m.VENTA_CODIGO,
mo.id_moneda,
a.id_anuncio
FROM gd_esquema.Maestra m
INNER JOIN [DropTable].[Anuncio] a ON a.codigo  = m.ANUNCIO_CODIGO 
INNER JOIN [DropTable].[Moneda] mo ON mo.nombre  = m.VENTA_MONEDA  
WHERE m.ANUNCIO_CODIGO IS NOT NULL and m.VENTA_CODIGO IS NOT NULL


INSERT INTO [DropTable].[Comprador] (id_persona , id_venta)
SELECT DISTINCT p.id_persona , v.id_venta
FROM gd_esquema.Maestra m 
INNER JOIN [DropTable].[Persona] p ON p.dni = m.COMPRADOR_DNI
INNER JOIN [DropTable].[Venta] v ON v.codigo  = m.VENTA_CODIGO
WHERE m.VENTA_CODIGO IS NOT NULL and m.COMPRADOR_DNI IS NOT NULL

INSERT INTO [DropTable].[Pago_Venta] (
importe,
cotizacion,
id_medio_pago,
id_moneda,
id_venta
)
SELECT DISTINCT m.PAGO_VENTA_IMPORTE, m.PAGO_VENTA_COTIZACION,
mp.id_medio_pago , mo.id_moneda, v.id_venta
FROM gd_esquema.Maestra m
INNER JOIN [DropTable].[Moneda] mo ON mo.nombre  = m.PAGO_VENTA_MONEDA  
INNER JOIN [DropTable].[Medio_Pago] mp ON mp.nombre  = m.PAGO_VENTA_MEDIO_PAGO 
INNER JOIN [DropTable].[Venta] v ON v.codigo  = m.VENTA_CODIGO
WHERE m.VENTA_CODIGO IS NOT NULL and m.PAGO_VENTA_MEDIO_PAGO IS NOT NULL
    
