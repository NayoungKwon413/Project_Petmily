<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- /WebContent/model2/dailycare/dcdetail.jsp 
	1. id �Ķ���Ͱ� ��ȸ
	2. login ���� ����
		�α׾ƿ� ���� : "�α����ϼ���" �޼��� ��� �� loginForm.jsp �� ������ �̵�
	3. login ���� ����2
		id �Ķ���Ͱ��� login id �� �ٸ� ���, "�� ������ ��ȸ �����մϴ�." ����� home.jsp �� �̵�
	4. db���� id ������ ������ ��ȸ : selectOne(id) ���
	5. ��ȸ�� ���� ����1 ���
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>  
<title>Dailycare ��������</title>
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript">
	function win_open(page){
		var op = "width=800, height=600, menubar=no, top=20, left=200";
		open(page+ ".do","", op);
	}
	
	$(function() {
	    $( "#search" ).datepicker({
	    	dateFormat : 'yy-mm',
	    	showOtherMonths : true,
	    	changeYear : true,
	    	changeMonth : true,
	    });
	    $("#search").datepicker('setDate', 'today');
	});
</script>
</head>
<body>
<!-- �ݷ��� ���� ��ȸ ���� -->
<div style="display:flex; justify-content: center;">
<table style="width:50%; padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;">
<tr><th colspan="3">�ݷ��� ����</th></tr>
<tr><td rowspan="3"><img src="../member/dphoto/${mem.dphoto}" width="200" height="210"></td>
	<th>�ݷ��� �̸�</th><td>${mem.dname}</td></tr>
<tr><th>�ݷ��� ����</th><td>${mem.dage}</td></tr>
<tr><th>�ݷ��� ����</th><td>${mem.dsex == 1?"��":"��"}</td></tr>
</table>
</div>

<br>

<!-- ü�� �� bcs ��¥�� �˻� -->
<form name="sf" action="dcdetail.do" method="post">
<div style="display:flex; justify-content: center;">
<!-- <input type="hidden" name="id" value="${sessionScope.login}">  -->
<input style="width:30%;" type="text" name="search" id="search" value="${param.search}"> 
<input type="submit" value="�˻�">
</div><br>
</form>

<!-- ü�� �� bcs ��ȸ �� �Է�,����,�м� ���� -->
<div style="display:flex; justify-content: center;">
<table style="width:50%; padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;">
<tr><th>�Է� ��¥</th><th>������</th><th>BCS</th></tr>

<c:if test="${dccount == 0}">
<tr><td colspan="3">��ϵ� �����Ͱ� �����ϴ�.</td></tr></c:if>
<c:if test="${dccount > 0}">

<c:forEach var="dc" items="${dclist}">
<tr><td>${dc.caredate}</td><td>${dc.weight}</td>
	<c:choose>
	<c:when test="${dc.bcs == 1}"> <td>�ſ� ����</td></tr></c:when>
	<c:when test="${dc.bcs == 2}"> <td>��ü��</td></tr></c:when>
	<c:when test="${dc.bcs == 3}"> <td>���� ü��</td></tr></c:when>
	<c:when test="${dc.bcs == 4}"> <td>��ü��</td></tr></c:when>
	<c:when test="${dc.bcs == 5}"> <td>��</td></tr></c:when>
	</c:choose>
</c:forEach>
</c:if>
<tr><th colspan="3">
			<input type="button" value="�Է�" onclick="javascript:win_open('dcinsertForm')">
			<input type="button" value="����" onclick="javascript:win_open('dcupdateForm')">
			<input type="button" value="�м�" onclick="location.href='dcgraph.do?id=${mem.id}'"></th>
</table>
</div>
<br><br>

<!-- ��Ÿ �ｺ�ɾ� �޸� �Է¹���ȸ ���� -->
<div style="display:flex; justify-content: center;">
<input type="hidden" name="id" value="${sessionScope.login}">
<table style="width:80%; padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;"><caption>�˷��� ���� �� ��Ÿ �ｺ�ɾ� ���� �޸� ����</caption>
<tr><th>no</th><th>memo</th></tr>
<c:forEach var="cm" items="${memolist}">
<tr><td>${cm.memono}</td><td style="text-align:left;">&nbsp;&nbsp;${cm.memo}</td></tr>
</c:forEach>
<tr><th colspan="2"><input type="button" value="�Է�" onclick="javascript:win_open('dcmemoForm')"></th></tr>
</table></div>

</body>
</html>