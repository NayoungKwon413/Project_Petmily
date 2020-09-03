<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%-- WebContent/model2/alert3.jsp --%>
<script>
	alert("${msg}");
	opener.location.href="calendar.do?id=${sessionScope.login}";
	self.close();
</script>