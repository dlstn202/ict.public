<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
    function del(f){

        if(confirm("정말 회원을 탈퇴시키시겠습니까?") == false) return;

        f.method = "post";
        f.action = "member_del_m.do";
        f.submit();
    }

    function pwd(f){

        if(confirm("회원 비밀번호를 초기화하시겠습니까?") == false) return;

        f.method = "post";
        f.action = "change_pwd_m.do";
        f.submit();
    }

    function g_modify(f){

        if(confirm("회원 정보를 수정하시겠습니까?") == false) return;

        f.method = "post";
        f.action = "member_modify_m.do";
        f.submit();
    }


</script>
</head>
<body>

<!-- 사장 수정 모달 -->
<div id="CEOModifyModal" class="modal fade custom-modal-mypage" role="dialog">
    <div class="modal-dialog custom-modal-mypage">
        <div class="modal-content">
            <div class="modal-header memberlist_modal_header">
                <button id="closememberlistModal" type="button" class="close" data-dismiss="modal">&times;</button>
                <p class="modal-title">회원정보 수정</p>
            </div>
            <div class="modal-body">
                <!-- Modal body -->
                <form id="ceo_form">
                    <input type="hidden" name="mem_idx" value="">
                    <input type="hidden" name="mem_grade" value="">
                    <div class="form-wrap">
                        <h6 class="form-tit">가입일자</h6>
                        <div class="inputset inputset-round">
                            <input name="mem_joindate"  type="text" class="inputset-input form-control" aria-label="내용" readonly="readonly" value="금쪽맘">
                        </div>
                    </div>
                    <div class="form-wrap">
                        <h6 class="form-tit">회원명</h6>
                        <div class="inputset inputset-round">
                            <input name="mem_name" type="text" class="inputset-input form-control" aria-label="내용" required="" readonly="readonly" value="금쪽일">
                        </div>
                    </div>
                    <div class="form-wrap">
                        <h6 class="form-tit">아이디</h6>
                        <div class="inputset inputset-round">
                        <input name="mem_id"  type="text" class="inputset-input form-control" aria-label="내용" required="" readonly="readonly" value="gold1">
                        </div>
                    </div>
                    <div class="form-wrap">
                        <h6 class="form-tit">이메일</h6>
                        <div class="inputset inputset-round">
                        <input name="mem_email" type="text" class="inputset-input form-control" aria-label="내용" required="" readonly="readonly" value="gold1@ict.com">
                        </div>
                    </div>
                    <div class="form-wrap">
                        <h6 class="form-tit">연락처</h6>
                        <div class="inputset inputset-round">
                        <input name="mem_tel"  type="text" class="inputset-input form-control" aria-label="내용" required="" readonly="readonly" value="010-2222-2222">
                        </div>
                    </div>
                    <!-- <div class="form-wrap">
                        <h6 class="form-tit">신고누적</h6>
                        <div class="inputset inputset-round">
                            <input type="text" class="inputset-input form-control" aria-label="내용" required="" value="0">
                        </div>
                    </div> -->
                    <div class="form-wrap">
                        <h6 class="form-tit">회원탈퇴여부</h6>
                        <div class="inputset inputset-round">
                            <input name="mem_quit_yn" type="text" class="inputset-input form-control" aria-label="내용" required="" readonly="readonly" value="">
                        </div>
                        <h6 class="form-tit">회원탈퇴일자</h6>
                        <div class="inputset inputset-round">
                            <input name="mem_quitdate"  type="text" class="inputset-input form-control" aria-label="내용" required="" readonly="readonly" value="">
                        </div>
                    </div>
                    
                    <div class="form-wrap">
                        <div class="inputset inputset-round ml_modify_btn_wrap">
                            <!-- <input class="memberlist_btn btnset-line" type="button" onclick="c_modify(this.form);" value="수정하기"> -->
                            <input class="memberlist_btn_del" type="button" onclick="del(this.form);" value="삭제하기">
                            <input class="memberlist_btn" type="button" onclick="pwd(this.form);" value="비밀번호리셋">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 일반 수정 모달 -->
