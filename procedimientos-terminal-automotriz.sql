
use terminal_automotriz_tp;

select * from consesionario;
select * from pedido;
select * from pedido_detalle;
select * from insumo;
select * from insumo_proveedor;
select * from proveedor;
select * from linea_montaje;
select * from modelo;
select * from estacion_trabajo;
select * from automovil;

-- values ("1HGBH41JXMN109186","","2021-10-20",1,1);
-- call alta_pedido_detalle(@mensaje,@resultado,1,'1HGBH41JXMN109186');
call agregar_patente('1HGBH41JXMN109186');

/*insert into modelo
values(1,"Cupra - Ateca",1500000);
insert into modelo
values(2,"Citroën - Ami", 2000000);
insert into modelo
values(3, "Audi - A4", 2999999);*/

/*insert into linea_montaje
values(10,1);
insert into linea_montaje
values(20,2);
insert into linea_montaje
values(30,3);*/

/*insert into consesionario
values(401,"X401");
insert into consesionario
values(402, "R402");
insert into consesionario
values(403,"S403");*/

/*insert into estacion_trabajo
values(9,"Pintura Ateca",1,10);
insert into estacion_trabajo
values(8,"Pintura Ami",2,20);
insert into estacion_trabajo
values(7,"Pintura A4",1,30);*/

select @id_pedido;
select @mensaje;
select @resultado;

/*-------------------------------------------------------------------------------------------------------*/
/*Creacion de procedimiento para creacion de pedidos*/

/*
	Se  requiere  crear  un  procedimiento  que  dada  la  información  de  un  pedido  en   particular,
    se  generan  los  automóviles  con  la  patente  asignada  al  azar  en  la  tabla correspondiente  
    según  el  modelo.  La  idea  es  que  se  deben  generar  los  automóviles  
    y dejarlos  en  el  estado  inicial,  es  decir,  con  la  línea  de  montaje  asignada, 
    pero  sin ingresar  a  la  primer  estación  de  dicha  línea. 
*/


delimiter $$
  /*CREATE PROCEDURE generar_automovil (in id_pedido_p int)
 begin
 
 
 
 end; $$*/


-- SUBSTRING(string, start, length)
-- Rand() devuelve un numero random entre las cantidades dadas
-- esta funcion busca randommente(? un caracter alfanumerico dado en el string uno a uno para completar la patente
-- apartir del rand() develve un numero el cual es la posicion del caracter en el string
-- en este caso use el modelo viejo de patente siendo esta tres letras y tres numeros

delimiter $$
CREATE PROCEDURE agregar_patente (in chasis varchar(17))
begin 
declare patente_nueva varchar(6);
select concat(substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ', Rand()*27, 1),
              substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ', Rand()*27, 1),
              substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ', Rand()*27, 1),
              substring('0123456789', Rand()*10, 1),
              substring('0123456789', Rand()*10, 1),
              substring('0123456789', Rand()*10, 1)
              )as patente_nueva;
insert into automovil(patente)
values(patente_nueva);

end; $$