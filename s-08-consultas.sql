--consultas.sql

--1 se desea saber los datos de contacto (e mail, direccion, telefono) de todas las personas cuyos apellidos paterno coincida con 
-- la busqueda, o cuyos apellidos sean el mismo

SELECT c.email, c.direccion, c.telefono 
FROM cliente c
WHERE (c.apppaterno = 'Rivera' or c.appmaterno = c.apppaterno); -- si no existe cambiar otro que exista en la bd

--2 se busca las personas afectadas y los hospitales a donde fueron llevadas de los siniestros donde hubo colision y perdidas humanas
--en todos los siniestros que requirieron grua y sucedieron despues del medio dia o en los siniestros donde se requirio ambulancia

SELECT pa.nombrecompleto, pa.nombrehospital, pa.direccionhospital
FROM personaafectada pa, social ss
WHERE(pa.idpersonaafectada = ss.fkpersonaafectada1 
and siniestro s)
WHERE(ss.idsocial = s.fksocial1 
and colision c)
WHERE(c.idcolision = s.fkcolision1)
WHERE((s.hora > 12 and c.requieregrua ='T' ) or  ss.requiereambulancia='T');


-- 3 se desea ver la fecha, direccion, estado donde ocurrio un siniestro, el folio del mismo y las placas de los asegurados

SELECT s.fecha, s.direccion, (SELECT e.nombre FROM estado e), p.placa, p.folio
from siniestro s 
INNER JOIN poliza p ON (p.fksiniestro1 =s.idsiniestro);

--4 mostrar todos los seguros contratados por menores de 30 anios que no hayan tenido accidentes

SELECT c.nombre, c.apppaterno, c.appmaterno 
FROM cliente c 
JOIN poliza p ON (c.fkfolio1 = p.folio)
WHERE (p.fksiniestro1 is null)
MINUS SELECT cliente.nombre, cliente.apppaterno, cliente.appmaterno
FROM cliente INNER JOIN cotizacion co ON (cliente.fkcotizacion1 = co.idcotizacion)
WHERE (cotizacion.edadconductor > 30);

--5 mostrar los datos de los clientes cliente y de las poliza

SELECT  nombre, apppaterno, rfc, telefono, email
FROM cliente
UNION
SELECT fechainicio, fechafin, placa, numeroserieauto,
FROM poliza;

--6 mostrar las aseguradoras y los modelos de los autos involucrados en los siniestros que no hayan requerido  grua

SELECT a.descripcion, (SELECT ai.modeloinv FROM autoinvolucrado ai) AS modelo
FROM aseguradora a 
INNER JOIN ai ON (a.fkautoinvolucrado3 = ai.idautoinvolucrado)
INNER JOIN colision c ON (c.fkautoinvolucrado1 =ai.idautoinvolucrado)
WHERE(SELECT ai.marcainv FROM autoinvolucrado WHERE c.requieregrua == 'F'); 

--7 mostrar los accidentes de colision sucedidos pasadas las 10 de la noche y antes de las 6 de la ma;ana donde los autos involucrados no
--tengan aseguradora

SELECT  s.fecha, s.direccion, c.numeroreportevial
FROM siniestro s, colision c
WHERE(s.hora>22 and s.hora<6)
INTERSECT
SELECT s.fecha, s.direccion, c.numeroreportevial
FROM siniestro s, colision c
WHERE (s.fkcolision1 = idcolision 
and autoinvolucrado ai)
WHERE(c.fkautoinvolucrado1 = ai.idautoinvolucrado AND ai.fkaseguradora2 IS NULL);

--8 mostrar los nombres del cliente y folio de poliza de las polizas recien contratadas

SELECT nombre, folio
FROM cliente JOIN poliza
ON (cliente.idcliente  = poliza.fkcliente2)
WHERE (poliza.fkpolizaanterior is NULL);

--9 mostrar los nombres completos de los mayores de 60 anios que aseguraron una marca en especifico 

SELECT c.nombre, c.apppaterno, c.appmaterno
FROM cliente c
INNER JOIN poliza p ON (c.idcliente = p.fkcliente2)
INNER JOIN cotizacion co ON (co.idcotizacion = p.fkcotizacion7)
INNER JOIN marcaauto m ON (co.fkmarca1 = m.idmarca)
WHERE(co.edadconductor > 60 and m.descripcion = 'BMW') ORDER BY c.apppaterno; --o cambiar por una marca que aparezca

--10 mostrar la fecha de cada cotizacion que han realizado los clientes de 21 anios, nombre y apellido del cliente y la marca y modelo de los autos

SELECT cot.fecha, ma.descripcion, mo.descripcion, 
(SELECT c.nombre, c.apppaterno
FROM cliente c)
FROM cotizacion cot, marcaauto ma
WHERE(cot.fkmarca1 =ma.idmarca and  modeloauto mo)
WHERE(cot.fkmodeloauto1 = mo.idmodeloauto and cot.edadconductor <21);
