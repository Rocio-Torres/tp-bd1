
/* Creacion y uso de la base de datos*/
create database terminal_automotriz;
use terminal_automotriz;

/*-------------------------------------------------------------------------------------------------------*/
/*Creacion de tablas*/
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
	matricula_chasis varchar(6) primary key,
    modelo_id int not null,
    foreign key (modelo_id) references modelo(id_modelo)
);

drop table matricula_chasis;
drop table pedido_detalle;
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
    matricula varchar(6) not null,
    foreign key (matricula) references matricula_chasis(matricula_chasis)
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
);

/*-------------------------------------------------------------------------------------------------------*/
/*Creacion de procedimientos ABM de la tabla PEDIDO*/
delimiter $$

CREATE PROCEDURE alta_pedido (out pedido_id int, out mensaje varchar(200), out resultado int, in pedido_fechaEntrega datetime, in pedido_cons_id int)
begin
	if(exists(select * from pedido where id_pedido = pedido_id)) THEN
		set mensaje = "El pedido ya existe";
        set resultado = -1;
	else
		insert into pedido(fecha_entrega, consesionario_id)
			values (pedido_fechaentrega, pedido_cons_id);
		set mensaje = "El pedido fue cargado correctamente";
        set resultado = 0;
	end if;
end	$$
delimiter;

 
delimiter $$
CREATE PROCEDURE baja_pedido (out mensaje varchar(200), out resultado int, in id_pedido_p int) 
	begin
		if(exists(select * from pedido where id_pedido = id_pedido_p)) THEN
			set mensaje = "Pedido dado de baja correctamente";
            set resultado = 0;
			delete from pedido
            where id_pedido = id_pedido_p;
		else
			set mensaje = "Pedido no encontrado";
            set resultado = -1;
		end if;
    end;	$$

delimiter $$
CREATE PROCEDURE modificar_pedido(out mensaje varchar(200), out resultado int, in id_pedido_p int, in new_fechaentrega datetime, in new_cons_id int)
begin
	if(exists(select * from pedido where id_pedido = id_pedido_p)) THEN
		set mensaje = "Pedido modificado correctamente";
        set resultado = 0;
		update pedido 
		set fecha_entrega = new_fechaentrega, consesionario_id = new_cons_id
		where id_pedido = id_pedido_p;	
	else
		set mensaje = "Pedido no encontrado";
        set resultado = -1;
	end if;
    
end;	$$

/*-------------------------------------------------------------------------------------------------------*/
/*Creacion de procedimientos ABM de la tabla PEDIDO_DETALLE*/

delimiter $$
CREATE PROCEDURE alta_pedido_detalle(out mensaje varchar(200), out resultado int, out pedido_detalle_id int, in id_pedido_p int, out id_matricula_chasis_mc int)
begin
	if(exists(select * from pedido_detalle where id_pedido_detalle = pedido_detalle_id)) THEN
		set mensaje = "El detalle del pedido ya existe";
        set resultado = -1;
	else
		set mensaje = "El detalle del pedido fue cargado exitosamente";
        set resultado = 0;
		insert into pedido_detalle (pedido_id, matricula_chasis_id)
				values (id_pedido_p, id_matricula_chasis_mc);
	end if;
end;	$$

delimiter $$
CREATE PROCEDURE baja_pedido_detalle(out mensaje varchar(200), out resultado int, in pedido_detalle_id int)
begin
	if(exists(select * from pedido_detalle where id_pedido_detalle = pedido_detalle_id)) THEN
		set mensaje = "Detalle del pedido borrado corrextamente";
        set resultado = 0;
		delete from pedido_detalle
        where id_pedido_detalle = pedido_detalle_id;
	else
		set mensaje = "Detalle del pedido no encontrado";
        set resultado = -1;
	end if;
        
end;	$$
	
delimiter $$
CREATE PROCEDURE modificar_pedido_detalle(out mensaje varchar(200), out resultado int, in pedido_detalle_id int, in new_id_pedido int, out new_id_chasis int)
begin
	if(exists(select * from pedido_detalle where id_pedido_detalle = pedido_detalle_id)) THEN
		set mensaje = "Detalle del pedido modificado correctamente";
        set resultado = 0;
		update pedido_detalle
        set pedido_id = new_id_pedido, matricula_chasis_id = new_id_chasis
        where id_pedido_detalle = pedido_detalle_id;
	else 
		set mensaje = "Detalle del pedido no encontrado";
        set mensaje = -1;
	end if;
end;	$$

/*-------------------------------------------------------------------------------------------------------*/
/*Creacion de procedimientos ABM de la tabla INSUMO*/

delimiter $$
CREATE PROCEDURE alta_insumo (out mensaje varchar(200), out resultado int, in insumo_id int, in descr varchar(45), in precio_ins float)
begin
	if(exists(select * from insumo where id_insumo = insumo_id)) THEN
		set mensaje = "El insumo ya existe";
        set resultado = -1;
	else
		set mensaje = "Insumo cargado exitosamente";
        set resultado = 0;
		insert into insumo(id_insumo, descripcion, precio)
				values(insumo_id, descr, precio_ins);
	end if;
