package com.ict.finalproject.vo;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("room")
public class RoomVo {

	int	   room_idx;	//객실번호
	int	   mem_idx;		//회원번호
	String bizrno;		//사업자번호
	String room_name;	//객실명
	int	   room_min;	//최소인원
	int	   room_max;	//최대인원
	String room_in;		//입실시간
	String room_out;	//퇴실시간
	String room_etc;	//기타

	List<PhotoVo> photo_list;
	List<FeeVo>	  fee_list;



}
