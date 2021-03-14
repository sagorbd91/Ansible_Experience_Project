
--3.1.3. Commands for 3DDashboard:
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
-- Create database
-- Create database
CREATE DATABASE $(dbname) COLLATE SQL_Latin1_General_CP1_CI_AS;
PRINT 'DB CREATED' 
GO
PRINT 'Database created successfully...'
-- Minimizing deadlock potential
ALTER DATABASE $(dbname) SET READ_COMMITTED_SNAPSHOT ON;
-- Create logins
CREATE LOGIN x3ddash WITH PASSWORD = '$(pasword1)', CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
--PRINT $(pasword1)
CREATE LOGIN x3ddashadmin WITH PASSWORD = '$(pasword2)', CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
--PRINT $(pasword2)
USE $(dbname);
-- Create users on correct DATABASE (after use) and with correct schema
CREATE USER x3ddash FOR LOGIN x3ddash WITH DEFAULT_SCHEMA = $(schema);
PRINT 'USER x3ddash CREATED'
CREATE USER x3ddashadmin FOR LOGIN x3ddashadmin WITH DEFAULT_SCHEMA = $(schema);
PRINT 'USER x3ddashadmin CREATED'
-- Create schema
GO
IF (SCHEMA_ID('$(schema)') IS NULL) 
BEGIN
    EXEC ('CREATE SCHEMA [$(schema)] AUTHORIZATION [x3ddashadmin]')
END
PRINT 'SCHEMA IS CREATED' 
-- Grant access
GRANT CREATE TABLE, ALTER, SELECT, INSERT, UPDATE, DELETE ON DATABASE::$(dbname) TO x3ddashadmin;
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON SCHEMA::$(schema) TO x3ddash;
