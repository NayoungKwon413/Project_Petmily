<%@page import="model.MemberDao"%>
<%@page import="model.Member"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- /WebContent/model2/member/info.jsp 
	1. id 파라미터 값을 조회
	2. login 상태 검증
	   로그아웃 상태 : "로그인하세요" 메세지 출력 후 loginForm.jsp 로 페이지 이동
	3. login 상태 검증2
	   id 파라미터값과 login id가 다른 경우, "내 정보 조회만 가능합니다." 메세지 출력 후 main.jsp 페이지 이동
	4. db에서 id 값으로 데이터 조회 : selectOne(id) 사용
	5. 조회된 내용을 화면에 출력하기
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원정보보기</title>
<link rel="stylesheet" href="../../css/main.css">
</head>
<body>
<div style="display:flex; justify-content: center;">
<table style="width:50%; padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;"><caption>회원 정보 보기</caption>
<c:if test="${param.id == 'admin' && sessionScope.login == 'admin'}">
	<tr><th colspan="3">관리자 정보</th></tr>
	<tr><th>아이디</th><td colspan="2">${mem.id}</td></tr>
	<tr><th>이름</th><td colspan="2">${mem.name}</td></tr>
	<tr><th>이메일</th><td colspan="2">${mem.email}</td></tr>
	<tr><th>전화</th><td colspan="2">${mem.tel}</td></tr>
	<tr><th colspan="3"><input type="button" value="수정" onclick="location.href='updateForm.me?id=${mem.id}'"></th></tr>
</c:if>
<c:if test="${param.id != 'admin' && sessionScope.login != 'admin'}">
	<tr><th colspan="3">반려인 정보</th></tr>
	<tr><th>아이디</th><td colspan="2">${mem.id}</td></tr>
	<tr><th>이름</th><td colspan="2">${mem.name}</td></tr>
	<tr><th>이메일</th><td colspan="2">${mem.email}</td></tr>
	<tr><th>전화</th><td colspan="2">${mem.tel}</td></tr>
	<tr><th colspan="3">반려견 정보</th></tr>
	<tr><td rowspan="3"><img src="dphoto/${mem.dphoto}" width="200" height="210"></td>
		<th>반려견 이름</th><td>${mem.dname}</td></tr>
	<tr><th>반려견 나이</th><td>${mem.dage}</td></tr>
	<tr><th>반려견 성별</th><td>${mem.dsex == 1?"남":"여"}</td></tr>
	<tr><th colspan="3"><input type="button" value="수정" onclick="location.href='updateForm.me?id=${mem.id}'">
		<input type="button" value="탈퇴" onclick="location.href='deleteForm.me?id=${mem.id}'">
	</th></tr></c:if>
</table>
</div>
</body>
</html>
