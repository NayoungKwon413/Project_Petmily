<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- /WebContent/model2/member/list.jsp --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ����Ϻ���</title>
<link rel="stylesheet" href="../../css/main.css">
</head>
<body>
<div style="display:flex; justify-content: center;">
<table style="padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;"><caption>ȸ�� ���</caption>
<tr><th colspan="4">����� ����</th><th colspan="4">�ݷ��� ����</th><th rowspan="2">ȸ������</th></tr>
<tr><th>���̵�</th><th>�̸�</th><th>�̸���</th><th>��ȭ</th><th>�̸�</th><th>����</th><th>����</th><th>����</th></tr>

<c:forEach var="m" items="${list}">
<tr><td><a href="info.me?id=${m.id}">${m.id}</a></td>
	<td>${m.name}</td><td>${m.email}</td><td>${m.tel}</td>
	<td>${m.dname}</td><td>${m.dage}</td><td>${m.dsex == 1?"��":"��"}</td>
	<td><img src="dphoto/sm_${m.dphoto}" width="90" height="100" id="pic"></td>
	<td><a href="updateForm.me?id=${m.id}">[����]</a>
	<c:if test="${m.id != 'admin'}">
		<a href="delete.me?id=${m.id}">[����Ż��]</a>
</c:if></td></tr>   <%-- admin �� ���, ��й�ȣ �Է� ���� �ٷ� delete.jsp �������� �̵� --%>
</c:forEach>
</table></div>
</body>
</html>
