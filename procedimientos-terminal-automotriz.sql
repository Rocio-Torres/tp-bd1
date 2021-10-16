
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

-- CREATE PROCEDURE generar_automovil (in id_pedido_detalle int)
-- SUBSTRING(MD5(Rand()) FROM 1 FOR 8) CADENA ALEATORIA
-- lpad(conv(floor(rand()*pow(36,8)), 10, 36), 8, 0);

select @pedido_id;
select @mensaje;
select @resultado;

select * from pedido;

/*DELIMITER $$
	CREATE FUNCTION random_string (largo INT(6), seed VARCHAR(255)) RETURNS varchar(6) CHARSET utf8
    NO SQL
	BEGIN
		SET @output = '';
		IF seed IS NULL OR seed = '' THEN SET seed = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'; 
		END IF;

    SET @rnd_multiplier = LENGTH(seed);

    WHILE LENGTH(@output) < largo 
    DO
        # Select random character and add to output
        SET @output = CONCAT(@output, SUBSTRING(seed, RAND() * (@rnd_multiplier + 1), 1));
    END WHILE;

    RETURN @output;
END; $$
*/

-- SUBSTRING(string, start, length)
-- Rand() devuelve un numero random entre las cantidades dadas
-- esta funcion busca randommente(? un caracter alfanumerico dado en el string uno a uno para completar la patente
-- apartir del rand() develve un numero el cual es la posicion del caracter en el string
-- en este caso use el modelo viejo de patente siendo esta tres letras y tres numeros
insert into matricula (patente)
select concat(substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ', Rand()*26+1, 1),
              substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ', Rand()*26+1, 1),
              substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ', Rand()*26+1, 1),
              substring('0123456789', Rand()*9+1, 1),
              substring('0123456789', Rand()*9+1, 1),
              substring('0123456789', Rand()*9+1, 1)
             ) as patente;
