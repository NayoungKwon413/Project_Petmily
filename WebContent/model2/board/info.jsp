<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- /WebContent/model2/board/info.jsp --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խù� �� ����</title>
<link rel="stylesheet" href="../../css/main2.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<script type="text/javascript">
	function deleteconfirm(){
		var msg = confirm("�Խñ��� �����Ͻðڽ��ϱ�?");
		if(msg == true){
			document.location.href="delete.do?boardno="+${b.boardno};	
		}else{
			return false;
		}
	}
	function repdel(boardno,replyno){
		var msg = confirm("����� �����Ͻðڽ��ϱ�?");
		if(msg == true){
			document.location.href="repdelete.do?boardno=" + boardno + "&replyno=" + replyno;
		}else{
			return false;
		}
	}
	function repupd(boardno, replyno){
		var op = "width=800, height=600, menubar=no, top=20, left=200";
		open("repupdateForm.do?boardno=" + boardno + "&replyno=" + replyno,"", op);
	}
	function inputcheck(){
		repf = document.repf;
		if(repf.repcontent.value == ''){
			alert("��� ������ �Է��ϼ���");
			repf.repcontent.focus();
			return false;
		}
		repf.submit();
	}
</script>
</head>
<body>
<div style="display:flex; justify-content: center;">
<table style="width:80%; padding : 10px; border-top : 1px solid black; border-collapse: collapse;"><caption>�Խù� �� ����</caption>
<tr><th width="20%">�۾���</th>
	<td width="80%" style="text-align:left">${b.id}</td></tr>
<tr><th>����</th>
	<td style="text-align:left">${b.title}</td></tr>	
<tr><th>����</th>
	<td><table style="width: 100%; height: 250px;">
<tr><td style="border-width: 0px; vertical-align: top; text-align: left">
	${b.content}</td></tr></table></td></tr>
<tr><th>÷������</th>
	<td><c:if test="${empty b.file1}">
		&nbsp;
	</c:if>
	<c:if test="${!empty b.file1}">
		<a href="file/${b.file1}">${b.file1}</a>
	</c:if></td></tr>
<tr><th colspan="2">
<c:choose>
<c:when test="${b.id == sessionScope.login}">
	<input type="button" value="����" onclick="location.href='updateForm.do?boardno=${b.boardno}'">
	<input type="button" value="����" onclick="javascript:deleteconfirm()">
</c:when>
<c:when test="${sessionScope.login == 'admin'}">
	<input type="button" value="��������" onclick="javascript:deleteconfirm()">
</c:when></c:choose>
	<input type="button" value="���" onclick="location.href='list.do'"></th></tr>
</table></div>

<!-- ��� ��� �κ� -->
<hr>
<form name="fl">
<div style="display:flex; justify-content: left; margin-left : 140px;">
<p><i class="material-icons">textsms</i>&nbsp;��ۼ� : ${replycount}</p>
</div>
<div style="display:flex; justify-content: center;">
<c:if test="${!empty replist}">
	<table style="width:80%; border:1px solid #444444; border-collapse:collapse;">
	<c:forEach var="r" items="${replist}">
	<input type="hidden" name="boardno" value="${r.boardno}">
	<input type="hidden" name="replyno" value="${r.replyno}">
	<tr><td style="border-right:hidden; background-color : white; text-align : left;">&nbsp;&nbsp;<i class="material-icons">account_circle</i>&nbsp;${r.id}</td>
		<td style="width:50%; border-right:hidden; background-color : white; text-align : left;">&nbsp;&nbsp;${r.repcontent}</td>
	<fmt:formatDate value="${r.repdate}" pattern="yyyy-MM-dd hh:mm" var="repdate" />
	<td style="border-right:hidden; background-color : white; text-align : right;">${repdate}</td>
	<c:choose>
	<c:when test="${r.id == sessionScope.login}">
		<td style="background-color : white; text-align : right;"><input type="button" value="����" onclick="javascript:repupd(${r.boardno},${r.replyno})">
			<input type="button" value="����" onclick="javascript:repdel(${r.boardno},${r.replyno})"></td>
	</c:when>
	<c:when test="${sessionScope.login == 'admin'}">
		<td style="background-color : white; text-align : right;"><input type="button" value="����" onclick="javascript:repdel(${r.boardno},${r.replyno})"></td>
	</c:when>
	<c:otherwise>
		<td style="background-color : white;"></td>
	</c:otherwise>
	</c:choose>
	</tr>
	</c:forEach>
	</table>
</c:if></div>
</form>
<br>
<!-- ��� �ۼ� �κ� -->
<c:if test="${!empty sessionScope.login}">
<form action="reply.do" method="post" name="repf">
<input type="hidden" name="boardno" value="${b.boardno}">
<input type="hidden" name="id" value="${sessionScope.login}">
<div style="display:flex; justify-content: center;">
<table style="width:80%; border:1px solid #444444; border-collapse:collapse;">
<tr>
	<td style="border-right:hidden; text-align : left;">&nbsp;&nbsp;<i class="material-icons">account_circle</i>&nbsp;${sessionScope.login}</td>
	<td style="width:60%; border-right:hidden;"><textarea name="repcontent" rows="1" cols="100" onclick="this.value=''">����� �Է��ϼ���</textarea></td>
	<td style="text-align : right;"><input type="button" value="��۵��" onclick="javascript:inputcheck()"></td></tr></table></div>
</form>
</c:if>
</body>
</html>