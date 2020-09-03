<%@page import="model.Member"%>
<%@page import="model.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<%-- /WebContet/model2/member/id.jsp --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>id찾기</title>
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript">
	function idsend(id){
		opener.document.f.id.value = id;
		self.close();
	}
</script>
</head>
<body>
<div style="display:flex; justify-content: center; margin-top:100px;">
<table style="width:50%; padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;"><caption>아이디 찾기</caption>
<tr><th style="width:50%;">아이디</th>
	<td>${id.substring(0,id.length()-2)}**</td></tr>
<tr><th colspan="2">
	<input type="button" value="아이디전송" onclick="idsend('${id.substring(0,id.length()-2)}')">
	</th></tr>	
</table></div>
</body>
</html>
