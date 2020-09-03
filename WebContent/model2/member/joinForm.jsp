<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%-- /WebContent/model2/member/joinForm.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원가입</title>
<link rel="stylesheet" href="../../css/main.css">
<link href='https://fonts.googleapis.com/css?family=RobotoDraft' rel='stylesheet' type='text/css'>
<style>
	input[type=password] {font-family:"RobotoDraft"}
</style>
<script type="text/javascript">
	function win_upload(){
		var op = "width=500, height=150, left=50, top=150";
		open("pictureForm.me","",op);
	}
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
		if(f.name.value == ''){
			alert("이름을 입력하세요");
			f.name.focus();
			return false;
		}
		if(f.email.value == ''){
			alert("이메일을 입력하세요");
			f.email.focus();
			return false;
		}
		if(f.tel.value == ''){
			alert("전화번호를 입력하세요");
			f.tel.focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>
<form action="join.me" name="f" method="post" onsubmit="return inputcheck(this)">
  <input type="hidden" name="dphoto" value="">
  <div style="display:flex; justify-content: center;">
  <table style="padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;"><caption>회원가입</caption>
  <tr><th colspan="3">반려인 정보</th></tr>
  <tr><th>아이디</th><td colspan="2"><input type="text" name="id"></td></tr>
  <tr><th>비밀번호</th><td colspan="2"><input type="password" name="pass"></td></tr>
  <tr><th>이름</th><td colspan="2"><input type="text" name="name"></td></tr>
  <tr><th>이메일</th><td colspan="2"><input type="text" name="email"></td></tr>
  <tr><th>전화번호</th><td colspan="2"><input type="text" name="tel"></td></tr>
  <tr><th colspan="3">반려견 정보</th></tr>
  <tr><td rowspan="3" valign="bottom">
  	<img src="" width="100" height="120" id="pic"><br>
  	<font size="1"><a href="javascript:win_upload()">사진등록</a></font></td>
  	  <th>반려견 이름</th><td><input type="text" name="dname"></td></tr>
  <tr><th>반려견 나이</th><td><input type="text" name="dage"></td></tr>
  <tr><th>반려견 성별</th><td><input type="radio" name="dsex" value="1" checked>남
  					  	  <input type="radio" name="dsex" value="2">여</td></tr>
  <tr><th colspan="3"><input type="submit" value="회원가입"></th>
  </table></div>
</form>
</body>
</html>