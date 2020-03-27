--use this https://docs.oracle.com/cd/E25259_01/appdev.31/e24285/migration.htm#RPTUG41484
--1. https://sourceforge.net/projects/jtds/?source=typ_redirect

--2.
create user migrant identified by migrant;
grant all PRIVILEGES to migrant;

--3. connect to that user

--4. Start migration