CREATE TABLE calisanlar
(
id CHAR(5) PRIMARY KEY, -- not null + unique
isim VARCHAR(50) UNIQUE, -- UNIQUE --> Bir sutundaki tüm değerlerin BENZERSİZ yani tek olmasını sağlar
maas int NOT NULL, -- NOT NULL --> Bir sutunun NULL içermemesini yani boş olmamasını sağlar
ise_baslama DATE
);
INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10010', Mehmet Yılmaz, 5000, '2018-04-14'); --Unique
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); --NOT NULL
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); --UNIQUE
--INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); --NOT NULL
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
--INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); --PRIMARY KEY
--INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); --PRIMARY KEY
--INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -- PRIMARY KEY
-- FOREIGN KEY--
CREATE TABLE adresler
(
adres_id char(5) ,
sokak varchar(20),
cadde varchar(30),
sehir varchar(20),
CONSTRAINT fk FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);
INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');
select * from adresler;
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');
--Parent tabloda olmayan id ile child tabloya ekleme yapamayız
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
--Calısanlar id ile adresler tablosundaki adres_id ile eşlesenlere bakmak için
select * from calisanlar,adresler WHERE calisanlar.id = adresler.adres_id;
DROP table calisanlar
--Parant tabloyu yani primary key olan tabloyu silmek istediğimizde tabloyu silmez
--Önce child tabloyu silmemiz gerekir
delete from calisanlar where id='10002' --Parent

delete from adresler where adres_id = '10002'; -Child

drop table calisanlar;

--ON DELETE CASCADE --
--Her defasinda once child tablodaki verileri silmek yerine 
--ON DELETE CASCADE silme ozelligini aktif hale getirebiliriz
--Bunun icin FK olan satirin en sonuna ON DELETECASCADE komutunu yazmamiz yeterli

CREATE TABLE talebeler
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);
CREATE TABLE notlar(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
on delete cascade
);
INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);

select * from talebeler
select * from notlar

delete from notlar WHERE talebe_id = '123'
delete from talebeler WHERE id = '126' -- ON DELETE CASCADE kullandigimiz cin parent table den direk silebildik
--Parent table den sildigimiz icin child table'den silinmis olur

delete from talebeler-- hepsini sildi icini bosaltti

drop table talebeler cascade;-- Parent tabloyu kaldirmak istersek Drop table_adi'indan sonra
--CASCADE komutunu kullaniriz

--Talebeler tablosundaki isim sutununa NOT NULL kisitlamasi ekleyiniz ve veri tipini VARCHAR(30) olarak degistiriniz

alter table talebeler 
alter column isim TYPE VARCHAR(30),
alter column isim SET NOT NULL;

--Talebeler tablosundaki yazili_notu sutununa 60 dan buyuk rakam girebilsin
alter table talebeler
ADD CONSTRAINT sinir CHECK(yazili_notu>60);
--CHECK kisitlamasi ile tablodaki istedigimiz sutunu sinirlandirabiliriz
 -- yukarda 60'i sinir olarak belirledigimiz icin bunu eklemedi


INSERT INTO talebeler VALUES(127, 'Mustafa Can', 'Caan',45);



create table ogrenciler(
id int,
isim varchar(45),
adres varchar(100),
sinav_notu int
);

Create table ogrenci_adres
AS
SELECT id, adres from ogrenciler;

select * from ogrenciler
select * from ogrenci_adres

--Tablodaki bir sutuna PRIMERY KEY ekleme
ALTER table ogrenciler 
ADD PRIMARY KEY (id);

--primary key olusturmada 2. yol

alter table ogrenciler
ADD CONSTRAINT pk_id PRIMARY KEY(id);

--pk'dan sonra forein key atamasi

alter table ogrenci_adres
ADD foreign key (id) REFERENCES ogrenciler
--Child tabloyu parent tablodan olusturdugumuz icin sutun adi verilmedi 

--PK'yi silme CONTRAINT silme
alter table ogrenciler DROP CONSTRAINT pk_id;
--FK'yi silme CONTRAINT silme
alter table ogrenci_adres DROP CONSTRAINT ogrenci_adres_id_fkey;

--Yazili notu 85 den buyul olan talebe bilgilerini getirin
select * from talebeler WHERE yazili_notu>85;

--ismi Mustafa Bak olan talebenin tum bilgilerini getirin
select * from talebeler WHERE isim = 'Mustafa Bak'

--SELECT komutunda -- BETWEEN Kosulu
--Between belirttigimiz 2 veri arasindaki bilgileri listeler
--Between de belittigimiz bilgilerde listelemeye dahildir

create table personel
(
id char(4),
isim varchar(50),
maas int
);

insert into personel values('1001', 'Ali Can', 70000);
insert into personel values('1002', 'Veli Mert', 85000);
insert into personel values('1003', 'Ayşe Tan', 65000);
insert into personel values('1004', 'Derya Soylu', 95000);
insert into personel values('1005', 'Yavuz Bal', 80000);
insert into personel values('1006', 'Sena Beyaz', 100000);

/*
	AND (ve) : Belirtilen sartlarin her ikiside gerceklesiyorsa o kayit listelenir
bir tanesi gerceklesmez ise listelemez
	Select * from matematik sinavi > 50 AND sinav2 > 50
Hem sinav 1 hem de sinav 2 alani 50'den buyuk olan kayitlari listeler

	OR (veya) : Belirtilen sartlardan biri gerceklesirse, kayit listelenir
select * from matematik sinav > 50 OR sinav2>50
hem sinav1 veya sinav2 alani; 50'den buyuk olan kayitlari listeler

*/
select * from personel
--id'si 1003 ile 1005 arasinda olan personel bilgisini listeleyiniz
select * from personel WHERE id BETWEEN '1003' and '1005';
--2. Yol
select * from personel WHERE id>='1003' and id<='1005' 

--derya soylu ile yavuz bal arasindaki personel bilgisini listeleyiniz

select * from personel WHERE isim between 'Derya Soylu' and 'Yavuz Bal'

--maasi 70000 ve Sena olan personeli listele
select * from personel where maas = 70000 or isim = 'Sena Beyaz'

--IN : Birden fazla mantiksal ifade ile tanimlayabilecegiiz durumlari tek komutla yazabilme imkani verir
--Farkli sutunlar icin IN kullanilamaz
--id'si 1001,1002 ve 1004 olan personelin bilgilerini listele

select * from personel WHERE id = '1001' or id = '1002' or id = '1004' 

--2. yol

select * from personel where id IN ('1001','1002','1004');

--maasi sadece 70000, 100000 olan personeli listele

select * from personel where maas in (70000,100000);\

/*
select - like kosulu
like : sorgulama yaparken belirli kalip ifadeleri kullanabilmemizi saglar
ilike : sorgulama yaparken harfe duyarsiz olarak eslestirir
like : ~~
ilike : ~~*
not like : !~~
not like : !~~*

% --> 0 veya daha fazla karakteri belirtir.
_ --> Tek bir karakteri belirtir
*/

-- ismi A harfi ile baslayan personeli listele
select * from personel where isim like 'A%';

--ismi t harfi ile biten personeli listele
select * from personel where isim like '%t';

--isminin 2. harfi e olan personeli listeleyiniz
select * from personel where isim like '_e%';