<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%-- /WebContent/model1/member/passwordForm.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��й�ȣ ����</title>
<link rel="stylesheet" href="../../css/main.css">
<link href='https://fonts.googleapis.com/css?family=RobotoDraft' rel='stylesheet' type='text/css'>
<style>
	input[type=password] {font-family:"RobotoDraft"}
</style>
<script type="text/javascript">
	function inchk(f){
		if(f.chgpass.value != f.chgpass2.value){
			alert("���� ��й�ȣ�� ���� ��й�ȣ ���Է��� �ٸ��ϴ�");
			f.chgpass2.value="";
			f.chgpass2.focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>
<form action="password.me" method="post" name="f" onsubmit="return inchk(this)">
<div style="display:flex; justify-content: center;">
<table style="padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;"><caption>��й�ȣ ����</caption>
<tr><th>���� ��й�ȣ</th><td><input type="password" name="pass"></td></tr>
<tr><th>���� ��й�ȣ</th><td><input type="password" name="chgpass"></td></tr>
<tr><th>���� ��й�ȣ ���Է�</th><td><input type="password" name="chgpass2"></td></tr>
<tr><th colspan="2"><input type="submit" value="��й�ȣ ����"></th></tr>
</table></div>
</form>
</body>
</html>