<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%-- /WebContent/model2/dailycare/dcmemoForm.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>dailycare memo �Է��ϱ�</title>
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript">
function inputcheck(f){
	if(f.memo.value == ""){
		alert("�޸� �Է����ּ���");
		f.memo.focus();
		return false;
	}
	return true;
}
</script>
</head>
<body>
<form action="dcmemo.do" method="post" name="f" onsubmit="return inputcheck(this)">
<input type="hidden" name="id" value="${sessionScope.login}">
<div style="display:flex; justify-content: center; margin-top:100px;">
<table style="padding : 10px; border-left:hidden; border-right:hidden; border-collapse: collapse;">
<caption>�˷��� ���� �� ��Ÿ �ｺ�ɾ� ���� ���� �޸�</caption>
<tr><td><textarea name="memo" rows="10" cols="80" onclick="this.value=''">�޸� �Է��ϼ���</textarea></td></tr>
<tr><th><input type="submit" value="���"></th></tr>
</table>
</div>
</form>
</body>
</html>