-- kisi ismine göre satılan toplam meyve miktarlarını gösteren sorguyu yazınız.
select isim,sum(urun_miktari) as toplam_alim from manav group by isim

-- satılan meyve türüne (urun_adi) göre urun alan kişi sayısını gösteren sorguyu yazınız. NULL olarak girilen meyveyi listelemesin.
select urun_adi,count(isim) from manav
where urun_adi is not null
group by urun_adi 

-- satılan meyve türüne (urun_adi) göre satılan (urun_miktari )MIN ve -- MAX urun miktarlarini, MAX urun miktarina göre sıralayarak listeyen sorguyu yazınız
select urun_adi,min(urun_miktari) as min_urun_miktari,max(urun_miktari) as maksimun_urun_miktari from manav
where urun_adi is not null
group by urun_adi
order by maksimun_urun_miktari desc

-- kisi ismine ve urun adına göre satılan ürünlerin toplamını gruplandıran
-- ve isime göre ters sırasıda listeyen sorguyu yazınız.
select isim,urun_adi,sum(urun_miktari) from manav 
group by isim,urun_adi
order by isim desc

-- personelin calıştığı ülkeleri listeleyiniz

select ulke from personel
group by ulke

-- Ülkelere göre ortalama maaşları listeleyiniz
select ulke,round(avg(maas)) as ortalama_maas from personel
group by ulke

-- Maas ortalamasını bayanlar ve baylar olarak sorgulayınız

select ulke,cinsiyet,round(avg(maas)) as ortalama_maas from personel
group by cinsiyet,ulke
order by ortalama_maas desc

-- Personelin, ulkelere göre ve şehirler göre calışan sayısını sorgulayın.
select ulke,sehir,count(*) as calisan_sayisi from personel
group by ulke,sehir
order by calisan_sayisi desc

-- Her ulke için bay ve bayan çalışan sayısı ve yaş ortalamasını sorgulayınız.
select ulke,cinsiyet,avg(yas) as ortalama_yas,count(*) as calisan_sayisi from personel
group by ulke,cinsiyet

-- Her ulke için; bay ve bayan çalışan sayısı, yaş ortalamasını, maaşı 30000 den büyük olanları-- ve ortalama yaşı büyükten küçüğe doğru sıralayınız.
select ulke,cinsiyet,avg(yas) as yas_ortalamasi,count(*) from personel
where maas>30000
group by ulke,cinsiyet
order by yas_ortalamasi desc






























