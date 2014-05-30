DROP DATABASE IF EXISTS Practica5;

CREATE DATABASE Practica5;

USE Practica5;

CREATE TABLE CLIENTE(
        ID_CLIENTE INTEGER PRIMARY KEY AUTO_INCREMENT,
        NOMBRE VARCHAR(30) NOT NULL,
        APPATERNO VARCHAR(30) NOT NULL,
        APMATERNO VARCHAR(30) NOT NULL,
        RFC VARCHAR(13),
        CREDITO DECIMAL(5,2),
        DEUDA DECIMAL(5,2),
        DIRECCION VARCHAR(70) NOT NULL,
        CP INTEGER(5) NOT NULL);

INSERT INTO CLIENTE(ID_CLIENTE,NOMBRE,APPATERNO,APMATERNO,RFC,CREDITO,DEUDA,DIRECCION,CP)
            VALUES (1,'Gamaliel','Jimenez','Garcia','JIGE930831',500,400,'DatosDireccion1',57770),
                   (2,'Eduardo','Jimenez','Garcia','JIGE930831',200,100,'DatosDireccion2',57900);

-- 1.Muestra los primeros tres caracteres del nombre
SELECT LEFT(NOMBRE,3) FROM Cliente;

-- 2.Muestra los últimos tres caracteres del nobre
SELECT RIGHT(NOMBRE,3) FROM Cliente;

-- 3.Muestra del 2do al 5to caracter del nombre
SELECT SUBSTRING(NOMBRE,2,5) FROM Cliente;

-- 4.Reemplaza las d por s en nombre
SELECT REPLACE(NOMBRE,'d','s') FROM Cliente;

-- 5.Obtiene la longitud del ApPaterno
SELECT CHAR_LENGTH(APPATERNO) FROM Cliente;

-- 6.Quita los espacios en blanco al final del nombre
SELECT RTRIM(NOMBRE) FROM Cliente;

-- 7.Muestra los nombres que tienen espacios al final
SELECT NOMBRE FROM Cliente WHERE SUBSTRING(CHAR_LENGTH(NOMBRE),1) = ' ';

-- 8.Muestra en mayúsculas el nombre
SELECT UPPER(NOMBRE) FROM Cliente;

-- 9.Muestra en minúsculas 
SELECT LOWER(APPATERNO) FROM Cliente;

-- 10.Muestra el nombre completo empezando por el apellido paterno con mayusculas

SELECT CONCAT(UPPER(APPATERNO),' ',APMATERNO,' ',NOMBRE) AS 'NOMBRE COMPLETO' FROM Cliente;

-- 11.Convierte el ultimo caracter del nombre en mayusculas
SELECT UPPER(SUBSTRING(NOMBRE,CHAR_LENGTH(NOMBRE),1)) AS 'ULTIMO CARACTER EN MAYUSCULA' FROM Cliente;

-- 12.Convierte el primer caracter del nombre en mayúscula
SELECT UPPER(SUBSTRING(NOMBRE,1,1)) AS 'PRIMER CARACTER EN MAYUSCULA' FROM Cliente;

-- 13.Convierte el 3er caracter en mayuscula
SELECT UPPER(SUBSTRING(NOMBRE,3,1)) AS 'TERCER CARACTER EN MAYUSCULA' FROM Cliente;

-- 14.Convierte el 2do y 4to caracter en mayuscula
SELECT UPPER(SUBSTRING(NOMBRE,2,1)) AS 'SEGUNDO CARACTER EN MAYUSCULA', UPPER(SUBSTRING(NOMBRE,4,1)) AS 'CUARTO CARACTER EN MAYUSCULA' FROM Cliente;

-- 15.Muestra los clientes que su nombre tiene másde 5 letras
SELECT * FROM CLIENTE WHERE CHAR_LENGTH(NOMBRE) >= 5;

-- 16.Muestra la Delegación Benito Juaez como B.Juarez
SELECT CONCAT(SUBSTRING(SUBSTRING_INDEX('Benito Juarez',' ',1),1,1),'.',SUBSTRING_INDEX('Benito Juarez',' ',-1)) AS 'CAMBIO DELEGACION';

