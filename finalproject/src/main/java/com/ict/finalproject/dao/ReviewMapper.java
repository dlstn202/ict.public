package com.ict.finalproject.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ict.finalproject.vo.ReviewVo;

@Mapper
public interface ReviewMapper {

    public List<ReviewVo> selectList();

	public List<ReviewVo> selectListMap(Map<String, Object> map);

	public List<ReviewVo> selectListMember(int mem_idx);

	public ReviewVo selectOne(int rev_idx);

	public int rev_idx();

	public int mem_idx();
	
	public double selectReviewCount(int contentId);

	public double selectReviewSum(int contentId);

	public int review_insert(ReviewVo review_vo) throws Exception; 
 
	public int review_delete(int rev_idx) throws Exception; 
	
	public int photo_delete(int pho_idx) throws Exception; 

	public int review_update(ReviewVo review_vo);

	public int updateHeaNum(ReviewVo vo); //리뷰 좋아요 

	// public int update_title(ReviewVo title_new); 

}
