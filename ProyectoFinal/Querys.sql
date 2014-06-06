USE ProyectoFinal;

/*Consulta 1*/
SELECT PL.nombre AS "Planeta",SS.nombre AS "Sistema Solar",G.nombre AS "Galaxia", P.nombre,E.nombreCientifico,E.nombreLocal FROM 
Proyecto P INNER JOIN ProyectoFloraFauna PF ON P.idProyecto = PF.idProyecto INNER JOIN FloraProyectoFloraFauna FP ON 
PF.idProyecto = FP.idProyectoFloraFauna INNER JOIN Flora F ON FP.idFlora = F.idEspecie INNER JOIN Especie E ON E.idEspecie  = F.idEspecie 
INNER JOIN EspecieArea EA ON EA.idEspecie = E.idEspecie INNER JOIN Area A ON EA.idArea = A.idArea INNER JOIN AreaPlaneta AP ON A.idArea = AP.idArea 
INNER JOIN Planeta PL ON AP.codigoPlaneta = PL.codigo INNER JOIN SistemaSolar SS ON SS.idSistemaSolar = PL.idSistemaSolar INNER 
JOIN Galaxia G ON SS.idGalaxia = G.idGalaxia 
UNION
SELECT PL.nombre AS "Planeta",SS.nombre AS "Sistema Solar",G.nombre AS "Galaxia", P.nombre,E.nombreCientifico,E.nombreLocal FROM 
Proyecto P INNER JOIN ProyectoFloraFauna PF ON P.idProyecto = PF.idProyecto INNER JOIN FaunaProyectoFloraFauna FP ON PF.idProyecto = FP.idProyectoFloraFauna 
INNER JOIN Fauna F ON FP.idFauna = F.idEspecie INNER JOIN Especie E ON E.idEspecie  = F.idEspecie INNER JOIN EspecieArea EA ON EA.idEspecie = E.idEspecie 
INNER JOIN Area A ON EA.idArea = A.idArea INNER JOIN AreaPlaneta AP ON A.idArea = AP.idArea INNER JOIN Planeta PL ON AP.codigoPlaneta = PL.codigo 
INNER JOIN SistemaSolar SS ON SS.idSistemaSolar = PL.idSistemaSolar INNER JOIN Galaxia G ON SS.idGalaxia = G.idGalaxia
UNION
SELECT PL.nombre AS "Planeta",SS.nombre AS "Sistema Solar",G.nombre AS "Galaxia", P.nombre,M.nombreCientifico,M.nombreLocal FROM
Proyecto P INNER JOIN ProyectoMineral PM ON P.idProyecto=PM.idProyectoMineral INNER JOIN MineralProyecto MP ON PM.idMineral = MP.idMineral
INNER JOIN Mineral M ON MP.idMineral = M.idMineral INNER JOIN MineralArea MA ON MA.idMineral = M.idMineral INNER JOIN Area A 
ON MA.idArea = A.idArea INNER JOIN AreaPlaneta AP ON A.idArea = AP.idArea INNER JOIN Planeta PL ON AP.codigoPlaneta = PL.codigo 
INNER JOIN SistemaSolar SS ON SS.idSistemaSolar = PL.idSistemaSolar INNER JOIN Galaxia G ON SS.idGalaxia = G.idGalaxia;

/*Consulta 2*/
SELECT E.nombreCientifico,E.nombreLocal FROM Especie E INNER JOIN AlimentoEspecie AE ON E.idEspecie = AE.idConsumidor WHERE AE.idConsumidor 
NOT IN (SELECT DISTINCT(AE.idEspecie)  FROM Especie E INNER JOIN AlimentoEspecie AE ON E.idEspecie = AE.idEspecie);

