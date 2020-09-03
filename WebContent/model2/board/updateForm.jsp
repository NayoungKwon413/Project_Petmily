<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- /WebContent/model2/board/updateForm.jsp --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시글 수정화면</title>
<link rel="stylesheet" href="../../css/main.css">
<script>
	function file_delete(){
		document.f.file2.value="";      // file2 의 값을 삭제
		file_desc.style.display="none"; // [첨부파일 삭제] 부분도 보이지 않게
	}
</script>
</head>
<body>
<form action="update.do" method="post" enctype="multipart/form-data" name="f">
	<input type="hidden" name="boardno" value="${b.boardno}">   <%--키값을 넘겨주는 것이 필수임 -> hidden으로 --%>
	<input type="hidden" name="file2" value="${b.file1}">
	<div style="display:flex; justify-content: center;">
	<table style="padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;"><caption>게시판 수정 화면</caption>
	<tr><th>글쓴이</th><td style="text-align : left;">&nbsp;&nbsp;${b.id}</td></tr>
	<tr><th>제목</th><td><input type="text" name="title" value="${b.title}"></td></tr>
	<tr><th>내용</th><td><textarea rows="15" name="content" id="content1">${b.content}</textarea></td></tr>
	<script>CKEDITOR.replace("content1", {
		filebrowserImageUploadUrl : "imgupload.do"
	});
	</script>
	<tr><th>첨부파일</th><td style="text-align: left">
	<c:if test="${!empty b.file1}">
		<div id="file_desc">${b.file1}
	  <a href="javascript:file_delete()">[첨부파일 삭제]</a></div>      <%-- [첨부파일 삭제]를 클릭하면 file_delete() 함수로 연결 --%>
	</c:if>
	<input type="file" name="file1"></td></tr>
	<tr><th colspan="2">
	<input type="button" value="게시물 수정" onclick="javascript:document.f.submit()"></th></tr>
	</table></div>
</form>
</body>
</html>