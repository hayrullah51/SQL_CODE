--LIMIT--

-- Kisiler tablosundan ilk 5 veriyi listeleyiniz
Select * from kisiler Limit 5 ; 

--ilk 2 veriden sonra 5 veriyi listeleyin
Select * from kisiler Limit 5 OFFSET 2 ;

-- id değeri 5 den büyük olan ilk iki veriyi listeleyiniz
SELECT * from kisiler where id>5 limit 2 ;
select * from kisiler ORDER by id limit 2 OFFSET  5

--  MAAŞ'ı en yüksek 3 kişinin bilgilerini listeleyiniz
SELECT * from kisiler order by maas desc limit 3

-- En yüksek maaşı alan 4. 5.  6. kişilerin bilgilerini listeleyiniz
select * from kisiler order by maas desc limit 3 offset 3