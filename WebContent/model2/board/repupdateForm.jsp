<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��� �����ϱ�</title>
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript">
	function inputcheck(f){
			if(f.repcontent.value == ''){
				alert("��� ������ �Է��ϼ���");
				f.repcontent.focus();
				return false;
			}
		return true;
	}
</script>
</head>
<body>
<form action="repupdate.do" method="post" name="f" onsubmit="return inputcheck(this)">
<input type="hidden" name="replyno" value="${param.replyno}">
<input type="hidden" name="boardno" value="${param.boardno}">
<input type="hidden" name="id" value="${sessionScope.login}">
<div style="display:flex; justify-content: center; margin-top:100px;">
<table style="padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;"><caption>��� �����ϱ�</caption>
<tr><td><div>${sessionScope.login}</div></td>
	<td><div><textarea name="repcontent" rows="1" cols="70">${r.repcontent}</textarea></div></td></tr>
<tr><th colspan="2" align="center"><input type="submit" value="��ۼ���">
		<input type="button" value="���" onclick="window.close()"></th></tr>
</table>
</div>
</form>
</body>
</html>