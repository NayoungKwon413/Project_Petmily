<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��й�ȣ ã��</title>
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript">
	function inputcheck(f){
		if(f.id.value == ''){
			alert("���̵� �Է��ϼ���");
			f.id.focus();
			return false;
		}
		if(f.email.value == ''){
			alert("�̸����� �Է��ϼ���");
			f.email.focus();
			return false;
		}
		if(f.tel.value == ''){
			alert("��ȭ��ȣ�� �Է��ϼ���");
			f.tel.focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>
<form action="pw.me" method="post" name="f" onsubmit="return inputcheck(this)">
<div style="display:flex; justify-content: center; margin-top:100px;">
<table style="width:50%; padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;">
<caption>��й�ȣ ã��</caption>
<tr><th>���̵�</th><td><input type="text" name="id"></td></tr>
<tr><th>�̸���</th><td><input type="text" name="email"></td></tr>
<tr><th>��ȭ��ȣ</th><td><input type="text" name="tel"></td></tr>
<tr><th colspan="2"><input type="submit" value="��й�ȣã��"></th></tr>
</table></div>
</form>
</body>
</html>