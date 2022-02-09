-- varchar binary -> ordena las mayúsculas antes que las minúsculas

-- AUTOINCREMENTOS Y VALORES POR DEFECTO
create table prueba (
	clave int primary key AUTO_INCREMENT,
	precio float (4,2) default (20.10)
);

--Hacer que el autoincremento empiece en 10
alter table prueba AUTO_INCREMENT=10;

--Crear indice
CREATE INDEX apellido1doc ON docentes (apellido1);

-- Ejercicio 1
-- CREAR BASE DE DATOS -----------------
CREATE DATABASE quimica;

-- CREAR TABLAS ------------------------
CREATE TABLE COMPUESTOS (
  	nombre VARCHAR (15) PRIMARY KEY,
	densidad FLOAT (5,2),
  	polaridad VARCHAR(6),
  	puntofusion FLOAT(5,2),
 	puntoebullicion FLOAT(5,2)
  );
  
CREATE TABLE ELEMENTOS (
	simbolo VARCHAR(2) PRIMARY KEY,
  	nombre VARCHAR (15) UNIQUE NOT NULL,
	pesoatomico  FLOAT(5,2),
  	numatomico INT(6)
  );

-- BORAR TABLAS ------------------------
DROP TABLE COMPUESTOS;
DROP TABLE ELEMENTOS;

-- CREAR TABLAS CON REFERENCIAS --------
CREATE TABLE enlaces (
	compuesto VARCHAR (10),
	elemento VARCHAR (2),
	n_atomos SMALLINT,
	CONSTRAINT pk PRIMARY KEY (compuesto, elemento),
	CONSTRAINT fk1 FOREIGN KEY (compuesto) REFERENCES COMPUESTOS (nombre),
	CONSTRAINT fk2 FOREIGN KEY (elemento) REFERENCES ELEMENTOS (simbolo)
);

-- MODIFICAR TABLAS --------------------
ALTER TABLE quimica.enlaces DROP FOREIGN KEY fk1;
ALTER TABLE quimica.enlaces DROP FOREIGN KEY fk2;
ALTER TABLE quimica.enlaces DROP PRIMARY KEY;

-- AÑADIR RELACIONES A TABLAS -----------
ALTER TABLE enlaces ADD CONSTRAINT fk1 FOREIGN KEY (compuesto) REFERENCES compuestos(nombre);
ALTER TABLE compuestos ADD COLUMN solubilidad FLOAT (3,2) NULL;
ALTER TABLE compuestos MODIFY COLUMN solubilidad FLOAT (3,2) NULL;

-- RENOMBRAR TABLA ----------------------
ALTER TABLE compuestos RENAME TO compuesto;

-- AÑADIR RESTRICCIONES A VALORES
-- Elegir valores de la lista
ALTER TABLE quimica.compuestos modify polaridad set ('polar', 'no polar');

-- Opcion 2
ALTER TABLE quimica.enlaces add check (n_atomos>0);

-- Añadir datos
insert into compuestos(densidad, nombre, polaridad, puntoebullicion, puntofusion, solubilidad) VALUES (10, 'H2O','polaridad',12, 11, 18);

insert into elementos( nombre, numatomico, pesoatomico, simbolo) VALUES ('a', 10, 'e', 'H');

-- Elegir un único valor de la lista
ALTER TABLE quimica.compuestos modify polaridad ENUM ('polar', 'no polar');

-- hacer que la pareja de valores sea única
alter table compuestos add constraint ukcompuestos unique (puntoebullicion, puntofusion);

-- COMENTARIO
-- =========================================================================================
-- Ejercicio 2

CREATE DATABASE colegio;

CREATE TABLE DOCENTES (
	n_reg VARCHAR (10) PRIMARY KEY,
	dni	VARCHAR (9) UNIQUE NOT NULL,
	nombre VARCHAR (10) NOT NULL,
	apellido1 VARCHAR (10) NOT NULL,
	apellido2 VARCHAR (10)
);

CREATE TABLE ALUMNOS (
	nie VARCHAR (10) PRIMARY KEY,
	dni	VARCHAR (9) UNIQUE NOT NULL,
	nombre VARCHAR (10) NOT NULL,
	apellido1 VARCHAR (10) NOT NULL,
	apellido2 VARCHAR (10)
);

