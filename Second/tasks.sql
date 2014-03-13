--Zad1.
--Wyznaczenie klasyfikatora liniowego Fishera

DROP TABLE #pro;
GO
;WITH proste (wspx, wspy)
AS
(
	SELECT CAST(-5 as NUMERIC(3,1)) as wspx, 1.0 as wspy UNION SELECT 1 as x, 0 as y
	UNION ALL
	SELECT CAST(p.wspx + 0.20 AS NUMERIC(3,1)) as wspx, p.wspy as wspy FROM proste as p 
	WHERE p.wspx < 5.0 AND p.wspy = 1
)

SELECT * INTO #pro FROM proste;
DROP TABLE #pro1;
GO
SELECT * INTO #pro1 FROM ( 
SELECT linie.wspx, linie.wspy, linie.x, linie.y, linie.xpp, linie.ypp, linie.wyrwol, linie.class
FROM (
SELECT *, xpp = 
CASE 
	WHEN wspx <> 0 AND wspy <> 0 THEN (-1/wspx)
	WHEN wspx = 1 AND wspy = 0 THEN 0
	WHEN wspx = 0 AND wspy = 1 THEN 1
END, ypp = 
CASE 
	WHEN wspx <> 0 AND wspy <> 0 THEN 1
	WHEN wspx = 1 AND wspy = 0 THEN 1
	WHEN wspx = 0 AND wspy = 1 THEN 0
END, wyrwol = 
CASE
	WHEN wspx <> 0 AND wspy <> 0 THEN (y-((-1/wspx))*x)
	WHEN wspx = 1 AND wspy = 0 THEN y
	WHEN wspx = 0 AND wspy = 1 THEN x
END
FROM XY2
CROSS JOIN #pro ) as linie) as linie1;
GO
DROP TABLE #pro2;
GO
SELECT * INTO #pro2 FROM (
SELECT DISTINCT p.wspx, p.wspy, p.class, p.meanx, p.meany, p.varx, p.vary FROM (
SELECT *, AVG(nowex) over(partition by wspx, class) as meanx,
VAR(nowex) over(partition by wspx, class) as varx,
AVG(nowey) over(partition by wspx, class) as meany,
VAR(nowey) over(partition by wspx, class) as vary
FROM (
SELECT ttt.wspx, ttt.wspy, ttt.x, ttt.y, ttt.nowex, ttt.nowey, ttt.class FROM (
SELECT *, nowex =
CASE
	WHEN wspx <> 0 AND wspy <> 0 THEN (wyrwol/(wspx-xpp))
	WHEN wspx = 1 AND wspy = 0 THEN 0
	WHEN wspx = 0 AND wspy = 1 THEN x
END, nowey =
CASE
	WHEN wspx <> 0 AND wspy <> 0 THEN xpp*(wyrwol/(wspx-xpp)) + wyrwol
	WHEN wspx = 1 AND wspy = 0 THEN y
	WHEN wspx = 0 AND wspy = 1 THEN 0
END 
FROM #pro1) AS ttt) AS t) AS p) AS z;


DROP TABLE #pro3;
GO
SELECT * INTO #pro3 FROM (
SELECT DISTINCT TOP 1 (t.wspKlX), t.wspKlY, (t.mx1+t.mx2)/2 as x, (t.my1+t.my2)/2 as y, 
((POWER(t.mx1-t.mx2,2))/(t.var1x+t.var2x)) as j1
FROM (
SELECT p1.wspx AS wspKlX, p1.wspy AS wspKlY, p1.meanx as mx1, p1.meany as my1,  p2.meanx as mx2, p2.meany as my2,
p1.varx as var1x, p1.vary as var1y, p2.varx as var2x, p2.vary as var2y 
FROM #pro2 as p1
JOIN #pro2 as p2 ON
p1.wspx=p2.wspx AND p1.wspy=p2.wspy AND p1.class <> p2.class) as t order by j1 desc) as z;
GO
select (-1/wspKlX) WS, y - ((-1/wspKlX))*x from #pro3;

--Zad3.
--Dzielenie punktów jednej klasy na n grup. (algorytm k-œrednich)

--DROP PROCEDURE initminmax;
GO
CREATE PROCEDURE initminmax(@minx FLOAT output, @maxx FLOAT output, @miny FLOAT output,@maxy FLOAT output)
AS
BEGIN
	SET @minx = (SELECT MIN(x) FROM XY4);
	SET @miny = (SELECT MIN(y) FROM XY4);
	SET @maxx = (SELECT MAX(x) FROM XY4);
	SET @maxy = (SELECT MAX(y) FROM XY4);
END
GO
--DROP PROCEDURE kmeans;
GO
CREATE PROCEDURE kmeans(@k INT=2)
AS
BEGIN
	DECLARE @output TABLE (
		idPunktu INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
		x FLOAT,
		y FLOAT,
		groupID varchar(10)
	);

	INSERT INTO @output(x,y)
	SELECT x,y FROM XY4;

	DECLARE @centroids TABLE (cx FLOAT, cy FLOAT, Idcentroidu INT);
	DECLARE @minx FLOAT;
	DECLARE @miny FLOAT;
	DECLARE @maxx FLOAT;
	DECLARE @maxy FLOAT;

	--inicjalizacja wartoœci brzegowych x i y
	EXEC initminmax @minx OUTPUT, @maxx OUTPUT, @miny OUTPUT, @maxy OUTPUT;
	
	--losowanie k dowolnych centroidów
	DECLARE @i INT;
	SET @i = 0;

	WHILE (@i <> @k)
	BEGIN
		INSERT INTO @centroids VALUES(ROUND(RAND()*(@maxx - @minx) + @minx,1), ROUND(RAND()*(@maxy - @miny) + @miny,1), @i);
		SET @i = @i + 1;
	END

	--petla przypisujaca wszystkie punkty do odpowiednich centroidów tzn. grup

	DECLARE @hasChanged BIT;
	SET @hasChanged = 1;

	WHILE (@hasChanged=1)
	BEGIN
		SELECT * INTO #tmpCtrs
		FROM @centroids;

		--przypisz punkty do centroidów
		DECLARE @ile INT;
		SET @ile = (SELECT COUNT(*) FROM XY4);

		WHILE (@ile <> 0)
		BEGIN
			DECLARE @x FLOAT;
			DECLARE @y FLOAT;
			SET @x = (SELECT x FROM XY4 WHERE id=@ile);
			SET @y = (SELECT y FROM XY4 WHERE id=@ile);

			DECLARE @tmp TABLE (
				idGrupy INT NOT NULL,
				odl FLOAT NOT NULL
			);

			DELETE @tmp;

			SET @i = 0;
			WHILE (@i <> @k)
			BEGIN
				DECLARE @ctrx FLOAT;
				SET @ctrx = (SELECT cx FROM @centroids WHERE Idcentroidu=@i);
				DECLARE @ctry FLOAT;
				SET @ctry = (SELECT cy FROM @centroids WHERE Idcentroidu=@i);
				DECLARE @odl FLOAT;
				SET @odl = (SELECT CAST (SQRT(POWER(@ctrx - @x,2)+POWER(@ctry - @y,2)) AS FLOAT));

				INSERT INTO @tmp VALUES(@i, @odl);

				SET @i = @i + 1;
			END
			DECLARE @ktoraGrupa INT;
			SET @ktoraGrupa = (SELECT idGrupy FROM @tmp WHERE odl=(SELECT MIN(odl) FROM @tmp));
			UPDATE @output SET groupID=@ktoraGrupa WHERE idPunktu=@ile;
			SET @ile = @ile - 1;
		END

		--oblicz nowe centroidy
		SET @i = 0;

		WHILE (@i <> @k)
		BEGIN
			DECLARE @centrx FLOAT;
			DECLARE @centry FLOAT;
			SET @centrx = (SELECT AVG(Cast(x as Float)) FROM @output WHERE groupID=@i);
			SET @centry = (SELECT AVG(Cast(y as Float)) FROM @output WHERE groupID=@i);
			UPDATE @centroids SET cx=@centrx WHERE Idcentroidu=@i;
			UPDATE @centroids SET cy=@centry WHERE Idcentroidu=@i;
			SET @i = @i + 1;
		END
		
		--sprawdŸ czy po³ozenie centroidów sie zmieni³o, jeœli nie to zakoñcz
		IF (NOT EXISTS (SELECT * FROM @centroids except SELECT * FROM #tmpCtrs))
			SET @hasChanged = 0;
		ELSE
		BEGIN
			DROP TABLE #tmpCtrs;
			CONTINUE;
		END
	END
	
	SELECT * FROM @output;
	SELECT * FROM @centroids;

	SELECT SUM(ODL) AS MiaraJakosciGrupowania FROM (
	SELECT SQRT(POWER(tab1.cx - tab1.x,2) + POWER(tab1.cy - tab1.y,2)) AS ODL FROM (
	SELECT * FROM @output AS t1
	JOIN @centroids AS t2 ON
	t1.groupID=t2.Idcentroidu) as tab1) AS Tab2;

END
GO
use Homework2;
GO
exec kmeans

--Zad4.
--Znalezienie punktów g³ównych w grafie.
use Homework2;
GO
DROP PROCEDURE graph;
GO
CREATE PROCEDURE graph
AS
BEGIN
	DECLARE @i INT;
	DECLARE @degs TABLE (
		id INT,
		degree INT,
		PRIMARY KEY (id ASC)
	);

	SET @i = (SELECT COUNT(*) FROM Actors);

	WHILE (@i<>0)
	BEGIN
		DECLARE @hm INT;
		SET @hm = (SELECT COUNT(*) FROM (SELECT e.fromNode, e.toNode FROM Edges AS e WHERE e.toNode = @i
		UNION
		SELECT * FROM Edges WHERE fromNode = @i) AS tmp);
		INSERT INTO @degs VALUES(@i, @hm);
		SET @i = @i - 1;
	END

	CREATE TABLE #Temp (
		idDegree INT PRIMARY KEY IDENTITY(1,1),
		id INT
	);

	INSERT INTO #Temp
	SELECT TOP 2 id FROM @degs ORDER BY degree DESC;

	SELECT * FROM #Temp;

	SET @i = (SELECT COUNT(*) FROM Actors);

	DECLARE @output TABLE (
		nodeID INT,
		groupNode INT
	);

	INSERT INTO @output(nodeID) SELECT id FROM Actors;

	SELECT * INTO #tmp FROM (SELECT * FROM edges) AS tmp;
	UPDATE #tmp SET toNode=fromNode, fromNode=toNode;

	SELECT * INTO #Tempora FROM (SELECT * FROM edges
	UNION
	SELECT * FROM #tmp) as tmp2;

	DECLARE @centr INT;
	SET @centr = (SELECT COUNT(*) FROM #Temp);

	WHILE (@centr <> 0)
	BEGIN
		DECLARE @degree INT;
		SET @degree = (SELECT id FROM #Temp WHERE idDegree=@centr);
		SET @i = (SELECT COUNT(*) FROM Actors);
		DECLARE @whichNode INT;
		DECLARE @min INT;

		SET @min = 1000;

		WHILE (@i <> 0)
		BEGIN
				WITH pathTo(start, stopN, distance, pathName) AS
				( 
					--anchor element
					SELECT fromNode, toNode, 1 AS distance, CAST(CAST(fromNode as varchar(100)) + '.' + CAST(tonode as varchar(100)) as varchar(100)) 
					as pathName FROM #Tempora WHERE fromNode = @degree
					UNION ALL
					-- recursive element
					SELECT pt.start, e.toNode, pt.distance + 1, CAST((pt.pathName + '.' + CAST(e.toNode AS varchar(10))) 
					AS varchar(100)) FROM edges AS e
					JOIN pathTo AS pt ON e.fromNode = pt.stopN
				)

				SELECT * INTO #tmp1 FROM (SELECT TOP 1 * FROM pathTo WHERE stopN=@i ORDER BY distance ASC) as rek;
				DECLARE @dist INT;
				SET @dist = (SELECT distance FROM #tmp1);

				IF @dist <= @min
				BEGIN
					SET @min = @dist;
					UPDATE @output SET groupNode=@degree WHERE nodeID=@i;
				END

				DROP TABLE #tmp1;
				SET @i = @i - 1;
		END
		SET @centr = @centr - 1;
	END
	SELECT * FROM @output;

	SELECT (CAST(jakosc.ilosc1 as REAL)/CAST(jakosc.ilosc2 as REAL)) FROM (
	SELECT TOP 1 * FROM (SELECT COUNT(*) as ilosc1 FROM @output GROUP BY groupNode) as t1
	JOIN (SELECT COUNT(*) as ilosc2 FROM @output GROUP BY groupNode) as t2
	ON t1.ilosc1 <> t2.ilosc2) as jakosc;

	DROP TABLE #tmp;
	DROP TABLE #Tempora
END
GO
exec graph;