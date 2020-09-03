<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Calendar</title>

<link rel="stylesheet" href="../calendar/vendor/css/fullcalendar.min.css" />
<link rel="stylesheet" href="../calendar/vendor/css/bootstrap.min.css">
<link rel="stylesheet" href='../calendar/vendor/css/select2.min.css' />
<link rel="stylesheet"
	href='../calendar/vendor/css/bootstrap-datetimepicker.min.css' />

<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Open+Sans:400,500,600">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">

<link rel="stylesheet" href="../calendar/css/main.css">

</head>

<body>
	<div class="container">

		<!-- 일자 클릭시 메뉴오픈 -->
		<div id="contextMenu" class="dropdown clearfix">
			<ul class="dropdown-menu dropNewEvent" role="menu"
				aria-labelledby="dropdownMenu"
				style="display: block; position: static; margin-bottom: 5px;">
				<li><a tabindex="-1" href="#">Create</a></li>
				<li class="divider"></li>
				<li><a tabindex="-1" href="#" data-role="close">Close</a></li>
			</ul>
		</div>

		<div id="wrapper">
			<div id="loading"></div>
			<div id="calendar"></div>
		</div>


		<!-- 일정 추가 MODAL -->
		<div class="modal fade" tabindex="-1" role="dialog" id="eventModal">
			<div class="modal-dialog" role="document" style="height: 100%; margin-top: 0px; margin-right: 0px;">
				<div class="modal-content" style="float: right;height: 100%;">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title"></h4>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-xs-12">
								<label class="col-xs-4" for="subject">회의제목</label> <input
									class="inputModal" type="text" name="subject"
									id="subject" required="required" />
							</div>
						</div>
						
						<div class="row">
							<div class="col-xs-12">
								<label class="col-xs-4" for="content">회의내용</label>
								<textarea rows="10" cols="50" class="inputModal" name="content"
									id="content" style="resize: none;"></textarea>
							</div>
						</div>
						
						<div class="row">
							<div class="col-xs-12">
								<label class="col-xs-4" for="start">시작시간</label> <input
									class="inputModal" type="text" name="start"
									id="start" />
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12">
								<label class="col-xs-4" for="end">종료시간</label> <input
									class="inputModal" type="text" name="end" id="end" />
							</div>
						</div>
						
						<div class="row">
							<div class="col-xs-12">
								<label class="col-xs-4" for="color">색상</label> <select
									class="inputModal" name="color" id="color">
									<option value="#D25565" style="color: #D25565;">빨간색</option>
									<option value="#9775fa" style="color: #9775fa;">보라색</option>
									<option value="#ffa94d" style="color: #ffa94d;">주황색</option>
									<option value="#74c0fc" style="color: #74c0fc;">파란색</option>
									<option value="#f06595" style="color: #f06595;">핑크색</option>
									<option value="#63e6be" style="color: #63e6be;">연두색</option>
									<option value="#a9e34b" style="color: #a9e34b;">초록색</option>
									<option value="#4d638c" style="color: #4d638c;">남색</option>
									<option value="#495057" style="color: #495057;">검정색</option>
								</select>
							</div>
						</div>
						
					</div>
					<div class="modal-footer modalBtnContainer-addEvent">
						<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary" id="save-event">저장</button>
					</div>
					<div class="modal-footer modalBtnContainer-modifyEvent">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-danger" id="deleteEvent">삭제</button>
						<button type="button" class="btn btn-primary" id="updateEvent">저장</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->

	</div>
	<!-- /.container -->
	<input class="inputModal" type="hidden" name="pno" id="pno" value="${sessionScope.list.get(0).pno}" />
	<input class="inputModal" type="hidden" name="login" id="login" value="${sessionScope.login}" />

	<script src="../calendar/vendor/js/jquery.min.js"></script>
	<script src="../calendar/vendor/js/bootstrap.min.js"></script>
	<script src="../calendar/vendor/js/moment.min.js"></script>
	<script src="../calendar/vendor/js/fullcalendar.min.js"></script>
	<script src="../calendar/vendor/js/ko.js"></script>
	<script src="../calendar/vendor/js/select2.min.js"></script>
	<script src="../calendar/vendor/js/bootstrap-datetimepicker.min.js"></script>
	
	<script type="text/javascript">
	console.log($('#name'));
	</script>
	
	<script src="../calendar/js/event.js"></script>

</body>

</html>