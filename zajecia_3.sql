select*from t2018_kar_buildings limit 100;
select*from t2019_kar_buildings limit 100;

--1
select *
from t2019_kar_buildings b_19
left join t2018_kar_buildings b_18
on b_19.polygon_id=b_18.polygon_id
where b_18.polygon_id is null
or b_19.height != b_18.height
or not st_equals(b_19.geom,b_18.geom);


--2
select st_astext(geom) from t2019_kar_poi_table;
--update t2019_kar_poi_table set geom=st_transform(St_setsrid(geom,4326),30);



with nowe_budynki as (select st_transform(st_setsrid(b_19.geom,4326),3068) as geom,b_19.gid,b_19.type
from t2019_kar_buildings b_19
left join t2018_kar_buildings b_18
on b_19.polygon_id=b_18.polygon_id
where b_18.polygon_id is null
or b_19.height <> b_18.height
or not st_equals(b_19.geom,b_18.geom)),

new_poi as(select p19.gid,p19.type,st_transform(st_setsrid(p19.geom,4326),3068) 
as geom from t2019_kar_poi_table p19
left join t2018_kar_poi_table p18 on p18.gid=p19.gid
where p18.gid is null)

select count(distinct np.gid ) as zliczenie, np.type from new_poi np, nowe_budynki nb
where st_dwithin(nb.geom,np.geom,500)
group by np.type;





--3
create table streets_reprojected as
select *from t2019_kar_streets;
--select st_astext(geom) from streets_reprojected;

update streets_reprojected set geom=st_transform(St_setsrid(geom,4326),3068);

select ST_SRID(geom) from streets_reprojected;

--4

create table input_points (
id int primary key,
name varchar(50),
geom geometry(Point,4326)
)

insert into input_points(id,name,geom) values
(1,'A',ST_SetSRID(ST_MakePoint(8.36093, 49.03174), 4326)),
(2,'B',ST_SetSRID(ST_MakePoint(8.39876, 49.00644), 4326));

select updategeometrySRID('input_points','geom',3068);

--5
Update input_points
set geom=ST_Transform(ST_SetSRID(geom,4326),3068);

select ST_srid(geom) from input_points;
select st_astext(geom) from input_points;
--6
select * from T2019_kar_street_node;

with input_lines as(select st_makeline(geom)
as geom from input_points)

--select st_length(geom) from input_lines;
--select st_srid(geom) from t2019_kar_street_node;
--update t2019_kar_street_node set geom=ST_Transform(ST_setSrid(geom,4326),3068);

select sn.*
from t2019_kar_street_node sn, input_lines il
where ST_DWithin(sn.geom,il.geom,200)
and sn.intersect='Y';

--7
select st_srid(geom) from t2019_kar_land_use_a;
select st_srid(geom) from t2019_kar_poi_table;


select st_transform(geom,3068) from t2019_kar_land_use_a; 



select count (distinct poi.gid) from t2019_kar_poi_table poi,
t2019_kar_land_use_a use
where poi.type='Sporting Goods Store' and
st_dwithin(poi.geom,use.geom,300) and use.type like 'Park%';


--8
select * from t2019_kar_railways;
select *from t2019_kar_water_lines;

create table t2019_kar_bridges
(id serial primary key,
geom geometry(Point));

insert into t2019_kar_bridges (geom)
select distinct
st_intersection(r.geom,w.geom) as geom
from t2019_kar_railways r, t2019_kar_water_lines w
where st_intersects(r.geom,w.geom);

select*from t2019_kar_bridges;