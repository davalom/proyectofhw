create database p1;

create table p1.propietarios (
    dni varchar(9) primary key,
    nombre varchar(15) not null,
    apellido1 varchar(15) not null,
    apellido2 varchar(15)
);

create table p1.viviendas (
    ref_catastral varchar(20) primary key,
    metros smallint,
    estancias tinyint,
    check (metros > 0)
);

create table p1.arrendatario (
    dni varchar(9) primary key,
    nombre varchar(15) not null,
    apellido1 varchar(15) not null,
    apellido2 varchar(15),
    vivienda varchar(20) unique not null
);

create table p1.inquilino (
    dni varchar(9) primary key,
    nombre varchar(15) not null,
    apellido1 varchar(15) not null,
    apellido2 varchar(15),
    arrendatario varchar(9) unique not null
);

create table p1.propiedad (
    dni varchar(9),
    ref_catastral varchar(20),
    constraint pk primary key (dni, ref_catastral)
);

alter table p1.propiedad add constraint fk1 foreign key (dni) references p1.propietarios(dni);
alter table p1.propiedad add constraint fk2 foreign key (ref_catastral) references p1.viviendas(ref_catastral);
alter table p1.arrendatario add constraint fk3 foreign key (vivienda) references p1.viviendas(ref_catastral);
alter table p1.inquilino add constraint fk4 foreign key (arrendatario) references p1.arrendatario(dni);

alter table p1.viviendas
    add column tipo_via varchar(2),
    add column nombre_via varchar(50),
    add column numero varchar(4),
    add column bloque varchar(3),
    add column planta varchar(2),
    add column puerta varchar(2);

alter table p1.viviendas modify tipo_via set ('AV', 'CL', 'CM', 'CT', 'PC');

alter table p1.viviendas add check (estancias > 1);

drop database p1;
