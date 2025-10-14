--dodaj cztery tabeless( baza danych firma i schemat ksiegowosc zostaly juz utworzone)
create table ksiegowosc.pracownicy (
id_pracownika int primary key,
imie varchar(50),
nazwisko varchar(50),
adres varchar(70),
telefon varchar(20)
);


create table ksiegowosc.godziny(
id_godziny int primary key,
data date,
liczba_godzin int,
id_pracownika int references
ksiegowosc.pracownicy(id_pracownika)
);

create table ksiegowosc.pensja(
id_pensji int primary key,
stanowisko varchar(50),
kwota decimal(10,2));

create table ksiegowosc.premia(
id_premii int primary key,
rodzaj varchar(50),
kwota decimal(10,2));

create table ksiegowosc.wynagrodzenie(
id_wynagrodzenia int primary key,
data date,
id_pracownika int  references 
ksiegowosc.pracownicy(id_pracownika),
id_godziny int  references 
ksiegowosc.godziny(id_godziny),

id_pensji int  references 
ksiegowosc.pensja(id_pensji),
id_premii int  references
ksiegowosc.premia(id_premii));
select * from ksiegowosc.pracownicy;

--4.wypelnij kazda tabele 10 rekordami
insert into ksiegowosc.pracownicy values
(1, 'Jan', 'Kowalski', 'Warszawa, ul. Długa 3', '501123456'),
(2, 'Anna', 'Nowak', 'Kraków, ul. Lipowa 7', '502234567'),
(3, 'Piotr', 'Wiśniewski', 'Łódź, ul. Krótka 12', '503345678'),
(4, 'Ewa', 'Kowalczyk', 'Gdańsk, ul. Morska 9', '504456789'),
(5, 'Marek', 'Lewandowski', 'Poznań, ul. Jasna 2', '505567890'),
(6, 'Kasia', 'Zielińska', 'Wrocław, ul. Leśna 8', '506678901'),
(7, 'Tomasz', 'Wójcik', 'Katowice, ul. Ogrodowa 4', '507789012'),
(8, 'Magda', 'Kamińska', 'Szczecin, ul. Polna 6', '508890123'),
(9, 'Kamil', 'Mazur', 'Lublin, ul. Wesoła 5', '509901234'),
(10, 'Paulina', 'Kaczmarek', 'Bydgoszcz, ul. Słoneczna 10', '510012345');

insert into ksiegowosc.godziny values
(1, '2025-10-01', 180, 1),
(2, '2025-10-01', 170, 2),
(3, '2025-10-01', 160, 3),
(4, '2025-10-02', 180, 4),
(5, '2025-10-02', 188, 5),
(6, '2025-10-02', 155, 6),
(7, '2025-10-03', 177, 7),
(8, '2025-10-03', 177, 8),
(9, '2025-10-03', 164, 9),
(10, '2025-10-03', 80, 10);


insert into ksiegowosc.pensja values
(1, 'Księgowy', 1100.00),
(2, 'Asystent', 2000.00),
(3, 'Specjalista', 12000.00),
(4, 'Kierownik', 2300.00),
(5, 'Kadrowy', 3000.00),
(6, 'Analityk', 1000.00),
(7, 'Sekretarka', 3200.00),
(8, 'Recepcjonista', 3500.00),
(9, 'Dyrektor', 3800.00),
(10, 'Praktykant', 500.00);

insert into ksiegowosc.premia values
(1, 'Brak', 0.00),
(2, 'Za frekwencję', 300.00),
(3, 'Za wydajność', 500.00),
(4, 'Uznaniowa', 700.00),
(5, 'Brak', 0.00),
(6, 'Za projekt', 800.00),
(7, 'Za punktualność', 200.00),
(8, 'Brak', 0.00),
(9, 'Za staż pracy', 400.00),
(10, 'Uznaniowa', 600.00);

insert into ksiegowosc.wynagrodzenie values
(1, '2025-10-01', 1, 1, 1, 2),
(2, '2025-10-01', 2, 2, 2, 1),
(3, '2025-10-01', 3, 3, 3, 4),
(4, '2025-10-01', 4, 4, 4, 3),
(5, '2025-10-01', 5, 5, 5, 5),
(6, '2025-10-01', 6, 6, 6, 6),
(7, '2025-10-01', 7, 7, 7, 7),
(8, '2025-10-01', 8, 8, 8, 8),
(9, '2025-10-01', 9, 9, 9, 9),
(10, '2025-10-01', 10, 10, 10, 10);

--5.wykonaj nastepujace zaytanie
--a.wyswietl id i imie
select id_pracownika,nazwisko from ksiegowosc.pracownicy;

--b wyswietl id_pracownikow gdzie pensja wieksza niz 1000
select p.id_pracownika from ksiegowosc.pracownicy p join ksiegowosc.wynagrodzenie w on p.id_pracownika=w.id_pracownika
join ksiegowosc.pensja pe on pe.id_pensji=w.id_pensji where pe.kwota>1000;

--c wyswietl id pracownikow bez premii i z pensja wieksza niz 2000
select p.id_pracownika from ksiegowosc.pracownicy p join ksiegowosc.wynagrodzenie w on p.id_pracownika=w.id_pracownika
join ksiegowosc.premia pr on pr.id_premii=w.id_premii join ksiegowosc.pensja pe on pe.id_pensji=w.id_pensji where pr.rodzaj = 'Brak' and pe.kwota>2000; 

