<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%-- WebContent/model2/alert2.jsp --%>
<script>
	alert("${msg}");
	opener.location.href="dcdetail.do";
	self.close();
</script>