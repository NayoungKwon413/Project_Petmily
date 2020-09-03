<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- /WebContent/model2/dailycare/dcdetail.jsp 
	1. id 파라미터값 조회
	2. login 상태 검증
		로그아웃 상태 : "로그인하세요" 메세지 출력 후 loginForm.jsp 로 페이지 이동
	3. login 상태 검증2
		id 파라미터값과 login id 가 다른 경우, "내 정보만 조회 가능합니다." 출력후 home.jsp 로 이동
	4. db에서 id 값으로 데이터 조회 : selectOne(id) 사용
	5. 조회된 내용 섹션1 출력
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>  
<title>Dailycare 상세페이지</title>
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript">
	function win_open(page){
		var op = "width=800, height=600, menubar=no, top=20, left=200";
		open(page+ ".do","", op);
	}
	
	$(function() {
	    $( "#search" ).datepicker({
	    	dateFormat : 'yy-mm',
	    	showOtherMonths : true,
	    	changeYear : true,
	    	changeMonth : true,
	    });
	    $("#search").datepicker('setDate', 'today');
	});
</script>
</head>
<body>
<!-- 반려견 정보 조회 섹션 -->
<div style="display:flex; justify-content: center;">
<table style="width:50%; padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;">
<tr><th colspan="3">반려견 정보</th></tr>
<tr><td rowspan="3"><img src="../member/dphoto/${mem.dphoto}" width="200" height="210"></td>
	<th>반려견 이름</th><td>${mem.dname}</td></tr>
<tr><th>반려견 나이</th><td>${mem.dage}</td></tr>
<tr><th>반려견 성별</th><td>${mem.dsex == 1?"남":"여"}</td></tr>
</table>
</div>

<br>

<!-- 체중 및 bcs 날짜로 검색 -->
<form name="sf" action="dcdetail.do" method="post">
<div style="display:flex; justify-content: center;">
<!-- <input type="hidden" name="id" value="${sessionScope.login}">  -->
<input style="width:30%;" type="text" name="search" id="search" value="${param.search}"> 
<input type="submit" value="검색">
</div><br>
</form>

<!-- 체중 및 bcs 조회 및 입력,수정,분석 섹션 -->
<div style="display:flex; justify-content: center;">
<table style="width:50%; padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;">
<tr><th>입력 날짜</th><th>몸무게</th><th>BCS</th></tr>

<c:if test="${dccount == 0}">
<tr><td colspan="3">등록된 데이터가 없습니다.</td></tr></c:if>
<c:if test="${dccount > 0}">

<c:forEach var="dc" items="${dclist}">
<tr><td>${dc.caredate}</td><td>${dc.weight}</td>
	<c:choose>
	<c:when test="${dc.bcs == 1}"> <td>매우 마름</td></tr></c:when>
	<c:when test="${dc.bcs == 2}"> <td>저체중</td></tr></c:when>
	<c:when test="${dc.bcs == 3}"> <td>적정 체중</td></tr></c:when>
	<c:when test="${dc.bcs == 4}"> <td>과체중</td></tr></c:when>
	<c:when test="${dc.bcs == 5}"> <td>비만</td></tr></c:when>
	</c:choose>
</c:forEach>
</c:if>
<tr><th colspan="3">
			<input type="button" value="입력" onclick="javascript:win_open('dcinsertForm')">
			<input type="button" value="수정" onclick="javascript:win_open('dcupdateForm')">
			<input type="button" value="분석" onclick="location.href='dcgraph.do?id=${mem.id}'"></th>
</table>
</div>
<br><br>

<!-- 기타 헬스케어 메모 입력및조회 섹션 -->
<div style="display:flex; justify-content: center;">
<input type="hidden" name="id" value="${sessionScope.login}">
<table style="width:80%; padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;"><caption>알러지 정보 및 기타 헬스케어 관련 메모 내역</caption>
<tr><th>no</th><th>memo</th></tr>
<c:forEach var="cm" items="${memolist}">
<tr><td>${cm.memono}</td><td style="text-align:left;">&nbsp;&nbsp;${cm.memo}</td></tr>
</c:forEach>
<tr><th colspan="2"><input type="button" value="입력" onclick="javascript:win_open('dcmemoForm')"></th></tr>
</table></div>

</body>
</html>