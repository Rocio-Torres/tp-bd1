
use terminal_automotriz;

/*-------------------------------------------------------------------------------------------------------*/
/*Creacion de procedimiento para creacion de pedidos*/

/*
	Se  requiere  crear  un  procedimiento  que  dada  la  información  de  un  pedido  en   particular,
    se  generan  los  automóviles  con  la  patente  asignada  al  azar  en  la  tabla correspondiente  
    según  el  modelo.  La  idea  es  que  se  deben  generar  los  automóviles  
    y dejarlos  en  el  estado  inicial,  es  decir,  con  la  línea  de  montaje  asignada, 
    pero  sin ingresar  a  la  primer  estación  de  dicha  línea. 
*/
-- USO DE PATENTES VIEJAS (ABC 123) 


select * from proveedor;
select * from insumo;

call alta_insumo (@mensaje,@resultado,901,'Luneta trasera',5487.99);
select @mensaje;
select @resultado;

delimiter $$
 CREATE PROCEDURE generar_automovil (in id_pedido_detalle int)
 begin
 
 
 
 end; $$





-- SUBSTRING(string, start, length)
-- Rand() devuelve un numero random entre las cantidades dadas
-- esta funcion busca randommente(? un caracter alfanumerico dado en el string uno a uno para completar la patente
-- apartir del rand() develve un numero el cual es la posicion del caracter en el string
-- en este caso use el modelo viejo de patente siendo esta tres letras y tres numeros
insert into matricula
select concat(substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ', Rand()*27, 1),
              substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ', Rand()*27, 1),
              substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ', Rand()*27, 1),
              substring('0123456789', Rand()*10, 1),
              substring('0123456789', Rand()*10, 1),
              substring('0123456789', Rand()*10, 1)
              )as patente;
select * from matricula;



delimiter $$
CREATE FUNCTION agregar_patente () returns varchar(6)
begin 
declare patente_nueva varchar(6);
declare auxiliar varchar(6);
select concat(substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ', Rand()*27, 1),
              substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ', Rand()*27, 1),
              substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ', Rand()*27, 1),
              substring('0123456789', Rand()*10, 1),
              substring('0123456789', Rand()*10, 1),
              substring('0123456789', Rand()*10, 1)
              )into auxiliar;
set patente_nueva = auxiliar;
return patente_nueva;
end; $$