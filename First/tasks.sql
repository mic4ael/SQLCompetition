use Homework;

-- Zadanie 1

-- a) Dla ka¿dej firmy wybraæ pracowników z najwiêksz¹ liczb¹ umiejêtnoœci oczekiwanych
select tmp2.Firma, tmp2.Pracownik from (
SELECT *, MAX(tmp1.LiczbaUmiej) over(partition by Firma) as Maks from
(select tmp.Firma, tmp.Pracownik, COUNT(tmp.Pracownik) as LiczbaUmiej from (
SELECT f.Nazwa AS Firma, co.IdFirmy as IdFirmy, cp.IdPracownika,
cp.IdUmiejetnosci, co.IdStanowiska, pr.Nazwisko as Pracownik
from [Cechy Oczekiwane] as co
JOIN [Cechy Posiadane] as cp
ON co.IdUmiejetnosci=cp.IdUmiejetnosci
JOIN Pracownicy as pr
ON pr.IdPracownika=cp.IdPracownika
JOIN Firma as f
ON f.IdFirmy=co.IdFirmy
group by f.Nazwa, co.IdFirmy, cp.IdPracownika,
cp.IdUmiejetnosci, co.IdStanowiska, pr.Nazwisko) as tmp
group by grouping sets(tmp.Pracownik), tmp.Firma) as tmp1) as tmp2
where tmp2.LiczbaUmiej=tmp2.Maks

-- b) Dla ka¿dej firmy, wybraæ pracowników, których suma umiejêtnoœci wa¿onych jest najwiêksza
Select f.Nazwa, p.Nazwisko  from (Select *, Max(tmp.Suma) over(partition by idfirmy) as MaxDlaDzialu from (
SELECT Distinct co.IdFirmy, SUM(co.Waga) over(partition by idpracownika, idfirmy) as Suma,
cp.IdPracownika from [Cechy Oczekiwane] as co
join [Cechy Posiadane] as cp
on co.IdUmiejetnosci=cp.IdUmiejetnosci) as tmp) as tmp1
join Pracownicy as p
on p.IdPracownika=tmp1.IdPracownika
join Firma as f
on f.IdFirmy=tmp1.IdFirmy
Where tmp1.Suma=tmp1.MaxDlaDzialu

-- c) Dla ka¿dego stanowiska, wybraæ pracowników którzy najlepiej spe³niaj¹ wymagania
SELECT tmp2.Stanowisko, tmp2.Nazwisko from (
SELECT *, MAX(tmp1.Lu) over(partition by Stanowisko) as Maks from 
(SELECT distinct tmp.Stanowisko, tmp.Nazwisko, Count(tmp.Nazwisko) 
over(partition by Stanowisko, Nazwisko) as Lu
from (select distinct s.IdStanowiska as IdStanowiska, s.Stanowisko as Stanowisko,u.IdUmiejetnosci,
u.Nazwa AS Umiejetnosc, p.Nazwisko
from Stanowisko as s
join [Cechy Oczekiwane] as co
on co.IdStanowiska=s.IdStanowiska
join Umiejetnosci as u
on u.IdUmiejetnosci=co.IdUmiejetnosci
join [Cechy Posiadane] as cp
on u.IdUmiejetnosci=cp.IdUmiejetnosci
join Pracownicy as p
on p.IdPracownika=cp.IdPracownika) as tmp) as tmp1) as tmp2
where tmp2.Lu=tmp2.Maks

-- d) Pracownicy, których liczba umiejêtnoœci stanowi wiêkszy procent
-- od sta³ej danej parametrem umiejêtnoœci oczekiwanej przez firme
select tmp2.Firma, tmp2.Pracownik from (
SELECT *, MAX(tmp1.LiczbaUmiej) over(partition by Firma) as Maks from
(select tmp.Firma, tmp.Pracownik, COUNT(tmp.Pracownik) as LiczbaUmiej from (
SELECT f.Nazwa AS Firma, co.IdFirmy as IdFirmy, cp.IdPracownika,
cp.IdUmiejetnosci, co.IdStanowiska, pr.Nazwisko as Pracownik
from [Cechy Oczekiwane] as co
JOIN [Cechy Posiadane] as cp
ON co.IdUmiejetnosci=cp.IdUmiejetnosci
JOIN Pracownicy as pr
ON pr.IdPracownika=cp.IdPracownika
JOIN Firma as f
ON f.IdFirmy=co.IdFirmy
group by f.Nazwa, co.IdFirmy, cp.IdPracownika,
cp.IdUmiejetnosci, co.IdStanowiska, pr.Nazwisko) as tmp
group by grouping sets(tmp.Pracownik), tmp.Firma) as tmp1) as tmp2
where tmp2.LiczbaUmiej>=(0.8)*tmp2.Maks