--d pracownicy z pierwsza litera imienia na 'J'
select imie from ksiegowosc.pracownicy where imie like 'J%';

--e pracownicy ktorzy maja w nazwisku 'n' oraz imie konczy sie na 'a'
select nazwisko from ksiegowosc.pracownicy where nazwisko like '%a' and nazwisko like '%ń%';

--f wyswielt imie i nazwisko pracownikow i liczbe nadgodzin
select p.imie ||' ' || p.nazwisko as imie, case 
when g.liczba_godzin>160 then g.liczba_godzin-160 
else 0
end as nadgodziny
from ksiegowosc.pracownicy p join ksiegowosc.godziny g on g.id_pracownika=p.id_pracownika;


--g wyswietl imie i nazwisko pracownikow, ktorych pensja zawiera sie w przedziale 1500-3000
select p.imie, p.nazwisko from ksiegowosc.pracownicy p join ksiegowosc.wynagrodzenie w 
on w.id_pracownika=p.id_pracownika join ksiegowosc.pensja pe on pe.id_pensji=w.id_pensji
where pe.kwota between '1500' and '3000'; 

--h wyswietl imie i azwisko pracownikow ktorzy pracowali  w nadgodzinach i nie otrzymali premii
select p.imie || ' ' || p.nazwisko as imie from ksiegowosc.pracownicy p join
ksiegowosc.godziny g on g.id_pracownika=p.id_pracownika join ksiegowosc.wynagrodzenie w on w.id_pracownika=p.id_pracownika
join ksiegowosc.premia pr on pr.id_premii=w.id_premii where g.liczba_godzin>160 and pr.kwota=0;

--i uszereguj pracownikow wedlug pensji
select p.imie, pe.kwota from ksiegowosc.pracownicy p join ksiegowosc.wynagrodzenie w on
p.id_pracownika=w.id_pracownika join ksiegowosc.pensja pe on pe.id_pensji=w.id_pensji
order by pe.kwota asc;

--j uszeereguj pracownikow wedlug premii i pensji malejaco
select p.imie, pe.kwota as pensja,pr.kwota as premia  from ksiegowosc.pracownicy p join ksiegowosc.wynagrodzenie w on
p.id_pracownika=w.id_pracownika join ksiegowosc.pensja pe on pe.id_pensji=w.id_pensji
join ksiegowosc.premia pr on pr.id_premii=w.id_premii
order by pe.kwota desc,pr.kwota desc;

--k zlicz i pogrupuj pracownikow wedlug stanowiska
select pe.stanowisko,count(*) as zliczenia from ksiegowosc.pracownicy p
join ksiegowosc.wynagrodzenie w on p.id_pracownika=w.id_pracownika 
join ksiegowosc.pensja pe on pe.id_pensji=w.id_pensji 
group by pe.stanowisko;

--l policz srednia minimalna i maksymalna pensje pracownikow  dla kierownika
select avg(pe.kwota) as srednia,min(pe.kwota) as min,max(pe.kwota) as max 
from ksiegowosc.pracownicy p
join ksiegowosc.wynagrodzenie w on p.id_pracownika=w.id_pracownika 
join ksiegowosc.pensja pe on pe.id_pensji=w.id_pensji where pe.stanowisko='Kierownik';

--m policz sume wszystkich wynagrodzen
select sum(kwota) as suma
from ksiegowosc.pracownicy p
join ksiegowosc.wynagrodzenie w on p.id_pracownika=w.id_pracownika 
join ksiegowosc.pensja pe on pe.id_pensji=w.id_pensji;

--f policz sume wynagrodzen w ramach danego stanowiska
select pe.stanowisko,sum(kwota) as suma
from ksiegowosc.pracownicy p
join ksiegowosc.wynagrodzenie w on p.id_pracownika=w.id_pracownika 
join ksiegowosc.pensja pe on pe.id_pensji=w.id_pensji
group by pe.stanowisko;



--g wyznacz liczbe premii przyznanych dla pracownikow danego stanowiska
select pe.stanowisko,count(case when pr.kwota>0 then 1 end) as liczba_premii from ksiegowosc.pracownicy p join ksiegowosc.wynagrodzenie w on
p.id_pracownika=w.id_pracownika join ksiegowosc.pensja pe on pe.id_pensji=w.id_pensji
join ksiegowosc.premia pr on pr.id_premii=w.id_premii 
group by pe.stanowisko;

--h usun wszystkich pracownikow majacych pensje ponizej 1200
delete from ksiegowosc.wynagrodzenie where id_pracownika in (
select p.id_pracownika from ksiegowosc.pracownicy p 
join ksiegowosc.wynagrodzenie w on p.id_pracownika = w.id_pracownika  
join ksiegowosc.pensja pe on pe.id_pensji = w.id_pensji               
where pe.kwota <5200
);


delete from ksiegowosc.godziny where id_pracownika in (
select p.id_pracownika from ksiegowosc.pracownicy p join ksiegowosc.wynagrodzenie w 
on p.id_pracownika = w.id_pracownika join ksiegowosc.pensja pe on pe.id_pensji= w.id_pensji
where pe.kwota <5200);


delete from ksiegowosc.pracownicy where id_pracownika in (
select p.id_pracownika from ksiegowosc.pracownicy p join ksiegowosc.wynagrodzenie w 
on p.id_pracownika = w.id_pracownika join ksiegowosc.pensja pe on pe.id_pensji= w.id_pensji
where pe.kwota <5200
);




