package com.ict.finalproject.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("report_answer")
public class ReportAnswerVo {

	int	   rep_ans_idx;		//신고답변번호
	int	   rep_idx;			//신고번호
	int	   mem_idx;			//처리자idx
	String mem_name;		//처리자명
	String han_reason;		//처리사유
	String han_date;		//처리날짜
	String ans_modify_yn;	//신고답변수정여부
	String ans_modifydate;	//신고답변수정일자
}
