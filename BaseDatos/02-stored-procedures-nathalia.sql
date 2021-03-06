use sistema_tickets;

go

/* --------------------------------
Mantenimiento: roles
-------------------------------- */

-- sp_obtener_roles

create or alter procedure sp_obtener_roles
as
begin
	select 
		*
	from
		rol
	;
end;

go

-- sp_obtener_rol_por_id

create or alter procedure sp_obtener_rol_por_id(
	@id_rol int
)
as
begin
	select 
		*
	from
		rol
	where 
		1 = 1
		and id_rol = @id_rol
	;
end;

go

-- sp_registrar_rol

create or alter procedure sp_registrar_rol(
	@nombre varchar(100),
	@id_usuario_mod int
)
as
begin
	insert into rol
		(nombre, id_usuario_mod)
	values
		(@nombre, @id_usuario_mod)
	;
end;

go

-- sp_modificar_rol

create or alter procedure sp_modificar_rol(
	@id_rol int,
	@nombre varchar(100),
	@activo char(1),
	@id_usuario_mod int
)
as 
begin
	update 
		rol
	set
		nombre = @nombre,
		activo = @activo,
		id_usuario_mod = @id_usuario_mod,
		fecha_mod = getdate()
	where 
		1 = 1
		and id_rol = @id_rol
	;
end;

go 

-- sp_act_ina_rol

create or alter procedure sp_act_ina_rol(
	@id_rol int
)
as 
begin	
	declare @activo_actual char(1);
	declare @activo_nuevo char(1);
	
	select 
		@activo_actual = activo 
	from 
		rol
	where 
		1 = 1
		and id_rol = @id_rol;
	
	if (@activo_actual = 'S') begin
		set @activo_nuevo = 'N';
	end
	else begin 
		set @activo_nuevo = 'S';
	end ;
	
	update 
		rol
	set
		activo = @activo_nuevo
	where 
		1 = 1
		and id_rol = @id_rol
	;
end;

go

/* --------------------------------
LoginDao
-------------------------------- */

-- sp_obtener_usuario_login

create or alter procedure sp_obtener_usuario_login(
	@usuario varchar(100),
	@password varchar(200)
)
as
begin
	select 
		usu.id_usuario,
		usu.usuario,
		usu.nombres,
		usu.apellidos,
		rol.nombre as rol
	from
		usuario usu 
		join rol_usuario rus
			on usu.id_usuario = rus.id_usuario
		join rol rol 
			on rus.id_rol = rol.id_rol
	where 
		1 = 1
		and usu.usuario = @usuario
		and password = @password
	;
end;

go

exec sp_obtener_usuario_login 'admin', 'admin';