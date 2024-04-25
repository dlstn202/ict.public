<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
         <!DOCTYPE html>
         <html>

         <head>
            <meta charset="UTF-8">
            <title>Insert title here</title>

            <script>

               function setRating(rev_idx, rating) {
                $("#rev_grade_new" + rev_idx).val(rating);

                
               }
            </script>
            
            <script>
               //포토삭제
               function photo_del(pho_idx){
             
                 if(confirm("정말 삭제하시겠습니까?\n수정하기를 눌러주셔야 수정됩니다.")==false) return;

               var pho_name = "pho_name_"+pho_idx;
               var img = "img_"+pho_idx;

               $("#"+pho_name).removeAttr('name');
               $("#"+img).hide();

                           
               }
             
             </script>

            <script type="text/javascript">

               //리뷰삭제
               function delRe(rev_idx){
                  
                  if(confirm("정말 삭제하시겠습니까?")==false) return;

               
                  $.ajax({
                     url      :   "../review/delete.do",
                     data      :   {"rev_idx": rev_idx },
                     dataType   :   "json",
                     success   :   function(res_data){
                     
                        if(res_data.result){
               
                           alert('삭제 성공!!!');
                           location.href = location.href;   
                           
                        }
                     },
                     error      :   function(err){
                        alert(err.responseText);
                     }
                  });
               }
   
            </script>
            

             <script>
             function re_modify_content(f) {
      
               var rev_idx        = f.rev_idx.value.trim();
               var rev_content    = f.rev_content.value.trim();
               var rev_grade      = f.rev_grade.value;
               var file_count     = f.photo.files.length;
               var fileInput      = f.photo;

               //let file_count = f.photo.files.length;
               if(rev_grade == ''){
                  alert("별점을 입력하세요.");
                  f.rev_grade.value = '';
                  f.rev_grade.focus();
                  return;
               }
               
         
               if(rev_content == ''){
                  alert("수정할 내용이 존재하지 않습니다.");
                  f.rev_content.value = '';
                  f.rev_content.focus();
                  return;
               }

               if (file_count>5) {
                  fileInput.value = '';
               alert("첨부파일은 5개까지만 가능합니다");
               return;
               }
           
               
               var formData = new FormData(f);     
               
               
               // formData.append('rev_idx', rev_idx);
               // formData.append('rev_content', rev_content);
               // formData.append('rev_grade', rev_grade);
         
               $.ajax({
                 type: "POST",
                  url: "review/modify.do",
                  data: formData,
                  dataType: "json",
                  contentType: false,
                  processData: false,
                  success: function(res_data) {

                     if(res_data.review_no){
                        alert("욕설이 감지되었습니다.\r댓글수정에 실패했습니다.");
                        return;
                     }
                     if(res_data.result){
                        alert("리뷰 수정이 완료되었습니다.");
                        location.href = location.href;
                     }else{
                        alert("리뷰 수정 실패하였습니다.\r관리자에게 문의바랍니다.");
                        location.href = location.href;               
                        
                     }

                     
                     
                  },
                  error : function(err) {
                     console.log(err.responseText);
                  }
                  
                  
               });
               }  
            </script>

            <script>
               //별점
               $(document).ready(function(){
                  var avg = "${reviewAverage}"/5*100;
                  $("#star_avg").css("width",avg+"%");
               })
            </script>

            <script type="text/javascript">

               let re_flag_modify = {};
               
               function rev_modify_content_form(rev_idx) {

                  // var formSelector = '#form_' + rev_idx;
                  // var form = $(formSelector);

                  // // 선택된 폼으로 무언가를 수행
                  // console.log(form);

                   re_flag_modify[rev_idx] = !re_flag_modify[rev_idx];
                   
                   let review_score = $("#rev_grade_new"+rev_idx).val();
                   
                   $("#review_score_" + rev_idx + " input[name='rev_grade'][value='" + review_score + "']").prop('checked', true);   
                   
                   if (re_flag_modify[rev_idx]) {
                     // 수정 폼 및 관련 요소 표시 //수정버튼을 눌렀을때
                     $("#rev_content_form_" + rev_idx).show();
                     $("#btn_review_modify_" + rev_idx).show();
                     $("#review_score_" + rev_idx).show();
                     $("#rev_content" + rev_idx).hide();
                     $("#rev_review_star" + rev_idx).hide();
                     $("#imagein_" + rev_idx).show();
                     $(".pho_name_a_" + rev_idx).show();
                     $("#btn_re_modify_" + rev_idx).text("취소");

                   } else {
                   // 수정 폼 및 관련 요소 숨김
                     $("#btn_review_modify_" + rev_idx).hide();
                     $("#rev_content_form_" + rev_idx).hide();
                     $("#review_score_" + rev_idx).hide();
                     $("#rev_review_star" + rev_idx).show();
                     $("#rev_content" + rev_idx).show();
                     $("#photo_list_" + rev_idx+"> div").show();
                     $("#photo_list_" + rev_idx+"> .image-wrapper").each(function(index, element) {
                        $(element).find('input').each(function(inputIndex, inputElement) {
                           $(inputElement).attr('name', 'photo_idx');
                        });
                     });

                     var content =$("#rev_content" + rev_idx).html();
                     $("#re_content"+rev_idx).val(content);
                     $("#imagein_" + rev_idx).hide();
                     $(".pho_name_a_" + rev_idx).hide();
                     $("#btn_re_modify_" + rev_idx).text("수정");

                     // 파일 입력 필드 내용을 지우기
                     $("#imagein_" + rev_idx).val('');  
                     $("#imagein_" + rev_idx).hide();
                     $(".pho_name_a_" + rev_idx).hide();
                     $("#btn_re_modify_" + rev_idx).text("수정");

                   }

               }
  
            
               </script>
               <!-- 좋아요 눌렀을때 -->
               <script type="text/javascript">
                     function heartOn(rev_idx) {
                        console.log("하트추가가 눌림");
               
                           $.ajax({
                              url : "review_keep_insert.do",
                              data : {"rev_idx":rev_idx,"mem_idx":"${user.mem_idx}"
                              },
                              dataType :"json",
                              success : function(res_data) {
                                 if (res_data.result) {
                                    $("#heartOff_num_"+rev_idx).html(res_data.hea_num);
                                    $("#heartOn_num_"+rev_idx).html(res_data.hea_num);
                                    $("#rev_keep_On_"+rev_idx).css("display", "none");
                                    $("#rev_keep_Off_"+rev_idx).css("display", "");

                                 }else{
                                    alert("리뷰 좋아요가 되지않았습니다.\r관리자에게 문의바랍니다.\r사유 : "+res_data.error);
                                 }
                              },
                              error : function(err) {
                                 console.log(err.responseText);
                              }
                           });
         
                     }
               </script> 

                <!-- 좋아요 취소 -->
               <script type="text/javascript">
                  function heartOff(rev_idx) {
                     // console.log("하트취소가 눌림");
            
                     $.ajax({
                        url : "review_keep_delete.do",
                        data : {"rev_idx":rev_idx,"mem_idx":"${user.mem_idx}"},
                        dataType :"json",
                        success : function(res_data) {
                           if (res_data.result) {
                              $("#heartOff_num_"+rev_idx).html(res_data.hea_num);
                              $("#heartOn_num_"+rev_idx).html(res_data.hea_num);
                              $("#rev_keep_On_"+rev_idx).css("display", "");
                              $("#rev_keep_Off_"+rev_idx).css("display", "none");
                              
                           }else{
                              alert("리뷰 좋아요 취소가 되지않았습니다.\r관리자에게 문의바랍니다.\r사유 : "+res_data.error);
                           }
                        },
                        error : function(err) {
                           console.log(err.responseText);
                        }
                     });
                  

                  }
            </script> 


         </head>

         <body>
            <!-- ---------------------리뷰--------------------- -->
            <div id="review">

               <div class="all_score">
                  <p>전체</p>
                  <div class="review_total">${fn:length(review_list)}</div>
               </div>

               <div class="average">
                  <div class="average_score">
                     <!-- 평균 계산 -->
                     <c:set var="totalScore" value="${reviewSum}" />
                     <!-- 리뷰점수/리뷰목록(개수) -->
                     <c:set var="averageScore" value="${totalScore / fn:length(review_list)}" />
                     <!-- 소수둘째자리 반올림처리 (minFractionDigits: 소수점 아래 최소,  maxFractionDigits:최대 자리수-->
                     <fmt:formatNumber value="${reviewAverage}" minFractionDigits="1" maxFractionDigits="1" />
                     ${roundedAverageScore}점
                     
                     <span class='star-rating'>
                        <span style="width: 80%" id="star_avg">
                        </span>
                     </span>

                   </div>
               </div>
               <!-- ----------------------------리뷰목록----------- -->
               
               <c:forEach var="vo" items="${ review_list }">
                  
               <form method="post" enctype="multipart/form-data" id="form_${vo.rev_idx}">
                                    <div id="review_bord">
                                       <hr>
                                          <div class="review_writer" id="review_writer">${vo.mem_id}</div>
                                          <div class="review_regdate" id="re_regdate${vo.rev_idx}">
                                             ${fn:substring(vo.rev_date, 0, 10)}
                                          
                                             <c:if test="${vo.hea == 0}">
                                                <div class="rev_keep_heart" id="rev_keep_Off_${vo.rev_idx}"  style="display: none;">
                                                   <i id="heartOff_${vo.rev_idx}" class="fa-solid fa-heart" style="color: red;" onclick="heartOff('${vo.rev_idx}')"></i>
                                                   <div id="heartOff_num_${vo.rev_idx}" class="hea_num">${vo.hea_num}</div> 
                                             </div>
                                             
                                             <div class="rev_keep_heart" id="rev_keep_On_${vo.rev_idx}">
                                                   <i id="heartOn_${vo.rev_idx}" class="fa-regular fa-regular fa-heart" style="color: red;" onclick="heartOn('${vo.rev_idx}')"></i>
                                                   <div id="heartOn_num_${vo.rev_idx}" class="hea_num">${vo.hea_num}</div>
                                             </div>
                                             </c:if>
                                          
                                             <c:if test="${vo.hea == 1}">
                                                <div class="rev_keep_heart" id="rev_keep_Off_${vo.rev_idx}" >
                                                   <i id="heartOff_${vo.rev_idx}" class="fa-solid fa-heart" style="color: red;" onclick="heartOff('${vo.rev_idx}')"></i>
                                                   <div id="heartOff_num_${vo.rev_idx}" class="hea_num">${vo.hea_num}</div> 
                                             </div>
                                             
                                             <div class="rev_keep_heart" id="rev_keep_On_${vo.rev_idx}" style="display: none;">
                                                   <i id="heartOn_${vo.rev_idx}" class="fa-regular fa-heart" style="color: red;" onclick="heartOn('${vo.rev_idx}')"></i>
                                                   <div id="heartOn_num_${vo.rev_idx}" class="hea_num">${vo.hea_num}</div>
                                             </div>
                                             </c:if>

                                             <c:if test="${user.mem_idx eq vo.mem_idx or user.mem_grade eq 'manager'}">
                                                <span class="del_close">
                                                   <c:if test="${user.mem_idx eq vo.mem_idx}">
                                                      <span class="btn_re_modify" id="btn_re_modify_${ vo.rev_idx }"
                                                         onclick="rev_modify_content_form('${ vo.rev_idx}');">수정</span>
                                                   </c:if>
                                                   <span onclick="delRe('${vo.rev_idx}');">x</span>
                                                </span>
                                             </c:if>
                                             <c:if test="${user.mem_idx ne vo.mem_idx and user.mem_grade ne 'manager'}">
                                                <span class="del_close">
                                                   <span id="btn_re_modify_${ vo.rev_idx }">&nbsp;</span>
                                                   <span>&nbsp;</span>
                                                </span>
                                             </c:if>
                                          </div>
                                       
                                          <div class="review_write"> 
                                             <div> 
                                                <fieldset class="review_score_rate" id="review_score_${vo.rev_idx}" style="display: none;">
                                                   <input type="radio" checked="checked" id="rating_5_0${vo.rev_idx}" name="rev_grade" value="5.0"><label for="rating_5_0${vo.rev_idx}" title="5점"></label>
                                                   <input type="radio" checked="checked" id="rating_4_5${vo.rev_idx}" name="rev_grade" value="4.5"><label class="half" for="rating_4_5${vo.rev_idx}" title="4.5점"></label>
                                                   <input type="radio" checked="checked" id="rating_4_0${vo.rev_idx}" name="rev_grade" value="4.0"><label for="rating_4_0${vo.rev_idx}" title="4점"></label>
                                                   <input type="radio" checked="checked" id="rating_3_5${vo.rev_idx}" name="rev_grade" value="3.5"><label class="half" for="rating_3_5${vo.rev_idx}" title="3.5점"></label>
                                                   <input type="radio" checked="checked" id="rating_3_0${vo.rev_idx}" name="rev_grade" value="3.0"><label for="rating_3_0${vo.rev_idx}" title="3점"></label>
                                                   <input type="radio" checked="checked" id="rating_2_5${vo.rev_idx}" name="rev_grade" value="2.5"><label class="half" for="rating_2_5${vo.rev_idx}" title="2.5점"></label>
                                                   <input type="radio" checked="checked" id="rating_2_0${vo.rev_idx}" name="rev_grade" value="2.0"><label for="rating_2_0${vo.rev_idx}" title="2점"></label>
                                                   <input type="radio" checked="checked" id="rating_1_5${vo.rev_idx}" name="rev_grade" value="1.5"><label class="half" for="rating_1_5${vo.rev_idx}" title="1.5점"></label>
                                                   <input type="radio" checked="checked" id="rating_1_0${vo.rev_idx}" name="rev_grade" value="1"><label for="rating_1_0${vo.rev_idx}" title="1점"></label>
                                                   <input type="radio" checked="checked"id="rating_0_5${vo.rev_idx}" name="rev_grade" value="0.5"><label class="half" for="rating_0_5${vo.rev_idx}" title="0.5점"></label>
                                                </fieldset>

                                                
												<div id="rev_content_form_${vo.rev_idx}" style="display: none;">
													<input type="hidden" name="rev_idx" value="${vo.rev_idx}">
													<input type="hidden" name="contentId" value="${vo.contentId}">
													<input type="hidden" name="photo_yn " value="${vo.photo_yn}">
													<!-- <input type="hidden" name="mapY " value="${vo.mapY}">
													<input type="hidden" name="mapX " value="${vo.mapX}"> -->
													<input type="hidden" class="review_star2" name="rev_grade" id="rev_grade_new${vo.rev_idx}" value="${vo.rev_grade}">
													<textarea class="review_content" name="rev_content" id="re_content${vo.rev_idx}">${vo.rev_content}</textarea>
													<input type="file" id="imagein_${vo.rev_idx}" multiple="multiple" class="photo" name="photo">
													<input class="modifybut3" type="button" value="수정" id="btn_review_modify_${vo.rev_idx}" onclick="re_modify_content(this.form);" style="display: none;">
												</div> 
												
												<div class="review_star2" id="rev_review_star${vo.rev_idx}">${vo.re_star}</div>
												<div class="review_content" id="rev_content${vo.rev_idx}">${vo.rev_content}</div>
												
												<div class="photo_list" id="photo_list_${vo.rev_idx}">
													<c:if test="${vo.photo_yn eq 'y'}">

														<c:forEach var="photo_vo" items="${vo.photo_list}" varStatus="i">
															<div class="image-wrapper" id="img_${photo_vo.pho_idx}">
                                                <input type="hidden" name="photo_idx" value="${photo_vo.pho_idx}" id="pho_name_${photo_vo.pho_idx}">
																<img src="${pageContext.request.contextPath}/review_file_upload/${photo_vo.pho_name}" alt="리뷰이미지" class="pho_name">
                                                <p class="pho_name_btn pho_name_a_${vo.rev_idx}" style="display: none;"><a onclick="photo_del('${photo_vo.pho_idx}');">X</a></p>
															</div>
														</c:forEach>

													</c:if>
												</div>
                                                   
                           </div>
                        </div>
                     </div>
                  </form>
               </c:forEach>
            

            <!-- 게시물이 없는 경우 -->
               
               <c:if test="${empty review_list}">
                  <hr>
                  <div class="no">
                     <p style="color:red;">등록된 리뷰가 없습니다</p>
                  </div>
               </c:if>

            </div>


         </body>

         </html>