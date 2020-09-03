<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- /WebContent/member/home.jsp 
	1. Ȩ�������� Ȩ ȭ��
	2. �ΰ��� ������ �ٷ� Ȩ ȭ������
	3. ȸ������ ������ ����
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
	<!-- .select : class �Ӽ����� select -->
</style>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$(".control_button").each(function(index){
			$(this).attr("idx", index);           // control_button class�鿡 ���� idx=0, idx=1 ... �Ӽ� �߰�
		}).click(function(){                      // ���� �̺�Ʈ ���: click �� ������ �ش� class�� �ε����� index�� ����
			var index = $(this).attr("idx");
			moveSlider(index);
		})
		$(".slider_text").css("left", -300).each(function(index){
			$(this).attr("idx", index);          // slider_text class�鿡 ���� idx=index �Ӽ� �߰�
		});
		moveSlider(0);     // �ʱ�ȭ���� ù��° �̹��� ���
		
		// ȭ���� �ε���ڸ��� �ڵ����� 2�ʰ������� �̹����� �����̱�
		var idx = 0;  // �ʱⰪ
		var inc = 1;  // ������
		setInterval(function(){
			if(idx >= 8) inc = -1;
			if(idx <= 0) inc = 1;
			idx += inc;
			moveSlider(idx);
		}, 2000)
	})
	
	function moveSlider(index){
		var moveLeft = -(index*600);
		// ���õ� �̹����� ȭ�鿡 ������
		$(".slider_panel").animate({left:moveLeft}, 'slow');
		// �ش� index�� control_button�� ���, �Ӽ����� "select" ���
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
		<div class="slider_text"><h1>�縷�̹���</h1><p>����縷</p></div>
		<div class="slider_text"><h1>�����̹���</h1><p>������ �ڶ�� �����Ĺ�</p></div>
		<div class="slider_text"><h1>���ĸ��̹���</h1><p>���ĸ��� ���� ����</p></div>
		<div class="slider_text"><h1>�ھ˶��̹���</h1><p>�ھ˶�� ��Į�������� ������</p></div>
		<div class="slider_text"><h1>����̹���</h1><p>���� ���</p></div>
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