/*Consulta 3*/
SELECT E.nombreCientifico,E.nombreLocal FROM Galaxia G INNER JOIN SistemaSolar SS ON G.idGalaxia = SS.idGalaxia INNER JOIN Planeta P ON  SS.idSistemaSolar = P.idSistemaSolar
INNER JOIN AreaPlaneta AP ON P.codigo = AP.codigoPlaneta INNER JOIN Area A ON AP.idArea = A.idArea INNER JOIN EspecieArea EA ON A.idArea = EA.idArea
INNER JOIN Especie E ON EA.idEspecie = E.idEspecie WHERE G.nombre = 'Andromeda';

/*Consulta 4*/
DROP PROCEDURE IF EXISTS getEspecies;
DELIMITER //
CREATE PROCEDURE getEspecies()
BEGIN	
	DECLARE federacion VARCHAR(100);
	DECLARE done INTEGER DEFAULT 0;

	DECLARE federacion_cursor CURSOR FOR SELECT F.nombreFederacion FROM Federacion F;
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;	
	OPEN federacion_cursor;
		get_especies: LOOP
			FETCH federacion_cursor INTO federacion;
			IF done = 1 THEN 
				LEAVE get_especies;
			END IF;
			SELECT federacion;
			SELECT E.nombreCientifico,E.nombreLocal FROM Especie E WHERE E.idEspecie NOT IN (SELECT EA.idEspecie FROM 
				   Federacion F INNER JOIN FederacionPlaneta FP ON F.idFederacion = FP.idFederacion INNER JOIN 
				   Planeta P ON FP.codigoPlaneta = P.codigo INNER JOIN AreaPlaneta AP ON AP.codigoPlaneta = P.codigo INNER JOIN 
				   Area A ON AP.idArea = A.idArea  INNER JOIN EspecieArea EA ON A.idArea = EA.idArea WHERE F.nombreFederacion = federacion);
		END LOOP get_especies;
	CLOSE federacion_cursor;
END //
DELIMITER ;

call getEspecies();

/*Consulta 5*/
SELECT P.idPersonal AS ID,CONCAT(P.nombre," ",P.categoria," ",P.rango) AS 'INVESTIGADORES Y GEOLOGOS QUE NO ESTAN INVOLUCRADOS EN ALGÚN PROYECTO' FROM Personal P INNER JOIN Investigador I ON P.idPersonal = I.idPersonal LEFT JOIN ProyectoFloraFauna PF ON I.idPersonal = PF.idInvestigador WHERE PF.idInvestigador IS NULL UNION 
SELECT P.idPersonal AS ID,CONCAT(P.nombre," ",P.categoria," ",P.rango) AS 'INVESTIGADORES Y GEOLOGOS QUE NO ESTAN INVOLUCRADOS EN ALGÚN PROYECTO' FROM Personal P NATURAL JOIN Geologo G LEFT JOIN ProyectoMineral PM ON G.idPersonal = PM.idGeologo WHERE PM.idProyectoMineral IS NULL; 



SELECT A.nombreArea,EA.idEspecie FROM Federacion F INNER JOIN FederacionPlaneta FP ON F.idFederacion = FP.idFederacion INNER JOIN Planeta P ON FP.codigoPlaneta = P.codigo INNER JOIN AreaPlaneta AP ON AP.codigoPlaneta = P.codigo INNER JOIN Area A ON AP.idArea = A.idArea 
INNER JOIN EspecieArea EA ON A.idArea = EA.idArea WHERE F.nombreFederacion = "Gama 3XY";

