create table matricula
(
	patente varchar(6) primary key
);

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

select * from matricula;
drop table matricula;