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
    tiempo_restante FLOAT(20) NOT NULL,
    FOREIGN KEY(idSistemaSolar) REFERENCES SistemaSolar(idSistemaSolar)
);

CREATE TABLE Planeta(
    codigo VARCHAR(10) NOT NULL PRIMARY KEY,
    idSistemaSolar INTEGER NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    lider VARCHAR(30) NOT NULL,
    distancia_sol FLOAT(15) NOT NULL,
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

INSERT INTO Galaxia(nombre) VALUES("Motorola"),("Otro"),("Sony"),("Andromeda"),("Equis"),
								  ("Yolo"),("Samsung"),("Cat"),("Nay"),("Many");

INSERT INTO SistemaSolar(nombre) VALUES	("Orion"), ("Oreo"), ("Chokis"), ("Principe"), ("Florentina"),
										("Emperador"), ("Pirueta"), ("Arcoiris"), ("Maria"), ("Animalito");

INSERT INTO Sol( idSistemaSolar, tiempo_vida, tiempo_restante) VALUES  ("1", "3.14", "4.9"), ("2", "434.4", "545.3"), ("3", "234234.2", "12.9"), ("4", "6234.2", "32.9"),
																		("5", "9834.2", "1.9"), ("6", "31221.2", "70.0"), ("7", "34.222", "90"),("8", "937334.2", "122.9"),
																		("9", "9993", "44"), ("10", "834.2", "1.9");

INSERT INTO Planeta(codigo, idSistemaSolar, nombre, lider, distancia_sol) VALUES ("00001", "1", "Ego", "Bellatrix", "22332.13"), ("00002", "2", "Bomabi", "Lestrange", "523.51"),
																					("00003", "3", "Tierra", "Marvell", "5853.3"), ("00004", "4", "Murphio", "Severus", "1111.11"),
																					("00005", "5", "M2-12", "Albus", "67634.44"),("00006", "6", "Totonaine", "Neville", "3312.3"),
																					("00007", "7", "Overlook", "Jack", "3873.01"), ("00008", "8", "Maine", "Carrietta", "7555.12"),
																					("00009", "9", "Chamberline", "Doby", "88878.34"), ("00010", "10", "Morti", "Riddle", "666.66"); 
INSERT INTO Luna(codigoPlaneta, nombreLuna) VALUES ("00001", "Red Moon"), ("00002", "Blue Moon"), ("00003", "Orange Moon"),("00004", "Brown Moon"), ("00005", "Cyan Moon"), ("00006", "black Moon"),
													("00007", "Yellow Moon"), ("00008","Green Moon"), ("00009", "White Moon"), ("00010", "Purple Moon");
