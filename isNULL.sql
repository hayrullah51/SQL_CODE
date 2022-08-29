-- is null, is not null, coalesce --
/*
is null ve is not boolean operatorleridir, Bir ifadenin null olup olmadigini kontrol eder

COALESCE (Birlestirme) ise bir fonksiyondur ve icerisindeki parametrelerden null olmayan ilk ifadeyi dondurur
*/

CREATE TABLE insanlar (
ssn CHAR(9),	-- Social Security Number	
isim VARCHAR(50), 	adres VARCHAR(50) );
	
INSERT INTO insanlar VALUES('123456789', 'Ali Can', 'Istanbul');
INSERT INTO insanlar VALUES('234567890', 'Veli Cem', 'Ankara');
INSERT INTO insanlar VALUES('345678901', 'Mine Bulut', 'Izmir');
INSERT INTO insanlar (ssn, adres) VALUES('456789012', 'Bursa');
INSERT INTO insanlar (ssn, adres) VALUES('567890123', 'Denizli');
INSERT INTO insanlar (adres) VALUES('Sakarya');
INSERT INTO insanlar (ssn) VALUES('999111222');
	
--ismi null olanlari sorgula
select * from insanlar where isim is null

-- null olmayanlari listeleyelim
select * from insanlar where isim is not null

-- isim 'i NULL olan kişilerin isim'ine NO NAME atayınız.
update insanlar
set isim = 'NO NAME'
where isim = null

-- Tabloyu bir önceki soruyu çözmeden önceki haline geri getirin
update insanlar
set isim = null
where isim = 'NO NAME'

--not : coklu degisimde her degisim icin SET ... where isim is null gibi ifade yazdadam icin
--COALESCE(birlestirme) kullanilir
/* 
isim 'i NULL olanlara 'Henuz isim girilmedi'
adres 'i NULL olanlara 'Henuz adres girilmedi'
ssn 'i NULL olanlara ' no ssn' atayalım.
*/

update insanlar
set isim = coalesce (isim,'Henuz isim girilmedi'),
	adres = coalesce (adres,'Henuz adres girilmedi'),
	ssn = coalesce (ssn,'NO ssn');

select * from insanlar
