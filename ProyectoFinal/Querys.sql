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
SELECT F.nombreFederacion FROM Federacion F INNER JOIN FederacionPlaneta FP ON F.idFederacion = FP.idFederacion INNER JOIN Planeta P 
ON FP.codigoPlaneta = P.codigo INNER JOIN AreaPlaneta AP ON AP.codigoPlaneta = P.codigo INNER JOIN Area A ON AP.idArea = A.idArea 
INNER JOIN EspecieArea EA ON E;

/*Consulta 5*/
SELECT P.idPersonal AS ID,CONCAT(P.nombre," ",P.categoria," ",P.rango) AS 'INVESTIGADORES Y GEOLOGOS QUE NO ESTAN INVOLUCRADOS EN ALGÚN PROYECTO' FROM Personal P INNER JOIN Investigador I ON P.idPersonal = I.idPersonal LEFT JOIN ProyectoFloraFauna PF ON I.idPersonal = PF.idInvestigador WHERE PF.idInvestigador IS NULL UNION 
SELECT P.idPersonal AS ID,CONCAT(P.nombre," ",P.categoria," ",P.rango) AS 'INVESTIGADORES Y GEOLOGOS QUE NO ESTAN INVOLUCRADOS EN ALGÚN PROYECTO' FROM Personal P NATURAL JOIN Geologo G LEFT JOIN ProyectoMineral PM ON G.idPersonal = PM.idGeologo WHERE PM.idProyectoMineral IS NULL; 
