<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%-- /WebContent/dailycare/dcinsertForm.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>  
<title>dailycare �Է��ϱ�</title>
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript">
	function win_open(page){
		var op = "width=800, height=600, menubar=no, top=20, left=200";
		open(page+ ".do","", op);
	}

	function inputcheck(f){
		if(f.caredate.value == null || f.caredate.value==""){
			alert("��¥�� �Է����ּ���");
			f.caredate.focus();
			return false;
		}else if(f.weight.value == null || f.weight.value == ""){
			alert("�����Ը� �Է����ּ���");
			f.weight.focus();
			return false;
		}else if(f.bcs.value == null || f.bcs.value == ""){
			alert("BCS�� �������ּ���");
			f.bcs.focus();
			return false;
		}
		return true;
	}
	
	$(function() {
	    $( "#caredate" ).datepicker({
	    	dateFormat : 'yy-mm',
	    	showOtherMonths : true,
	    	changeYear : true,
	    	changeMonth : true,	
	    });
	    $("#caredate").datepicker('setDate', 'today');
<%--	    caredate.value=$("#caredate").val();  --%>
	});
	
</script>
</head>
<body>
<form action="dcinsert.do" method="post" name="f" onsubmit="return inputcheck(this)">
<input type="hidden" name="id" value="${sessionScope.login}">
<div style="display:flex; justify-content: center; margin-top:100px;">
<table style="width:50%; padding : 10px; border-left : hidden; border-right:hidden; border-collapse: collapse;">
<caption>dailycare ü�� �� BCS �Է��ϱ�</caption>
<tr><th>�Է� ��¥</th><td><input type="text" name="caredate" id="caredate"></td></tr>
<tr><th>������</th><td><input type="text" name="weight" style="width:70%;">&nbsp;kg</td></tr>
<tr><th>BCS <input type="button" value="����" onclick="javascript:win_open('support')"></th>
				<td><select name="bcs" id="bcs">
					<option value="">�����ϼ���</option>
					<option value=1>�ſ� ����</option>
					<option value=2>��ü��</option>
					<option value=3>����ü��</option>
					<option value=4>��ü��</option>
					<option value=5>��</option></select></td></tr>
<tr><th colspan="2"><input type="submit" value="���" id="submit"><input type="button" value="���" onclick="window.close()"></th></tr>
</table></div>
</form>
</body>
</html>