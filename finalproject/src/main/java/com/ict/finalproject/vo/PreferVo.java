package com.ict.finalproject.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("prefer")
public class PreferVo {

	int	   pre_idx; //선호번호
	String pre_si;	//도/시
	String pre_gun;	//군/구
	int	   mem_idx;	//회원번호



}
