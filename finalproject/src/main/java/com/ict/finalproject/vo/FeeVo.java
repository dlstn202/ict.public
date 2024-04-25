package com.ict.finalproject.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("fee")
public class FeeVo {

	int	   fee_idx;			//요금번호
	int	   room_idx;		//객실번호
	int	   mem_idx;			//회원번호
	String fee_peak_yn;		//성수기여부
	String fee_weekend_yn;	//주말여부
	int	   fee_adult;		//성인
	int	   fee_child;		//소인
	int	   fee_infant;		//유아

}
