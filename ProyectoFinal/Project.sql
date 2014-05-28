DROP DATABASE IF EXISTS ProyectoFinal;

CREATE DATABASE ProyectoFinal
DEFAULT CHARACTER SET utf8
DEFAULT COLLATE utf8_general_ci;

USE ProyectoFinal;

CREATE TABLE Galaxia(
    idGalaxia INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE SistemaSolar(
    idSistemaSolar INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,    
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Sol(
    idSol INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idSistemaSolar INTEGER NOT NULL UNIQUE,
    tiempo_vida FLOAT(20) NOT NULL,
    tiempo_restante float(20) NOT NULL,
    FOREIGN KEY(idSistemaSolar) REFERENCES SistemaSolar(idSistemaSolar)
);

CREATE TABLE Planeta(
    codigo VARCHAR(10) NOT NULL PRIMARY KEY,   
    idSistemaSolar INTEGER NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    lider VARCHAR(30) NOT NULL,
    distancia_sol DECIMAL(5,2) NOT NULL,
    FOREIGN KEY(idSistemaSolar) REFERENCES SistemaSolar(idSistemaSolar)
);

CREATE TABLE Luna(
    idLuna INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    codigoPlaneta VARCHAR(10) NOT NULL,
    nombreLuna VARCHAR(30) NOT NULL,
    FOREIGN KEY(codigoPlaneta) REFERENCES Planeta(codigo)
);

/*
CREATE TABLE Especie(
nombre_cientifico varchar(50) not null,
nombre_local varchar(50) not null
);
CREATE TABLE Mineral(
nombre_cientifico varchar(50) not null,
existencia float(10) not null,
nombre_local varchar(50) not null
);
CREATE TABLE Fauna(
numero_extremidades integer(2) not null,
cantidad_ojos integer(2) not null,
numero_ejemplares integer(5) not null
);
CREATE TABLE Proyecto(
nombre varchar(100) not null,
proposito varchar(300) not null,
fecha_inicio integer(15) not null,
fecha_final integer(15) not null
);
*/
