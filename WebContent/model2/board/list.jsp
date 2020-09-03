<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- /WebContent/model2/board/list.jsp --%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시물 목록 보기</title>
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
		<option value="">선택하세요</option>
		<option value="title">제목</option>
		<option value="id">작성자</option>
		<option value="content">내용</option>	
		<option value="title,content">제목+내용</option>
</select>
<script>document.sf.column.value="${param.column}";</script>
<input style="width:50%;" type="text" name="search" value="${param.search}">
<input type="submit" value="검색"></div> 
</form>
<br>

<div style="display:flex; justify-content: center;">
<table style="width:80%; padding : 10px; border-top : 1px solid black; border-collapse: collapse;"><caption>게시판 목록</caption>
<%-- 등록된 게시글이 없는 경우 --%>
<c:if test="${boardcount == 0}">
<tr><td colspan="5">등록된 게시글이 없습니다.</td></tr></c:if>

<%-- 등록된 게시글이 있는 경우 --%>
<c:if test="${boardcount > 0 }">
<tr><td colspan="5" style="border:hidden; border-bottom:1px solid #353535; text-align:right"><i class="material-icons">description</i>&nbsp;글갯수:${boardcount}</td></tr>
 <tr><th width="8%">번호</th><th width="50%">제목</th>
 	 <th width="14%">작성자</th><th width="17%">등록일</th>
 	 <th width="11%">조회수</th></tr>
 
 <%-- 게시글 조회 시작 --%>
 <c:forEach var="b" items="${list}">
 <tr><td>${boardnum}<c:set var="boardnum" value="${boardnum - 1}" /></td>  
  <td style="text-align: left">  
  <%-- 이미지 파일있을 때 아이콘 추가하기 --%>
  <c:choose>
  <c:when test="${!empty b.file1}">
  	<a href="file/${b.file1}" style="text-decoration: none;"><i class="material-icons">attach_file</i></a> 
  </c:when>
  <c:otherwise>
 	 &nbsp;&nbsp;&nbsp;
  </c:otherwise>
  </c:choose>
  <%-- 답글일 때 공백과 엔터 표시 추가하기 
  <c:if test="${b.grplevel >0 }">
  	<c:forEach var="i" begin="1" end="${b.grplevel}">
  		&nbsp;&nbsp;&nbsp;
  	</c:forEach> └ </c:if> --%>
  	<a href="info.do?boardno=${b.boardno}">${b.title}</a>
  </td><td>${b.id}</td>
 <%-- 게시글등록날짜가 오늘이면 시간만, 오늘이 아니면 날짜와 시간 모두 출력하기 --%> 
  <fmt:formatDate value="${b.regdate}" pattern="yyyy-MM-dd" var="regdate"/>  <%--게시글 등록날짜 --%>
  <fmt:formatDate value="${b.regdate}" pattern="HH:mm:ss" var="today2"/>            <%--오늘자 게시글일 때 --%>
  <fmt:formatDate value="${b.regdate}" pattern="yyyy-MM-dd hh:mm" var="nottoday"/> <%--오늘자 게시글이 아닐 때 --%>
  <c:if test="${today == regdate}">
  	<td>${today2}</td>
  </c:if>
  <c:if test="${today != regdate}">
  	<td>${nottoday}</td>
  </c:if>   
  	<td>${b.readcnt}</td></tr>
 </c:forEach>
<%-- 게시글 조회 끝 --%>
 
 <tr><td colspan="5">
 <%-- 페이지 처리하기 --%>
 	<c:choose>
 	<c:when test="${pageNum <= 1}">[이전]</c:when>
 	<c:otherwise>
 		<a href="javascript:listdo(${pageNum - 1})">[이전]</a>
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
 		[다음]
 	</c:when>
 	<c:otherwise>
 		<a href="javascript:listdo(${pageNum + 1})">[다음]</a>
 	</c:otherwise>
 	</c:choose>
 </td></tr>
</c:if>
<%-- 등록된 게시글이 있는 경우 if문 끝 --%>

 <tr><th colspan="5" style="text-align:right">
 	<input type="button" value="글쓰기" onclick="location.href='writeForm.do'"></th></tr>
</table></div>
</body>
</html> 