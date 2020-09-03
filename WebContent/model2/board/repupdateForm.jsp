<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>댓글 수정하기</title>
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript">
	function inputcheck(f){
			if(f.repcontent.value == ''){
				alert("댓글 내용을 입력하세요");
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
<table style="padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;"><caption>댓글 수정하기</caption>
<tr><td><div>${sessionScope.login}</div></td>
	<td><div><textarea name="repcontent" rows="1" cols="70">${r.repcontent}</textarea></div></td></tr>
<tr><th colspan="2" align="center"><input type="submit" value="댓글수정">
		<input type="button" value="취소" onclick="window.close()"></th></tr>
</table>
</div>
</form>
</body>
</html>