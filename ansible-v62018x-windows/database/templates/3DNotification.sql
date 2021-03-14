--3.1.6. Commands for 3DNotification:
PRINT '3.1.6. Commands for 3DNotification:'
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
GO
PRINT 'Creating Database...'
-- Create database x3dnotification
CREATE DATABASE $(dbname) COLLATE SQL_Latin1_General_CP1_CI_AS;
PRINT 'DB CREATED' 
GO
PRINT 'Database created successfully...'
GO
PRINT 'Minimizing deadlock potential...'
GO
-- Minimizing deadlock potential
ALTER DATABASE $(dbname) SET READ_COMMITTED_SNAPSHOT ON;
GO
-- Create logins
CREATE LOGIN x3dn WITH PASSWORD = '$(pasword1)', CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
CREATE LOGIN x3dn_admin WITH PASSWORD = '$(pasword2)', CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
GO
PRINT 'Create log in successfully..'
GO
USE $(dbname);
-- Create users on correct DATABASE (after use) and with correct schema
CREATE USER x3dn FOR LOGIN x3dn WITH DEFAULT_SCHEMA = $(schema)
CREATE USER x3dn_admin FOR LOGIN x3dn_admin WITH DEFAULT_SCHEMA =$(schema);
-- Create schema
GO
IF (SCHEMA_ID('$(schema)') IS NULL) 
BEGIN
    EXEC ('CREATE SCHEMA [$(dbname)] AUTHORIZATION [x3dn_admin]')
END
PRINT 'Schema create successfully..'
GO
-- Grant access
GRANT CREATE TABLE, ALTER, SELECT, INSERT, UPDATE, DELETE ON DATABASE::x3dnotification TO x3dn_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::$(dbname) TO x3dn;
PRINT 'GRANT PRIVELGE SUCCESFULLY..'
GO
PRINT 'Task successful'

