<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="text/html; charset=windows-1254" http-equiv="Content-Type">
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
<title>ASP - AJAX Takvim</title>
<style type="text/css">
* { font-family: Tahoma; font-size:12px; }
.takvim { border-left:1px #000 solid; border-top:1px #000 solid; }
.takvim th { text-align:center; width:30px; height:20px; }
.takvim td { text-align:center; line-height:18px; }
.takvim th, .takvim td { border-right:1px #000 solid; border-bottom:1px #000 solid; }
.takvim td.bosluk { background-color:#bbb; }
.takvim td.bugun { color:f00; font-weight:bold }
</style>
<script type="text/javascript">
function TakvimGetir(veri) {
	$.ajax({
		type: "GET",
		url: "takvim.asp",
		data: veri,
		cache: false,
		success: function(html){
			$("#takvim-katmani").html(html);
		}
	});
}
</script>
</head>
<body onload="TakvimGetir('ay=<%=Month(Date)%>&yil=<%=Year(Date)%>');">
<div id="takvim-katmani">
	
</div>
</body>
</html>
