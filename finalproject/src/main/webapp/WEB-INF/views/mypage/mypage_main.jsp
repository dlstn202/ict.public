<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../all/chatbot.jsp" %>
<!DOCTYPE html>
<html>

<head>
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<!-- include summernote css/js -->
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	<meta charset="UTF-8">
	<title>캠프로버</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/setting.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugin.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/template.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/mypage.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/nav.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/qna.css">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script type="text/javascript">
		
		$(document).ready(function(){
			if('${empty user}' == 'true'){
				location.href = 'login_main.do?timeout=true';
				return;
			}
			if('${qna_result}' == 'true'){
				alert("문의 등록이 됐습니다.");
			}

			if('${not empty qna_result}' == 'true' && '${qna_result}' == 'false'){
				alert("문의 등록이 되지않았습니다.\rcamprover@naver.com으로 메일부탁드립니다.");
			}

			//main 초기화
			$.ajax({
				url: "nav.do",
				success: function (res_data) {
					$("#main_general_nav").html(res_data);
					$.ajax({
						url: "mypage_header.do",
						success: function (res_data) {
							$("#mypage_header").html(res_data);
							//contanier_list
							$.ajax({
								url: "mypage_container_list.do",
								success: function (res_data) {
									$("#container_list").html(res_data);
									// 세션에 저장되어있는 메뉴 번호 가져와서 해당 메뉴 실행
									var now_menu = parseInt(sessionStorage.getItem('mypage_menu'));
									switch (now_menu) {
										case 1:  container_info(); 		break;
										case 2:	 keep_list();	  		break;
										case 3:	 mygeneral_reserve(); 	break;
										case 4:	 inquiry(); 		  	break;
										case 5:	 review(); 				break;
										case 6:	 business(); 			break;
										case 7:	 ceo_room(); 			break;
										case 8:	 member(); 				break;
										case 9:	 qna(); 				break;
										case 10: faq(); 				break;
										case 11: notice(); 				break;
										case 12: req_content(); 		break;
										case 13: report(); 				break;
										case 14: authorize(); 			break;
										case 15: manager_modify_camp(); break;
										case 16: room_rev(); 			break;
										case 17: room_rev_old(); 		break;
										default: container_info();
									}
									$.ajax({
										url: "footer.do",
										success: function (res_data) {
											$("#main_general_footer").html(res_data);
										},
										error: function (jqXHR, textStatus, errorThrown) {
											console.table(jqXHR)
										}

									});
								},
								error: function (jqXHR, textStatus, errorThrown) {
									console.table(jqXHR)
								}

							});
						},

						error: function (jqXHR, textStatus, errorThrown) {
							console.table(jqXHR)
						}
					});
				},
				error: function (jqXHR, textStatus, errorThrown) {
					console.table(jqXHR)
				}

			});
		});



		if("${mem_del}" =="del"){
			alert("회원 탈퇴가 성공적으로 됐습니다.");
		}

		if("${not empty change_pwd_error}" =="true"){
			alert("비밀번호 초기화가 안됐습니다. \r사유 : "+"${change_pwd_error}");
		}

		if("${not empty change_pwd_error}" =="true"){
			alert("비밀번호 초기화가 안됐습니다. \r사유 : "+"${change_pwd_error}");
		}

		if("${change_pwd_result}" =="true" && "${change_pwd_pwd}" =="true"){
			alert("비밀번호 초기화가 성공적으로 됐습니다.");
		}
		
		if("${not empty mem_update_g}" =="true"){
			if("${mem_update_g}" =="true"){
				alert("업데이트가 성공적으로 됐습니다.");
			}else{
				alert("업데이트가 실패 됐습니다.");
			}
		}
		

		if("${kakao_insert}" =="true"){
			alert("카카오 연동이 성공적으로 됐습니다.");
		}
		
		if("${kakao_insert_error}" =="true"){
			alert("카카오 연동이 실패했습니다.\r관리자에게 문의바랍니다.");
		}

		if("${naver_insert}" =="true"){
			alert("네이버 연동이 성공적으로 됐습니다.");
		}

		if("${naver_insert_error}" =="true"){
			alert("네이버 연동이 실패했습니다.\r관리자에게 문의바랍니다.");
		}
		if("${google_insert}" =="true"){
			alert("구글 연동이 성공적으로 됐습니다.");
		}

		if("${google_insert_error}" =="true"){
			alert("구글 연동이 실패했습니다.\r관리자에게 문의바랍니다.");
		}
		


		// //리뷰
		// $.ajax({
		// 	url: "mygeneral_container_review.do",
		// 	success: function (res_data) {
		// 		$("#container_review").html(res_data);
		// 	},
		// 	error: function (jqXHR, textStatus, errorThrown) {
		// 		console.table(jqXHR)
		// 	}

		// });



	</script>
</head>

<body>
	<button class="chat_open_btn" onclick="openChatBotModal();">챗봇</button>
	<div id="main_general_nav"></div>
	<div id="mypage_header"></div>
	<div class="container">
		<div id="container_list"></div>
		<div id="container_content"></div>
	</div>
	<div id="main_general_footer"></div>

</body>

</html>