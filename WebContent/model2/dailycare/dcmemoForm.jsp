<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%-- /WebContent/model2/dailycare/dcmemoForm.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>dailycare memo 입력하기</title>
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript">
function inputcheck(f){
	if(f.memo.value == ""){
		alert("메모를 입력해주세요");
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
<caption>알러지 여부 및 기타 헬스케어 관련 정보 메모</caption>
<tr><td><textarea name="memo" rows="10" cols="80" onclick="this.value=''">메모를 입력하세요</textarea></td></tr>
<tr><th><input type="submit" value="등록"></th></tr>
</table>
</div>
</form>
</body>
</html>