<%@page import="model.MemberDao"%>
<%@page import="model.Member"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- /WebContent/model2/member/updateForm.jsp 
	InfoAction �� ��ħ 
--%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ����������</title>
<link rel="stylesheet" href="../../css/main.css">
<link href='https://fonts.googleapis.com/css?family=RobotoDraft' rel='stylesheet' type='text/css'>
<style>
	input[type=password] {font-family:"RobotoDraft"}
</style>
<script type="text/javascript">
	function inputcheck(f){
//<c:if test="${sessionScope.login != 'admin'}">
		if(f.pass.value == ""){
			alert("��й�ȣ�� �Է��ϼ���")
			f.pass.focus();
			return false;
		}
		return true;
//</c:if>
	
	}
	function win_passchg(){
		var op = "width=500, height=250, left=50, top=150";
		open("passwordForm.me","",op);
	}
	function win_upload(){
		var op = "width=500, height=150, left=50, top=150";
		open("pictureForm.me","",op);
	}
</script>
</head>
<body>
<c:choose>
<c:when test="${param.id == 'admin' && sessionScope.login == 'admin'}">
<form action="updateadmin.me" name="f" method="post" onsubmit="return inputcheck(this)">
<div style="display:flex; justify-content: center;">
<table style="width:50%; padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;"><caption>ȸ�� ���� ����</caption>
	<tr><th colspan="3">������ ����</th></tr>
	<tr><th>���̵�</th><td colspan="2"><input type="text" name="id" readonly value="${mem.id}"></td></tr>
	<tr><th>��й�ȣ</th><td colspan="2"><input type="password" name="pass"></td></tr>
	<tr><th>�̸�</th><td colspan="2"><input type="text" name="name" value="${mem.name}"></td></tr>
	<tr><th>�̸���</th><td colspan="2"><input type="text" name="email" value="${mem.email}"></td></tr>
	<tr><th>��ȭ</th><td colspan="2"><input type="text" name="tel" value="${mem.tel}"></td></tr>
	<tr><th colspan="3"><input type="submit" value="ȸ����������">
		<input type="button" value="��й�ȣ����" onclick="win_passchg()"></th></tr></table></div>
</form>
</c:when>

<c:when test="${param.id != 'admin'}">
<form action="update.me" name="f" method="post" onsubmit="return inputcheck(this)">
  <input type="hidden" name="dphoto" value="${mem.dphoto}">       <%-- ${mem.picture} : ���� �̹��� --%>
<div style="display:flex; justify-content: center;">
<table style="width:50%; padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;"><caption>ȸ�� ���� ����</caption>
<tr><th colspan="3">�ݷ��� ����</th></tr>
	<tr><th>���̵�</th><td colspan="2"><input type="text" name="id" readonly value="${mem.id}"></td></tr>
	<tr><th>��й�ȣ</th><td colspan="2"><input type="password" name="pass"></td></tr>
	<tr><th>�̸�</th><td colspan="2"><input type="text" name="name" value="${mem.name}"></td></tr>
	<tr><th>�̸���</th><td colspan="2"><input type="text" name="email" value="${mem.email}"></td></tr>
	<tr><th>��ȭ</th><td colspan="2"><input type="text" name="tel" value="${mem.tel}"></td></tr>
	<tr><th colspan="3">�ݷ��� ����</th></tr>
	<tr><td rowspan="3" valign="bottom"><img src="dphoto/${mem.dphoto}" width="150" height="160" id="pic"><br>
						<font size="1"><a href="javascript:win_upload()">��������</a></font></td>
		<th>�ݷ��� �̸�</th><td><input type="text" name="dname" value="${mem.dname}"></td></tr>
	<tr><th>�ݷ��� ����</th><td><input type="text" name="dage" value="${mem.dage}"></td></tr>
	<tr><th>�ݷ��� ����</th><td><input type="radio" name="dsex" value="1" 
					<c:if test="${mem.dsex == 1}">checked</c:if>>��
					<input type="radio" name="dsex" value="2"
					<c:if test="${mem.dsex == 2}">checked</c:if>>��</td></tr>
<tr><th colspan="3"><input type="submit" value="ȸ����������">
<c:if test="${sessionScope.login != 'admin'}">
<input type="button" value="��й�ȣ����" onclick="win_passchg()">
</c:if></th></tr>
</table></div>
</form>
</c:when></c:choose>
</body>
</html>
