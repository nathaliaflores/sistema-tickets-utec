insert into rol (nombre) values('Administrador');
insert into rol (nombre) values('Solicitante');

insert into unidad(nombre) values('Unidad1');

insert into usuario (usuario, password, nombres, apellidos, cargo, correo, telefono, id_unidad)
values('admin', 'admin', 'Admin', 'Admin', 'Cargo1', 'admin@utec.edu.sv', '25252525',1);

insert into rol_usuario(id_rol, id_usuario) values(1,1);

