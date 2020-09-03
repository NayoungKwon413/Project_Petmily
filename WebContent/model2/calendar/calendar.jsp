<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%-- /WebContent/model2/calendar/calendar.jsp --%>
<!DOCTYPE html>
<html>
<head>
<link href='../../css/fullcalendar.css' rel='stylesheet' type='text/css'/>
<link href='../../css/daygrid.css' rel='stylesheet' type='text/css'/>
<link href='../../css/timegrid.css' rel='stylesheet' type='text/css'/>
<script src="../../js/fullcalendar.js"></script>
<script src="../../js/daygrid.js"></script>
<script src="../../js/timegrid.js"></script>
<script src="../../js/interaction.js"></script>

<sql:setDataSource var="conn" driver="org.mariadb.jdbc.Driver" 
	url="jdbc:mariadb://localhost:3306/petmilydb"
	user="scott" password="4151" />
	<sql:query var="rs" dataSource="${conn}">
	select * from calendar
	where id = '${sessionScope.login}'
</sql:query>

<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function(){
		var calendarEl = document.getElementById('calendar');
		var calendar = new FullCalendar.Calendar(calendarEl, {
			plugins : ['dayGrid', 'timeGrid', 'interaction'],
			defaultView : 'dayGridMonth',
			defaultDate : new Date(),
			header : {
				left : 'prev, next, today',
				center : 'title',
				right : '',
			},
			events : [
				<c:forEach items="${rs.rows}" var="c">
				{
					start : '${c.startdate}',
					end : '${c.enddate}'+'T23:59:00',
					title : '${c.plan}',
					color : '#337AB7',
					calno : ${c.calno},
					id : '${c.id}',
					starttime : '${c.starttime}',
					endtime : '${c.endtime}',
					url : 'planview.do?calno='+${c.calno} + '&id=${c.id}',
				},
				</c:forEach>
				],
				displayEventTime: false,
				eventClick : function(calno){
					calno.jsEvent.preventDefault();
					var start = calno.event.start;
					var end = calno.event.end;
					var op = "width=800, height=600, menubar=no, top=20, left=200";
					window.open(calno.event.url, "", op);
				}
		});
		calendar.render();
	});

	function win_open(page){
		var op = "width=800, height=600, menubar=no, top=20, left=200";
		open(page+ ".do","", op);
	}
</script>
<meta charset="EUC-KR">
<title>Calendar</title>
</head>
<body>
<div>
<div style="float:right;">
	<input type="button" value="일정 등록" onclick="javascript:win_open('addplanForm')">
</div>
<div id='calendar' style="justify-content: center;"></div>
</div>
</body>
</html>