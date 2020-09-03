<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- /WebContent/member/home.jsp 
	1. 홈페이지의 홈 화면
	2. 로고를 누르면 바로 홈 화면으로
	3. 회원들의 사진을 전시
--%>
<c:set var="path" value="${pageContext.request.contextPath}" />  
<c:set var="path2" value="${request.getServletContext().getRealPath('')}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Petmily Home</title>
<style type="text/css">
	* { margin:0px; padding:0px; }
	.animation_canvas {
		margin-left:400px;
		overflow : hidden;
		position : relative;
		width : 600px;
		height : 700px;
	}
	.slider_panel {
		width : 5400px;     
		position : relative;
	}
	.slider_image {
		float : left;
		width : 600px;
		height : 700px;
	}
	.slider_text_panel {  
		position : absolute;   
		top : 100px;
		left : 50px;
	}
	.slider_text {
		position : absolute;
		width : 250px;
		height : 150px;
	}
	.control_panel {
		position : absolute; top: 380px; left : 280px;
		height : 13px; overflow : hidden;
	}
	.control_button {
		width : 12px; height: 46px; position: relative; float : left;
		cursor : pointer; background: url('point_button.png')
	}
	.control_button:hover {top:-16px;}
	.control_button.select {top:-31px;}
	<!-- .select : class 속성값이 select -->
</style>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$(".control_button").each(function(index){
			$(this).attr("idx", index);           // control_button class들에 각각 idx=0, idx=1 ... 속성 추가
		}).click(function(){                      // 각각 이벤트 등록: click 시 선택한 해당 class의 인덱스값 index에 저장
			var index = $(this).attr("idx");
			moveSlider(index);
		})
		$(".slider_text").css("left", -300).each(function(index){
			$(this).attr("idx", index);          // slider_text class들에 각각 idx=index 속성 추가
		});
		moveSlider(0);     // 초기화면은 첫번째 이미지 출력
		
		// 화면이 로드되자마자 자동으로 2초간격으로 이미지를 움직이기
		var idx = 0;  // 초기값
		var inc = 1;  // 증감값
		setInterval(function(){
			if(idx >= 8) inc = -1;
			if(idx <= 0) inc = 1;
			idx += inc;
			moveSlider(idx);
		}, 2000)
	})
	
	function moveSlider(index){
		var moveLeft = -(index*600);
		// 선택된 이미지만 화면에 보여줌
		$(".slider_panel").animate({left:moveLeft}, 'slow');
		// 해당 index의 control_button인 경우, 속성값에 "select" 등록
		$(".control_button[idx=" + index + "]").addClass("select");
		$(".control_button[idx!=" + index + "]").removeClass("select");
		$(".slider_text[idx=" + index + "]").show().animate({
			left : 0
		}, "slow")
		$(".slider_text[idx !=" + index + "]").hide("slow", function(){
			$(this).css("left", -300);
		})
	}
</script>
</head>
<body>
<div class="animation_canvas">
	<div class="slider_panel">
		<img src="${path}/model2/img/a1.jpg" class="slider_image" />
		<img src="${path}/model2/img/a7.jpg" class="slider_image" />
		<img src="${path}/model2/img/a8.jpg" class="slider_image" />
		<img src="${path}/model2/img/a9.jpg" class="slider_image" />
		<img src="${path}/model2/img/a2.jpg" class="slider_image" />
		<img src="${path}/model2/img/a3.jpg" class="slider_image" />
		<img src="${path}/model2/img/a4.jpg" class="slider_image" />
		<img src="${path}/model2/img/a5.jpg" class="slider_image" />
		<img src="${path}/model2/img/a6.jpg" class="slider_image" />
	</div>
<!--	<div class="slider_text_panel">
		<div class="slider_text"><h1>사막이미지</h1><p>더운사막</p></div>
		<div class="slider_text"><h1>수국이미지</h1><p>물에서 자라는 수생식물</p></div>
		<div class="slider_text"><h1>해파리이미지</h1><p>해파리는 독이 있음</p></div>
		<div class="slider_text"><h1>코알라이미지</h1><p>코알라는 유칼립투스를 좋아해</p></div>
		<div class="slider_text"><h1>등대이미지</h1><p>빨간 등대</p></div>
	</div>    -->
</div>
<div class="control_panel">
	<div class="control_button"></div>
	<div class="control_button"></div>
	<div class="control_button"></div>
	<div class="control_button"></div>
	<div class="control_button"></div>
	<div class="control_button"></div>
	<div class="control_button"></div>
	<div class="control_button"></div>
	<div class="control_button"></div>
</div>
</body>
</html>