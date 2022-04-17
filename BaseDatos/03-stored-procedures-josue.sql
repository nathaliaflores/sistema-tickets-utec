use sistema_tickets;

go

/* --------------------------------
Mantenimiento: estado
-------------------------------- */

-- sp_obtener_estados

create or alter procedure sp_obtener_estados
as
begin
	select 
		*
	from
		estado
	;
end;

go

-- sp_obtener_estado_por_id

create or alter procedure sp_obtener_estado_por_id(
	@id_estado int
)
as
begin
	select 
		*
	from
		estado
	where 
		activo = 1
		and id_estado = @id_estado
	;
end;

go

-- sp_registrar_estado

create or alter procedure sp_registrar_estado(
	@nombre varchar(100),
	@id_usuario_mod int
)
as
begin
	insert into estado
		(nombre, id_usuario_mod)
	values
		(@nombre, @id_usuario_mod)
	;
end;

go

-- sp_modificar_estado

create or alter procedure sp_modificar_estado(
	@id_estado int,
	@nombre varchar(100),
	@activo char(1),
	@id_usuario_mod int    
)
as 
begin
	update 
		estado
	set
		nombre = @nombre,
		activo = @activo,
		id_usuario_mod = @id_usuario_mod,
		fecha_mod = getdate()
	where 
		 id_estado = @id_estado
	;
end;

go 

-- sp_act_ina_estado

create or alter procedure sp_act_ina_estado(
	@id_estado int
)
as 
begin	
	declare @activo_actual char(1);
	declare @activo_nuevo char(1);
	
	select 
		@activo_actual = activo 
	from 
		estado
	where 
		1 = 1
		and id_estado = @id_estado;
	
	if (@activo_actual = 'S') begin
		set @activo_nuevo = 'N';
	end
	else begin 
		set @activo_nuevo = 'S';
	end ;
	
	update 
		estado
	set
		activo = @activo_nuevo
	where 
		1 = 1
		and id_estado = @id_estado
	;
end;

go

/* --------------------------------
Mantenimiento: Ubicacion
-------------------------------- */

-- sp_obtener_ubicacion

create or alter procedure sp_obtener_ubicacion
as
begin
	select 
		*
	from
		ubicacion
	;
end;

go

-- sp_obtener_ubicacion_por_id

create or alter procedure sp_obtener_ubicacion_por_id(
	@id_ubicacion int
)
as
begin
	select 
		*
	from
		ubicacion
	where 
		activo = 1
		and id_ubicacion = @id_ubicacion
	;
end;

go

-- sp_registrar_ubicacion

create or alter procedure sp_registrar_ubicacion(
	@nombre varchar(100),
	@id_usuario_mod int
)
as
begin
	insert into ubicacion
		(nombre, id_usuario_mod)
	values
		(@nombre, @id_usuario_mod)
	;
end;

go

-- sp_modificar_ubicacion

create or alter procedure sp_modificar_ubicacion(
	@id_ubicacion int,
	@nombre varchar(100),
	@activo char(1),
	@id_usuario_mod int    
)
as 
begin
	update 
		ubicacion
	set
		nombre = @nombre,
		activo = @activo,
		id_usuario_mod = @id_usuario_mod,
		fecha_mod = getdate()
	where 
		 id_ubicacion = @id_ubicacion
	;
end;

go 

--sp_act_ina_ubicacion

create or alter procedure sp_act_ina_ubicacion(
	@id_ubicacion int
)
as 
begin	
	declare @activo_actual char(1);
	declare @activo_nuevo char(1);
	
	select 
		@activo_actual = activo 
	from 
		ubicacion
	where 
		1 = 1
		and id_ubicacion = @id_ubicacion;
	
	if (@activo_actual = 'S') begin
		set @activo_nuevo = 'N';
	end
	else begin 
		set @activo_nuevo = 'S';
	end ;
	
	update 
		ubicacion
	set
		activo = @activo_nuevo
	where 
		1 = 1
		and id_ubicacion = @id_ubicacion
	;
end;

go

/* --------------------------------
Mantenimiento: tipo_servicio
-------------------------------- */

-- sp_obtener_tipo_servicio

create or alter procedure sp_obtener_tipo_servicio
as
begin
	select 
		*
	from
		tipo_servicio
	;
end;

go

-- sp_obtener_tipo_servicio

create or alter procedure sp_obtener_tipo_servicio(
	@id_tip_ser int
)
as
begin
	select 
		*
	from
		tipo_servicio
	where 
		activo = 1
		and id_tip_ser = @id_tip_ser
	;
end;

go

-- sp_registrar_tipo_servicio

create or alter procedure sp_registrar_tipo_servicio(
	@nombre varchar(100),
	@id_usuario_mod int
)
as
begin
	insert into tipo_servicio
		(nombre, id_usuario_mod)
	values
		(@nombre, @id_usuario_mod)
	;
end;

go

-- sp_modificar_tipo_servicio

create or alter procedure sp_modificar_tipo_servicio(
	@id_tip_ser int,
	@nombre varchar(100),
	@activo char(1),
	@id_usuario_mod int    
)
as 
begin
	update 
		tipo_servicio
	set
		nombre = @nombre,
		activo = @activo,
		id_usuario_mod = @id_usuario_mod,
		fecha_mod = getdate()
	where 
		 id_tip_ser = @id_tip_ser
	;
end;

go 

--sp_act_ina_tipo_servicio
create or alter procedure sp_act_ina_tipo_servicio(
	@id_tip_ser int
)
as 
begin	
	declare @activo_actual char(1);
	declare @activo_nuevo char(1);
	
	select 
		@activo_actual = activo 
	from 
		tipo_servicio
	where 
		1 = 1
		and id_tip_ser = @id_tip_ser;
	
	if (@activo_actual = 'S') begin
		set @activo_nuevo = 'N';
	end
	else begin 
		set @activo_nuevo = 'S';
	end ;
	
	update 
		tipo_servicio
	set
		activo = @activo_nuevo
	where 
		1 = 1
		and id_tip_ser = @id_tip_ser
	;
end;

go
