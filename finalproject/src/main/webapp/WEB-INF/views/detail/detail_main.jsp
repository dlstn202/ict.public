<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
			<!DOCTYPE html>
			<html>

			<head>
				<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
				<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
				<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
				<link rel="stylesheet"
					href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
				<meta charset="UTF-8">
				<title>캠프로버</title>
				<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/setting.css">
				<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/plugin.css">
				<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/template.css">
				<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
				<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/detail.css">
				<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/nav.css">
				<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
				<script type="text/javascript">

					//main 초기화
					$.ajax({
						url: "nav.do",
						success: function (res_data) {	
							$("#detail_nav").html(res_data);
							$.ajax({
								url: "detail_container_info.do",
								data:{"contentId":"${contentId}"},
								success: function (res_data) {
									$("#container_info").html(res_data);
									
									$.ajax({
										url: "detail_container_notice.do",
										success: function (res_data) {
											$("#container_notice").html(res_data);
											$.ajax({
												url: "detail_container_insert_review.do",
												data:{"contentId":"${contentId}"},
												success: function (res_data) {
													$("#container_insert_review").html(res_data);
													$.ajax({
														url: "review/list.do",
														data:{"contentId":"${contentId}"},
														success: function (res_data) {
															$("#container_review").html(res_data);
															$.ajax({
																url: "footer.do",
																success: function (res_data) {
																	$("#detail_footer").html(res_data);
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





				</script>
			</head>

			<body>
				<div id="detail_nav"></div>
				<div id="container_info"></div>
				<div id="container_notice"></div>
				<div id="container_insert_review"></div>
				<div id="container_review"></div>
				<div id="detail_footer"></div>

			</body>

			</html>