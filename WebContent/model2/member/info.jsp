<%@page import="model.MemberDao"%>
<%@page import="model.Member"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- /WebContent/model2/member/info.jsp 
	1. id �Ķ���� ���� ��ȸ
	2. login ���� ����
	   �α׾ƿ� ���� : "�α����ϼ���" �޼��� ��� �� loginForm.jsp �� ������ �̵�
	3. login ���� ����2
	   id �Ķ���Ͱ��� login id�� �ٸ� ���, "�� ���� ��ȸ�� �����մϴ�." �޼��� ��� �� main.jsp ������ �̵�
	4. db���� id ������ ������ ��ȸ : selectOne(id) ���
	5. ��ȸ�� ������ ȭ�鿡 ����ϱ�
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ����������</title>
<link rel="stylesheet" href="../../css/main.css">
</head>
<body>
<div style="display:flex; justify-content: center;">
<table style="width:50%; padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;"><caption>ȸ�� ���� ����</caption>
<c:if test="${param.id == 'admin' && sessionScope.login == 'admin'}">
	<tr><th colspan="3">������ ����</th></tr>
	<tr><th>���̵�</th><td colspan="2">${mem.id}</td></tr>
	<tr><th>�̸�</th><td colspan="2">${mem.name}</td></tr>
	<tr><th>�̸���</th><td colspan="2">${mem.email}</td></tr>
	<tr><th>��ȭ</th><td colspan="2">${mem.tel}</td></tr>
	<tr><th colspan="3"><input type="button" value="����" onclick="location.href='updateForm.me?id=${mem.id}'"></th></tr>
</c:if>
<c:if test="${param.id != 'admin' && sessionScope.login != 'admin'}">
	<tr><th colspan="3">�ݷ��� ����</th></tr>
	<tr><th>���̵�</th><td colspan="2">${mem.id}</td></tr>
	<tr><th>�̸�</th><td colspan="2">${mem.name}</td></tr>
	<tr><th>�̸���</th><td colspan="2">${mem.email}</td></tr>
	<tr><th>��ȭ</th><td colspan="2">${mem.tel}</td></tr>
	<tr><th colspan="3">�ݷ��� ����</th></tr>
	<tr><td rowspan="3"><img src="dphoto/${mem.dphoto}" width="200" height="210"></td>
		<th>�ݷ��� �̸�</th><td>${mem.dname}</td></tr>
	<tr><th>�ݷ��� ����</th><td>${mem.dage}</td></tr>
	<tr><th>�ݷ��� ����</th><td>${mem.dsex == 1?"��":"��"}</td></tr>
	<tr><th colspan="3"><input type="button" value="����" onclick="location.href='updateForm.me?id=${mem.id}'">
		<input type="button" value="Ż��" onclick="location.href='deleteForm.me?id=${mem.id}'">
	</th></tr></c:if>
</table>
</div>
</body>
</html>
