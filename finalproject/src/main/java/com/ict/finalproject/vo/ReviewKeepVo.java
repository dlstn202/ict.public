package com.ict.finalproject.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("review_keep")
public class ReviewKeepVo {

	int	   mem_idx;			//회원번호
	int	   rev_idx;			//리뷰번호

}
