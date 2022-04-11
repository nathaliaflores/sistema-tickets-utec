/* ============================== */
-- CONVENCIONES DE BASE DE DATOS
/* ============================== */

/*
	
Propuesta de convenciones base de datos

- Manejar solo minusculas
- Toda tabla debe de tener un nombre en singular
- Si una tabla tiene nombre largo, separar con guion bajo
- Todas las primary keys deben de respetar las siguientes reglas:
	Para la PK:
		- id_<nombre_de_la_tabla en singular>
        - si el nombre de la pk se ve muy larga, poner unicamente las 
          primeras 3 letras de cada palabra que compone el nombre, ejemplo:
          si tuviera una tabla llamada: ubicacion_unidad
          podemos crear un id: id_ubi_uni
- Todas las foreign keys deben de respetar el siguiente patron:
	fk_<3 letras de la tabla hija>_<3 letras de la tabla padre>
	Ejemplo: fk_ubi_uni
- Todos los procedimientos almacenados deben comenzar con las letras "sp"
	Ejemplo: sp_guardar_orden_de_trabajo();
*/

/* ============================== */
-- CREACION DE BASE DE DATOS
/* ============================== */

drop database if exists sistema_tickets;
create database sistema_tickets;
go

use sistema_tickets;
go

/* ============================== */
-- CREACION DE TABLAS
/* ============================== */

/* --------------------------------
Tabla: rol
-------------------------------- */

/*

- Para que sirve?
	Tabla catalogo que alamacenara todos 
    los roles dentro del sistema de tickets:
		- Administrador
        - Supervisor
        - Solicitante
		- RecepcionObraMtto
		- RecepcionObraSol

- Como se ira llenando?
	Tendra un mantenimiento

*/

drop table if exists rol;
create table rol (
	id_rol int primary key identity(1,1),
    nombre varchar(100) not null,
	activo char(1) default 'S',
	id_usuario_mod int default 1,
	fecha_mod datetime default getdate()
);

/* --------------------------------
Tabla: unidad
-------------------------------- */

/*

- Para que sirve?
	En esta tabla se almacenaran los nombres 
    de todas las unidades que solicitaran 
    servicios dentro del sistema de tickets.

- Como se ira llenando?
	Tendra un mantenimiento

*/

drop table if exists unidad;
create table unidad (
	id_unidad int primary key identity(1,1),
    nombre varchar(100) not null,
	activo char(1) default 'S',
	id_usuario_mod int default 1,
	fecha_mod datetime default getdate()
);

/* --------------------------------
Tabla: usuario
-------------------------------- */

/*

- Para que sirve?
	En esta tabla se almacenaran todos los 
	usuarios que solicitaran servicios 
    dentro del sistema de tickets.

- Como se ira llenando?
	Cada vez que un empleado cree una cuenta
    dentro del sistema de tickets.
    
    El formulario de creacion de cuenta le pedira:
		- que cree un usuario
        - que elija la unidad a la que el pertenece

*/

drop table if exists usuario;
create table usuario (
	id_usuario int primary key identity(1,1),
	usuario varchar(100) not null,
    password varchar(200) not null,
    nombres varchar(100) not null,
    apellidos varchar(100) not null,
    cargo varchar(100) not null,
	correo varchar(100) not null,
    telefono char(8) not null,
    id_unidad int not null,
	activo char(1) default 'S',
	id_usuario_mod int default 1,
	fecha_mod datetime default getdate(),
    constraint fk_usu_uni foreign key (id_unidad) references unidad (id_unidad)
);

/* --------------------------------
Tabla: rol_usuario
-------------------------------- */

/*

- Para que sirve?
	Tabla intermedia que sirve para definir
	multiples roles a los usuarios 
	dentro del sistema de tickets.

- Como se ira llenando?
	Tendra un mantenimiento

*/

