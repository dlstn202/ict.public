<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(document).ready(function() {
   
   
   $("#registerform [name='url']").val(location.href);

});
</script>
<script type="text/javascript">
//모달이 닫혔을때 별점해제
$(document).ready(function(){
    // 리뷰 모달이 닫힐 때 실행되는 함수
    $('#review_modal').on('hidden.bs.modal', function () {
        // 별점을 선택 해제
        $(".star_intro_star .rate input[name='rev_grade']").prop('checked', false);
        $("textarea[name='rev_content']").val("");
    });
    
    // 로그인 모달이 닫힐 때 실행되는 함수
    $('#myModal').on('hidden.bs.modal', function () {
        // 별점을 선택 해제
        $(".star_intro_star .rate input[name='rev_grade']").prop('checked', false);
    });
    
});







//별점 클릭 이벤트 핸들러
function handleRatingClick(value) {

   let ratingValue = parseFloat(value);
      
   // 별점 입력 요소들을 찾음
   let radioButtons = document
         .querySelectorAll('.rate input[name="rev_grade"]');

   // 각 별점 입력 요소에 선택된 값 적용
   radioButtons.forEach(function(radioButton) {
      if (parseFloat(radioButton.value) == ratingValue) {
         radioButton.checked = true;
      } else {
         radioButton.checked = false;
      }
   });



      //로그인 되었을때 리뷰 작성 모달띄우기
   if ('${not empty sessionScope.user}' == "true") {
      $('#review_modal').modal('show');
   } else {
      location.href='login_main.do?url='+location.href;

   }


}
</script> 

 
<script type="text/javascript">

