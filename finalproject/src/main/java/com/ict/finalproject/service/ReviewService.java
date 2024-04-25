package com.ict.finalproject.service;

import java.util.List;
import java.util.Map;

import com.ict.finalproject.vo.PhotoVo;
import com.ict.finalproject.vo.ReviewKeepVo;
import com.ict.finalproject.vo.ReviewVo;

public interface ReviewService {

    List<ReviewVo>  selectList();

    List<ReviewVo>  selectListMap(Map<String, Object> map);

    List<ReviewVo> selectListMember(int mem_idx);
    
    ReviewVo selectOne(int rev_idx);

    List<PhotoVo> selectList_pho_idx(int rev_idx);	                                                //사진리스트 불러옴

    int rev_idx();

    int mem_idx();

    int insertReKeep(ReviewKeepVo vo,ReviewVo rev_vo) throws Exception;

    int deleteReKeep(ReviewKeepVo vo,ReviewVo rev_vo) throws Exception;

    double selectReviewCount(int contentId);

    double selectReviewSum(int contentId);

    int review_insert(ReviewVo review_vo, List<PhotoVo> rev_photo_list) throws Exception;

    int review_update(ReviewVo review_vo, List<PhotoVo> rev_photo_list) throws Exception;

    int review_delete(int rev_idx) throws Exception;

    int photo_delete(int rev_pho_idx) throws Exception; //파일삭제

    

    



    


}
