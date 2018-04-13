--usuarios.sql
--connect to database as sys user to excecute this sentences 

----- creacion del rol administrador, asignacion de permisos

CREATE ROLE admi IDENTIFIED by admipass; --password admipass
GRANT create session TO admi --DAR PERMISOS DE INICIO DE SESION
GRANT create table, create synonym TO admi WITH ADMIN OPTION;
GRANT create secuence, create view TO admi;
GRANT ALL ON ALL TABLES IN SCHEMA TO admi;

---- creacion del rol invitado

CREATE ROLE invitado NOT IDENTIFIED;
GRANT create session TO invitado;	--DAR PERMISOS DE OBJETO
GRANT SELECT ON ALL TABLES IN SCHEMA public TO invitado;

------------CREACION DEL ADMIN
Prompt Creando un nuevo usuario administrador
Prompt Proporcione usuario y password
CREATE USER &&J_PROY_ADMIN IDENTIFIED BY &&afjvadminpass
DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp
QUOTA unlimited ON users
ACCOUNT UNLOCK;

GRANT admi TO J_PROY_ADMIN; --se asigna el rol de administrador al usuario
SET ROLE admi IDENTIFIED BY admipass;
-----------------creacion del usuario invitado
Prompt Creando un nuevo usuario invitado
Prompt Proporcione usuario y password
CREATE USER &&R_PROY_INVITADO IDENTIFIED BY &&orcinvitadopass
DEFAULT TABLESPACE users
QUOTA 0M ON users
ACCOUNT UNLOCK;

GRANT invitado TO R_PROY_INVITADO; --ASIGNAR EL ROL AL USUARIO
---------------------