DROP PROCEDURE IF EXISTS getProyectos;
DELIMITER //
CREATE PROCEDURE getProyectos()
BEGIN
	DECLARE done INTEGER DEFAULT 0; 
	DECLARE nomPlaneta VARCHAR(100);
	DECLARE totalFF,totalM,totalAux,totalAuxMineral INTEGER DEFAULT 0;
	DECLARE nombre_planetas CURSOR FOR SELECT P.nombre FROM Planeta P;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
	SET @query = 'SELECT "Flora y Fauna" AS "Tipo Proyecto - Planeta",';
	SET @query2 = 'SELECT "Mineral" AS "Tipo Proyecto - Planeta",';
	SET @totalQuery = 'SELECT "Total" AS "Tipo Proyecto - Planeta",';	
	OPEN nombre_planetas;
	planeta: LOOP
		FETCH nombre_planetas INTO nomPlaneta;
		IF done = 1 THEN 
			LEAVE planeta;
		END IF;
		
		SELECT ((SELECT COUNT(*) FROM Proyecto P INNER JOIN ProyectoFloraFauna PFF ON P.idProyecto = PFF.idProyecto 
												INNER JOIN FloraProyectoFloraFauna FPFF ON PFF.idProyecto = FPFF.idProyectoFloraFauna
												INNER JOIN Flora F ON FPFF.idFlora = F.idEspecie
												INNER JOIN Especie E ON F.idEspecie = E.idEspecie
												INNER JOIN EspecieArea EA ON E.idEspecie = EA.idEspecie
												INNER JOIN Area A ON EA.idArea = A.idArea
												INNER JOIN AreaPlaneta AP ON AP.idArea = A.idArea
												INNER JOIN Planeta PL ON AP.codigoPlaneta = PL.codigo 
												WHERE PL.nombre = nomPlaneta) + 
				(SELECT COUNT(*) FROM Proyecto P  INNER JOIN ProyectoFloraFauna PFF ON P.idProyecto = PFF.idProyecto
												INNER JOIN FaunaProyectoFloraFauna FPFF ON PFF.idProyecto = FPFF.idProyectoFloraFauna 
												INNER JOIN Fauna F ON FPFF.idFauna = F.idEspecie
												INNER JOIN Especie E ON F.idEspecie = E.idEspecie
												INNER JOIN EspecieArea EA ON E.idEspecie = EA.idEspecie
												INNER JOIN Area A ON EA.idArea = A.idArea
												INNER JOIN AreaPlaneta AP ON AP.idArea = A.idArea
												INNER JOIN Planeta PL ON AP.codigoPlaneta = PL.codigo 
												WHERE PL.nombre = nomPlaneta)) INTO totalAux;	
		
		SELECT COUNT(*) FROM Proyecto P  INNER JOIN ProyectoMineral PM ON P.idProyecto = PM.idProyectoMineral
										INNER JOIN MineralProyecto MP ON PM.idProyectoMineral = MP.idProyectoMineral
										INNER JOIN Mineral M ON MP.idMineral = M.idMineral
										INNER JOIN MineralArea MA ON M.idMineral = MA.idMineral
										INNER JOIN Area A ON MA.idArea = A.idArea
										INNER JOIN AreaPlaneta AP ON AP.idArea = A.idArea
										INNER JOIN Planeta PL ON AP.codigoPlaneta = PL.codigo
										WHERE PL.nombre = nomPlaneta INTO totalAuxMineral;


		SET @totalQuery = CONCAT(@totalQuery,totalAux+totalAuxMineral,",");
		SET @query = CONCAT(@query,totalAux," AS ",nomPlaneta,",");
		SET @query2 = CONCAT(@query2,totalAuxMineral," AS ",nomPlaneta,",");
		SET totalFF = totalFF + totalAux;
		SET totalM = totalM + totalAuxMineral;
	END LOOP planeta;
	CLOSE nombre_planetas;
	

	SET @query = CONCAT(@query,totalFF," AS Total");
	SET @query2 = CONCAT(@query2,totalM," AS Total");
	SET @totalQuery = CONCAT(@totalQuery,totalFF+totalM," AS Total");
	SET @query = CONCAT(@query," UNION ",@query2," UNION ",@totalQuery);
	
	/*SELECT @query;*/
	
	PREPARE stmt FROM @query;
	EXECUTE stmt;
	
END//
DELIMITER ;

CALL getProyectos();

