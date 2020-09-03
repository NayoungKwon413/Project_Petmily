<%@page import="java.awt.Graphics2D"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%-- /WebContent/model2/member/picture.jsp 
	1. 이미지파일 업로드 (->request 객체 사용 불가)
	2. 이미지파일의 3분의1 크기의 섬네일 이미지 생성. -> sm_파일이름 으로 설정
	3. opener 화면에 결과 전달 => javascript
	4. 현재화면 close() => javascript
--%>

<script type="text/javascript">
	img = opener.document.getElementById("pic");    <%--id속성이 "pic"인 이미지 파일--%>
	img.src = "dphoto/${fname}";                 <%--opener 창에 이미지가 보여짐--%>
	opener.document.f.dphoto.value = "${fname}"; <%--hidden 태그. 파라미터값 설정--%>
	self.close();
</script>

