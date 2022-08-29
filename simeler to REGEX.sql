-- SELECT - SIMILAR TO - REGEX (Regular Expressions) -- 
/*
SIMILAR TO : Daha karmasik pattern ile sorgulaman islemi icin similar to kullanilabilir.
Sadece PostgreSQL de kullanilir. Buyuk kucuk harf onemlidir.

REGEX : Herhangi bir kod, metin icerisinde istenen yazi veya kod parcasinin aranip bulunmasini saglayan
kendine ait bir soz dizimi olan bir yapidir.MySQL'de (REGEX_LIKE) olarak kullanilir.
PostgreSQL'de "~" karakteri ile kullanilir.
*/

CREATE TABLE kelimeler
(
id int,
kelime VARCHAR(50),
harf_sayisi int
);

INSERT INTO kelimeler VALUES (1001, 'hot', 3);
INSERT INTO kelimeler VALUES (1002, 'hat', 3);
INSERT INTO kelimeler VALUES (1003, 'hit', 3);
INSERT INTO kelimeler VALUES (1004, 'hbt', 3);
INSERT INTO kelimeler VALUES (1005, 'hct', 3);
INSERT INTO kelimeler VALUES (1006, 'adem', 4);
INSERT INTO kelimeler VALUES (1007, 'selim', 5);
INSERT INTO kelimeler VALUES (1008, 'yusuf', 5);
INSERT INTO kelimeler VALUES (1009, 'hip', 3);
INSERT INTO kelimeler VALUES (1010, 'HOT', 3);
INSERT INTO kelimeler VALUES (1011, 'hOt', 3);
INSERT INTO kelimeler VALUES (1012, 'h9t', 3);
INSERT INTO kelimeler VALUES (1013, 'hoot', 4);
INSERT INTO kelimeler VALUES (1014, 'haaat', 5);
INSERT INTO kelimeler VALUES (1015, 'hooooot', 5);
INSERT INTO kelimeler VALUES (1016, 'booooot', 5);
INSERT INTO kelimeler VALUES (1017, 'bolooot', 5);

select * from kelimeler

--  İçerisinde 'ot' veya 'at' bulunan kelimeleri listeleyiniz
-- veya islemi icin | kullanilir 

--SIMILAR TO ile
select * from kelimeler where kelime similar to '%(at|ot)%'

--LIKE ile
select * from kelimeler where kelime ILIKE '%at%' or kelime ILIKE '%ot%'
select * from kelimeler where kelime ~~* '%at%' or kelime ~~* '%ot%'

--REGEX
select * from kelimeler where kelime ~* 'ot' or kelime ~* 'at';

-- : 'ho' veya 'hi' ile başlayan kelimeleri listeleyeniz
select * from kelimeler where kelime ~* 'ho%' or kelime ~*'hi%'

--similar to ile
select * from kelimeler where kelime similar to 'ho%|hi%'

--like ile
select * from kelimeler where kelime ~~* 'ho%' or kelime ~~* 'hi%'

--regex ile
select * from kelimeler where kelime ~* 'h[oi].(.*)' --regex'te ".(nokta) bir karakteri temsil eder"
--Regex'de ikinci karakter için köşeli parantez kullanılır. * hepsi anlamında kullanılır

--Sonu 't' veya 'm' ile bitenleri listeleyeniz
select * from kelimeler where kelime ~~* '%t' kelime ~~* '%m'
select * from kelimeler where kelime similar to 't|m%' 
select * from kelimeler where kelime ~* '(.*)[tm]$' --$ karakteri bitisi gosterir

-- h ile başlayıp t ile biten 3 harfli kelimeleri listeleyeniz
select * from kelimeler where kelime ~~* 'h_t'
select * from kelimeler where kelime similar to 'h[a-z,A-Z,0-9]t';


--İlk karakteri 'h', son karakteri 't' ve ikinci karakteri 'a'dan 'e'ye herhangi bir karakter olan “kelime" değerlerini çağırın.
select * from kelimeler where kelime similar to 'h[a-e]%(.*)t'
select * from kelimeler where kelime ~* 'h[a-e]%(.*)t'
select * from kelimeler where kelime similar to 'h[a-e]%t'

--İlk karakteri 's', 'a' veya 'y' olan "kelime" değerlerini çağırın.

select * from kelimeler where kelime ~* '^[say](.*)' -- ^ baslangic'i temsil eder


--Son karakteri 'm', 'a' veya 'f' olan "kelime" değerlerini çağırın.
select * from kelimeler where kelime ~ '(.*)[maf]$'
select * from kelimeler where kelime ~ '[maf]$';

--İlk harfi h, son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tüm bilgilerini sorgulayalım.
select * from kelimeler where kelime ~ '^h[a|i]t'
SELECT * from kelimeler where kelime similar to 'h[a|i]t';

--İlk harfi 'b' dan ‘s' ye bir karakter olan ve ikinci harfi herhangi bir karakter olup
--üçüncü harfi ‘l' olan “kelime" değerlerini çağırın.

select kelime from kelimeler where kelime ~ '^[b-s].l(.*)'

--içerisinde en az 2 adet oo barıdıran kelimelerin tüm bilgilerini listeleyiniz
select * from kelimeler where kelime similar to '%[o][o]%'
select * from kelimeler where kelime similar to '%[o]{2}%'
select * from kelimeler where kelime ~* '(.)oo' or kelime ~*'oo(.*)'
-- Süslü parantez içinde belirttiğimiz rakam bir önceki
--köşeli parantez içinde kaçtane olduğunu belirtir

-- 4 tane o isterse
SELECT * FROM kelimeler where kelime similar to '%[o]{4}%';

--'a', 's' yada 'y' ile başlayan VE 'm' yada 'f' ile biten "kelime" değerlerini çağırın.
SELECT * FROM kelimeler where kelime similar to '[asy](.*)[mf]'
SELECT * FROM kelimeler where kelime ~ '^[a|s|y](.*)[m|f]'


