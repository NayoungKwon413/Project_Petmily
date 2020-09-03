<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%-- /WebContent/model2/dailycare/dcgraph.jsp --%>
<c:set var="path" value="${pageContext.request.contextPath}" />  
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>dailycare 데이터 분석하기</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src="http://www.chartjs.org/dist/2.9.3/Chart.min.js"></script> 
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript"
	src="http://cdn.ckeditor.com/4.5.7/full/ckeditor.js"></script>
<style>
	h3 {background-color : #A9D0F5; text-align: center;}
	canvas {
		-moz-user-select: none;
		-webkit-user-select : none;
		-ms-user-select: none;
	}
</style>

<sql:setDataSource var="conn" driver="org.mariadb.jdbc.Driver" 
	url="jdbc:mariadb://localhost:3306/petmilydb"
	user="scott" password="4151" />
	<sql:query var="rs" dataSource="${conn}">
	select caredate, weight, bcs from dailycare
	where id = '${sessionScope.login}'
	order by caredate
</sql:query>

</head>
<body>
<h3>월별 몸무게 및 BCS 변화 추이 분석</h3><br>
<div style="display:flex; justify-content: center;">
<div style="width:80%; border: 1px solid black;">
	<canvas id="canvas1" style="width:100%; height:100%;"></canvas>
</div>
&nbsp;&nbsp;
<div style="width:80%; border: 1px solid black;">
<canvas id="canvas2" style="width:100%; height:100%;"></canvas>
</div></div>
<script>
		var weightData = {
			labels : [<c:forEach items="${rs.rows}" var="m">
						"${m.caredate}", </c:forEach>],
			datasets : [
				{
					type : 'line',
					borderColor : 'red',
					borderWidth : 2,
					label : "몸무게",
					fill : false,
					data : [<c:forEach items="${rs.rows}" var="m">
							"${m.weight}", </c:forEach>],
				}, {
					type : 'bar',
					label : '몸무게',
					backgroundColor : '#F6CECE',
					borderWidth : 2,
					data : [<c:forEach items="${rs.rows}" var="m">
							"${m.weight}",
							</c:forEach>],
				}
			]
		};
		
		var bcsData = {
				labels : [<c:forEach items="${rs.rows}" var="m">
							"${m.caredate}", </c:forEach>],
				datasets : [
					{
						type : 'line',
						borderColor : 'blue',
						borderWidth : 2,
						label : "BCS",
						fill : false,
						data : [<c:forEach items="${rs.rows}" var="m">
								"${m.bcs}", </c:forEach>],
					}, {
						type : 'bar',
						label : 'BCS',
						backgroundColor : '#A9BCF5',
						borderWidth : 2,
						data : [<c:forEach items="${rs.rows}" var="m">
								"${m.bcs}",
								</c:forEach>],
					}
				]
			};
		
		window.onload = function() {
			var ctx1 = document.getElementById('canvas1').getContext('2d');
			var ctx2 = document.getElementById('canvas2').getContext('2d');
			new Chart(ctx1, {
				type : 'bar',
				data : weightData,
				options :{
					responsive : false,
					legend : {display : false},
					scales : {
						xAxes : [{
							display : true,
							scaleLabel : {
								display : true,
								labelString : "입력년월"
							},
							stacked : true
						}],
						yAxes : [{
							display : true,
							scaleLabel : {
								display : true,
								labelString : "몸무게(kg)"
							},
							stacked : true
						}]
					},
					animation : {
						animation:true,
						duration: 3000,
					}
				}
			});
			new Chart(ctx2, {
				type : 'bar',
				data : bcsData,
				options :{
					responsive : false,
					legend : {display : false},
					scales : {
						xAxes : [{
							display : true,
							scaleLabel : {
								display : true,
								labelString : "입력년월"
							},
							stacked : true
						}],
						yAxes : [{
							ticks:{
								callback : function(bcs){
									if(bcs == 1){return "매우 마름";}
									if(bcs == 2){return "저체중";}
									if(bcs == 3){return "적정 체중";}
									if(bcs == 4){return "과체중";}
									if(bcs == 5){return "비만";}
									},
							},
							display : true,
							scaleLabel : {
								display : true,
								labelString : "BCS(Body Condition Scale)"
							},
							stacked : true
						}]
					},
					animation : {
						animation:true,
						duration: 3000,
					}
				}
			});
		}
</script>
</body>
</html>