<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- /WebContent/model2/board/updateForm.jsp --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խñ� ����ȭ��</title>
<link rel="stylesheet" href="../../css/main.css">
<script>
	function file_delete(){
		document.f.file2.value="";      // file2 �� ���� ����
		file_desc.style.display="none"; // [÷������ ����] �κе� ������ �ʰ�
	}
</script>
</head>
<body>
<form action="update.do" method="post" enctype="multipart/form-data" name="f">
	<input type="hidden" name="boardno" value="${b.boardno}">   <%--Ű���� �Ѱ��ִ� ���� �ʼ��� -> hidden���� --%>
	<input type="hidden" name="file2" value="${b.file1}">
	<div style="display:flex; justify-content: center;">
	<table style="padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;"><caption>�Խ��� ���� ȭ��</caption>
	<tr><th>�۾���</th><td style="text-align : left;">&nbsp;&nbsp;${b.id}</td></tr>
	<tr><th>����</th><td><input type="text" name="title" value="${b.title}"></td></tr>
	<tr><th>����</th><td><textarea rows="15" name="content" id="content1">${b.content}</textarea></td></tr>
	<script>CKEDITOR.replace("content1", {
		filebrowserImageUploadUrl : "imgupload.do"
	});
	</script>
	<tr><th>÷������</th><td style="text-align: left">
	<c:if test="${!empty b.file1}">
		<div id="file_desc">${b.file1}
	  <a href="javascript:file_delete()">[÷������ ����]</a></div>      <%-- [÷������ ����]�� Ŭ���ϸ� file_delete() �Լ��� ���� --%>
	</c:if>
	<input type="file" name="file1"></td></tr>
	<tr><th colspan="2">
	<input type="button" value="�Խù� ����" onclick="javascript:document.f.submit()"></th></tr>
	</table></div>
</form>
</body>
</html>