USE GD2C2023; 

DECLARE @SchemaName NVARCHAR(128) = 'DROP_TABLE';
DECLARE @SQL NVARCHAR(MAX);

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = @SchemaName)
BEGIN
    SET @SQL = 'CREATE SCHEMA ' + QUOTENAME(@SchemaName);
    PRINT 'El esquema ' + QUOTENAME(@SchemaName) + ' ha sido creado.';
    EXEC sp_executesql @SQL;
END
ELSE
BEGIN
    PRINT 'El esquema ' + QUOTENAME(@SchemaName) + ' ya existía.';
END;


USE GD2C2023;

SELECT name
FROM sys.schemas;



USE [GD2C2023]
SET
ANSI_NULLS ON
SET
QUOTED_IDENTIFIER ON

CREATE TABLE [DROP_TABLE].[Disposicion](
[id_disposicion] [int] IDENTITY(1,
1) primary key,
[nombre] VARCHAR(100) NOT NULL,
)
CREATE TABLE [DROP_TABLE].[Orientacion](
[id_orientacion] [int] IDENTITY(1,
1) primary key,
[nombre] VARCHAR(100) NOT NULL
)
CREATE TABLE [DROP_TABLE].[Tipo_inmueble](
[id_tipo_inmueble] [int] IDENTITY(1,
1) primary key,
[nombre] VARCHAR(100) NOT NULL
)
CREATE TABLE [DROP_TABLE].[Inmueble_estado](
[id_inmueble_estado] [int] IDENTITY(1,
1) primary key,
[nombre] VARCHAR(100) NOT NULL
)

CREATE TABLE [DROP_TABLE].[Estado_anuncio](
[id_estado_anuncio] [int] IDENTITY(1,
1) primary key,
[nombre] VARCHAR(100) NOT NULL
)


CREATE TABLE [DROP_TABLE].[Barrio](
[id_barrio] [int] IDENTITY(1,
1) PRIMARY KEY,
[nombre] VARCHAR(100) NOT NULL
);

CREATE TABLE [DROP_TABLE].[Localidad](
[id_localidad] [int] IDENTITY(1,
1) PRIMARY KEY,
[nombre] VARCHAR(100) NOT NULL,
[id_barrio] [int],
CONSTRAINT fk_localidad_barrio FOREIGN KEY ([id_barrio]) REFERENCES [DROP_TABLE].[Barrio]([id_barrio])
);

CREATE TABLE [DROP_TABLE].[Provincia](
[id_provincia] [int] IDENTITY(1,
1) PRIMARY KEY,
[nombre] VARCHAR(100) NOT NULL,
[id_localidad] [int],
CONSTRAINT fk_provincia_localidad FOREIGN KEY ([id_localidad]) REFERENCES [DROP_TABLE].[Localidad]([id_localidad])
);

CREATE TABLE [DROP_TABLE].[Inmueble](
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
CONSTRAINT fk_disposicion FOREIGN KEY ([id_disposicion]) REFERENCES [DROP_TABLE].[Disposicion]([id_disposicion]),
[id_orientacion] [int],
CONSTRAINT fk_orientacion FOREIGN KEY ([id_orientacion]) REFERENCES [DROP_TABLE].[Orientacion]([id_orientacion]),
[id_tipo_inmueble] [int],
CONSTRAINT fk_tipo_inmueble FOREIGN KEY ([id_tipo_inmueble]) REFERENCES [DROP_TABLE].[Tipo_inmueble]([id_tipo_inmueble]),
[id_inmueble_estado] [int],
CONSTRAINT fk_inmueble_estado FOREIGN KEY ([id_inmueble_estado]) REFERENCES [DROP_TABLE].[Inmueble_estado]([id_inmueble_estado]),
[id_barrio] [int],
CONSTRAINT fk_barrio FOREIGN KEY ([id_barrio]) REFERENCES [DROP_TABLE].[Barrio]([id_barrio]),
)
CREATE TABLE [DROP_TABLE].[Caracteristicas](
[id_caracteristicas] [int] IDENTITY(1,
1) primary key,
[caracteristica] VARCHAR(100) NOT NULL
)
CREATE TABLE [DROP_TABLE].[Caracteristicas_por_inmueble](
[id_caracteristicas_por_inmueble] [int] IDENTITY(1,
1) primary key,
[id_inmueble] [int],
CONSTRAINT fk_inmueble FOREIGN KEY ([id_inmueble]) REFERENCES [DROP_TABLE].[Inmueble]([id_inmueble]),
[id_caracteristicas] [int],
CONSTRAINT fk_caracteristicas FOREIGN KEY ([id_caracteristicas]) REFERENCES [DROP_TABLE].[Caracteristicas]([id_caracteristicas])
)



