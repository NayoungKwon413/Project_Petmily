<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%-- /WebContent/model2/member/joinForm.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ������</title>
<link rel="stylesheet" href="../../css/main.css">
<link href='https://fonts.googleapis.com/css?family=RobotoDraft' rel='stylesheet' type='text/css'>
<style>
	input[type=password] {font-family:"RobotoDraft"}
</style>
<script type="text/javascript">
	function win_upload(){
		var op = "width=500, height=150, left=50, top=150";
		open("pictureForm.me","",op);
	}
	function inputcheck(f){
		if(f.id.value == ''){
			alert("���̵� �Է��ϼ���");
			f.id.focus();
			return false;
		}
		if(f.pass.value == ''){
			alert("��й�ȣ�� �Է��ϼ���");
			f.pass.focus();
			return false;
		}
		if(f.name.value == ''){
			alert("�̸��� �Է��ϼ���");
			f.name.focus();
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
<form action="join.me" name="f" method="post" onsubmit="return inputcheck(this)">
  <input type="hidden" name="dphoto" value="">
  <div style="display:flex; justify-content: center;">
  <table style="padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;"><caption>ȸ������</caption>
  <tr><th colspan="3">�ݷ��� ����</th></tr>
  <tr><th>���̵�</th><td colspan="2"><input type="text" name="id"></td></tr>
  <tr><th>��й�ȣ</th><td colspan="2"><input type="password" name="pass"></td></tr>
  <tr><th>�̸�</th><td colspan="2"><input type="text" name="name"></td></tr>
  <tr><th>�̸���</th><td colspan="2"><input type="text" name="email"></td></tr>
  <tr><th>��ȭ��ȣ</th><td colspan="2"><input type="text" name="tel"></td></tr>
  <tr><th colspan="3">�ݷ��� ����</th></tr>
  <tr><td rowspan="3" valign="bottom">
  	<img src="" width="100" height="120" id="pic"><br>
  	<font size="1"><a href="javascript:win_upload()">�������</a></font></td>
  	  <th>�ݷ��� �̸�</th><td><input type="text" name="dname"></td></tr>
  <tr><th>�ݷ��� ����</th><td><input type="text" name="dage"></td></tr>
  <tr><th>�ݷ��� ����</th><td><input type="radio" name="dsex" value="1" checked>��
  					  	  <input type="radio" name="dsex" value="2">��</td></tr>
  <tr><th colspan="3"><input type="submit" value="ȸ������"></th>
  </table></div>
</form>
</body>
</html>