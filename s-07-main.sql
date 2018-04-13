Prompt Caso ventas de seguros

Prompt Cargando usuarios ....
@s-01-usuarios.sql


Prompt Cargando usuario administrador
-- Para autologearme como el usuario
connect &J_PROY_ADMIN as sysdba

Prompt Cargando secuencias ...
@s-05-secuencias.sql

Prompt Cargando tablas ...
@s-02-entidades.sql

Prompt Cargando tablas temporales ...
@s-03-tablas-temporales.sql

Prompt Cargando usuario administrador
-- Para autologearme como el usuario
connect &R_PROY_INVITADO/&orcinvitadopass

Prompt Realizando consultas ...
@s-08-consultas.sql

Prompt Listo.