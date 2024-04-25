package com.ict.finalproject.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("report")
public class ReportVo {

	int	   rep_idx;			//신고번호
	String rep_loc;			//신고위치
	int	   mem_idx;			//신고자번호
	String mem_name;		//신고자명
	String rep_date;		//신고일자
	String rep_content;		//신고내용
	String rep_type;		//신고유형
	String rep_delete_yn;	//신고삭제여부
	String rep_deldate;		//신고삭제날짜
	String rep_modify_yn;	//신고수정여부
	String rep_modifydate;	//신고수정날짜
	String han_history;		//처리내역
	int	   contentId;		//콘텐츠아이디
	int	   rev_idx;			//리뷰번호



}
