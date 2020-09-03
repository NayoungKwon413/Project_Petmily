<%@page import="model.MemberDao"%>
<%@page import="model.Member"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<%--/WebContent/model2/member/pw.jsp --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>pw찾기</title>
<link rel="stylesheet" href="../../css/main.css">
</head>
<body>
<div style="display:flex; justify-content: center; margin-top:100px;">
<table style="width:50%; padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;">
<caption>비밀번호 찾기</caption>
<tr><th style="width:50%;">비밀번호</th><td>**${fn:substring(pw,2,pw.length())}</td></tr>
<tr><th colspan="2"><input type="button" value="닫기" onclick="window.close()"></th></tr>
</table>
</div>
</body>
</html>
