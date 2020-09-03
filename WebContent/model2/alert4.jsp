<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%-- WebContent/model2/alert4.jsp --%>
<script>
	alert("${msg}");
	opener.location.href="info.do?boardno=" + ${param.boardno};
	self.close();
</script>