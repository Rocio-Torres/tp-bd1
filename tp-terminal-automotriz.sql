/*
use terminal_automotriz;

create table consesionario
(
	id_consesionario int primary key,
    descripcion varchar(45) not null
);

create table modelo
(
	id_modelo int primary key,
    descripcion varchar(45) not null,
    precio int not null
);

create table matricula_chasis
(
	id_matricula_chasis int primary key,
    modelo_id int not null,
    foreign key (modelo_id) references modelo(id_modelo)
);

create table pedido
(
	id_pedido int auto_increment primary key not null,
    fecha_entrega datetime not null,
    consesionario_id int not null,
    foreign key (consesionario_id) references consesionario(id_consesionario)
);

create table pedido_detalle
(
	id_pedido_detalle int auto_increment primary key not null,
    pedido_id int not null,
    matricula_chasis_id int not null,
    foreign key (matricula_chasis_id) references matricula_chasis(id_matricula_chasis)
);

create table insumo
(
	id_insumo int primary key,
    descripcion varchar(45) not null,
    precio float
);	

create table proveedor
(
	id_proveedor int primary key,
    descripcion varchar(45) not null,
    contacto varchar(45) not null
);

create table insumo_proveedor
(
	id_insumo_proveedor int primary key,
    cantidad int not null,
    insumo_id int not null,
    proveedor_id int not null,
    foreign key (insumo_id) references insumo(id_insumo),
    foreign key (proveedor_id) references proveedor(id_proveedor)
);

create table linea_montaje
(
	id_linea_montaje int primary key,
    modelo_id int not null,
    foreign key (modelo_id) references modelo(id_modelo)
);

create table estacion_trabajo
(
	id_estacion_trabajo int primary key,
    descripcion varchar(45) not null,
    insumo_proveedor_id int not null,
    linea_montaje_id int not null,
    foreign key (insumo_proveedor_id) references insumo_proveedor(id_insumo_proveedor),
    foreign key (linea_montaje_id) references linea_montaje(id_linea_montaje)
);

create table modelo_estacion
(
	modelo_id int not null,
    estacion_trabajo_id int not null,
    fecha_entrada datetime not null,
    fecha_salida datetime not null,
    foreign key (modelo_id) references modelo(id_modelo),
    foreign key (estacion_trabajo_id) references estacion_trabajo(id_estacion_trabajo)    
);*/

/*Alta-Baja-Modificacion de:
1- Pedido
2- Pedido Detalle
3- Insumo
4- Proveedor
5- Insumo Proveedor

**Se puede especificar la direccionalidad de los parametros dentro del procedimiento
IN/OUT/INOUT *nombre parametro* *tipo de dato*
IN: LECTURA - OUT: ESCRITURA

 delimiter *MySQL necesita explicacion sobre donde empieza y termina un procedimiento*/

delimiter $$

CREATE PROCEDURE alta_pedido (out pedido_id int, in pedido_fechaEntrega datetime, in pedido_cons_id int)
begin
		insert into pedido(fecha_entrega, consesionario_id)
			values (pedido_fechaentrega, pedido_cons_id);
end;	$$

delimiter $$
CREATE PROCEDURE baja_pedido (in id_pedido_p int) /*ver que el pedido no este en marcha*/
-- select count(*) from ;
-- if (cantidad =0)
	begin
			delete from pedido
            where id_pedido = id_pedido_p;
    end;	$$

delimiter $$
CREATE PROCEDURE modificar_pedido(in id_pedido_p int, in new_fechaentrega datetime, in new_cons_id int)
begin
	update pedido 
	set fecha_entrega = new_fechaentrega, consesionario_id = new_cons_id
    where id_pedido = id_pedido_p;	
end;	$$

delimiter $$
CREATE PROCEDURE alta_pedido_detalle(out pedido_detalle_id int, in id_pedido_p int, out id_matricula_chasis_mc int)
begin
		insert into pedido_detalle (pedido_id, matricula_chasis_id)
				values (id_pedido_p, id_matricula_chasis_mc);
end;	$$

delimiter $$
CREATE PROCEDURE baja_pedido_detalle(in pedido_detalle_id int)
begin
		delete from pedido_detalle
        where id_pedido_detalle = pedido_detalle_id;
end;	$$
	
delimiter $$
CREATE PROCEDURE modificar_pedido_detalle(in pedido_detalle_id int, in new_id_pedido int, out new_id_chasis int)
begin
		update pedido_detalle
        set pedido_id = new_id_pedido, matricula_chasis_id = new_id_chasis
        where id_pedido_detalle = pedido_detalle_id;
end;	$$

delimiter $$
CREATE PROCEDURE alta_insumo(in insumo_id int, in descr varchar(45), in precio_ins float)
begin
		insert into insumo(id_insumo, descripcion, precio)
				values(insumo_id, descr, precio_ins);
end;	$$

delimiter $$
CREATE PROCEDURE baja_insumo(in insumo_id int)
begin
		delete from insumo
        where id_insumo = insumo_id;
end;	$$

delimiter $$
CREATE PROCEDURE modificar_insumo(in insumo_id int, in descr varchar(45), in precio_ins float)
begin
		update insumo
        set descripcion = descr, precio = precio_ins
        where id_insumo = insumo_id;
end;	$$

delimiter $$
CREATE PROCEDURE alta_insumo_proveedor(in ins_prov_id int, in cant int, in id_insumo_i int, in id_proveedor_p int)
begin
		insert into insumo_proveedor(id_insumo_proveedor, cantidad, insumo_id, id_proveedor_p)
				values(ins_prov_id, cant, id_insumo_i, id_proveedor_p);
end;	$$

delimiter $$
CREATE PROCEDURE baja_insumo_proveedor(in insumo_proveedor_id int)
begin
		delete from insumo_proveedor
        where id_insumo_proveedor = insumo_proveedor_id;
end;	$$

delimiter $$
CREATE PROCEDURE modificar_insumo_proveedor(in ins_prov_id int, in cant int, in id_insumo_i int, in id_proveedor_p int)
begin
		update insumo_proveedor
        set cantidad=cant, insumo_id=id_insumo_i, proveedor_id=id_proveedor_p
        where id_insumo_proveedor = ins_prov_id;
end;	$$

delimiter $$
CREATE PROCEDURE alta_proveedor(in proveedor_id int, in descr varchar(45), in contacto_prov varchar(45))
begin
		insert into proveedor(id_proveedor, descripcion, contacto)
				values(proveedor_id, descr, contacto_prov);
end;	$$

delimiter $$
CREATE PROCEDURE baja_proveedor(in proveedor_id int)
begin
		delete from proveedor
        where id_proveedor = proveedor_id;
end;	$$

delimiter $$
CREATE PROCEDURE modificar_proveedor(in proveedor_id int, in descr varchar(45), in contacto_prov varchar(45))
begin
		update proveedor
        set descripcion = descr, contacto = contacto_prov
        where id_proveedor = proveedor_id;
end;	$$
