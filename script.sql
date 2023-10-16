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
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE TABLE [DROP_TABLE].[Disposicion](
	[id] [int] IDENTITY(1,1) primary key,
	[nombre] VARCHAR(100) NOT NULL,
 	[id_inmueble] [int] FOREIGN KEY REFERENCES [Inmueble]
) 
CREATE TABLE [DROP_TABLE].[Orientacion](
	[id] [int] IDENTITY(1,1) primary key,
	[nombre] VARCHAR(100) NOT NULL
) 
CREATE TABLE [DROP_TABLE].[Tipo_inmueble](
	[id] [int] IDENTITY(1,1) primary key,
	[nombre] VARCHAR(100) NOT NULL
) 
CREATE TABLE [DROP_TABLE].[Inmueble_estado](
	[id] [int] IDENTITY(1,1) primary key,
	[nombre] VARCHAR(100) NOT NULL
) 
CREATE TABLE [DROP_TABLE].[Inmueble](
	[id] [int] IDENTITY(1,1) primary key,
	[nombre] VARCHAR(100) NOT NULL
) 