package com.ict.finalproject.vo;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("place_keep")
public class PlaceKeepVo {

	int	   p_keep_idx;	//장소번호
	int	   contentId;	//콘텐츠아이디
	int	   mem_idx;		//회원번호
	double mapY;		//위도
	double mapX;		//경도
	String pl_keepdate;	//장소찜일자
	String facltNm;		//캠핑장명


	CampVo camp_vo;
}
