<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- /WebContent/model2/calendar/planview.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>일정 확인하기</title>
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript">
	function plandelete(){
		var msg = confirm("일정을 삭제하시겠습니까?");
		if(msg == true){
			document.location.href="plandelete.do?calno=${cal.calno}&id=${cal.id}";	
		}else{
			return false;
		}
	}
</script>
</head>
<body>
<form name="f">
<div style="display:flex; justify-content: center; margin-top:100px;">
<input type="hidden" name="calno" value="${cal.calno}">
<input type="hidden" name="id" value="${cal.id}">
<table style="padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;"><caption>일정 확인</caption>
<fmt:formatDate value="${cal.startdate}" pattern="yyyy-MM-dd" var="startdate"/>
<fmt:formatDate value="${cal.enddate}" pattern="yyyy-MM-dd" var="enddate"/>
<tr><th>일정 시작 날짜</th><td>${startdate}</td><th>일정 시작 시간</th><td>${cal.starttime}</td></tr>
<tr><th>일정 끝 날짜</th><td>${enddate}</td><th>일정 끝 시간</th><td>${cal.endtime}</td></tr>
<tr><th>일정 내용</th><td colspan="3">${cal.plan}</td></tr>
<tr><th colspan="4"><input type="button" value="일정 수정" onclick="location.href='planupdateForm.do?calno='+${cal.calno}+'&id=${cal.id}'">
					<input type="button" value="일정 삭제" onclick="javascript:plandelete()">
					<input type="button" value="확인" onclick="window.close()"></th></tr>
</table>
</div>
</form>
</body>
</html>