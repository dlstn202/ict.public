<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function delete_place(contentId){

    if(confirm("장소를 삭제하시겠습니까?")==false) return;

    $.ajax({
        url : "place_keep_delete.do",
        data : {contentId:contentId},
        dataType :"json",
        success : function(res_data) {
            alert("삭제하였습니다");
            $.ajax({
            url: "mypage_container_general_keep_list.do",
            success: function (res_data) {
                $("#container_content").html(res_data);
                changeLiColor();
                $("#keep").css("color", "#00AF52");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.table(jqXHR)
            }
        });
        },
        error : function(err) {
            console.log(err.responseText);
        }
    });
}
</script>
</head>
<body>
    <main class="th-layout-main">
        <div id="my_keep">
            <div class="my_info_title">내 장소</div>

            
            <div class="my_keep_list">

                <c:forEach var="vo" items="${keep_list}" varStatus="i">
                
                    <div class="keep_box">
                        <div class="keep_box_img">
                            <c:if test="${!empty vo.camp_vo.firstImageUrl}">
                                <img src="${ vo.camp_vo.firstImageUrl }" alt="">
                            </c:if>
                            <c:if test="${empty vo.camp_vo.firstImageUrl}">
                                <img src="${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_1.png" alt="">
                            </c:if>
                        </div>
                            <div class="keep_box_content">
                                <div class="keep_box_content_f">
                                    <div class="hashtag">${ vo.camp_vo.induty },${vo.camp_vo.lctCl}</div>
                                    <input type="button" class="btn_keep_del" onclick="delete_place('${vo.contentId}');" value="X">
                                </div>
                                <div class="keep_title"><a href="detail_main.do?contentId=${ vo.contentId }">${ vo.facltNm }</a></div>
                                <div class="keep_addr">${ vo.camp_vo.addr1 }</div>
                                <div class="keep_line_intro">
                                    ${ vo.camp_vo.intro }
                                    <c:if test="${empty vo.camp_vo.intro}">${ vo.camp_vo.lineIntro }
                                        <c:if test="${empty vo.camp_vo.lineIntro}">${ vo.camp_vo.featureNm }</c:if>
                                    </c:if>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                    <br>
 

                </c:forEach>

                <c:if test="${ empty keep_list }">등록된 장소가 없습니다.</c:if>

            </div>


        </div>
    </main>
</body>
</html>