--3.1.4. Commands for 3DSwym:
USE master
GO
IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'$(dbname)') 
	BEGIN
		DROP DATABASE $(dbname);
		PRINT 'DROP DB $(dbname) SUCCESSFUL';
	END
ELSE
	BEGIN
		PRINT '$(dbname) DB NOT EXISTS';
	END
GO
USE master
GO
IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'$(dbname1)') 
	BEGIN
		DROP DATABASE $(dbname1);
		PRINT 'DROP DB $(dbname1) SUCCESSFUL';
	END
ELSE
	BEGIN
		PRINT '$(dbname1) DB NOT EXISTS';
	END
GO
IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'$(dbname2)') 
	BEGIN
		DROP DATABASE $(dbname2);
		PRINT 'DROP DB $(dbname2) SUCCESSFUL';
	END
ELSE
	BEGIN
		PRINT '$(dbname2) DB NOT EXISTS';
	END
GO
USE master;
GO
PRINT 'Creating Database...'
USE master;
-- Create databases x3dswym_social,x3dswym_media,x3dswym_widget
CREATE DATABASE $(dbname) COLLATE SQL_Latin1_General_CP1_CI_AS;
PRINT 'DB CREATED' 
CREATE DATABASE $(dbname1) COLLATE SQL_Latin1_General_CP1_CI_AS;
PRINT 'DB CREATED'
CREATE DATABASE $(dbname2) COLLATE SQL_Latin1_General_CP1_CI_AS;
PRINT 'DB CREATED'
GO
PRINT 'Database created successfully...'

-- Minimizing deadlock potential
ALTER DATABASE $(dbname) SET READ_COMMITTED_SNAPSHOT ON;
ALTER DATABASE $(dbname1) SET READ_COMMITTED_SNAPSHOT ON;
ALTER DATABASE $(dbname2) SET READ_COMMITTED_SNAPSHOT ON;
-- Set database compatibility level to 110
ALTER DATABASE $(dbname) SET COMPATIBILITY_LEVEL = 110;
-- Create logins
CREATE LOGIN x3ds WITH PASSWORD = '$(pasword1)', CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
CREATE LOGIN x3ds_admin WITH PASSWORD = '$(pasword2)', CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
USE $(dbname);
-- Create users on correct DATABASE (after use) and with correct schema
CREATE USER x3ds FOR LOGIN x3ds WITH DEFAULT_SCHEMA = $(schema);
CREATE USER x3ds_admin FOR LOGIN x3ds_admin WITH DEFAULT_SCHEMA =$(schema);
PRINT 'USER IS CREATED'
-- Create schema
GO
IF (SCHEMA_ID('$(schema)') IS NULL) 
BEGIN
    EXEC ('CREATE SCHEMA [$(schema)] AUTHORIZATION [x3ds_admin]')
END
PRINT 'SCHEMA IS CREATED' 
-- Grant access
GRANT CREATE TABLE, ALTER, SELECT, INSERT, UPDATE, DELETE ON DATABASE::$(dbname) TO x3ds_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::$(schema) TO x3ds;
USE $(dbname1);
-- Create users on correct DATABASE (after use) and with correct schema
CREATE USER x3ds FOR LOGIN x3ds WITH DEFAULT_SCHEMA = $(schema1);
CREATE USER x3ds_admin FOR LOGIN x3ds_admin WITH DEFAULT_SCHEMA = $(schema1);
PRINT 'USER CREATED SUCCESFULLY'
-- Create schema
GO
IF (SCHEMA_ID('$(schema1)') IS NULL) 
BEGIN
    EXEC ('CREATE SCHEMA [$(schema1)] AUTHORIZATION [x3ds_admin]')
END
PRINT 'SCHEMA IS CREATED'
-- Grant access
GRANT CREATE TABLE, ALTER, SELECT, INSERT, UPDATE, DELETE ON DATABASE::$(dbname1) TO x3ds_admin;
GRANT CREATE TABLE ON DATABASE::$(dbname1) TO x3ds;
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON SCHEMA::$(schema1) TO x3ds;
USE $(dbname2);
-- Create users on correct DATABASE (after use) and with correct schema
CREATE USER x3ds FOR LOGIN x3ds WITH DEFAULT_SCHEMA = $(schema2);
CREATE USER x3ds_admin FOR LOGIN x3ds_admin WITH DEFAULT_SCHEMA = $(schema2);
PRINT 'USER IS CREATED'
-- Create schema
GO
IF (SCHEMA_ID('$(schema2)') IS NULL) 
BEGIN
    EXEC ('CREATE SCHEMA [$(schema2)] AUTHORIZATION [x3ds_admin]')
END
PRINT 'SCHEMA IS CREATED'
-- Grant access
GRANT CREATE TABLE, ALTER, SELECT, INSERT, UPDATE, DELETE ON DATABASE::$(dbname2) TO x3ds_admin;
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON SCHEMA::$(schema2) TO x3ds;