package com.ict.finalproject.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("photo")
public class PhotoVo {

	int	   pho_idx;			//사진번호
	int	   mem_idx;			//회원번호
	int	   rev_idx;			//리뷰번호
	String bizrno;			//사업자번호
	int	   room_idx;		//객실번호
	String pho_name;		//사진위치 //사진명
	String pho_regdate;		//일자
	String pho_del_yn;		//삭제유무
	String pho_deldate;		//삭제일자
	String pho_modify_yn;	//수정유무
	String pho_modifydate;	//수정일자

}
