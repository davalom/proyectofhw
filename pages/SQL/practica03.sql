
--BORRAR COSAS
--drop database p3;

-- =====================================================================
-- ---------------------------- INICIO ---------------------------------
-- =====================================================================

create database p3;

create table p3.alumnado (
    codigo int AUTO_INCREMENT primary key,
    IBAN varchar(10) not null,
    nombre varchar(15) not null,
    apellido1 varchar(15) not null,
    apellido2 varchar(15),
    tipo_via varchar(4),
    nombre_via varchar(30),
    num_via varchar(3),
    cod_postal varchar(5)
);

create table p3.profesorado (
    dni varchar(9) primary key,
    nombre varchar(15) not null,
    apellido1 varchar(15) not null,
    apellido2 varchar(15),
    tipo_via varchar(4),
    nombre_via varchar(30),
    num_via varchar(3),
    cod_postal varchar(5),
    check (dni REGEXP '/\d{8}-?(?:(?![OIU])\w)/i')
);

create table p3.permisos (
    codigo varchar(10) primary key,
    tipo_vehiculo varchar(10),
    precio float(7,2)
);

create table p3.vehiculos (
    matricula varchar(8) primary key,
    anio_matricula smallint,
    anio_compra smallint,
    tipo varchar(10),
    marca varchar(10),
    modelo varchar(10),
    check (matricula REGEXP '/\d{4}[ -]?[BCDFGHJKLMNPRSTVWXYZ]{3}/i')
);

create table p3.clases (
    fecha date,
    hora time,
    alumno int,
    importe float(3,2) default ('28.5'),
    fecha_pago date,
    forma_pago varchar(10),
    vehiculo varchar(8) not null,
    permiso varchar(10) not null,
    profesor varchar(9) not NULL,
    constraint pk primary key (fecha, hora, alumno)
);

create table p3.alumnado_ext (
    alumno int,
    convocatoria varchar(15),
    nota float(2,2),
    constraint pk primary key (alumno, convocatoria),
    check (convocatoria REGEXP '/T(0[1-9]|12[0-9]|3[01])-(0[1-9]|1[12])-(\d{4})-(\w{2})/i')
);

create table p3.alumnado_exp (
    alumno int,
    convocatoria varchar(15),
    nota float(2,2),
    constraint pk primary key (alumno, convocatoria),
    check (convocatoria REGEXP '/P(0[1-9]|12[0-9]|3[01])-(0[1-9]|1[12])-(\d{4})-(\w{2})/i')
);

create table p3.examenes_p (
    cod_convocatoria varchar(15) primary key,
    fecha date,
    hora time,
    lugar varchar(15),
    examinador varchar(15),
    check (cod_convocatoria REGEXP '/P(0[1-9]|12[0-9]|3[01])-(0[1-9]|1[12])-(\d{4})-(\w{2})/i')
);

create table p3.examen_t (
    cod_convocatoria varchar(15) primary key,
    fecha date,
    hora time,
    lugar varchar(15),
    check (cod_convocatoria REGEXP '/T(0[1-9]|12[0-9]|3[01])-(0[1-9]|1[12])-(\d{4})-(\w{2})/i')
);

alter table p3.alumnado_exp add constraint fk1 foreign key (convocatoria) references p3.examenes_p(cod_convocatoria);

alter table p3.alumnado_ext add constraint fk2 foreign key (convocatoria) references p3.examen_t(cod_convocatoria);

alter table p3.alumnado_ext add constraint fk3 foreign key (alumno) references p3.alumnado(codigo);

alter table p3.alumnado_exp add constraint fk4 foreign key (alumno) references p3.alumnado(codigo);

alter table p3.clases add constraint fk5 foreign key (alumno) references p3.alumnado(codigo);

alter table p3.clases add constraint fk6 foreign key (vehiculo) references p3.vehiculos(matricula);

alter table p3.clases add constraint fk7 foreign key (permiso) references p3.permisos(codigo);

alter table p3.clases add constraint fk8 foreign key (profesor) references p3.profesorado(dni);

ALTER TABLE p3.alumnado_exp modify nota ENUM ('APTO', 'NO APTO');

ALTER TABLE p3.alumnado_ext modify nota ENUM ('APTO', 'NO APTO');

ALTER TABLE p3.clases add check (importe > 0);