DROP PROCEDURE IF EXISTS getTranspuesta;
DELIMITER //
CREATE PROCEDURE getTranspuesta()
BEGIN
	DECLARE done INTEGER DEFAULT 0; 
	DECLARE nomPlaneta VARCHAR(100);
	DECLARE totalFF,totalM,totalAux,totalAuxMineral INTEGER DEFAULT 0;
	DECLARE nombre_planetas CURSOR FOR SELECT P.nombre FROM Planeta P;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
	SET @query = '';
	
	OPEN nombre_planetas;
	planeta: LOOP
		FETCH nombre_planetas INTO nomPlaneta;
		IF done = 1 THEN 
			LEAVE planeta;
		END IF;
		SELECT ((SELECT COUNT(*) FROM Proyecto P INNER JOIN ProyectoFloraFauna PFF ON P.idProyecto = PFF.idProyecto 
												INNER JOIN FloraProyectoFloraFauna FPFF ON PFF.idProyecto = FPFF.idProyectoFloraFauna
												INNER JOIN Flora F ON FPFF.idFlora = F.idEspecie
												INNER JOIN Especie E ON F.idEspecie = E.idEspecie
												INNER JOIN EspecieArea EA ON E.idEspecie = EA.idEspecie
												INNER JOIN Area A ON EA.idArea = A.idArea
												INNER JOIN AreaPlaneta AP ON AP.idArea = A.idArea
												INNER JOIN Planeta PL ON AP.codigoPlaneta = PL.codigo 
												WHERE PL.nombre = nomPlaneta) + 
				(SELECT COUNT(*) FROM Proyecto P  INNER JOIN ProyectoFloraFauna PFF ON P.idProyecto = PFF.idProyecto
												INNER JOIN FaunaProyectoFloraFauna FPFF ON PFF.idProyecto = FPFF.idProyectoFloraFauna 
												INNER JOIN Fauna F ON FPFF.idFauna = F.idEspecie
												INNER JOIN Especie E ON F.idEspecie = E.idEspecie
												INNER JOIN EspecieArea EA ON E.idEspecie = EA.idEspecie
												INNER JOIN Area A ON EA.idArea = A.idArea
												INNER JOIN AreaPlaneta AP ON AP.idArea = A.idArea
												INNER JOIN Planeta PL ON AP.codigoPlaneta = PL.codigo 
												WHERE PL.nombre = nomPlaneta)) INTO totalAux;

		SELECT COUNT(*) FROM Proyecto P  INNER JOIN ProyectoMineral PM ON P.idProyecto = PM.idProyectoMineral
										INNER JOIN MineralProyecto MP ON PM.idProyectoMineral = MP.idProyectoMineral
										INNER JOIN Mineral M ON MP.idMineral = M.idMineral
										INNER JOIN MineralArea MA ON M.idMineral = MA.idMineral
										INNER JOIN Area A ON MA.idArea = A.idArea
										INNER JOIN AreaPlaneta AP ON AP.idArea = A.idArea
										INNER JOIN Planeta PL ON AP.codigoPlaneta = PL.codigo
										WHERE PL.nombre = nomPlaneta INTO totalAuxMineral;

		SET totalFF = totalFF + totalAux;
		SET totalM = totalM + totalAuxMineral;

		SET @query = CONCAT(@query,'SELECT "',nomPlaneta,'" AS "Tipo Proyecto - Planeta",',totalAux,' AS "Flora y Fauna",'
							,totalAuxMineral,' AS "Mineral",',totalAux+totalAuxMineral,' AS "Total" UNION ');

	END LOOP planeta;
	CLOSE nombre_planetas;

	SET @query = CONCAT(@query,'SELECT "Total" AS "Tipo Proyecto - Planeta",',totalFF,' AS "Flora y Fauna",'
						,totalM,' AS "Mineral",',totalFF+totalM,' AS "Total"');
	
	PREPARE stmt FROM @query;
	EXECUTE stmt;

END //
DELIMITER ;

call getTranspuesta();

