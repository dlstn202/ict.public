<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var radiosetTexts = document.querySelectorAll('.radioset-text');

        radiosetTexts.forEach(function (text) {
            text.addEventListener('click', function () {
                var inputId = this.getAttribute('data-for');
                var input = document.getElementById(inputId);
                if (input) {
                    input.checked = true;
                }
            });
        });
    });
</script>
<script>
    $(document).ready(function () {
        var mem_email = "${user.mem_email}";
        var emailParts = mem_email.split('@');

        // 분리된 이메일 주소를 폼 입력 필드에 할당
        if (emailParts.length === 2) {
            $("input[name='qna_email_first']").val(emailParts[0]);
            $("input[name='qna_email_domain']").val(emailParts[1]);
        }
    });
</script>
<script>
    let tel_regular = /^[0-9]*$/;
    let email_regular = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

    function qna_insert(f) {

        var qna_tos_yn = f.qna_tos_yn.value;
        var qna_section = f.qna_section.value;
        var qna_name = f.qna_name.value.trim();
        var qna_tel = f.qna_tel.value;
        var qna_email_first = f.qna_email_first.value.trim();
        var qna_email_domain = f.qna_email_domain.value.trim();
        var email = qna_email_first + "@" + qna_email_domain;
        var qna_title = f.qna_title.value.trim();
        var qna_content = f.qna_content.value.trim();

        if (qna_tos_yn != 'y') {
            alert("개인정보 수집 동의하지 않으시면\n문의를 남기실 수 없습니다. ");
            return;
        }

        if (qna_section == '') {
            alert("상담구분을 선택해주세요.");
            return;
        }

        if (qna_name == '') {
            alert("이름을 입력해주세요.");
            f.qna_name.value = '';
            f.qna_name.focus();
            return;
        }

        if (!tel_regular.test(qna_tel)) {
            alert("전화번호는 - 빼고 입력해주세요");
            f.qna_tel.value = '';
            f.qna_tel.focus();
            return;
        }

        if (!email_regular.test(email)) {
            alert("올바른 이메일을 입력해주세요");
            f.qna_email_first.value = '';
            f.qna_email_domain.value = '';
            f.qna_email_first.focus();
            return;
        }

        if (qna_title == '') {
            alert("문의 제목을 입력해주세요.");
            f.qna_title.value = '';
            f.qna_title.focus();
            return;
        }

        if (qna_content == '') {
            alert("문의 내용을 입력해주세요.");
            f.qna_content.value = '';
            f.qna_content.focus();
            return;
        }

        f.method = 'post';
        f.action = 'qna_insert.do';
        f.submit();
    }
</script>

</head>

<body>

