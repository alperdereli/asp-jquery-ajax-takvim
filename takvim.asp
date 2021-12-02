<%
'Türkçe karakterlerde problem olmasýný engelliyoruz
Response.Charset = "windows-1254"

'Tarih problemi olmasýný engelliyoruz
Session.LCID = 1055

'Aylarýn Türkçe isimlerinin bulunduðu dizi
Aylar = Array("","Ocak","Þubat","Mart","Nisan","Mayýs","Haziran","Temmuz","Aðustos","Eylül","Ekim","Kasým","Aralýk")

'Bulunduðumuz gün, ay ve yýlý alýyoruz
BuGun = Day(Date)
BuAy = Month(Date)
BuYil = Year(Date)

'Querystring'ten gelen gün,ay ve yil deðerlerini çekiyoruz
AktifGun = Request.QueryString("gun")
AktifAy = Request.QueryString("ay")
AktifYil = Request.QueryString("yil")

'Çektiðimiz deðerler boþsa(deðer verilmemiþse) gerekli düzenlemeleri yapýyoruz
If AktifGun = "" Then AktifGun = BuGun
If AktifAy = "" Or AktifAy > 12 Then AktifAy = BuAy
If AktifYil = "" Then AktifYil = BuYil

'Ekranda gösterilecek olan ayýn kaç gün olduðunu belirliyoruz
If AktifAy = 1 Or AktifAy = 3 Or AktifAy = 5 Or AktifAy = 7 Or AktifAy = 8 Or AktifAy = 10 Or AktifAy = 12 Then
	ToplamGunSayisi = 31
ElseIf AktifAy = 2 Then
	'Þubat ayýnýn kaç gün olduðunu belirliyoruz
	If AktifYil mod 4 = 0 Then
		ToplamGunSayisi = 29
	Else
		ToplamGunSayisi = 28
	End If
Else
	ToplamGunSayisi = 30
End If
AktifTarih = AktifGun & "." & AktifAy & "." & AktifYil

'Ayýn ilk gününün hangi güne denk geldiðini buluyoruz
AyinIlkGunu = DatePart("w","1."&AktifAy&"."&AktifYil)

'Ýlk günden önce boþluk varsa sayýsýný buluyoruz
If AyinIlkGunu = 1 Then
	Bosluk = 6
ElseIf AyinIlkGunu = 2 Then
	Bosluk = 0
Else
	Bosluk = AyinIlkGunu-2
End If

'Önceki ve sonraki aylarýn ve bu deðerlere baðlý olarak
'yýllarýn deðerlerini belirliyoruz
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
		<th>Ç</th>
		<th>P</th>
		<th>C</th>
		<th>C</th>
		<th>P</th>
	</tr>
	<tr>
<%
j = 1
k = 1
'Ayýn ilk gününden önce boþluk varsa onlarý dolduruyoruz.
If  Bosluk > 0 Then
	for i = 1 To Bosluk
		Response.Write "<td class=""bosluk"">&nbsp;</td>"
		k = k + 1
	next
end if

'Ayýn ilk gününden toplam gün sayýsýna kadar olan bölümü oluþturuyoruz.
for i = 1 To ToplamGunSayisi
	'Ýçinde bulunduðumuz gün kýrmýzý renk ve kalýn harflerle yazýlýyor
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

'Ayýn son gününden sonra boþluk kalýrsa onlarý tamamlýyoruz.
If k > 1 Then
	For i=1 To 8-k
		Response.Write "<td class=""bosluk"">&nbsp;</td>"
	Next
End If
%>
	</tr>
</table>