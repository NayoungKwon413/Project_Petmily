<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- /WebContent/model2/member/list.jsp --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원목록보기</title>
<link rel="stylesheet" href="../../css/main.css">
</head>
<body>
<div style="display:flex; justify-content: center;">
<table style="padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;"><caption>회원 목록</caption>
<tr><th colspan="4">사용자 정보</th><th colspan="4">반려견 정보</th><th rowspan="2">회원관리</th></tr>
<tr><th>아이디</th><th>이름</th><th>이메일</th><th>전화</th><th>이름</th><th>나이</th><th>성별</th><th>사진</th></tr>

<c:forEach var="m" items="${list}">
<tr><td><a href="info.me?id=${m.id}">${m.id}</a></td>
	<td>${m.name}</td><td>${m.email}</td><td>${m.tel}</td>
	<td>${m.dname}</td><td>${m.dage}</td><td>${m.dsex == 1?"남":"여"}</td>
	<td><img src="dphoto/sm_${m.dphoto}" width="90" height="100" id="pic"></td>
	<td><a href="updateForm.me?id=${m.id}">[수정]</a>
	<c:if test="${m.id != 'admin'}">
		<a href="delete.me?id=${m.id}">[강제탈퇴]</a>
</c:if></td></tr>   <%-- admin 인 경우, 비밀번호 입력 없이 바로 delete.jsp 페이지로 이동 --%>
</c:forEach>
</table></div>
</body>
</html>
