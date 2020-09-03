<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%-- /WebContent/model2/alert5.jsp --%>
<script>
	alert("${msg}");
	opener.location.href="joinForm.me";
	self.close();
</script>