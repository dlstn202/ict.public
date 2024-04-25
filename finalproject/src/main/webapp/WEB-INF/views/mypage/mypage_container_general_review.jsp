<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="mypage_container_general_review_modal.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script>


function showGeneralReviewModal(index,rev_idx,pho_idx){
	
		let rev_content		= $("#rev_content" + rev_idx).val();
		let contentId		= $("#contentId" + rev_idx).val();
		let rev_grade       = $("#rev_grade" + rev_idx).val();
        let facltNm         = $("#facltNm"+ rev_idx).text();
        let photo_yn        = $("#photo_yn"+ rev_idx).val();
        let pho_list        = $("input.photo-input[data-rev-idx='" + rev_idx + "']");
        let pho_list_values = $("input.photo-input[data-rev-idx='" + rev_idx + "']").map(function() {
                                    return $(this).val();
                                }).get();
        let $photoInputDiv = $("#photo_input");
        $photoInputDiv.empty();

        pho_list_values.forEach(pho_name => {
            $photoInputDiv.append("<input type='hidden' name='pho_name' value='" 
            + pho_name + "' id='photo_" 
            + pho_name.replace('.', '_') + "'><img src='${pageContext.request.contextPath}/review_file_upload/" 
            + pho_name + "' id='photo_name_"
            + pho_name.replace('.', '_')+"' name='pho_name' class='pho_name'><p id='photo_name_a_" 
            + pho_name.replace('.', '_') + "' onclick='photo_del(\"" 
            + pho_name + "\");'>X</p>");
});
        
        $("#rev_idx").val(rev_idx);
        $("#del_rev_idx").val(rev_idx);
        $("#rev_content_input").val(rev_content);
        $("#contentId_input").val(contentId);
        $("#facltNm_input").text(facltNm);
        $("#photo_yn_input").val(photo_yn);

        $("#myInput input[name='rev_grade'][value='" + rev_grade + "']").prop("checked", true); // 해당 별점 선택

        $("#GeneralReviewModal").modal('show');
        $("#GeneralReviewModal").modal({backdrop : "static"});
	}

</script>

<script type="text/javascript">

function photo_del(pho_name) {
    
    if (confirm("정말 삭제하시겠습니까?") == false) return;
    var photo_idx = "photo_"+pho_name.replace('.', '_');
    var photo_name = "photo_name_"+pho_name.replace('.', '_');
    var photo_name_a = "photo_name_a_"+pho_name.replace('.', '_');
    console.log(photo_name_a);
    
        $("#"+photo_idx).removeAttr('name');
        $("#"+photo_name).css("display","none");
        $("#"+photo_name_a).hide();
}
</script> 


</head>
<body>
    
    <!-- 리뷰 목록 -->

    <main class="th-layout-main">
        <div id="my_review">
            <div class="my_info_title">내 리뷰</div>
        </div>
        <div class="my_review_lists">
        <c:forEach var="vo" items="${ review_list }" varStatus="i">
            <div class="my_review_list_box">
                <input type="hidden" id="rev_idx${vo.rev_idx}" name="rev_idx" value="${vo.rev_idx}">
                <input type="hidden" id="contentId${vo.rev_idx}" name="contentId" value="${vo.contentId}">
                <input type="hidden" id="rev_content${vo.rev_idx}" name="rev_content" value="${vo.rev_content}">    
                <input type="hidden" id="photo_yn${vo.rev_idx}" name="photo_yn" value="${vo.photo_yn}">
                <input type="hidden" id="pho_idx${photo_vo.pho_idx}" name="pho_idx" value="${photo_vo.pho_idx}">
                

                <!-- 리뷰 좋아요 -->
                <div class="mypage_reviewlist_heart_btn">
                    <div class="rev_keep_heart"><i class="fa-regular fa-heart">
                    </i>&nbsp;<div class="hea_num">${vo.hea_num}</div>
                </div>

                <button class="mypage_reviewlist_btn"   onclick="showGeneralReviewModal('${i.index}','${vo.rev_idx}','${photo_vo.pho_idx}');">
                    <c:if test="${empty vo.photo_list}">
                        
                        <div class="mypage_review_backimage" style="background-image:url('${pageContext.request.contextPath}/assets/img/sample/img_glamping_N5_1.png');"></div>
                    </c:if>
                    <c:if test="${not empty vo.photo_list}">
                        <div class="mypage_review_backimage" style="background-image:url('${pageContext.request.contextPath}/review_file_upload/${vo.photo_list[0].pho_name}');"></div>
                        <input type="hidden" id="pho_name${photo_vo.pho_idx}" name="photo " value="${photo_vo.pho_name}">

                        <c:forEach var="photo_vo" items="${vo.photo_list}">
                            
                            <input type="hidden" class="photo-input" data-rev-idx="${vo.rev_idx}" value="${photo_vo.pho_name}">
                            
                        </c:forEach>
                    </c:if>
                    
                    <div class="mypage_review_info">
                        <div class="star-rating">
                            <input type="hidden" id="rev_grade${vo.rev_idx}" name="rev_grade" value="${vo.rev_grade}">${vo.re_star}
                        </div>
                        <div class="review_addr ellipsis">${vo.addr1}</div>
                        <div class="review_title_star">
                        <div class="review_title ellipsis" name="facltNm" id="facltNm${vo.rev_idx}" value="${vo.facltNm}">${vo.facltNm}</div>
                            
                        </div>
                    </div>
                </button>
            </div>
        </c:forEach>
    </div>
            
        <c:if test="${empty review_list}">
                <hr>
                <div class="no">
                   <p style="color:red;">등록된 리뷰가 없습니다</p>
                </div>
        </c:if>

        

        <!-- 페이징 -->
            <!-- <nav class="pagiset pagiset-circ">
                <div class="pagiset-ctrl">
                    <a class="pagiset-link pagiset-first" href="javascript:void(0)">
                    <span class="visually-hidden">처음</span>
                    </a>
                </div>
                <div class="pagiset-ctrl">
                    <a class="pagiset-link pagiset-prev" href="javascript:void(0)">
                    <span class="visually-hidden">이전</span>
                    </a>
                </div>
                <div class="pagiset-list">
                    <a class="pagiset-link active-fill" href="javascript:void(0)">1</a>
                    <a class="pagiset-link" href="javascript:void(0)">2</a>
                    <a class="pagiset-link" href="javascript:void(0)">3</a>
                </div>
                <div class="pagiset-ctrl">
                    <a class="pagiset-link pagiset-next" href="javascript:void(0)">
                    <span class="visually-hidden">다음</span>
                    </a>
                </div>
                <div class="pagiset-ctrl">
                    <a class="pagiset-link pagiset-last" href="javascript:void(0)">
                    <span class="visually-hidden">마지막</span>
                    </a>
                </div>
            </nav> -->
    </main>
</body>
</html>