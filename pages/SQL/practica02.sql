
-- BORRAR COSAS
--drop database p2;
--ALTER TABLE p2.linea_pedido DROP FOREIGN KEY fk5;


-- =====================================================================
-- ---------------------------- INICIO ---------------------------------
-- =====================================================================

create database p2;

create table p2.clientes (
    dni varchar(9) primary key,
    nombre varchar(15) not null,
    apellido1 varchar(15) not null,
    apellido2 varchar(15),
    tipo_via varchar(4),
    nombre_via varchar(30),
    numero varchar(3),
    fecha DATE
);

create table p2.vendedores (
    dni varchar(9) primary key,
    nombre varchar(15) not null,
    apellido1 varchar(15) not null,
    apellido2 varchar(15),
    tipo_via varchar(4),
    nombre_via varchar(30),
    numero varchar(3),
    fecha DATE
);

create table p2.proveedores (
    dni varchar(9) primary key,
    nombre varchar(15) not null,
    apellido1 varchar(15) not null,
    apellido2 varchar(15),
    tipo_via varchar(4),
    nombre_via varchar(30),
    numero varchar(3),
    telefono varchar(9)
);

create table p2.ventas (
    cod_venta varchar(20) primary key,
    fecha_venta date,
    factura varchar(20),
    cliente varchar(9),
    vendedor varchar(9) 
);

create table p2.linea_venta (
    venta varchar(20),
    linea varchar(10),
    cantidad TINYINT,
    precio float(4,2),
    articulo varchar(20),
    constraint pk primary key (venta, linea)
);

create table p2.electrodomesticos (
    referencia varchar(20) primary key,
    marca varchar(15) not null,
    modelo varchar (20) not null,
    precio float (4,2),
    constraint uk unique (marca, modelo)
);

create table p2.linea_pedido (
    pedido varchar(20),
    linea varchar(10),
    cantidad tinyint,
    articulo varchar(20),
    constraint pk primary key (pedido, linea)
);

create table p2.pedidos (
    cod_pedido varchar(20) primary key,
    fecha date,
    factura varchar(20),
    proveedor varchar(9)
);

alter table p2.ventas add constraint fk1 FOREIGN KEY (cliente) references p2.clientes (dni);

alter table p2.ventas add constraint fk2 foreign key (vendedor) references p2.vendedores (dni);

alter table p2.linea_venta add constraint fk3 foreign key (venta) references p2.ventas (cod_venta);

alter table p2.linea_venta add constraint fk4 foreign key (articulo) references p2.electrodomesticos (referencia);

alter table p2.linea_pedido add constraint fk5 foreign key (articulo) references p2.electrodomesticos (referencia);

alter table p2.linea_pedido add constraint fk6 foreign key (pedido) references p2.pedidos (cod_pedido);

alter table p2.pedidos add constraint fk7 foreign key (proveedor) references p2.proveedores (dni);

alter table p2.linea_venta add check (cantidad > 1);

alter table  p2.linea_pedido add check (cantidad > 1);

alter table p2.clientes modify tipo_via ENUM ('CL', 'AVDA', 'PLZ', 'CTRA');

alter table p2.proveedores modify tipo_via ENUM ('CL', 'AVDA','PLZ', 'CTRA');

alter table p2.vendedores modify tipo_via ENUM ('CL', 'AVDA','PLZ', 'CTRA');

alter table  p2.electrodomesticos add check (precio > 1);

alter table p2.linea_venta rename to p2.lineaventa;

alter table p2.linea_pedido rename to p2.lineapedido;