CREATE TABLE REL (
	docente VARCHAR (10),
	alumno	VARCHAR (10),
	CONSTRAINT pk PRIMARY KEY (docente, alumno),
	CONSTRAINT fk1 FOREIGN KEY (docente) REFERENCES DOCENTES (n_reg),
	CONSTRAINT fk2 FOREIGN KEY (alumno) REFERENCES ALUMNOS (nie)
);

DROP TABLE REL;

CREATE TABLE REL (
	docente VARCHAR (10),
	alumno	VARCHAR (10)
);

-- CREAR RELACIONES ENTRE TABLAS --------------------
ALTER TABLE REL ADD CONSTRAINT pk PRIMARY KEY (docente, alumno);
ALTER TABLE REL ADD CONSTRAINT fk1 FOREIGN KEY (docente) REFERENCES DOCENTES (n_reg);
ALTER TABLE REL ADD CONSTRAINT fk2 FOREIGN KEY (alumno) REFERENCES ALUMNOS (nie);


-- =========================================================================================
-- Ejercicio 3

CREATE DATABASE coches;

CREATE TABLE coches.coches (
	n_bastidor varchar(17) PRIMARY KEY,
	matricula	varchar(10) unique not NULL,
	marca varchar (10),
	modelo varchar (10),
	combustible varchar (10),
	cilindrada varchar (10),
	propietario varchar (10)
);

create table coches.propietarios (
	dni  varchar(9) primary key,
	nombre varchar(10) not null,
	apellido1 varchar(10) not null,
	apellido2 varchar(10),
	tipo_via varchar(10),
	nombre_via varchar(10),
	numero varchar(10),
	bloque varchar(10),
	portal varchar(10),
	piso varchar(10),
	puerta varchar(10)
);

alter table coches.coches add constraint fk FOREIGN key (propietario) references coches.propietarios (dni);


-- =========================================================================================
-- Ejercicio 4

create database viviendas1;

create table viviendas1.propietarios (
	dni varchar(9) primary key,
	nombre varchar(10) not null,
	apellido1 varchar(10) not null,
	apellido2 varchar(10)
);

create table viviendas1.viviendas (
	ref_catastral varchar(15) PRIMARY KEY,
	m_construidos varchar(10),
	m_utilies varchar(10),
	n_banios SMALLINT,
	n_habitaciones SMALLINT
);

CREATE Table viviendas1.rel (
	propietario varchar(9),
	vivienda varchar(15),
	constraint pk PRIMARY key (propietario, vivienda)
);

alter table viviendas1.rel add constraint fk1 FOREIGN key (propietario) references viviendas1.propietarios (dni);
alter table viviendas1.rel add constraint fk2 FOREIGN key (vivienda) references viviendas1.viviendas (ref_catastral);

-- =========================================================================================
-- Ejercicio 5

create database viviendas2;

create table viviendas2.viviendas (
	ref_catastral varchar(15) PRIMARY KEY,
	m_construidos varchar(10),
	m_utilies varchar(10),
	n_banios SMALLINT,
	n_habitaciones SMALLINT
);

create table viviendas2.propietarios (
	dni varchar(9) primary key,
	nombre varchar(10) not null,
	apellido1 varchar(10) not null,
	apellido2 varchar(10)
);

CREATE Table viviendas2.rel (
	propietario varchar(9),
	vivienda varchar(15),
	constraint pk PRIMARY key (propietario, vivienda)
);

alter table viviendas2.rel add constraint fk1 FOREIGN key (propietario) references viviendas1.propietarios (dni);
alter table viviendas2.rel add constraint fk2 FOREIGN key (vivienda) references viviendas1.viviendas (ref_catastral);

CREATE table viviendas2.arrendatarios (
	dni varchar(9) PRIMARY KEY,
	nombre varchar(10) not null,
	apellido1 varchar(10) not null,
	apellido2 varchar(10),
	vivienda varchar(15)
);

drop table viviendas2.arrendatarios;

alter table viviendas2.arrendatarios add constraint fk3 foreign key (vivienda) REFERENCES viviendas2.viviendas (ref_catastral);


-- =========================================================================================
-- Ejercicio 6

create database viviendas3;

create table viviendas3.propietarios (
	dni varchar(9) primary key,
	nombre varchar(10) not null,
	apellido1 varchar(10) not null,
	apellido2 varchar(10)
);

