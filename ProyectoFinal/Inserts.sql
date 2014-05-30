USE ProyectoFinal;

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
							  ("Bos taurus", "Vaca"),
						          ("Homo Sapiens","Humano");

INSERT INTO Fauna(idEspecie, noExtremidades, cantidadOjos, numeroEjemplares) VALUES (6,4,2,2),
										    (7,4,2,5),
										    (8, 3,2,3),
										    (9,2,2,6),
										    (10,4,2,7),
										    (11,4,2,10000);

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
                                                    ('Salvador','Intermedio',4),
						    ('Otro Inv','Avanzado',3);

INSERT INTO Investigador VALUES (1),(4);
INSERT INTO Geologo VALUES(2),
			  (3);

INSERT INTO Proyecto(nombre,proposito,fecha_inicio,fecha_final) VALUES ('Investigación de Girasol y Gorilla','Conocer las caracteristicas principales de estas especies','03-01-12','06-08-14'),
								       ('Investigación de Humanos y Lechuga','Conocer la cantidad de humanos que habitan el area y las características más importantes de la lechuga','01-01-90','10-01-14');


INSERT INTO ProyectoFloraFauna VALUES (1,1);

INSERT INTO FloraProyectoFloraFauna VALUES (1,1,50,"No tiene efecto curativo","No es venenosa");
INSERT INTO FaunaProyectoFloraFauna VALUES (1,6,70,183.5);