drop table if exists rol_usuario;
create table rol_usuario (
	id_rol_usu int primary key identity(1,1),
    id_rol int not null,
	id_usuario int not null,
	constraint fk_rus_rol foreign key (id_rol) references rol (id_rol),
	constraint fk_rus_usu foreign key (id_usuario) references usuario (id_usuario)
);

/* --------------------------------
Tabla: ubicacion
-------------------------------- */

/*

- Para que sirve?
	En esta tabla se almacenaran todas las 
	direcciones de casas y edificios dentro 
    del campus de la UTEC que solicitaran
    servicios dentro del sistema de tickets.

- Como se ira llenando?
	Tendra un mantenimiento

*/

drop table if exists ubicacion;
create table ubicacion (
	id_ubicacion int primary key identity(1,1),
    nombre varchar(100) not null,
	activo char(1) default 'S',
	id_usuario_mod int default 1,
	fecha_mod datetime default getdate()
);

/* --------------------------------
Tabla: tipo_servicio
-------------------------------- */

/*

- Para que sirve?
	En esta tabla se almacenaran todos los tipos de servicios 
    disponibles dentro del sistema de tickets:
		- Servicio interno
        - Servicio externo (Maestrias, Ctos, Insc)
		- Otros servicios (cuando se elija esta opcion, se habilitara el campo: "especifique")
        
- Como se ira llenando?
	Tendra un mantenimiento

*/

drop table if exists tipo_servicio;
create table tipo_servicio (
	id_tip_ser int primary key identity(1,1),
    nombre varchar(100) not null,
	activo char(1) default 'S',
	id_usuario_mod int default 1,
	fecha_mod datetime default getdate()
);

/* --------------------------------
Tabla: areas_servicios
-------------------------------- */

/*

- Para que sirve?
	En esta tabla se almacenaran todas las areas de servicios 
    disponibles dentro del sistema de tickets:
		- Obra civil
        - Mecanica de obra
        - Pintura
        - etc...
        
- Como se ira llenando?
	Tendra un mantenimiento

*/

drop table if exists area_servicio;
create table area_servicio (
	id_are_ser int primary key identity(1,1),
    nombre varchar(100) not null,
	activo char(1) default 'S',
	id_usuario_mod int default 1,
	fecha_mod datetime default getdate()
);

/* --------------------------------
Tabla: prioridad
-------------------------------- */

/*

- Para que sirve?
	En esta tabla se almacenara todas las prioridades
    que puede tener una orden de trabajo 
    dentro del sistema de tickets:
		- Baja
        - Media
        - Alta
        
- Como se ira llenando?
	Tendra un mantenimiento

*/

drop table if exists prioridad;
create table prioridad(
	id_prioridad int primary key identity(1,1),
    nombre varchar(50),
	activo char(1) default 'S',
	id_usuario_mod int default 1,
	fecha_mod datetime default getdate()
);

/* --------------------------------
Tabla: forma_contacto
-------------------------------- */

/*

- Para que sirve?
	En esta tabla se almacenara todas las formas de contacto
    donde se pueda notificar el avance de cada orden de trabajo 
		- Correo
        - Whatsapp
		- Llamada
        
- Como se ira llenando?
	tendra un mantenimiento

*/

drop table if exists forma_contacto;
create table forma_contacto(
	id_for_con int primary key identity(1,1),
	nombre varchar(100),
	activo char(1) default 'S',
	id_usuario_mod int default 1,
	fecha_mod datetime default getdate()
);

/* --------------------------------
Tabla: orden_trabajo
-------------------------------- */

/*

- Para que sirve?
	Esta es una de las tablas mas transaccionales del sistema.
	En esta tabla se almacenaran la info principal de todas
    las ordenes de trabajo solicitadas dentro del sistema de tickets:
        
- Como se ira llenando?
	Mediante el proceso de creacion de tickets

*/

