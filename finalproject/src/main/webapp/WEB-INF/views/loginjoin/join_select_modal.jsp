<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="joinModal" class="modal fade custom-modal-join" role="dialog">
		<div class="modal-dialog custom-modal-join">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<button id="closeJoinModal" type="button" class="close" data-dismiss="modal">&times;</button>
					<p class="modal-title">회원가입 유형 선택</p>
				</div>

				<!-- Modal body -->
				<div class="modal-body custom-modal-join">
					<div class="cn_type container">
						<input class="btn_join_type" type="button" value="일반" onclick="location.href='join_agree.do?mem_grade=general&url=${param.url}'">
						<input class="btn_join_type" type="button" value="사장" onclick="location.href='join_agree.do?mem_grade=ceo'">
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>