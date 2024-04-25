<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
    function handleRatingClick(value) {
        console.log("Rating clicked:", value);

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

}
</script>
<script>
    
    function general_ModifyRe(f){
      
               var rev_idx        = f.rev_idx.value.trim();
               var rev_content    = f.rev_content.value.trim();
               var rev_grade      = f.rev_grade.value;
               var file_count     = f.photo.files.length;
               var fileInput      = f.photo;
               var photo_yn       = f.photo_yn.value;
            //    var photo_yn      = f.photo_yn.value;

               
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

                if(confirm("정말 수정하시겠습니까?")==false) return;
                
                var formData = new FormData(f); 

               $.ajax({
                 type: "POST",
                  url: "mypage_container_general_review_modify.do",
                  data: formData,
                  dataType: "json",
                  contentType: false,
                  processData: false,
                  success: function(res_data) {
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

<script>
        //삭제하기
        function general_delRe(){
            
            let rev_idx = $("#rev_idx").val();

            if(confirm("정말 삭제하시겠습니까?")==false) return;
        
            $.ajax({
                url      :   "mypage_container_general_review_delete.do",
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

function go_datail(){

    let contentId   = document.getElementById('contentId_input').value;
    let facltNm     = document.getElementById('facltNm_input').innerHTML;

    location.href="detail_main.do?contentId="+encodeURIComponent(contentId)+"&title="+encodeURIComponent(facltNm);
}

</script>

</head>
<body>
<!-- 리뷰모달 -->
<div id="GeneralReviewModal" class="modal fade custom-modal-mypage" role="dialog">
    <div class="modal-dialog custom-modal-mypage">
        <div class="modal-content">
            <form method="post" enctype="multipart/form-data" id="form_${vo.rev_idx}">
                <div class="modal-header generalreview_modal_header">
                    <button id="closegeneralreviewModal" type="button" class="close" data-dismiss="modal">&times;</button>
                    <p class="modal-title" id="facltNm_input" onclick="go_datail();"></p>
                    <input type="hidden" id="contentId_input">
                </div>

                <div class="modal-body">
                    <input type="hidden" name="rev_idx" id="rev_idx" >
                    <input type="hidden" name="photo_yn" id="photo_yn_input" >
                    <!-- Modal body -->
                    <div class="form-wrap general_review_img_x_wrap">
                        <div class="form-wrap general_review_img_wrap" id="photo_input"></div>
                    </div>
                    <div class="general_reivew_photo">
                        <input type="file" multiple="multiple" class="general_reivew_photo_btn" name="photo" accept="image/*" onchange="checkFileType(this)"> 
                    </div>

                    <div class="form-wrap">
                        <h6 class="form-tit">별점</h6>      
                        <div class="star_intro_star">
                            <fieldset class="rate" id="myInput">
                                <input type="radio" id="rating10" name="rev_grade" value="5.0" onclick="handleRatingClick(this.value)"><label for="rating10" title="5점"></label>
                                <input type="radio" id="rating9" name="rev_grade" value="4.5" onclick="handleRatingClick(this.value)"><label class="half" for="rating9" title="4.5점"></label>
                                <input type="radio" id="rating8" name="rev_grade" value="4.0" onclick="handleRatingClick(this.value)"><label for="rating8" title="4점"></label>
                                <input type="radio" id="rating7" name="rev_grade" value="3.5" onclick="handleRatingClick(this.value)"><label class="half" for="rating7" title="3.5점"></label>
                                <input type="radio" id="rating6" name="rev_grade" value="3.0" onclick="handleRatingClick(this.value)"><label for="rating6" title="3점"></label>
                                <input type="radio" id="rating5" name="rev_grade" value="2.5" onclick="handleRatingClick(this.value)"><label class="half" for="rating5" title="2.5점"></label>
                                <input type="radio" id="rating4" name="rev_grade" value="2.0" onclick="handleRatingClick(this.value)"><label for="rating4" title="2점"></label>
                                <input type="radio" id="rating3" name="rev_grade" value="1.5" onclick="handleRatingClick(this.value)"><label class="half" for="rating3" title="1.5점"></label>
                                <input type="radio" id="rating2" name="rev_grade" value="1.0" onclick="handleRatingClick(this.value)"><label for="rating2" title="1점"></label>
                                <input type="radio" id="rating1" name="rev_grade" value="0.5" onclick="handleRatingClick(this.value)"><label class="half" for="rating1" title="0.5점"></label>
                            </fieldset>
                        </div>
                    </div>
                    <div class="form-wrap">
                        <h6 class="form-tit">내용</h6>
                        <div class="textarea_parent">
                            <textarea id="rev_content_input" name="rev_content" class="inputset-textarea form-control" value="" required=""></textarea>
                        </div>
                    </div>

                    <div class="form-wrap">
                        <div class="inputset inputset-round gl_modify_btn_wrap">
                            <input type="hidden" id="del_rev_idx" name="rev_idx">
 

                            <input class="generalreview_btn_modify btnset-line" type="button" onclick="general_ModifyRe(this.form);" value="수정하기">
                            <input class="generalreview_btn_modify" type="button" onclick="general_delRe();" value="삭제하기">
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>