drop table if exists orden_trabajo;
create table orden_trabajo(
	id_ord_tra int primary key identity(1,1),
	id_ubicacion int not null,
    id_tip_ser int not null,
    id_are_ser int not null,
    id_prioridad int not null,
	id_for_con int not null,
	des_ser_sol text, -- Descripcion del servicio solicitado
    des_ser_asi text, -- Descripcion del servicio asignado
	req_vobo_vice varchar(50), -- 
    material_sol text,
    compra_material bit,
    existencia bit,
    monto_material decimal(10,2),
    partida_presup varchar(100),
	constraint fk_otr_ubi foreign key (id_ubicacion) references ubicacion (id_ubicacion),
    constraint fk_otr_tse foreign key (id_tip_ser) references tipo_servicio (id_tip_ser),
    constraint fk_otr_ase foreign key (id_are_ser) references area_servicio (id_are_ser),
    constraint fk_otr_pri foreign key (id_prioridad) references prioridad (id_prioridad),
	constraint fk_otr_fco foreign key (id_for_con) references forma_contacto (id_for_con)
);

/* --------------------------------
Tabla: orden_usuario
-------------------------------- */

/*

- Para que sirve?
	Esta es una tabla intermedia.
	En esta tabla se almacenaran todos los usuarios que esten relacionados
	a cualquier orden de trabajo solicitada dentro del sistema de tickets:
        
- Como se ira llenando?
	Mediante el proceso de creacion de tickets

*/

drop table if exists orden_usuario;
create table orden_usuario(
	id_ord_usu int primary key identity(1,1),
	id_rol_usu int not null,
	id_ord_tra int not null,
	constraint fk_ous_rus foreign key (id_rol_usu) references rol_usuario (id_rol_usu),
	constraint fk_ous_otr foreign key (id_ord_tra) references orden_trabajo (id_ord_tra)
);

/* --------------------------------
Tabla: estado
-------------------------------- */

/*

- Para que sirve?
	En esta tabla se almacenara todos los tipos de estados
    que puede tener una orden de trabajo 
    dentro del sistema de tickets:
		- 1- Abierta
        - 2- Asignada
		- 3- Compra de Materiales
		- 4- En proceso
        - 5- Cerrada
        
- Como se ira llenando?
	tendra un mantenimiento

*/

drop table if exists estado;
create table estado(
	id_estado int primary key identity(1,1),
    nombre varchar(50),
	activo char(1) default 'S',
	id_usuario_mod int default 1,
	fecha_mod datetime default getdate()
);

/* --------------------------------
Tabla: bitacora_orden_trabajo
-------------------------------- */

/*

- Para que sirve?
	En esta tabla se almacenaran la info detalle de los 
    tiempos que tarda una orden de trabajo de pasar de un estado a otro.
        
- Como se ira llenando?
	Mediante el proceso de creacion de tickets

*/

drop table if exists bitacora_orden_trabajo;
create table bitacora_orden_trabajo (
	id_bit_ord_tra int primary key identity(1,1),
    id_ord_tra int not null,
    id_estado int not null,
    fecha_hora datetime,
    comentarios text,
    constraint fk_bot_otr foreign key (id_ord_tra) references orden_trabajo (id_ord_tra),
    constraint fk_bot_est foreign key (id_estado) references estado (id_estado)
);

/*
	id_bit		|	id_ord_tra	|	id_estado		|	fecha					|	comentarios
	------------------------------------------------------------------------------------------------------------
	1			|	120			|	1 (abierta)		|	23-03-2022 10:00 am		|	lo pidio la casa 20
	2			|	120			|	2 (asignad)		|	23-03-2022 02:00 pm		|	se asigna a don pedrito
	3			|	120			|	3 (material)	|	25-03-2022 08:00 am		|	se compro material
	4			|	120			|	4 (proceso)		|	25-03-2022 09:00 am		|	se comienza a trabajar
	5			|	120			|	5 (cerrada)		|	27-03-2022 03:00 pm		|	se termina el trabajo
	6			|	121			|	1 (abierta)		|	28-03-2022 09:00 am		|	lo pidio la casa 25
	7			|	122			|	1 (abierta)		|	28-03-2022 09:30 am		|	lo pidio la casa 26
*/