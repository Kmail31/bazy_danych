create extension postgis;

create table buildings(
id int primary key,
geometry GEOMETRY,
name varchar(50)
);

create table roads(
id int primary key,
geometry GEOMETRY,
name varchar(50)
);
create table points(
id int primary key,
geometry GEOMETRY,
name varchar(50)
);




INSERT INTO buildings (id, geometry, name)
VALUES
(1, ST_GeomFromText('POLYGON((8 4, 10.5 4, 10.5 1.5, 8 1.5, 8 4))'), 'BuildingA'),
(2, ST_GeomFromText('POLYGON((6 5, 6 7, 4 7, 4 5, 6 5))'), 'BuildingB'),
(3, ST_GeomFromText('POLYGON((5 6, 3 6, 3 8, 5 8, 5 6))'), 'BuildingC'),
(4, ST_GeomFromText('POLYGON((9 9, 10 9, 10 8, 9 8, 9 9))'), 'BuildingD'),
(5, ST_GeomFromText('POLYGON((9 8, 10 8, 10 9, 9 9, 9 8))'), 'BuildingF');

insert into roads(id,geometry,name)
values
(1,ST_GeomFromText('LINESTRING(7.5 0, 7.5 10.5)'),'RoadY'),
(2,ST_GeomFromText('LINESTRING(0.4 5,12.4 5)'),'RoadsX');

insert into points(id,geometry,name)
values
(1,ST_GeomFromText('POINT(1.3 5)'),'G'),
(2,ST_GeomFromText('POINT(5.5 1.5)'),'H'),
(3,ST_GeomFromText('POINT(6.5 6)'),'J'),
(4,ST_GeomFromText('POINT(6.9 5)'),'K'),
(5,ST_GeomFromText('POINT(9.5 6)'),'I');

--a
select sum(ST_Length(geometry)) as dlugosc
from roads;

--b
select ST_Area(geometry) as pole, ST_Perimeter(geometry) 
as obwod from buildings where name='BuildingA';

--c
select name , ST_Area(geometry) as powierzchnia 
from buildings
order by name asc;
--d
select name, ST_Perimeter(geometry)
as obwod from buildings
order by ST_Area(geometry) desc
limit 2;

--e

select ST_Distance(b.geometry,p.geometry) as odleglosc
from buildings b, points p
where p.name='K' and
b.name='BuildingC'
order by odleglosc
limit 1;

--f
select ST_Area(ST_Difference((select geometry from buildings
where name='BuildingC'),ST_Buffer((select geometry from buildings where name='BuildingB'),0.5)
)
)as pole;

select st_distance((select geometry from points
where name='H'),(select geometry from points where name='I')) as roznica;
--g st_y oczekuje punktow a nie linii wiec trzeba uzyc centroid zeby to zmienic
SELECT b.* 
FROM buildings b
WHERE ST_Y(ST_Centroid(b.geometry)) > ST_Y(ST_Centroid((
    SELECT r.geometry FROM roads r WHERE r.name = 'RoadsX'
)));

--h
SELECT ST_Area(
    ST_Union(
        ST_Difference(
            (SELECT geometry FROM buildings WHERE name = 'BuildingC'),
            ST_GeomFromText('POLYGON((4 7, 6 7, 6 8, 4 8, 4 7))')
        ),
        ST_Difference(
            ST_GeomFromText('POLYGON((4 7, 6 7, 6 8, 4 8, 4 7))'),
            (SELECT geometry FROM buildings WHERE name = 'BuildingC')
        )
    )
) AS pole_roznicy_symetrycznej;


