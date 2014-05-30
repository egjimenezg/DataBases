DROP DATABASE IF EXISTS ProyectoFinal;

CREATE DATABASE ProyectoFinal
DEFAULT CHARACTER SET utf8
DEFAULT COLLATE utf8_general_ci;

USE ProyectoFinal;

CREATE TABLE Galaxia(
    idGalaxia INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE SistemaSolar(
    idSistemaSolar INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE Sol(
    idSol INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idSistemaSolar INTEGER NOT NULL UNIQUE,
    tiempo_vida FLOAT(20) NOT NULL,
    tiempo_restante FLOAT(20) NOT NULL,
    FOREIGN KEY(idSistemaSolar) REFERENCES SistemaSolar(idSistemaSolar)
) ENGINE = InnoDB;

CREATE TABLE Planeta(
    codigo VARCHAR(10) NOT NULL PRIMARY KEY,
    idSistemaSolar INTEGER NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    lider VARCHAR(30) NOT NULL,
    distancia_sol FLOAT(15) NOT NULL,
    FOREIGN KEY(idSistemaSolar) REFERENCES SistemaSolar(idSistemaSolar)
) ENGINE = InnoDB;

CREATE TABLE Luna(
    idLuna INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    codigoPlaneta VARCHAR(10) NOT NULL,
    nombreLuna VARCHAR(50) NOT NULL,
    FOREIGN KEY(codigoPlaneta) REFERENCES Planeta(codigo)
) ENGINE = InnoDB;

CREATE TABLE Area(
    idArea INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombreArea VARCHAR(50) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE AreaPlaneta(
    idArea INTEGER NOT NULL,
    codigoPlaneta VARCHAR(10),
    PRIMARY KEY(idArea,codigoPlaneta),
    FOREIGN KEY(idArea) REFERENCES Area(idArea) ON DELETE CASCADE,
    FOREIGN KEY(codigoPlaneta) REFERENCES Planeta(codigo) ON DELETE CASCADE

) ENGINE = InnoDB;

CREATE TABLE AreaLuna(
    idArea INTEGER NOT NULL,
    idLuna INTEGER NOT NULL,
    PRIMARY KEY(idArea,idLuna),
    FOREIGN KEY(idArea) REFERENCES Area(idArea) ON DELETE CASCADE,
    FOREIGN KEY(idLuna) REFERENCES Luna(idLuna) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE Gas(
    idGas INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombreGas VARCHAR(30) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE GasArea(
    idGas INTEGER NOT NULL,
    idArea INTEGER NOT NULL,
    PRIMARY KEY(idGas,idArea),
    FOREIGN KEY(idGas) REFERENCES Gas(idGas) ON DELETE CASCADE,
    FOREIGN KEY(idArea) REFERENCES Area(idArea) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE Especie(
    idEspecie INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombreCientifico VARCHAR(30) NOT NULL,
    nombreLocal VARCHAR(30) NOT NULL
);

CREATE TABLE Fauna(
    idEspecie INTEGER NOT NULL,
    noExtremidades INTEGER NOT NULL,
    cantidadOjos INTEGER NOT NULL,
    numeroEjemplares INTEGER NOT NULL,
    FOREIGN KEY(idEspecie) REFERENCES Especie(idEspecie)
);

CREATE TABLE Flora(
    idEspecie INTEGER NOT NULL,
    FOREIGN KEY(idEspecie) REFERENCES Especie(idEspecie)    
);

CREATE TABLE Mineral(
    nombreCientifico VARCHAR(30) NOT NULL,
    nombreLocal VARCHAR(30) NOT NULL,
    existencia INTEGER(5) NOT NULL
);

CREATE TABLE AlimentoEspecie(
    idConsumidor INTEGER NOT NULL,
    idEspecie INTEGER NOT NULL,
    esPrincipal TINYINT(1) NOT NULL,
    PRIMARY KEY(idConsumidor,idEspecie),
    FOREIGN KEY(idConsumidor) REFERENCES Especie(idEspecie) ON DELETE CASCADE,
    FOREIGN KEY(idEspecie) REFERENCES Especie(idEspecie) ON DELETE CASCADE
);

CREATE TABLE Personal(
    idPersonal INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(80) NOT NULL,
    categoria VARCHAR(60) NOT NULL,
    rango INTEGER NOT NULL
);

CREATE TABLE Investigador(
    idPersonal INTEGER NOT NULL,
    FOREIGN KEY(idPersonal) REFERENCES Personal(idPersonal)
);

CREATE TABLE Geologo(
    idPersonal INTEGER NOT NULL,
    FOREIGN KEY(idPersonal) REFERENCES Personal(idPersonal)
);

CREATE TABLE Proyecto(
    idProyecto INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    proposito VARCHAR(100) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_final DATE NOT NULL
);

CREATE TABLE ProyectoFloraFauna(
    idProyectoFloraFauna INTEGER NOT NULL,
    idInvestigador INTEGER NOT NULL,
    aprendizajeDelIdioma DECIMAL(5,2) NOT NULL,
    FOREIGN KEY(idProyectoFloraFauna) REFERENCES Proyecto(idProyecto),
    FOREIGN KEY(idInvestigador) REFERENCES Investigador(idPersonal)
);

CREATE TABLE ProyectoFlora(
    idProyectoFloraFauna INTEGER NOT NULL,
    efectoCurativo VARCHAR(50) NOT NULL,    
    veneno VARCHAR(40) NOT NULL,
    FOREIGN KEY(idProyectoFloraFauna) REFERENCES Proyecto(idProyecto)
);

CREATE TABLE ProyectoFauna(
    idProyectoFloraFauna INTEGER NOT NULL,
    inteligencia DECIMAL(5,2) NOT NULL,
    FOREIGN KEY(idProyectoFloraFauna) REFERENCES ProyectoFloraFauna(idProyectoFloraFauna)
);

CREATE TABLE ProyectoMineral(
    idProyectoMineral INTEGER NOT NULL,
    idGeologo INTEGER NOT NULL,
    valorComercial DECIMAL(5,2) NOT NULL,
    propiedades VARCHAR(100) NOT NULL,
    FOREIGN KEY(idProyectoMineral) REFERENCES Proyecto(idProyecto),
    FOREIGN KEY(idGeologo) REFERENCES Geologo(idPersonal)
);



INSERT INTO Galaxia(nombre) VALUES("Motorola"),
                                  ("Otro"),
                                  ("Sony"),
                                  ("Andromeda"),
                                  ("Equis"),
                                  ("Yolo"),
                                  ("Samsung"),
                                  ("Cat"),
                                  ("Nay"),
                                  ("Many");

INSERT INTO SistemaSolar(nombre) VALUES	("Orion"), 
                                        ("Oreo"),
                                        ("Chokis"),
                                        ("Principe"),
                                        ("Florentina"),
                                        ("Emperador"),
                                        ("Pirueta"),
                                        ("Arcoiris"),
                                        ("Maria"),
                                        ("Animalito");

INSERT INTO Sol( idSistemaSolar, tiempo_vida, tiempo_restante) VALUES  ("1", "3.14", "4.9"), 
                                                                       ("2", "434.4", "545.3"),
                                                                       ("3", "234234.2", "12.9"),
                                                                       ("4", "6234.2", "32.9"),
                                                                       ("5", "9834.2", "1.9"), 
                                                                       ("6", "31221.2", "70.0"), 
                                                                       ("7", "34.222", "90"),
                                                                       ("8", "937334.2", "122.9"),
                                                                       ("9", "9993", "44"),
                                                                       ("10", "834.2", "1.9");

INSERT INTO Planeta(codigo, idSistemaSolar, nombre, lider, distancia_sol) VALUES ("00001", "1", "Ego", "Bellatrix", "22332.13"), 
                                                                                 ("00002", "2", "Bomabi", "Lestrange", "523.51"),
                                                                                 ("00003", "3", "Tierra", "Marvell", "5853.3"),
                                                                                 ("00004", "4", "Murphio", "Severus", "1111.11"),
                                                                                 ("00005", "5", "M2-12", "Albus", "67634.44"),
                                                                                 ("00006", "6", "Totonaine", "Neville", "3312.3"),
                                                                                 ("00007", "7", "Overlook", "Jack", "3873.01"),
                                                                                 ("00008", "8", "Maine", "Carrietta", "7555.12"),
                                                                                 ("00009", "9", "Chamberline", "Doby", "88878.34"),
                                                                                 ("00010", "10", "Morti", "Riddle", "666.66");
 
INSERT INTO Luna(codigoPlaneta, nombreLuna) VALUES ("00001", "Red Moon"), 
                                                   ("00002", "Blue Moon"), 
                                                   ("00003", "Orange Moon"),
                                                   ("00004", "Brown Moon"), 
                                                   ("00005", "Cyan Moon"), 
                                                   ("00006", "black Moon"),
                                                   ("00007", "Yellow Moon"), 
                                                   ("00008","Green Moon"), 
                                                   ("00009", "White Moon"), 
                                                   ("00010", "Purple Moon");

INSERT INTO Area(nombreArea) VALUES ("51"),
				    ("Chica"),
				    ("Grande"),
				    ("Norte"),
				    ("Sur"),
				    ("Este"), 
				    ("Oeste"),
				    ("Suroeste"),
				    ("Sureste"),
				    ("Noreste");

INSERT INTO AreaPlaneta(idArea, codigoPlaneta) VALUES ("1", "00001"),
						      ("2", "00002"),
						      ("3", "00003"),
						      ("4", "00004"),
						      ("5", "00005"),
						      ("6", "00006"),
						      ("7", "00007"),
						      ("8", "00008"),
						      ("9", "00009"),
						      ("10", "00010");
													  
INSERT INTO Gas(nombreGas) VALUES ("Helio"),
				  ("Exano"),
				  ("Etano"),
				  ("Propano"),
				  ("Edelgas"),
			  	  ("Neon"),
				  ("Kripton"),
				  ("Radon"),
				  ("Xenon"),
				  ("Argon");
								  
INSERT INTO GasArea(idGas, idArea) VALUES ("1", "1"),
					  ("2", "2"),
					  ("3", "3"),
					  ("4", "4"),
					  ("5", "5"),
					  ("6", "6"),
				  	  ("7", "7"),
					  ("8", "8"),
					  ("9", "9"),
					  ("10", "10");
										  
INSERT INTO Especie(nombreCientifico, nombreLocal) VALUES ("Helianthus annus", "Girasol"),
							  ("Zea mays", "Maiz"),
							  ("Daucus carota", "Zanahoria"),
							  ("Lactuca sativa", "Lechuga"),
							  ("Allium cepa", "Cebolla"),
							  ("Gorilla gorilla", "Gorilla"),
							  ("Mus musculus", "Raton"),
							  ("Delphinus delphis", "Delfin"),
						 	  ("Columba livia", "Paloma"),
							  ("Bos taurus", "Vaca");
														  
INSERT INTO Fauna(idEspecie, noExtremidades, cantidadOjos, numeroEjemplares) VALUES ("6", "4", "2", "2"),
										    ("7", "4", "2", "5"),
										    ("8", "3", "2", "3"),
										    ("9", "2", "2", "6"),
										    ("10", "4", "2", "7");

INSERT INTO Flora(idEspecie) VALUES ("1"),
				    ("2"),
				    ("3"),
				    ("4"),
				    ("5");

INSERT INTO Mineral(nombreCientifico, nombreLocal, existencia) VALUES ("Sulfuro de Plomo", "Galena", "122"),
								      ("Grafituloides", "Carbono", "1334"),
								      ("Dioxido de Uranio", "Uraninita", "86"),
								      ("Dioxido de Titanio", "Rutilo", "677"),
								      ("Fluoruro de Calcio", "Fluorita", "354"),
								      ("Retinol", "A", "43444"),
								      ("Tiamina", "B1", "67"),
								      ("Cianocobalamina", "B12", "44423"),
								      ("Enantiómero", "Carbom", "3444"),
								      ("Niacina", "B3", "2333");

INSERT INTO Personal(nombre,categoria,rango) VALUES ('Gamaliel Jimenez','Intermedio',3),
                                                    ('Carlos Hernadez','Intermedio',4),
                                                    ('Salvador','Intermedio',4);
