<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- /WebContent/model2/calendar/planupdateForm.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>일정 수정하기</title>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>  
<link rel="stylesheet" href="../../css/jquery.timepicker.css">
<script src="../../js/jquery.timepicker.js"></script>
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript">
	function inputcheck(f){
		if(f.startdate.value == null || f.startdate.value==""){
			alert("일정이 시작하는 날짜를 입력해주세요");
			f.startdate.focus();
			return false;
		}else if(f.enddate.value == null || f.enddate.value == ""){
			alert("일정이 끝나는 날짜를 입력해주세요");
			f.enddate.focus();
			return false;
		}else if(f.plan.value == null || f.plan.value == ""){
			alert("일정 내용을 입력해주세요");
			f.plan.focus();
			return false;
		}
		return true;
	}
	
	$(function() {
	    $( "#startdate" ).datepicker({
	    	dateFormat : 'yy-mm-dd',
	    	showOtherMonths : true,
	    	changeYear : true,
	    	changeMonth : true,	
	    });
//	    $("#startdate").datepicker('setDate', 'today');

		$( "#enddate" ).datepicker({
			dateFormat : 'yy-mm-dd',
			showOtherMonths : true,
			changeYear : true,
			changeMonth : true,	
		});
//		$("#enddate").datepicker('setDate', 'today');
		
		$("#starttime").timepicker({
			timeFormat : "HH:mm",
			interval : 10,
			dynamic : false,
			dropdown : true,
			scrollbar : true
		});
		$("#endtime").timepicker({
			timeFormat : "HH:mm",
			interval : 10,
			dynamic : false,
			dropdown : true,
			scrollbar : true
		});
	});
</script>
</head>
<body>
<form action="planupdate.do" method="post" name="f" onsubmit="return inputcheck(this)">
<input type="hidden" name="calno" value="${param.calno}">
<input type="hidden" name="id" value="${param.id}">
<div style="display:flex; justify-content: center; margin-top:100px;">
<table style="padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;"><caption>일정 수정</caption>
<fmt:formatDate value="${cal.startdate}" pattern="yyyy-MM-dd" var="startdate"/>
<fmt:formatDate value="${cal.enddate}" pattern="yyyy-MM-dd" var="enddate"/>
	<tr><th>일정 시작 날짜</th><td><input id="startdate" name="startdate" type="text" value="${startdate}"></td>
		<th>일정 시작 시간</th><td><input type="text" id="starttime" name="starttime" value="${cal.starttime}"></td></tr>
	<tr><th>일정 끝 날짜</th><td><input id="enddate" name="enddate" type="text" value="${enddate}"></td>
		<th>일정 끝 시간</th><td><input type="text" id="endtime" name="endtime" value="${cal.endtime}"></td></tr>
	<tr><th>일정 내용</th><td colspan="3"><input type="text" name="plan" value="${cal.plan}"></td></tr>
	<tr><th colspan="4"><input type="submit" value="수정" id="submit"><input type="button" value="취소" onclick="window.close()"></th></tr>
</table></div>
</form>
</body>
</html>