<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- /WebContent/model2/board/list.jsp --%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խù� ��� ����</title>
<link rel="stylesheet" href="../../css/main2.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<script type="text/javascript">
	function listdo(page){
		f = document.sf;
		f.pageNum.value = page;
		f.submit();
	}
</script>
</head>
<body>
<form name="sf" action="list.do" method="post">
<div style="display:flex; justify-content: center;">
<input type="hidden" name="pageNum" value="1">
<i class="material-icons">search</i><select name="column">
		<option value="">�����ϼ���</option>
		<option value="title">����</option>
		<option value="id">�ۼ���</option>
		<option value="content">����</option>	
		<option value="title,content">����+����</option>
</select>
<script>document.sf.column.value="${param.column}";</script>
<input style="width:50%;" type="text" name="search" value="${param.search}">
<input type="submit" value="�˻�"></div> 
</form>
<br>

<div style="display:flex; justify-content: center;">
<table style="width:80%; padding : 10px; border-top : 1px solid black; border-collapse: collapse;"><caption>�Խ��� ���</caption>
<%-- ��ϵ� �Խñ��� ���� ��� --%>
<c:if test="${boardcount == 0}">
<tr><td colspan="5">��ϵ� �Խñ��� �����ϴ�.</td></tr></c:if>

<%-- ��ϵ� �Խñ��� �ִ� ��� --%>
<c:if test="${boardcount > 0 }">
<tr><td colspan="5" style="border:hidden; border-bottom:1px solid #353535; text-align:right"><i class="material-icons">description</i>&nbsp;�۰���:${boardcount}</td></tr>
 <tr><th width="8%">��ȣ</th><th width="50%">����</th>
 	 <th width="14%">�ۼ���</th><th width="17%">�����</th>
 	 <th width="11%">��ȸ��</th></tr>
 
 <%-- �Խñ� ��ȸ ���� --%>
 <c:forEach var="b" items="${list}">
 <tr><td>${boardnum}<c:set var="boardnum" value="${boardnum - 1}" /></td>  
  <td style="text-align: left">  
  <%-- �̹��� �������� �� ������ �߰��ϱ� --%>
  <c:choose>
  <c:when test="${!empty b.file1}">
  	<a href="file/${b.file1}" style="text-decoration: none;"><i class="material-icons">attach_file</i></a> 
  </c:when>
  <c:otherwise>
 	 &nbsp;&nbsp;&nbsp;
  </c:otherwise>
  </c:choose>
  <%-- ����� �� ����� ���� ǥ�� �߰��ϱ� 
  <c:if test="${b.grplevel >0 }">
  	<c:forEach var="i" begin="1" end="${b.grplevel}">
  		&nbsp;&nbsp;&nbsp;
  	</c:forEach> �� </c:if> --%>
  	<a href="info.do?boardno=${b.boardno}">${b.title}</a>
  </td><td>${b.id}</td>
 <%-- �Խñ۵�ϳ�¥�� �����̸� �ð���, ������ �ƴϸ� ��¥�� �ð� ��� ����ϱ� --%> 
  <fmt:formatDate value="${b.regdate}" pattern="yyyy-MM-dd" var="regdate"/>  <%--�Խñ� ��ϳ�¥ --%>
  <fmt:formatDate value="${b.regdate}" pattern="HH:mm:ss" var="today2"/>            <%--������ �Խñ��� �� --%>
  <fmt:formatDate value="${b.regdate}" pattern="yyyy-MM-dd hh:mm" var="nottoday"/> <%--������ �Խñ��� �ƴ� �� --%>
  <c:if test="${today == regdate}">
  	<td>${today2}</td>
  </c:if>
  <c:if test="${today != regdate}">
  	<td>${nottoday}</td>
  </c:if>   
  	<td>${b.readcnt}</td></tr>
 </c:forEach>
<%-- �Խñ� ��ȸ �� --%>
 
 <tr><td colspan="5">
 <%-- ������ ó���ϱ� --%>
 	<c:choose>
 	<c:when test="${pageNum <= 1}">[����]</c:when>
 	<c:otherwise>
 		<a href="javascript:listdo(${pageNum - 1})">[����]</a>
 	</c:otherwise>
 	</c:choose>
 	<c:forEach var="a" begin="${startpage}" end="${endpage}">
 		<c:if test="${a == pageNum}">
 			[${a}]
 		</c:if>
 		<c:if test="${a != pageNum}">
 			<a href="javascript:listdo(${a})">[${a}]</a>
 		</c:if>
 	</c:forEach>
 	
 	<c:choose>
 	<c:when test="${pageNum >= maxpage}">
 		[����]
 	</c:when>
 	<c:otherwise>
 		<a href="javascript:listdo(${pageNum + 1})">[����]</a>
 	</c:otherwise>
 	</c:choose>
 </td></tr>
</c:if>
<%-- ��ϵ� �Խñ��� �ִ� ��� if�� �� --%>

 <tr><th colspan="5" style="text-align:right">
 	<input type="button" value="�۾���" onclick="location.href='writeForm.do'"></th></tr>
</table></div>
</body>
</html> 