<!-- [E]glamping-N11 -->
<!-- [S]glamping-N42 -->
<form>
    <input type="hidden" name="mem_idx" value="${user.mem_idx}">
    <c:if test="${not empty mypage}">
        <input type="hidden" name="mypage" value="${mypage}">
    </c:if>
    <div class="glamping-N42" data-bid="KHltWpT6mP">
        <div class="contents-inner">
            <div class="contents-container container-md">
                <h2 class="form-tit">개인정보 수집 동의 <span>(필수)</span></h2>

                <ul class="contents-list">
                    <li class="contents-item">
                        <strong>온라인 문의(문의) 개인정보수집동의</strong>
                        <p> 이용자 본인은 아래의 개인정보가 사실임을 확인하며, 아래와 같이 개인정보를 수집 및 이용하는 것에 동의합니다. </p>
                    </li>
                    <li class="contents-item">
                        <strong>1. 개인정보의 수집 및 이용 목적</strong>
                        <p> 원활한 고객상담, 각종 서비스의 제공, 정확한 본인 확인을 위한 개인정보를 수집하고 있습니다. <br> 수집한 개인정보는 수집∙이용목적 이외에 고객의
                            동의 없이 다른 용도로 이용하거나 제3자에게 제공하지 않습니다. </p>
                    </li>
                </ul>
                <div class="radioset-wrap">
                    <div class="radioset">
                        <input id="radioset-a-1-1" name="qna_tos_yn" class="radioset-input input-line"
                            type="radio" value="y" checked="">
                        <label class="radioset-label" for="radioset-a-1-1"></label>
                        <span class="radioset-text" data-for="radioset-a-1-1">약관에 동의합니다.</span>
                    </div>
                    <div class="radioset">
                        <input id="radioset-a-1-2" name="qna_tos_yn" class="radioset-input input-line"
                            type="radio" value="n">
                        <label class="radioset-label" for="radioset-a-1-2"></label>
                        <span class="radioset-text" data-for="radioset-a-1-2">동의하지 않습니다.</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- [E]glamping-N42 -->
    <!-- [S]glamping-N43 -->

    <div class="glamping-N43" data-bid="BNlTWpT6SZ">
        <div class="contents-inner">
            <div class="contents-container container-md">
                <h2 class="contents-tit">정보입력</h2>
                <div class="contents-group">
                    <div class="form-wrap">
                        <h6 class="form-tit">상담구분 <span>*</span></h6>
                        <div class="radioset-wrap">
                            <div class="radioset">
                                <input id="radioset-b-1" name="qna_section" class="radioset-input input-line"
                                    type="radio" value="reservation" checked="">
                                <label class="radioset-label" for="radioset-b-1"></label>
                                <span class="radioset-text">예약문의</span>
                            </div>
                            <div class="radioset">
                                <input id="radioset-b-2" name="qna_section" class="radioset-input input-line"
                                    type="radio" value="cancel">
                                <label class="radioset-label" for="radioset-b-2"></label>
                                <span class="radioset-text"> 취소문의</span>
                            </div>
                            <div class="radioset">
                                <input id="radioset-b-3" name="qna_section" class="radioset-input input-line"
                                    type="radio" value="dissatisfaction">
                                <label class="radioset-label" for="radioset-b-3"></label>
                                <span class="radioset-text">고객불만</span>
                            </div>
                            <div class="radioset">
                                <input id="radioset-b-4" name="qna_section" class="radioset-input input-line"
                                    type="radio" value="etc">
                                <label class="radioset-label" for="radioset-b-4"></label>
                                <span class="radioset-text">기타</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-wrap">
                        <h6 class="form-tit">성명 <span>*</span></h6>
                        <div class="inputset inputset-round">
                            <input type="text" name="qna_name" class="inputset-input form-control"
                                aria-label="내용" required="" value="${user.mem_name}">
                        </div>
                    </div>
                    <div class="form-wrap">
                        <h6 class="form-tit">연락처 <span>*</span></h6>
                        <div class="inputset inputset-round">
                            <input type="text" name="qna_tel" class="inputset-input form-control"
                                aria-label="내용" placeholder="-없이 번호를 입력해주세요" required=""
                                value="${user.mem_tel}">
                        </div>
                    </div>
                    <div class="form-wrap">
                        <h6 class="form-tit">이메일 <span>*</span>
                        </h6>
                        <div class="contents-form-group">
                            <div class="inputset inputset-round">
                                <div class="contents-mail">
                                    <input type="text" class="inputset-input form-control" aria-label="내용"
                                        required="" name="qna_email_first">
                                    <span class="joininput_email">@</span>
                                    <input type="text" class="email_domain inputset-input form-control"
                                        aria-label="내용" required="" name="qna_email_domain">
                                </div>
                            </div>
                        </div>
                        <div class="selectset selectset-round selectset-md">
                            <button class="selectset-toggle btn" type="button">
                                <span>선택해주세요</span>
                            </button>
                            <ul class="selectset-list">
                                <li class="selectset-item">
                                    <button class="selectset-link btn" type="button" data-value="직접입력"
                                        selected="">
                                        <span>직접입력</span>
                                    </button>
                                </li>
                                <li class="selectset-item">
                                    <button class="selectset-link btn" type="button" value="naver.com">
                                        <span>naver.com</span>
                                    </button>
                                </li>
                                <li class="selectset-item">
                                    <button class="selectset-link btn" type="button" value="daum.net">
                                        <span>daum.net</span>
                                    </button>
                                </li>
                                <li class="selectset-item">
                                    <button class="selectset-link btn" type="button" value="hanmail.net">
                                        <span>hanmail.net</span>
                                    </button>
                                </li>
                                <li class="selectset-item">
                                    <button class="selectset-link btn" type="button" value="kakao.com">
                                        <span>kakao.com</span>
                                    </button>
                                </li>
                                <li class="selectset-item">
                                    <button class="selectset-link btn" type="button" value="gmail.com">
                                        <span>gmail.com</span>
                                    </button>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="form-wrap">
                        <h6 class="form-tit">제목 <span>*</span></h6>
                        <div class="inputset inputset-round">
                            <input type="text" name="qna_title" class="inputset-input form-control"
                                aria-label="내용" required="">
                        </div>
                    </div>
                    <div class="form-wrap">
                        <h6 class="form-tit">문의내용 <span>*</span></h6>
                        <div class="inputset inputset-round">
                            <div class="textarea_parent">
                                <textarea class="inputset-textarea form-control" name="qna_content"
                                    required=""></textarea>
                            </div>
                            <div class="inputset-langth">
                                <span class="inputset-count">0</span>
                                <span class="inputset-total">/2000 Byte</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="contents-btn-group">
                    <input class="btnset btnset-round" type="button" onclick="qna_insert(this.form);"
                        value="문의하기">
                </div>
            </div>
        </div>
</form>
</body>

</html>