--drop table obiekty;

CREATE TABLE obiekty (
    id INT PRIMARY KEY,
    nazwa varchar(255),
	geom GEOMETRY
);



INSERT INTO obiekty VALUES
(1, 'obiekt1', ST_Union(ARRAY[
    ST_GeomFromText('LINESTRING(0 1, 1 1)'),
    ST_GeomFromText('CIRCULARSTRING(1 1, 2 0, 3 1)'),
    ST_GeomFromText('CIRCULARSTRING(3 1, 4 2, 5 1)'),
    ST_GeomFromText('LINESTRING(5 1, 6 1)')
])),
(2, 'obiekt2', ST_Union(ARRAY[
    ST_GeomFromText('LINESTRING(10 6, 14 6)'),
    ST_GeomFromText('CIRCULARSTRING(14 6, 16 4, 14 2)'),
    ST_GeomFromText('CIRCULARSTRING(14 2, 12 0, 10 2)'),
    ST_GeomFromText('LINESTRING(10 2, 10 6)'),
    ST_GeomFromText('CIRCULARSTRING(11 2, 12 3, 13 2, 12 1, 11 2)')
])),
(3, 'obiekt3', ST_GeomFromText('LINESTRING(10 17, 12 13, 7 15, 10 17)')),
(4, 'obiekt4', ST_GeomFromText('LINESTRING(20 20, 25 25, 27 24, 25 22, 26 21, 22 19, 20.5 19.5)')),
(5, 'obiekt5', ST_GeomFromText('MULTIPOINT Z((30 30 59),(38 32 234))')),
(6, 'obiekt6', ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(1 1, 3 2), POINT(4 2))'));


--2
SELECT ST_Area(ST_Buffer(ST_ShortestLine
((SELECT geom from obiekty WHERE nazwa = 'obiekt3'),
(SELECT geom from obiekty WHERE  nazwa = 'obiekt4')),
5 )) as pole_bufora;


--3
UPDATE obiekty 
SET geom =ST_MakePolygon(ST_AddPoint(geom,ST_GeomFromText('POINT(20 20)'))
where id = 4;

--4

INSERT INTO obiekty VALUES(
7,'obiekt7',ST_UNION((SELECT geom from obiekty where nazwa = 'obiekt3'),
(SELECT geom FROM obiekty WHERE nazwa = 'obiekt4')
));

--5
SELECT SUM(ST_AREA(ST_Buffer(geom, 5))) 
FROM obiekty WHERE ST_HasArc(geom) IS false;











-- st_distance zwraca tylko odleglosc nie linie





--komentarze
--2
select * from obiekty;

-- najkrótsza linia
SELECT ST_AsText(ST_ShortestLine(
    (SELECT geom FROM obiekty WHERE nazwa = 'obiekt1'),
    (SELECT geom FROM obiekty WHERE nazwa = 'obiekt3')
));


--obiekt 4 musi byc zamkniety zeby zmienic jego geometrie na poligon
--3 ST_Addpoint(linia,nowy_punkt) wiec dodajemy nowy punkt na poczatku zeby zamknac linie
-- ST_MakePolygon tworzy poligon z linii

