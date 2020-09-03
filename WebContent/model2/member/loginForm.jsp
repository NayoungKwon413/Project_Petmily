<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%-- /WebContent/model2/member/loginForm.jsp 
	1. jspstydy1에서 src/model/ 패키지의 모든 파일을 jspstudy2 로 복사
	2. jspstydy1의 WebContent/model1/member, board 폴더의 모든 파일 jspstudy2 의 WebContent/model2 에 복사
	3. jspstydy1의 WebContent/WEB-INF/lib 폴더의 모든 파일을 jspstydy2의 WebContent/WEB-INF/lib 폴더에 복사
	4. jspstudy1의 WebContent/css 폴더를 jspstudy2 에 복사
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그인 화면</title>
<link rel="stylesheet" href="../../css/main.css">
<link href='https://fonts.googleapis.com/css?family=RobotoDraft' rel='stylesheet' type='text/css'>
<style>
	input[type=password] {font-family:"RobotoDraft"}
</style>
<script type="text/javascript">
	function inputcheck(f){
		if(f.id.value == ''){
			alert("아이디를 입력하세요");
			f.id.focus();
			return false;
		}
		if(f.pass.value == ''){
			alert("비밀번호를 입력하세요");
			f.pass.focus();
			return false;
		}
		return true;
	}
	function win_open(page){
		var op = "width=800, height=600, menubar=no, top=20, left=200";
		open(page+ ".me","", op);
	}
</script>
</head>
<body>
<%-- login.me -> ControllerServlet 호출 -> LoginAction 메서드 호출 --%>
<form action="login.me" method="post" name="f" onsubmit="return inputcheck(this)">
<div style="display:flex; justify-content: center;">
<table style="padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;"><caption>로그인</caption>
<tr><th>아이디</th><td><input type="text" name="id"></td></tr>
<tr><th>비밀번호</th><td><input type="password" name="pass"></td></tr>
<tr><th colspan="2">
	<input type="submit" value="로그인">
	<input type="button" value="회원가입" onclick="location.href='joinForm.me'">
	<input type="button" value="아이디찾기" onclick="win_open('idForm');">
	<input type="button" value="비밀번호찾기" onclick="win_open('pwForm');">
</th></tr>
</table></div>
</form>
</body>
</html>