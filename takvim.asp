<%
'T�rk�e karakterlerde problem olmas�n� engelliyoruz
Response.Charset = "windows-1254"

'Tarih problemi olmas�n� engelliyoruz
Session.LCID = 1055

'Aylar�n T�rk�e isimlerinin bulundu�u dizi
Aylar = Array("","Ocak","�ubat","Mart","Nisan","May�s","Haziran","Temmuz","A�ustos","Eyl�l","Ekim","Kas�m","Aral�k")

'Bulundu�umuz g�n, ay ve y�l� al�yoruz
BuGun = Day(Date)
BuAy = Month(Date)
BuYil = Year(Date)

'Querystring'ten gelen g�n,ay ve yil de�erlerini �ekiyoruz
AktifGun = Request.QueryString("gun")
AktifAy = Request.QueryString("ay")
AktifYil = Request.QueryString("yil")

'�ekti�imiz de�erler bo�sa(de�er verilmemi�se) gerekli d�zenlemeleri yap�yoruz
If AktifGun = "" Then AktifGun = BuGun
If AktifAy = "" Or AktifAy > 12 Then AktifAy = BuAy
If AktifYil = "" Then AktifYil = BuYil

'Ekranda g�sterilecek olan ay�n ka� g�n oldu�unu belirliyoruz
If AktifAy = 1 Or AktifAy = 3 Or AktifAy = 5 Or AktifAy = 7 Or AktifAy = 8 Or AktifAy = 10 Or AktifAy = 12 Then
	ToplamGunSayisi = 31
ElseIf AktifAy = 2 Then
	'�ubat ay�n�n ka� g�n oldu�unu belirliyoruz
	If AktifYil mod 4 = 0 Then
		ToplamGunSayisi = 29
	Else
		ToplamGunSayisi = 28
	End If
Else
	ToplamGunSayisi = 30
End If
AktifTarih = AktifGun & "." & AktifAy & "." & AktifYil

'Ay�n ilk g�n�n�n hangi g�ne denk geldi�ini buluyoruz
AyinIlkGunu = DatePart("w","1."&AktifAy&"."&AktifYil)

'�lk g�nden �nce bo�luk varsa say�s�n� buluyoruz
If AyinIlkGunu = 1 Then
	Bosluk = 6
ElseIf AyinIlkGunu = 2 Then
	Bosluk = 0
Else
	Bosluk = AyinIlkGunu-2
End If

'�nceki ve sonraki aylar�n ve bu de�erlere ba�l� olarak
'y�llar�n de�erlerini belirliyoruz
OncekiAy = AktifAy - 1
OncekiYil = AktifYil
If OncekiAy = 0 Then
	OncekiAy = 12
	OncekiYil = AktifYil - 1
End If

SonrakiAy = AktifAy + 1
SonrakiYil = AktifYil
If SonrakiAy = 13 Then
	SonrakiAy = 1
	SonrakiYil = AktifYil + 1
End If
%>
<table cellpadding="0" cellspacing="0" border="0" class="takvim">
	<tr>
		<th><a href="javascript:void(0);" onclick="TakvimGetir('ay=<%=OncekiAy%>&yil=<%=OncekiYil%>');">&lt;</th>
		<th colspan="5"><%=Aylar(AktifAy)%>&nbsp;<%=AktifYil%></th>
		<th><a href="javascript:void(0);" onclick="TakvimGetir('ay=<%=SonrakiAy%>&yil=<%=SonrakiYil%>');">&gt;</th>
	</tr>
	<tr>
		<th>P</th>
		<th>S</th>
		<th>�</th>
		<th>P</th>
		<th>C</th>
		<th>C</th>
		<th>P</th>
	</tr>
	<tr>
<%
j = 1
k = 1
'Ay�n ilk g�n�nden �nce bo�luk varsa onlar� dolduruyoruz.
If  Bosluk > 0 Then
	for i = 1 To Bosluk
		Response.Write "<td class=""bosluk"">&nbsp;</td>"
		k = k + 1
	next
end if

'Ay�n ilk g�n�nden toplam g�n say�s�na kadar olan b�l�m� olu�turuyoruz.
for i = 1 To ToplamGunSayisi
	'��inde bulundu�umuz g�n k�rm�z� renk ve kal�n harflerle yaz�l�yor
	If Year(Date)=Int(AktifYil) And Int(BuAy)=Int(AktifAy) And Day(Date)=j Then
		stil = "bugun"
	Else
		stil = ""
	End If
%>
		<td class="<%=stil%>"<%If k mod 7 = 0 Then%> style="background-color:#ddd;"<%End If%>><%=j%></td>
<%
	if k mod 7 = 0 Then
		Response.Write "</tr><tr>"
		k = 1
	Else
		k = k + 1
	End If
	j = j + 1
next

'Ay�n son g�n�nden sonra bo�luk kal�rsa onlar� tamaml�yoruz.
If k > 1 Then
	For i=1 To 8-k
		Response.Write "<td class=""bosluk"">&nbsp;</td>"
	Next
End If
%>
	</tr>
</table>