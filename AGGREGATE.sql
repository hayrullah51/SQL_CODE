--AGGREGATE METHOD KULLANIMI --

/*
->Aggregate methodlari (SUM(Topla), COUNT(Say), MIN(En Kucuk deger), MAX(En Buyuk deger), AVG(Ortalama)) 
->Subquery icindede kullanilir
ancak sorgu tek bir deger donduruyor olmalidir
SYNTAX : sum() seklinde olmali --> sum () seklinde olmamali [arada bosluk seklinde olmamali]
*/

select * from calisanlar2

--calisanlar2 tablosundaki en yuksek maas degerini listeleyiniz

select max(maas) from calisanlar2

--calisanlar2 tablosundaki maaslarin toplamini listeleyiniz
select sum(maas) from calisanlar2

--calisanlar tablosundaki maas ortalamalarini listeleyiniz
select avg(maas) from calisanlar2
select round(avg(maas),2) from calisanlar2

--calisanlar2 tablosundan en dusuk maasi listeleyiniz
select min(maas) from calisanlar2

--calisanlar2 tablosunda ki kac kisinin maas aldigini listeleyin
select count(maas) from calisanlar2

select * from markalar
-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz
select marka_isim, calisan_sayisi, (select sum(maas) from calisanlar2 where marka_isim = isyeri) as toplam_maas From markalar

--  Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz
SELECT marka_isim, calisan_sayisi, (select sum(maas) from calisanlar2
WHERE marka_isim=isyeri) AS toplam_maas from markalar
--ALIAS (AS) tabloda gecici isim vermek istersek kosuldan sonra AS sutun_isim olarak kullanilir

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.


SELECT marka_isim,calisan_sayisi,(SELECT max(maas) from calisanlar2 where marka_isim=isyeri) AS max_maas,
                                 (SELECT min(maas) from calisanlar2 where marka_isim=isyeri) AS min_maas
from markalar;


--Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.

select marka_id, marka_isim, (select count(sehir) from calisanlar2 where marka_isim = isyeri) as sehir_sayisi from markalar

--Interview Question: En yüksek ikinci maas değerini çağırın.
select max(maas) as enyuksek_ikinci_maas from calisanlar2
where maas < (select max(maas) from calisanlar2)

--En yüksek üçüncü maas değerini bulun
select max(maas) as enyuksek_ucuncu_maas from calisanlar2
where maas<(select max(maas) from calisanlar where maas<(select max(maas) from calisanlar2))