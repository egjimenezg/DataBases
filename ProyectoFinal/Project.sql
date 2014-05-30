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
