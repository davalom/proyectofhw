/*crear una base de datos con los parámetros básicos*/
CREATE DATABASE basededatos;

/*activar la base de datos sobre la que vamos a trabajar*/
USE basededatos;

/******************************************************************************/
/*-----------      CREAR UNA TABLA    ----------------------------------------*/
/******************************************************************************/
/*      clave principal de solo un campo            ***************************/
/*      distintos tipos de datos                    ***************************/
/******************************************************************************/
CREATE TABLE tabla1(
    clave VARCHAR(15) PRIMARY KEY,
    campo1 FLOAT(5,2),
    campo2 VARCHAR(6),
    campo3 INT,
    campo4 BLOB
    );
    
    CREATE TABLE tabla2(
    clave INT PRIMARY KEY,
    campo1 FLOAT(5,2),
    campo2 VARCHAR(6),
    campo3 TINYTEXT,
    campo4 ENUM('valor1', 'valor2', 'valor3')
    );
    
    
    
/******************************************************************************/
/*-----------------      CREAR   UNA TABLA     -------------------------------*/
/*-----------------         SI NO EXISTE       -------------------------------*/
/******************************************************************************/
/*      clave principal de varios campos            --------------------------*/
/*      clave foránea en la creación                --------------------------*/
/******************************************************************************/


CREATE TABLE IF NOT EXISTS tabla3 (
    clave1 VARCHAR(15),
    clave2 VARCHAR(2),
    campo1 VARCHAR(15),
    campo2 INT,
    campo3 SMALLINT,
    CONSTRAINT pk PRIMARY KEY (clave1,clave2),
    CONSTRAINT fk1 FOREIGN KEY(campo1) REFERENCES tabla1(clave)
    );


/******************************************************************************/
/*--------      CREAR CLAVE FORÁNEA EN UNA TABLA YA CREADA      --------------*/
/******************************************************************************/

ALTER TABLE tabla3 ADD CONSTRAINT fk2 FOREIGN KEY(campo2) REFERENCES tabla2(clave) ON DELETE SET NULL ON UPDATE CASCADE;

/******************************************************************************/
/*------------      MODIFICAR LA ESTRUCTURA DE UNA TABLA    ------------------*/
/******************************************************************************/

/* añadir una columna */
ALTER TABLE tabla1 ADD COLUMN (campo5 VARCHAR(25) NOT NULL);

/* añadir varias columna */
ALTER TABLE tabla2 ADD COLUMN (campo5 LONGTEXT NOT NULL,campo6 INT);

/* modificar una columna */             

ALTER TABLE tabla3 MODIFY COLUMN campo3 DATE UNIQUE NOT NULL;

/******************************************************************************/
/*------------      RESTRICCIONES Y VALORES POR DEFECTO     ------------------*/
/******************************************************************************/

/* poner restricciones en la creación */
CREATE TABLE IF NOT EXISTS tabla4 (
    clave varchar(10) PRIMARY KEY,
    campo1 INT DEFAULT 100 CHECK (campo1>100 and campo1 <500) ,
    campo2 varchar(10) CHECK (campo2 REGEXP '[a-zA-Z][1-3]'),
    campo3 INT
    );
    
/* añadir restricciones */

ALTER TABLE tabla4 ADD CONSTRAINT cktabla4 CHECK(campo3>=0);
/******************************************************************************/
/*------------      CAMPOS AUTOINCREMENTO                   ------------------*/
/*------------ RECUERDA: DEBEN SER INT Y PRIMARY KEY        ------------------*/
/******************************************************************************/
    CREATE TABLE tabla5(
    clave INT PRIMARY KEY AUTO_INCREMENT,
    campo1 FLOAT(4,2) DEFAULT 20.10
    );  
    
/* establecer un valor de inicio (no se puede hacer al crearla) */             
    ALTER TABLE tabla5 AUTO_INCREMENT=10;

/******************************************************************************/
/*------------      CREAR ÍNDICES                           ------------------*/
/******************************************************************************/

/* sobre un único campo */   
          
CREATE INDEX idxtabla1 ON tabla1(campo1);

/* sobre varios campos */   

CREATE INDEX idxtabla2 ON tabla2(campo1,campo2);

/******************************************************************************/
/*------------      BORRAR OBJETOS                          ------------------*/
/******************************************************************************/

/* borrar índices */
ALTER TABLE tabla1 DROP INDEX idxtabla1;
ALTER TABLE tabla2 DROP INDEX idxtabla2;

/* borrar restricciones */

ALTER TABLE tabla4 DROP CONSTRAINT cktabla4;

/* borrar tablas */

DROP TABLE tabla4;

/* borrar base de datos */

DROP DATABASE basededatos;