end;	$$

delimiter $$
CREATE PROCEDURE baja_insumo(out mensaje varchar(200), out resultado int, in insumo_id int)
begin
	if(exists(select * from insumo where id_insumo = insumo_id)) THEN
		set mensaje = "Insumo borrado exitosamente";
        set resultado = 0;
		delete from insumo
        where id_insumo = insumo_id;
	else 
		set mensaje = "Insumo no encontrado";
        set resultado = -1;
	end if;
end	$$
delimiter;


delimiter $$
CREATE PROCEDURE modificar_insumo(out mensaje varchar(200), out resultado int, in insumo_id int, in descr varchar(45), in precio_ins float)
begin
	if(exists(select * from insumo where id_insumo = insumo_id)) THEN
		set mensaje = "Insumo modificado exitosamente";
        set resultado = 0;
		update insumo
        set descripcion = descr, precio = precio_ins
        where id_insumo = insumo_id;
	else 
		set mensaje = "El insumo no fue encontrado";
        set resultado = -1;
	end if;
end;	$$

/*-------------------------------------------------------------------------------------------------------*/
/*Creacion de procedimientos ABM de la tabla PROVEEDOR*/

delimiter $$
CREATE PROCEDURE alta_proveedor(out mensaje varchar(200), out resultado int, in proveedor_id int, in descr varchar(45), in contacto_prov varchar(45))
begin
	if(exists(select * from proveedor where id_proveedor = proveedor_id)) THEN
		set mensaje = "El proveedor ya existe";
        set resultado = -1;
	else
		set mensaje = "El proveedor fue cargado correctamente";
        set resultado = 0;
		insert into proveedor(id_proveedor, descripcion, contacto)
				values(proveedor_id, descr, contacto_prov);
	end if;
end;	$$

delimiter $$
CREATE PROCEDURE baja_proveedor(out mensaje varchar(200), out resultado int, in proveedor_id int)
begin
	if(exists(select * from proveedor where id_proveedor = proveedor_id)) THEN
		set mensaje = "Proveedor borrado exitosamente";
		set resultado = 0;
		delete from proveedor
        where id_proveedor = proveedor_id;
	else
		set mensaje = "Proveedor no encontrado";
        set resultado = -1;
	end if;
end;	$$

delimiter $$
CREATE PROCEDURE modificar_proveedor(out mensaje varchar(200), out resultado int, in proveedor_id int, in descr varchar(45), in contacto_prov varchar(45))
begin
	if(exists(select * from proveedor where id_proveedor = proveedor_id)) THEN
		set mensaje = "Proveedor modificado correctamente";
        set resultado = 0;
		update proveedor
        set descripcion = descr, contacto = contacto_prov
        where id_proveedor = proveedor_id;
	else
		set mensaje = "Proveedor no encontrado";
        set resultado = -1;
	end if;
end;	$$

/*-------------------------------------------------------------------------------------------------------*/
/*Creacion de procedimientos ABM de la tabla INSUMO_PROVEEDOR*/

delimiter $$
CREATE PROCEDURE alta_insumo_proveedor(out mensaje varchar(200), out resultado int, in ins_prov_id int, in cant int, in id_insumo_i int, in id_proveedor_p int)
begin
	if(exists(select * from insumo_proveedor where id_insumo_proveedor = ins_prov_id)) THEN
		set mensaje= "El insumo_proveedor ya existe";
        set resultado = -1;
	else
		set mensaje = "El insumo_proveedor fue cargado exitosamente";
        set resultado = 0;
		insert into insumo_proveedor(id_insumo_proveedor, cantidad, insumo_id, proveedor_id)
				values(ins_prov_id, cant, id_insumo_i, id_proveedor_p);
	end if;
end;	$$

delimiter $$
CREATE PROCEDURE baja_insumo_proveedor(out mensaje varchar(200), out resultado int, in insumo_proveedor_id int)
begin
	if(exists(select * from insumo_proveedor where id_insumo_proveedor = insumo_proveedor_id)) THEN
		set mensaje = "El insumo_proveedor fue eliminado correctamente";
        set resultado = 0;
		delete from insumo_proveedor
        where id_insumo_proveedor = insumo_proveedor_id;
	else
		set mensaje = "El insumo_proveedor no se encontro";
        set resultado = -1;
	end if;
end;	$$

delimiter $$
CREATE PROCEDURE modificar_insumo_proveedor(out mensaje varchar(200), out resultado int, in ins_prov_id int, in cant int, in id_insumo_i int, in id_proveedor_p int)
begin
	if(exists(select * from insumo_proveedor where id_insumo_proveedor = ins_prov_id)) THEN
		set mensaje = "Insumo_proveedor modificado correctamente";
        set resultado = 0;
        update insumo_proveedor
        set cantidad=cant, insumo_id=id_insumo_i, proveedor_id=id_proveedor_p
        where id_insumo_proveedor = ins_prov_id;
	else
		set mensaje = "El insumo_proveedor no se ha encontrado";
        set resultado = -1;
	end if;
end;	$$

