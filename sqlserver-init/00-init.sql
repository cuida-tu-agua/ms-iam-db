-- sqlserver-init/00-init.sql
IF DB_ID('sy-water-db') IS NULL
    CREATE DATABASE [sy-water-db];
GO

USE [sy-water-db];
GO

IF SCHEMA_ID('security') IS NULL
    EXEC('CREATE SCHEMA security');
GO

IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name='security_app')
    CREATE LOGIN security_app WITH PASSWORD='$(SECURITY_APP_PASSWORD)';
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name='security_app')
BEGIN
    CREATE USER security_app FOR LOGIN security_app
        WITH DEFAULT_SCHEMA = security;
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name='security_migrator')
    CREATE LOGIN security_migrator WITH PASSWORD='$(SECURITY_MIGRATOR_PASSWORD)';
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name='security_migrator')
BEGIN
    CREATE USER security_migrator FOR LOGIN security_migrator
        WITH DEFAULT_SCHEMA = security;
END
GO

GRANT CONTROL ON SCHEMA::security TO security_migrator;
GRANT CREATE TABLE TO security_migrator;
GRANT CREATE ROLE TO security_migrator;
GRANT ALTER ANY ROLE TO security_migrator;
GO