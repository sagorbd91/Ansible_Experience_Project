--3.1.5. Commands for 3DComment:
USE master;
GO
IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'$(dbname)') 
	BEGIN
		DROP DATABASE $(dbname);
		PRINT 'DROP DB SUCCESSFUL';
	END
ELSE
	BEGIN
		PRINT 'DB NOT EXISTS';
	END
GO
USE master;
-- Create database x3dcomment
GO
PRINT 'Creating Database...'
-- Create database
CREATE DATABASE $(dbname) COLLATE SQL_Latin1_General_CP1_CI_AS;
PRINT 'DB CREATED' 
GO
-- Minimizing deadlock potential
ALTER DATABASE $(dbname) SET READ_COMMITTED_SNAPSHOT ON;
-- Create logins
CREATE LOGIN x3d WITH PASSWORD = '$(pasword1)', CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
CREATE LOGIN x3d_admin WITH PASSWORD = '$(pasword2)', CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
USE $(dbname);
-- Create users on correct DATABASE (after use) and with correct schema
CREATE USER x3d FOR LOGIN x3d WITH DEFAULT_SCHEMA = $(schema);
CREATE USER x3d_admin FOR LOGIN x3d_admin WITH DEFAULT_SCHEMA = $(schema);
PRINT 'USER IS CREATED'
-- Create schema
GO
IF (SCHEMA_ID('$(schema)') IS NULL) 
BEGIN
    EXEC ('CREATE SCHEMA [$(schema)] AUTHORIZATION [x3d_admin]')
END
PRINT 'SCHEMA IS CREATED'
-- Grant access
GRANT CREATE TABLE, ALTER, SELECT, INSERT, UPDATE, DELETE ON DATABASE::$(dbname) TO x3d_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::$(schema) TO x3d;
PRINT 'GRANT PRIVELGE SUCCESFULLY..'
GO
PRINT 'Task successful'
