<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%-- /WebContent/model2/board/writeForm.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խ��� �۾���</title>
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript">
	function inputcheck(f){
		if(f.title.value == ''){
			alert("������ �Է��ϼ���");
			f.title.focus();
			return false;
		}
		return true;   //form ��ü�� submit �� ���� �߻� -> form �� ������ �ִ� �Ķ���Ͱ���� ���� ������ action �� �������� �̵�
	}
</script>
</head>
<body>
<form action="write.do" method="post" name="f" onsubmit="return inputcheck(this)" enctype="multipart/form-data">
<input type="hidden" name="id" value="${sessionScope.login}">
<div style="display:flex; justify-content: center;">
  <table style="padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;">
	<caption>�Խ��� �۾���</caption>
	<tr><th>�۾���</th><td style="text-align : left;">&nbsp;&nbsp;${sessionScope.login}</td></tr>
	<tr><th>����</th><td><input type="text" name="title"></td></tr>
	<tr><th>����</th><td><textarea rows="15" name="content" id="content1"></textarea></td></tr>
	<script>CKEDITOR.replace("content1", {
		filebrowserImageUploadUrl : "imgupload.do"
	});
	</script>
	<tr><th>÷������</th><td style="text-align : left;">&nbsp;&nbsp;<input type="file" name="file1"></td></tr>
	<tr><th colspan="2"><input type="submit" value="�Խù� ���"></th></tr> 
<!-- <a href="javascript:inputcheck()">[�Խù����]</a> -->  <%-- <a> �±״� <form> ���ο� �־ ������� �±�  --%>
  </table></div>
</form>
</body>
</html>