-- Zadanie 2

-- a) ZnaleŸæ klasyfikator liniowy dziel¹cy p³aszczyznê, na dwie czêœci
-- gdzie w ka¿dej znajduj¹ siê punkty róznych klas

-- do wyznaczenia separatora dziel¹cego punkty na dwie klasy, pos³u¿y³em siê metod¹ najmniejszych kwadratów
-- w pierwszym kroku wyznaczam wspó³rzêdn¹ X œrodka przestrzeni w której znajduj¹ sie punkty,
-- nastêpnie ka¿dy punkt poddaje symetrii wzglêdem prostej o równaniu x = 'wspó³rzêdna wyznaczona w poprzednim etapie'
-- na koniec wyznaczam liniê trendu dla wyznaczonych punktów metod¹ najmniejszych kwadratów
-- algorytm naiwny, jednak daje przybli¿one wartosci wspó³czynników klasyfikatora liniowego
select ((tmp2.a*(tmp2.b) - tmp2.c*tmp2.d)/(tmp2.a*tmp2.e - tmp2.f)) as WspPrzyX,
((tmp2.d - ((tmp2.a*(tmp2.b) - tmp2.c*tmp2.d)/(tmp2.a*tmp2.e - tmp2.f))*(tmp2.c))/(tmp2.a)) as WyrazWolny from (
select 
count(*) as a,
sUM(tmp1.XXX*tmp1.YYY) as b,
sum(tmp1.XXX) as c,
sum(tmp1.YYY) as d,
sum(power(tmp1.XXX,2)) as e,
power(sum(tmp1.XXX),2) as f
from (
select
case
	when tmp.XX <> tmp.prosta then
	case
		when tmp.XX > tmp.prosta then tmp.prosta - sqrt((power(tmp.xx - tmp.prosta,2)))
		else tmp.prosta + sqrt((power(tmp.xx - tmp.prosta,2)))
	end
	else tmp.XX
end 'XXX', tmp.YY as YYY
from (select xy.x as XX, xy.y as YY,
(select max(xy.x)/2 from xy) as prosta
from xy) as tmp) as tmp1) as tmp2

-- b) ZnaleŸæ prost¹ prostopad³a do prostej ³¹cz¹cej dwa punkty
-- najbli¿ej od siebie po³o¿one

Select 
case
	when tmp1.x1=tmp1.x2 and tmp1.y1=tmp1.y2 then 'ten sam punkt'
	when tmp1.x1<>tmp1.x2 or tmp1.y1<>tmp1.y2 then case
		when tmp1.x1=tmp1.x2 then 0
		when tmp1.y1=tmp1.y2 then 1
		else ((tmp1.y2-tmp1.y1)/(tmp1.x2 - tmp1.x1))*(-1)
	end
end 'WspolczynnikPrzyX',
case
	when tmp1.x1=tmp1.x2 and tmp1.y1=tmp1.y2 then 'ten sam punkt'
	when tmp1.x1<>tmp1.x2 or tmp1.y1<>tmp1.y2 then case
		when tmp1.x1=tmp1.x2 then 1
		when tmp1.y1=tmp1.y2 then 0
		else 1
	end
end 'WspolczynnikPrzyY',
case
	when tmp1.x1=tmp1.x2 and tmp1.y1=tmp1.y2 then 'ten sam punkt'
	when tmp1.x1<>tmp1.x2 or tmp1.y1<>tmp1.y2 then case
		when tmp1.x1=tmp1.x2 then tmp1.ysrodka
		when tmp1.y1=tmp1.y2 then tmp1.xsrodka
		else (tmp1.ysrodka - (((tmp1.y2-tmp1.y1)/(tmp1.x2 - tmp1.x1))*(-1)*tmp1.xsrodka))
	end
end 'WyrazWolny'
from(
Select * from (
Select *, ((xy2.x2+xy1.x1)/2) as xsrodka, ((xy2.y2+xy1.y1)/2) as ysrodka,
sqrt(power(xy2.x2 - xy1.x1,2) + power(xy2.y2 - xy1.y1,2)) as Odleglosc 
from ((Select X as x1, Y as y1 from XY where Class='krzyzyk') as xy1
cross join (Select X as x2,Y as y2 from XY where Class='kolko') as xy2)) as tmp
Where tmp.Odleglosc = (Select Min(tmp.Odleglosc) from 
(Select *, sqrt(power(xy2.x2 - xy1.x1,2) + power(xy2.y2 - xy1.y1,2)) as Odleglosc 
from ((Select X as x1, Y as y1 from XY where Class='krzyzyk') as xy1
cross join (Select X as x2,Y as y2 from XY where Class='kolko') as xy2)) as tmp
)) as tmp1


