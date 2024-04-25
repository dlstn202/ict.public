package com.ict.finalproject.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("qna")
public class QnaVo {

	int	   	 qna_idx;			//문의번호
	int	   	 mem_idx;			//회원번호
	String 	 qna_title;			//문의제목
	String 	 qna_content;		//문의내용
	String 	 qna_date;			//등록일자
	String 	 qna_condition;		//문의상태
	String 	 qna_email;			//이메일
	String	 qna_tel;			//연락처
	String 	 qna_name;			//문의자이름
	String 	 qna_tos_yn;		//약관동의여부
	String 	 qna_section;		//구분
	String 	 qna_del_yn;		//삭제여부
	String 	 qna_deldate;		//삭제일자
	String 	 qna_modify_yn;		//수정여부
	String 	 qna_modifydate;	//수정일자

	String 	 qna_email_first;	//이메일 앞부분
	String 	 qna_email_domain;	//이메일 도메인
	AnswerVo answer;			//답변
	int no;

	
	




}
