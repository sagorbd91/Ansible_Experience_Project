---3.1.1. Commands for 3DPassport:
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
USE master;
GO
PRINT 'Creating Database...'
-- Create database
CREATE DATABASE $(dbname) COLLATE SQL_Latin1_General_CP1_CI_AS;
PRINT 'DB CREATED' 
CREATE DATABASE $(dbname1) COLLATE SQL_Latin1_General_CP1_CI_AS;
PRINT 'DBCREATED'
GO
PRINT 'Database created successfully...'
-- Minimizing deadlock potential
ALTER DATABASE $(dbname) SET READ_COMMITTED_SNAPSHOT ON;
ALTER DATABASE $(dbname1) SET READ_COMMITTED_SNAPSHOT ON;
-- Create logins
CREATE LOGIN x3dpass WITH PASSWORD = '$(pasword1)',CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
CREATE LOGIN x3dpassadmin WITH PASSWORD = '$(pasword2)', CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
CREATE LOGIN x3dpasstokens WITH PASSWORD = '$(pasword3)', CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
USE $(dbname) ;
-- Create users on correct DATABASE (after use) and with correct schema
CREATE USER x3dpass FOR LOGIN x3dpass WITH DEFAULT_SCHEMA = $(schema);
CREATE USER x3dpassadmin FOR LOGIN x3dpassadmin WITH DEFAULT_SCHEMA = $(schema);
-- Create schema
GO
IF (SCHEMA_ID('$(schema)') IS NULL) 
BEGIN
    EXEC ('CREATE SCHEMA [$(schema)] AUTHORIZATION [x3dpassadmin]')
END

-- Grant access
GRANT CREATE TABLE, ALTER, SELECT, INSERT, UPDATE, DELETE ON DATABASE::$(dbname) 
TO x3dpassadmin;
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON SCHEMA::$(schema) TO x3dpass;
USE $(dbname1) ;
-- Create users on correct DATABASE (after use) and with correct schema
CREATE USER x3dpasstokens FOR LOGIN x3dpasstokens WITH DEFAULT_SCHEMA = $(schema1)
-- Create schema
GO
IF (SCHEMA_ID('$(schema1)') IS NULL) 
BEGIN
    EXEC ('CREATE SCHEMA [$(schema1)] AUTHORIZATION [x3dpasstokens]')
END

-- Grant access
GRANT CREATE TABLE, ALTER, SELECT, INSERT, UPDATE, DELETE ON DATABASE::$(dbname1) TO x3dpasstokens;

