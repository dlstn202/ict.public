package com.ict.finalproject.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("answer")
public class AnswerVo {

	int	   ans_idx;			//답변번호
	int	   qna_idx;			//문의번호
	int	   mem_idx;			//답변자idx
	String ans_content;		//답변내용
	String mem_name;		//답변자이름
	String ans_date;		//답변일자
	String ans_modify_yn;	//수정유무
	String ans_modifydate;	//수정일자
	String ans_del_yn;		//삭제유무
	String ans_deldate;		//삭제일자

	QnaVo  qna;

}
