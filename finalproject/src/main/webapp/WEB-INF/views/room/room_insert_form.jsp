<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
    $(document).ready(function(){
        $("#insert_form [name=bizrno]").val(bizrno);
    })
</script>
<script>

    function insert(f){
        var num_reguler = /^[0-9]*$/;
        var room_name = f.room_name.value.trim();
        var room_min  = f.room_min.value;
        var room_max  = f.room_max.value;
        var room_in   = f.room_in.value.trim();
        var room_out  = f.room_out.value.trim();

        let file_count = f.photo.files.length;

        if(room_name == ""){
            alert("객실명을 입력해주세요");
            f.room_name.value = "";
            f.room_name.focus();
            return;
        }

        if(!num_reguler.test(room_min)){
            alert("최소인원은 숫자만 입력 가능합니다.");
            f.room_min.value = "";
            f.room_min.focus();
            return;
        }

        if(!num_reguler.test(room_max)){
            alert("최대인원은 숫자만 입력 가능합니다.");
            f.room_max.value = "";
            f.room_max.focus();
            return;
        }

        if(room_in == ""){
            alert("입실시간을 입력해주세요");
            f.room_in.value = "";
            f.room_in.focus();
            return;
        }

        if(room_out == ""){
            alert("객실명을 입력해주세요");
            f.room_out.value = "";
            f.room_out.focus();
            return;
        }

        if (file_count>20) {
            alert("사진은 20장을 초과하여 등록할 수 없습니다.");
            return;
        }

        f.action="room/insert.do";
        f.submit();

    }
</script>
<script>
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
<main class="th-layout-main">
    <div id="my_room">
        <div class="my_info_title">객실등록</div>   
        <!-- [S]mypage_container_ceo_business_room_insertform  -->
        <div id="info_content">
            <form id="insert_form" method="post" enctype="multipart/form-data">
                <input type="hidden" name="bizrno" value="">
                <div class="glamping-N47" data-bid="KAltwpIVGl">
                    <div class="contents-inner2">
                        <div class="contents-container container-md">
                            <div class="contents-top">
                                <span>* 표시는 반드시 입력하셔야 하는 항목입니다</span>
                            </div>
                            <div class="contents-group">
                                <div class="roomform form-wrap">
                                    <h6 class="form-tit">객실명<span>*</span>
                                    </h6>
                                    <div class="contents-form-group">
                                        <div class="inputset inputset-round">
                                            <input name="room_name" type="text" class="inputset-input form-control" aria-label="내용" required="">
                                        </div>
                                    </div>
                                </div>
                                <div class="people">
                                    <div class="roomform form-wrap">
                                        <h6 class="form-tit">최소인원 <span>*</span>
                                        </h6>
                                        <div class="peopleset1 inputset inputset-round">
                                            <input type="text" class="inputset-input form-control" name="room_min">
                                        </div>
                                    </div>
                                    <div class="roomform form-wrap">
                                        <h6 class="form-tit">최대인원 <span>*</span>
                                        </h6>
                                        <div class="peopleset2 inputset inputset-round">
                                            <input type="text" class="inputset-input form-control" name="room_max">
                                        </div>
                                    </div>
                                </div>

                                <div class="checktime">
                                    <div class="roomform form-wrap">
                                        <h6 class="form-tit">입실시간 <span>*</span>
                                        </h6>
                                        <div class="checktimeset1 inputset inputset-round">
                                            <input type="time" class="inputset-input form-control" name="room_in">
                                        </div>
                                    </div>
                                    <div class="roomform form-wrap">
                                        <h6 class="form-tit">퇴실시간 <span>*</span>
                                        </h6>
                                        <div class="checktimeset2 inputset inputset-round">
                                            <input type="time" class="inputset-input form-control" name="room_out">
                                        </div>
                                    </div>
                                </div>
                                <div class="roomform form-wrap">
                                    <h6 class="form-tit">기타</h6>
                                    <div class="contents-form-group">
                                        <div class="inputset inputset-round">
                                            <input type="text" class="inputset-input form-control" name="room_etc" >
                                        </div>
                                    </div>
                                </div>
                                <div class="roomform form-wrap">
                                    <h6 class="form-tit">사진</h6>
                                    <div class="contents-form-group">
                                        <div >
                                            <input type="file"  name="photo" accept="image/*" multiple="multiple" onchange="checkFileType(this)">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="contents-btn-group">
                                <input type="button" class="btnset btnset-round" value="등록" onclick="insert(this.form);">
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <!-- [E]mypage_container_ceo_business_room_insertform  -->
    </div>
</main>
</body>

</html>