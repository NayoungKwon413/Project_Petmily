<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%-- /WebContent/model2/board/writeForm.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시판 글쓰기</title>
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript">
	function inputcheck(f){
		if(f.title.value == ''){
			alert("제목을 입력하세요");
			f.title.focus();
			return false;
		}
		return true;   //form 객체에 submit 을 강제 발생 -> form 이 가지고 있는 파라미터값들과 파일 정보를 action 값 페이지로 이동
	}
</script>
</head>
<body>
<form action="write.do" method="post" name="f" onsubmit="return inputcheck(this)" enctype="multipart/form-data">
<input type="hidden" name="id" value="${sessionScope.login}">
<div style="display:flex; justify-content: center;">
  <table style="padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;">
	<caption>게시판 글쓰기</caption>
	<tr><th>글쓴이</th><td style="text-align : left;">&nbsp;&nbsp;${sessionScope.login}</td></tr>
	<tr><th>제목</th><td><input type="text" name="title"></td></tr>
	<tr><th>내용</th><td><textarea rows="15" name="content" id="content1"></textarea></td></tr>
	<script>CKEDITOR.replace("content1", {
		filebrowserImageUploadUrl : "imgupload.do"
	});
	</script>
	<tr><th>첨부파일</th><td style="text-align : left;">&nbsp;&nbsp;<input type="file" name="file1"></td></tr>
	<tr><th colspan="2"><input type="submit" value="게시물 등록"></th></tr> 
<!-- <a href="javascript:inputcheck()">[게시물등록]</a> -->  <%-- <a> 태그는 <form> 내부에 있어도 상관없는 태그  --%>
  </table></div>
</form>
</body>
</html>