create table viviendas3.viviendas (
	ref_catastral varchar(15) primary key,
	m_construidos varchar(10),
	m_utiles varchar(10),
	n_banos SMALLINT,
	n_habitaciones SMALLINT
);

create table viviendas3.arrendatarios (
	dni varchar(9) primary key,
	nombre varchar(10) not null,
	apellido1 varchar(10) not null,
	apellido2 varchar(10),
	vivienda varchar(15)
);

create table viviendas3.inquilinos (
	dni varchar(9) primary key,
	nombre varchar(10) not null,
	apellido1 varchar(10) not null,
	apellido2 varchar(10),
	arrendatario varchar(9)
);

create table viviendas3.rel_viviendas (
	vivienda varchar(15),
	propietario varchar(9),
	constraint pk primary key (propietario, vivienda)
);

alter table viviendas3.rel_viviendas add constraint fk1 foreign key (vivienda) references viviendas3.viviendas (ref_catastral);

alter table viviendas3.rel_viviendas add constraint fk2 foreign key (propietario) references viviendas3.propietarios (dni);

alter table viviendas3.arrendatarios add constraint fk3 foreign key (vivienda) references viviendas3.viviendas (ref_catastral);

alter table viviendas3.inquilinos add constraint fk4 foreign key (arrendatario) references viviendas3.arrendatarios (dni);

-- =========================================================================================
-- Ejercicio 7

create database natacion;

create table natacion.clubes (
	nombre varchar(10) primary key,
	representante varchar(10)
);

create table natacion.nadadores (
	reg_fed varchar(20) primary key,
	nombre varchar(10) not null,
	apellido1 varchar(10) not null,
	apellido2 varchar(10),
	sexo varchar(10),
	categoria varchar(10),
	nac_day SMALLINT,
	nac_month SMALLINT,
	nac_year SMALLINT,
	club varchar (10) not null
);

create table natacion.pruebas (
	cod_prueba varchar(10) primary key,
	estilo varchar(10),
	distancia SMALLINT,
	categoria VARCHAR(10),
	hora smallint,
	minuto smallint,
	sexo varchar (10)
);

create table natacion.rel (
	nadador varchar(20),
	prueba varchar (10),
	calle varchar(2),
	m_hora smallint,
	m_minuto smallint,
	m_seg smallint,
	m_cent smallint,
	constraint pk primary key (nadador, prueba)
);

alter table natacion.rel add constraint fk1 foreign key (nadador) references natacion.nadadores (reg_fed);

alter table natacion.rel add constraint fk2 foreign key (prueba) references natacion.pruebas (cod_prueba);

alter table natacion.nadadores add constraint fk3 foreign key (club) references natacion.clubles (nombre);

-- =========================================================================================
-- Ejercicio 21

create database transporte;

create table transporte.vehiculos (
	n_bastidor varchar(20) primary key,
	color varchar(10),
	matricula varchar(10) unique not null
);

create table transporte.repostaje (
	fecha date,
	hora time,
	precio_l float(2,2),
	litros smallint,
	vehiculo varchar(20) not null,
	constraint pk primary key (fecha, hora)
);

create table transporte.portes (
	n_porte varchar(10) primary key,
	conductor varchar(9) unique not null
);

create table transporte.denuncias (
	id_multa varchar(15) primary key,
	fecha date,
	importe float(2,2),
	puntos smallint,
	descripcion varchar(200),
	conductor varchar (9) not null
);

create table transporte.conductores (
	dni varchar(9) primary key,
	nombre varchar(10) not null,
	apellido1 varchar(10) not null,
	apellido2 varchar(10),
	fecha_renov date,
	fecha_nac date,
	vehiculo varchar(20)
);

alter table transporte.repostaje add constraint fk1 foreign key (vehiculo) references transporte.vehiculos (n_bastidor);

alter table transporte.conductores add constraint fk2 foreign key (vehiculo) references transporte.vehiculos (n_bastidor);

alter table transporte.portes add constraint fk3 foreign key (conductor) references transporte.conductores (dni);

alter table transporte.denuncias add constraint fk4 foreign key (conductor) references transporte.conductores (dni);

drop database transporte;


-- =========================================================================================
-- Ejercicio 22