CREATE TABLE [DROP_TABLE].[Sucursal](
[id_sucursal] [int] IDENTITY(1,
1) PRIMARY KEY,
[nombre] VARCHAR(100) NOT NULL,
[codigo] VARCHAR(100) NOT NULL,
[telefono] int,
[direccion] VARCHAR(100) NOT NULL,
[id_barrio] [int],
CONSTRAINT fk_sucursal_barrio FOREIGN KEY ([id_barrio]) REFERENCES [DROP_TABLE].[Barrio]([id_barrio])
);

CREATE TABLE [DROP_TABLE].[Moneda](
[id_moneda] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[nombre] [varchar](100) NOT NULL,
)

CREATE TABLE [DROP_TABLE].[Tipo_Operacion](
[id_tipo_operacion] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[nombre] [varchar](100) NOT NULL,
)




CREATE TABLE [DROP_TABLE].[Persona](
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

CREATE TABLE [DROP_TABLE].[Agente](
[id_agente] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[id_persona] [int] ,
CONSTRAINT fk_agente_persona FOREIGN KEY ([id_persona]) REFERENCES [DROP_TABLE].[Persona]([id_persona]),
[id_sucursal] [int] ,
CONSTRAINT fk_agente_sucursal FOREIGN KEY ([id_sucursal]) REFERENCES [DROP_TABLE].[Sucursal]([id_sucursal])
)

CREATE TABLE [DROP_TABLE].[Medio_Pago](
[id_medio_pago] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[nombre] [varchar](100) NOT NULL,
)

CREATE TABLE [DROP_TABLE].[Anuncio](
[id_anuncio] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[fecha_Aplicacion] [date] ,
[precio_anuncio] [int] ,
[costoPublicacion] [int] ,
[fecha_Finalizacion] [date] ,
[id_agente] [int] ,
CONSTRAINT fk_anuncio_agente FOREIGN KEY ([id_agente]) REFERENCES [DROP_TABLE].[Agente]([id_agente]),
[id_inmueble] [int] ,
CONSTRAINT fk_anuncio_inmueble FOREIGN KEY ([id_inmueble]) REFERENCES [DROP_TABLE].Inmueble([id_inmueble]),
[id_moneda] [int] ,
CONSTRAINT fk_moneda_anuncio FOREIGN KEY ([id_moneda]) REFERENCES [DROP_TABLE].[Moneda]([id_moneda]),
[id_tipo_operacion] [int] ,
CONSTRAINT fk_tipo_operacion FOREIGN KEY ([id_tipo_operacion]) REFERENCES [DROP_TABLE].[Tipo_Operacion]([id_tipo_operacion]),
[id_estado_anuncio] [int] ,
CONSTRAINT fk_estado_anuncio FOREIGN KEY ([id_estado_anuncio]) REFERENCES [DROP_TABLE].[Estado_Anuncio]([id_estado_anuncio])
)
CREATE TABLE [DROP_TABLE].[Alquiler_Estado](
[id_estado_alquiler] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[nombre] [varchar](100) NOT NULL,
);

CREATE TABLE [DROP_TABLE].[Alquiler](
[id_alquiler] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[fecha_inicio] [date] ,
[fecha_fin] [date] ,
[deposito] [int] ,
[comision] [int] ,
[gastos] [int] ,
[codigo] [int] ,
[id_anuncio] [int] ,
CONSTRAINT fk_alquiler_anuncio FOREIGN KEY ([id_anuncio]) REFERENCES [DROP_TABLE].Anuncio([id_anuncio]),
[id_estado_alquiler] [int] ,
CONSTRAINT fk_estado_alquiler FOREIGN KEY ([id_estado_alquiler]) REFERENCES [DROP_TABLE].[Alquiler_Estado]([id_estado_alquiler])
);

CREATE TABLE [DROP_TABLE].[Detalle_Importe_Alquiler](
[id_detalle_alquiler] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[fecha_pago_alquiler] [date] NOT NULL ,
[fecha_inicio_periodo] [date] ,
[fecha_fin_periodo] [date] ,
[importe] [int] NOT NULL ,
[id_alquiler] [int] ,
CONSTRAINT fk_alquiler_detalle_importe_alquiler FOREIGN KEY ([id_alquiler]) REFERENCES [DROP_TABLE].[Alquiler]([id_alquiler])
)

CREATE TABLE [DROP_TABLE].[Inquilino](
[id_inquilino] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[id_persona] [int] ,
CONSTRAINT fk_persona_inquilino FOREIGN KEY ([id_persona]) REFERENCES [DROP_TABLE].[Persona]([id_persona]),
[id_alquiler] [int] ,
CONSTRAINT fk_alquiler_inquilino FOREIGN KEY ([id_alquiler]) REFERENCES [DROP_TABLE].[Alquiler]([id_alquiler])
)




CREATE TABLE [DROP_TABLE].[Pago_Alquiler](
[id_pago_alquiler] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[fecha_pago_alquiler] [date] NOT NULL ,
[fecha_inicio_periodo] [date] ,
[fecha_fin_periodo] [date] ,
[nro_periodo] [int] ,
[cantidad_periodos] [int] ,
[importe] [int] NOT NULL ,
[id_alquiler] [int] ,
CONSTRAINT fk_alquiler_pago_alquiler FOREIGN KEY ([id_alquiler]) REFERENCES [DROP_TABLE].[Alquiler]([id_alquiler]),
[id_medio_pago] [int] ,
CONSTRAINT fk_medio_pago_alquiler FOREIGN KEY ([id_medio_pago]) REFERENCES [DROP_TABLE].[Medio_Pago]([id_medio_pago])
)




CREATE TABLE [DROP_TABLE].[Propietario](
[id_propietario] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[id_persona] [int] NULL,
CONSTRAINT fk_propietario_persona FOREIGN KEY ([id_persona]) REFERENCES [DROP_TABLE].[Persona]([id_persona]),
[id_inmueble] [int] NULL,
CONSTRAINT fk_propietario_inmueble FOREIGN KEY ([id_inmueble]) REFERENCES [DROP_TABLE].[Inmueble]([id_inmueble])
)

CREATE TABLE [DROP_TABLE].[Venta](
[id_venta] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[fecha_venta] [date] ,
[precio_venta] [int] ,
[comision_inmobiliaria] [int] ,
[codigo] [int] ,
[id_moneda] [int],
CONSTRAINT fk_moneda_venta FOREIGN KEY ([id_moneda]) REFERENCES [DROP_TABLE].Moneda([id_moneda]),
[id_anuncio] [int] ,
CONSTRAINT fk_anuncio_venta FOREIGN KEY ([id_anuncio]) REFERENCES [DROP_TABLE].Anuncio([id_anuncio])
)

CREATE TABLE [DROP_TABLE].[Comprador](
[id_comprador] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[id_persona] [int] NULL,
CONSTRAINT fk_comprador_persona FOREIGN KEY ([id_persona]) REFERENCES [DROP_TABLE].[Persona]([id_persona]),
[id_venta] [int] NULL,
CONSTRAINT fk_venta_inmueble FOREIGN KEY ([id_venta]) REFERENCES [DROP_TABLE].[Venta]([id_venta])
)

CREATE TABLE [DROP_TABLE].[Pago_Venta](
[id_pago_venta] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[fecha_pago] [date] NOT NULL ,
[importe] [int] NOT NULL ,
[cotizacion] [int] NOT NULL ,
[id_medio_pago] [int] ,
CONSTRAINT fk_medio_pago_venta FOREIGN KEY ([id_medio_pago]) REFERENCES [DROP_TABLE].[Medio_Pago]([id_medio_pago]),
[id_moneda] [int] ,
CONSTRAINT fk_moneda_pago_venta FOREIGN KEY ([id_moneda]) REFERENCES [DROP_TABLE].[Moneda]([id_moneda]),
[id_venta] [int] ,
CONSTRAINT fk_venta_pago_venta FOREIGN KEY ([id_venta]) REFERENCES [DROP_TABLE].[Venta]([id_venta]),
[id_persona] [int],
CONSTRAINT fk_persona_pago_venta FOREIGN KEY ([id_persona]) REFERENCES [DROP_TABLE].[Persona]([id_persona])
)






INSERT
	INTO
	[DROP_TABLE].[Tipo_inmueble] (nombre)
select
	DISTINCT(INMUEBLE_TIPO_INMUEBLE)
from
	gd_esquema.Maestra
where
	INMUEBLE_TIPO_INMUEBLE is not null


INSERT
	INTO
	[DROP_TABLE].[Inmueble_estado] (nombre)
select
	DISTINCT(INMUEBLE_ESTADO)
from
	gd_esquema.Maestra
where
	INMUEBLE_ESTADO is not null

INSERT
	INTO
	[DROP_TABLE].[Tipo_Operacion] (nombre)
select
	DISTINCT(ANUNCIO_TIPO_OPERACION)
from
	gd_esquema.Maestra
where
	ANUNCIO_TIPO_OPERACION is not null

INSERT
	INTO
	[DROP_TABLE].[Medio_Pago] (nombre)
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
	[DROP_TABLE].[Orientacion] (nombre)
select
	DISTINCT(INMUEBLE_ORIENTACION)
from
	gd_esquema.Maestra
where
	INMUEBLE_ORIENTACION is not null

INSERT
	INTO
	[DROP_TABLE].[Moneda] (nombre)
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
	[DROP_TABLE].[Barrio] (nombre)
select
	DISTINCT(INMUEBLE_BARRIO)
from
	gd_esquema.Maestra
where
	INMUEBLE_BARRIO is not null

INSERT
	INTO
	[DROP_TABLE].[Localidad] (nombre,
	id_barrio)
SELECT
	DISTINCT localidad,
	id_barrio
FROM
	(
	SELECT
		INMUEBLE_LOCALIDAD AS localidad,
		barrio.id_barrio
	FROM
		gd_esquema.Maestra maestra
	INNER JOIN [DROP_TABLE].[Barrio] barrio ON
		maestra.INMUEBLE_BARRIO = barrio.nombre
	WHERE
		INMUEBLE_LOCALIDAD IS NOT NULL
UNION ALL
	SELECT
		SUCURSAL_LOCALIDAD AS localidad,
		barrio.id_barrio
	FROM
		gd_esquema.Maestra maestra
	INNER JOIN [DROP_TABLE].[Barrio] barrio ON
		maestra.INMUEBLE_BARRIO = barrio.nombre
	WHERE
		SUCURSAL_LOCALIDAD IS NOT NULL
) AS Localidades;

INSERT
	INTO
	[DROP_TABLE].[Provincia] (nombre,
	id_localidad) (
	select
		DISTINCT(INMUEBLE_PROVINCIA),
		localidad.id_localidad
	from
		gd_esquema.Maestra maestra
	inner join [DROP_TABLE].[Localidad] localidad on
		maestra.INMUEBLE_LOCALIDAD = localidad.nombre
	where
		INMUEBLE_PROVINCIA is not null
union
	select
		DISTINCT(SUCURSAL_PROVINCIA),
		localidad.id_localidad
	from
		gd_esquema.Maestra maestra
	inner join [DROP_TABLE].[Localidad] localidad on
		maestra.INMUEBLE_LOCALIDAD = localidad.nombre
	where
		SUCURSAL_PROVINCIA is not null)


INSERT
	INTO
	[DROP_TABLE].[Sucursal] (codigo,
	direccion,
	nombre,
	telefono,
	id_barrio)
select
	DISTINCT(SUCURSAL_CODIGO),
	SUCURSAL_DIRECCION,
	SUCURSAL_NOMBRE,
	SUCURSAL_TELEFONO,
	localidad.id_barrio
from
	gd_esquema.Maestra maestra
inner join [DROP_TABLE].[Provincia] provincia on
	maestra.SUCURSAL_PROVINCIA = provincia.nombre
inner join [DROP_TABLE].[Localidad] localidad on
	maestra.SUCURSAL_LOCALIDAD = localidad.nombre
where
	SUCURSAL_CODIGO is not null

INSERT
	INTO
	[DROP_TABLE].[Disposicion] (nombre)
select
	DISTINCT(INMUEBLE_DISPOSICION)
from
	gd_esquema.Maestra
where
	INMUEBLE_DISPOSICION is not null


INSERT
	INTO
	[DROP_TABLE].[Persona] (dni,
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





INSERT INTO [DROP_TABLE].[Inmueble] (codigo, nombre, descripcion, direccion, superficie, antiguedad, expensas, ambientes, id_inmueble_estado, id_tipo_inmueble, id_disposicion, id_orientacion, id_barrio)
SELECT DISTINCT INMUEBLE_CODIGO, INMUEBLE_NOMBRE, INMUEBLE_DESCRIPCION, INMUEBLE_DIRECCION, INMUEBLE_SUPERFICIETOTAL, INMUEBLE_ANTIGUEDAD, INMUEBLE_EXPESAS, INMUEBLE_CANT_AMBIENTES, ie.id_inmueble_estado, ti.id_tipo_inmueble, d.id_disposicion, o.id_orientacion, b.id_barrio
FROM gd_esquema.Maestra
INNER JOIN [DROP_TABLE].[Inmueble_estado] ie ON ie.nombre = INMUEBLE_ESTADO
INNER JOIN [DROP_TABLE].[Tipo_inmueble] ti ON ti.nombre = INMUEBLE_TIPO_INMUEBLE
INNER JOIN [DROP_TABLE].[Disposicion] d ON d.nombre = INMUEBLE_DISPOSICION
INNER JOIN [DROP_TABLE].[Orientacion] o ON o.nombre = INMUEBLE_ORIENTACION
INNER JOIN [DROP_TABLE].[Barrio] b ON b.nombre = INMUEBLE_BARRIO
WHERE INMUEBLE_CODIGO IS NOT NULL;


INSERT INTO [DROP_TABLE].[Caracteristicas] (caracteristica) VALUES
('Wifi'),
('Cable'),
('Calefacción'),
('Gas')



INSERT INTO [DROP_TABLE].[Caracteristicas_por_inmueble] (id_inmueble, id_caracteristicas)
SELECT inmueble.id_inmueble, c.id_caracteristicas
FROM gd_esquema.Maestra m
INNER JOIN [DROP_TABLE].[Inmueble] inmueble ON m.INMUEBLE_CODIGO = inmueble.codigo
LEFT JOIN [DROP_TABLE].[Caracteristicas] c ON
    (m.INMUEBLE_CARACTERISTICA_WIFI = 1 AND c.caracteristica = 'Wifi') OR
    (m.INMUEBLE_CARACTERISTICA_CABLE = 1 AND c.caracteristica = 'Cable') OR
    (m.INMUEBLE_CARACTERISTICA_CALEFACCION = 1 AND c.caracteristica = 'Calefacción') OR
    (m.INMUEBLE_CARACTERISTICA_GAS = 1 AND c.caracteristica = 'Gas')
WHERE
    m.INMUEBLE_CODIGO IS NOT NULL
    AND (m.INMUEBLE_CARACTERISTICA_WIFI = 1 OR m.INMUEBLE_CARACTERISTICA_CABLE = 1 OR m.INMUEBLE_CARACTERISTICA_CALEFACCION = 1 OR m.INMUEBLE_CARACTERISTICA_GAS = 1)

INSERT INTO [DROP_TABLE].[Propietario] (id_persona , id_inmueble)
SELECT DISTINCT p.id_persona , i.id_inmueble
FROM gd_esquema.Maestra m
INNER JOIN [DROP_TABLE].[Persona] p ON p.dni = m.PROPIETARIO_DNI
INNER JOIN [DROP_TABLE].[Inmueble] i ON i.codigo = m.INMUEBLE_CODIGO
WHERE m.INMUEBLE_CODIGO IS NOT NULL and m.PROPIETARIO_DNI IS NOT NULL;

INSERT
	INTO
	[DROP_TABLE].[Alquiler_Estado] (nombre)
select
	DISTINCT(Alquiler_Estado)
from
	gd_esquema.Maestra
where
	Alquiler_Estado is not null

	INSERT INTO [DROP_TABLE].[Inquilino] (id_persona , id_alquiler)
SELECT DISTINCT p.id_persona , a._id_alquiler
FROM gd_esquema.Maestra m 
INNER JOIN [DROP_TABLE].[Persona] p ON p.dni = m.INQUILINO_DNI
INNER JOIN [DROP_TABLE].[Alquiler] a ON i.id_alquiler = m.ALQUILER_CODIGO
WHERE m.ALQUILER_CODIGO IS NOT NULL and m.INQUILINO_DNI IS NOT NULL;

INSERT INTO [DROP_TABLE].[Comprador] (id_persona , id_venta)
SELECT DISTINCT p.id_persona , v._id_venta
FROM gd_esquema.Maestra m 
INNER JOIN [DROP_TABLE].[Persona] p ON p.dni = m.COMPRADOR_DNI
INNER JOIN [DROP_TABLE].[Venta] a ON v.id_venta = m.VENTA_CODIGO
WHERE m.VENTA_CODIGO IS NOT NULL and m.COMPRADOR_DNI IS NOT NULL;