<div id="GeneralModifyModal" class="modal fade custom-modal-mypage" role="dialog">
    <div class="modal-dialog custom-modal-mypage">
        <div class="modal-content">
            <div class="modal-header memberlist_modal_header">
                <button id="closememberlistModal" type="button" class="close" data-dismiss="modal">&times;</button>
                <p class="modal-title">회원정보 수정</p>
            </div>
            <div class="modal-body">
                <!-- Modal body -->
                <form id="general_form">
                    <input type="hidden" name="mem_idx" value="">
                    <input type="hidden" name="mem_photo" value="">
                    <input type="hidden" name="mem_grade" value="">
                    <div class="form-wrap">
                        <h6 class="form-tit">가입일자</h6>
                        <div class="inputset inputset-round">
                            <input name="mem_joindate"  type="text" class="inputset-input form-control" aria-label="내용" readonly="readonly" value="금쪽맘">
                        </div>
                    </div>
                    <div class="form-wrap">
                        <h6 class="form-tit">회원명</h6>
                        <div class="inputset inputset-round">
                            <input name="mem_name"   type="text" class="inputset-input form-control" aria-label="내용" required="" readonly="readonly" value="금쪽맘">
                        </div>
                    </div>
                    <div class="form-wrap">
                        <h6 class="form-tit">이메일</h6>
                        <div class="inputset inputset-round">
                            <input name="mem_email" type="text" class="inputset-input form-control" aria-label="내용" required="" readonly="readonly" value="gold0@icy.com">
                        </div>
                    </div>
                    <div class="form-wrap">
                        <h6 class="form-tit">연락처</h6>
                        <div class="inputset inputset-round">
                            <input name="mem_tel"   type="text" class="inputset-input form-control" aria-label="내용" required="" readonly="readonly" value="010-1111-1111">
                        </div>
                    </div>
                    <div class="form-wrap">
                        <h6 class="form-tit">아이디</h6>
                        <div class="inputset inputset-round">
                            <input name="mem_id"   type="text" class="inputset-input form-control" aria-label="내용" required="" readonly="readonly" value="gold0">
                        </div>
                    </div>
                    <div class="form-wrap">
                        <h6 class="form-tit">마케팅동의</h6>
                        <div class="inputset inputset-round">
                        <input name="agree3_yn"   type="text" class="inputset-input form-control" aria-label="내용" required="" readonly="readonly" value="y">
                        </div>
                    </div>
                    <!-- <div class="form-wrap">
                        <h6 class="form-tit">신고누적</h6>
                        <div class="inputset inputset-round">
                            <input type="text" class="inputset-input form-control" aria-label="내용" required="" value="0">
                        </div>
                    </div> -->
                    <div class="form-wrap">
                        <h6 class="form-tit">예약가능여부</h6>
                        <div class="selectset selectset-round selectset-md memberlist_yn">
                            <select class="yn_select" name="mem_reserv_yn">
                                <option value="y">y</option>
                                <option value="n">n</option>
                            </select>
                        </div>
                        <h6 class="form-tit">예약정지일자</h6>
                        <div class="inputset inputset-round">
                            <input name="mem_reservdate" type="text" class="inputset-input form-control" aria-label="내용" required="" readonly="readonly" value="">
                        </div>
                    </div>
                    <div class="form-wrap">
                        <h6 class="form-tit">리뷰가능여부</h6>
                        <div class="selectset selectset-round selectset-md memberlist_yn">
                            <select class="yn_select" name="mem_review_yn">
                                <option value="y">y</option>
                                <option value="n">n</option>
                            </select>
                        </div>
                        <h6 class="form-tit">리뷰정지일자</h6>
                        <div class="inputset inputset-round">
                            <input name="mem_reviewdate"   type="text" class="inputset-input form-control" aria-label="내용" required="" readonly="readonly" value="2024-03-28">
                        </div>
                    </div>
                    
                    <div class="form-wrap">
                        <h6 class="form-tit">회원탈퇴여부</h6>
                        <div class="inputset inputset-round">
                            <input name="mem_quit_yn" type="text" class="inputset-input form-control" aria-label="내용" required="" readonly="readonly" value="">
                        </div>
                        <h6 class="form-tit margin_tit">회원탈퇴일자</h6>
                        <div class="inputset inputset-round">
                            <input name="mem_quitdate" type="text" class="inputset-input form-control" aria-label="내용" required="" readonly="readonly" value="">
                        </div>
                    </div>
                    
                    <div class="form-wrap">
                        <div class="inputset inputset-round ml_modify_btn_wrap">
                            <input class="memberlist_btn btnset-line" type="button" onclick="g_modify(this.form);" value="수정하기">
                            <input class="memberlist_btn_del" type="button" onclick="del(this.form);" value="삭제하기">
                            <input class="memberlist_btn" type="button" onclick="pwd(this.form);" value="비밀번호리셋">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


</body>
</html>