//리뷰사진삭제
function photo_del(rev_idx){
     
     if(confirm("정말 삭제하시겠습니까?")==false) return;

     $.ajax({
        data      :   {"pho_idx": pho_idx },
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



</script>

<script type="text/javascript">

function insert_review(f) {

      var rateFieldset  = $("#registerform .rate");
      let rev_grade     = $('#registerform input[name="rev_grade"]:checked').val();
      let facltNm       = $("#registerform input[name='facltNm']").val();
      let contentId     = $("#registerform input[name='contentId']").val();
      let addr1         = $("#registerform input[name='addr1']").val();
      let mapY          = $("#registerform input[name='mapY']").val();
      let mapX          = $("#registerform input[name='mapX']").val();
      let rev_content   = $("#rev_content").val();
      let file_count    = f.photo.files.length;
      var fileInput     = f.photo;
      
      
      if (rev_grade == '') {
         alert('별점을 입력하세요!');
         f.rev_grade.value = '';
         f.rev_grade.focus();
         return;
      }

      if (rev_content == '') {
         alert('내용을 입력하세요!');
         f.rev_content.value = '';
         f.rev_content.focus();
         return;
      }
      if (file_count>5) {
         fileInput.value = '';
         alert("첨부파일은 5개까지만 가능합니다");
         return;
     }
      
      if(confirm("등록하시겠습니까?") == false) return;


      var formData = new FormData(f);
      $.ajax({
           type: "POST", 
            url: "review/insert.do",
            // data: {facltNm:facltNm,contentId:contentId,rev_content:rev_content,rev_grade:rev_grade,addr1:addr1,mapY:mapY,mapX:mapX},
            data: formData,
            dataType: "json",
            contentType: false,
            processData: false,
            success: function(res_data) {

               if(res_data.review_no){
                  alert("욕설이 감지되었습니다.\r댓글등록에 실패했습니다.");
                  return;
               }
               
              if(res_data.result == "time_out"){
                 alert("로그인이 만료됐습니다.\r로그인후 등록해주시길바랍니다.");
                 location.href = "login.do";

              }
               
               if(res_data.result){
                  alert("리뷰 등록이 완료되었습니다.");
                  location.href = location.href;
               }else{
                  alert("리뷰 등록 실패하였습니다.\r관리자에게 문의바랍니다.");
                  location.href = location.href;               
                  
               }
               
               
            },
            error : function(err) {
               console.log(err.responseText);
            }
            
            
         });
      
   }

   function checkFileType(input) {
    const file = input.files[0];
    if (file) {
        const fileType = file.type;
        if (!fileType.startsWith('image/')) {
            alert('이미지 파일을 선택해주세요.');
            input.value = ''; // 파일 선택을 취소합니다.
        }
    }
}


  

</script>
</head>
<body>
<c:if test="${(empty user) or (user.mem_grade eq 'general') }">
      <div class="star">
         <div style="text-align: center; display: flex;">
         
            <div class="star_intro">
               <c:choose>
                  <c:when test="${empty sessionScope.user}">
                     <p>이 장소의 후기를 남겨주세요.</p>
                  </c:when>
                  <c:otherwise>
                     <p>${sessionScope.user.mem_name}님후기를 남겨주세요.</p>
                  </c:otherwise>
               </c:choose>
            </div>
            
            <div>
               <div class="star_intro_star">
                  <fieldset class="rate">
                     <input type="radio" id="rating10" name="rev_grade" value="5.0" onclick="handleRatingClick(this.value)"><label for="rating10" title="5점"></label>
                           <input type="radio" id="rating9" name="rev_grade" value="4.5" onclick="handleRatingClick(this.value)"><label class="half" for="rating9" title="4.5점"></label>
                           <input type="radio" id="rating8" name="rev_grade" value="4.0" onclick="handleRatingClick(this.value)"><label for="rating8" title="4점"></label>
                           <input type="radio" id="rating7" name="rev_grade" value="3.5" onclick="handleRatingClick(this.value)"><label class="half" for="rating7" title="3.5점"></label>
                           <input type="radio" id="rating6" name="rev_grade" value="3.0" onclick="handleRatingClick(this.value)"><label for="rating6" title="3점"></label>
                           <input type="radio" id="rating5" name="rev_grade" value="2.5" onclick="handleRatingClick(this.value)"><label class="half" for="rating5" title="2.5점"></label>
                           <input type="radio" id="rating4" name="rev_grade" value="2.0" onclick="handleRatingClick(this.value)"><label for="rating4" title="2점"></label>
                           <input type="radio" id="rating3" name="rev_grade" value="1.5" onclick="handleRatingClick(this.value)"><label class="half" for="rating3" title="1.5점"></label>
                           <input type="radio" id="rating2" name="rev_grade" value="1" onclick="handleRatingClick(this.value)"><label for="rating2" title="1점"></label>
                           <input type="radio" id="rating1" name="rev_grade" value="0.5" onclick="handleRatingClick(this.value)"><label class="half" for="rating1" title="0.5점"></label>
                  </fieldset>
               </div>
            </div>
         </div>
      </div>
</c:if>
 <!-- ---------------------리뷰모달--------------------- -->
   <div id="review_modal" class="modal fade" role="dialog">
         <div class="modal-dialog custom-modal-size">
            <div class="custom-modal-reivew">
               <div class="modal-content ">
               
                  <!-- Modal Header -->
                  <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal">&times;</button>
                     <h4 class="modal-title" id="review_modal_title">${vo.facltNm}</h4>
                  </div>
      
                  <!-- Modal body -->
                  <div class="modal-body">
                     <div class="container">
                        <form id="registerform" method="post" enctype="multipart/form-data">
                           <input type="hidden" name="facltNm" value="${vo.facltNm}">
                           <input type="hidden" name="contentId" value="${contentId}">
                           <input type="hidden" name="url" value="">
                           <input type="hidden" name="addr1" value="${camp_vo.addr1}">
                           <input type="hidden" name="mapY" value="${camp_vo.mapY}">
                           <input type="hidden" name="mapX" value="${camp_vo.mapX}">
                           <div>

                              <fieldset class="rate">
                                    <input type="radio" id="rating10" name="rev_grade" value="5.0"><label for="rating10" title="5점"></label>
                                           <input  type="radio" id="rating9" name="rev_grade" value="4.5" ><label class="half" for="rating9" title="4.5점"></label>
                                           <input type="radio" id="rating8" name="rev_grade" value="4.0"><label for="rating8" title="4점"></label>
                                         <input type="radio" id="rating7" name="rev_grade" value="3.5"><label class="half" for="rating7" title="3.5점"></label>
                                         <input type="radio" id="rating6" name="rev_grade" value="3.0"><label for="rating6" title="3점"></label>
                                          <input type="radio" id="rating5" name="rev_grade" value="2.5"><label class="half" for="rating5" title="2.5점"></label>
                                           <input type="radio" id="rating4" name="rev_grade" value="2.0"><label for="rating4" title="2점"></label>
                                         <input type="radio" id="rating3" name="rev_grade" value="1.5"><label class="half" for="rating3" title="1.5점"></label>
                                              <input type="radio" id="rating2" name="rev_grade" value="1"><label for="rating2" title="1점"></label>
                                           <input type="radio" id="rating1" name="rev_grade" value="0.5"><label class="half" for="rating1" title="0.5점"></label>
                              </fieldset>
                         </div>

                              <div class="form-group mb-3">
                                 <div class="textarea_parent">
                                 <textarea class="form-control" id="rev_content" name="rev_content" rows="5" maxlength="1000" placeholder="작성내용은 마이페이지와 장소상세에 노출되며 매장주를 포함한 다른 사용자들이 볼 수 있으니, 서로를 배려하는 마음을 담아 작성해 주세요.">${ rev_content }</textarea>
                              </div>

                                                                 
                              </div>
                              <div class="modal-footer">
                                <div class="photo">
                                 <input type="file" id="imageInput" multiple="multiple" class="photo" name="photo" accept="image/*"  onchange="checkFileType(this)">

                                 <input type="button" id="btn-register" value="등록" onclick="insert_review(this.form);" >
                                 </div>
                              </div>

                        </form>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
</body>
</html>