<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%-- /WebContent/model2/member/deleteForm.jsp --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원 탈퇴 비밀번호 입력</title>
<link rel="stylesheet" href="../../css/main.css">
<link href='https://fonts.googleapis.com/css?family=RobotoDraft' rel='stylesheet' type='text/css'>
<style>
	input[type=password] {font-family:"RobotoDraft"}
</style>
</head>
<body>
<form action="delete.me" method="post">
<div style="display:flex; justify-content: center;">
	<input type="hidden" name="id" value="${param.id}">
<table style="width:50%; padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;"><caption>회원 탈퇴하기</caption>
<tr><th>비밀번호</th><td><input type="password" name="pass"></td></tr>
<tr><th colspan="2"><input type="submit" value="탈퇴하기"></th></tr>
</table></div>
</form>
</body>
</html>
