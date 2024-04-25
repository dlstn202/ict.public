package com.ict.finalproject.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("cancel")
public class CancelVo {

	int	   can_idx;			//취소번호
	int	   res_idx;			//예약번호
	int	   mem_idx;			//회원번호
	String facltNm;			//캠핑장명
	String res_checkindate;	//체크인일자
	String res_date;		//예약일자
	String res_can_date;	//예약취소일자
	int	   can_charge;		//취소수수료율

}
