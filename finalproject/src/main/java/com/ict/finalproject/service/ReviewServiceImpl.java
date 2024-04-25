package com.ict.finalproject.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ict.finalproject.dao.PhotoMapper;
import com.ict.finalproject.dao.ReviewKeepMapper;
import com.ict.finalproject.dao.ReviewMapper;
import com.ict.finalproject.vo.PhotoVo;
import com.ict.finalproject.vo.ReviewKeepVo;
import com.ict.finalproject.vo.ReviewVo;

@Service
public class ReviewServiceImpl implements ReviewService {


    @Autowired
    PhotoMapper photo_dao;

    @Autowired
    ReviewMapper review_dao;

    @Autowired
    ReviewKeepMapper review_keep_dao;


    //전체조회
    @Override
    public List<ReviewVo> selectList(){

        List<ReviewVo> list = review_dao.selectList();

        return list;
    };

    //가게 조회
    @Override
    public List<ReviewVo>  selectListMap(Map<String, Object> map){

        List<ReviewVo> list = review_dao.selectListMap(map);

        return list;
    };

    @Override
    public List<ReviewVo>  selectListMember(int mem_idx){

        List<ReviewVo> list = review_dao.selectListMember(mem_idx);

        return list;
    };

    @Override
    public double selectReviewCount(int contentId){
       
        return review_dao.selectReviewCount(contentId);
    }

    @Override
    public double selectReviewSum(int contentId){
   
        Double reviewSum = review_dao.selectReviewSum(contentId);
    
        return reviewSum != null ? reviewSum : 0;
    }


    //리뷰1건조회
    @Override
    public ReviewVo selectOne(int rev_idx){

        ReviewVo vo = review_dao.selectOne(rev_idx);

        return vo;

    };

    //  idx 조회
    @Override
    public int rev_idx(){

        int res = review_dao.rev_idx();

        return res;
    };

    @Override
    public int mem_idx(){

        int res = review_dao.mem_idx();

        return res;
    };


    @Override
    public List<PhotoVo> selectList_pho_idx(int rev_idx){

        List<PhotoVo> filenamelist = photo_dao.selectList_pho_idx(rev_idx);
        
        return filenamelist;
    };

    //등록
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int review_insert(ReviewVo review_vo, List<PhotoVo> rev_photo_list) throws Exception {
        
        int res = 0;


        res = review_dao.review_insert(review_vo);
        if (res != 1) {
            throw new Exception("revire_insert_fail"); 
        }
        
        res = 0;
        for(PhotoVo vo : rev_photo_list ){
            vo.setRev_idx(review_vo.getRev_idx());
            vo.setMem_idx(review_vo.getMem_idx());
           
            //vo.setContentId(review_vo.getContentId());
            res += photo_dao.photo_insert(vo);
        }


        if (res != rev_photo_list.size()) {
            throw new Exception("rev_photo_list_insert_fail"); 
        }
   
        res = 1;

        return res;
    };


    //수정
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int review_update(ReviewVo review_vo, List<PhotoVo> rev_photo_list) throws Exception {
        
        int res = 0;

        res = review_dao.review_update(review_vo);

        if (res != 1) {
            throw new Exception("review_update_fail"); 
        }
        
        res = 0;
        for(PhotoVo vo : rev_photo_list ){
            vo.setRev_idx(review_vo.getRev_idx());
            vo.setMem_idx(review_vo.getMem_idx());
           
            //vo.setContentId(review_vo.getContentId());
            res += photo_dao.photo_insert(vo);
        }


        if (res != rev_photo_list.size()) {
            throw new Exception("rev_photo_list_update_fail"); 
        }
   
        res = 1;

        return res;
    };

    //리뷰삭제
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int review_delete(int rev_idx) throws Exception {

        int res = 0;

        res = review_dao.review_delete(rev_idx);
        if (res != 1) {
            throw new Exception("review_delete_fail"); 
        }

        return res;
    };

    //파일삭제
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int photo_delete(int pho_idx) throws Exception {

        int res = 0;

        res = photo_dao.photo_delete(pho_idx);
        if (res != 1) {
            throw new Exception("photo_delete_fail"); 
        }
        

        return res;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int insertReKeep(ReviewKeepVo vo,ReviewVo rev_vo) throws Exception {
        
        int res = 0;

        res = review_dao.updateHeaNum(rev_vo);
        if (res != 1) {
            throw new Exception("review_update_fail"); 
        }

        res = 0;
        res = review_keep_dao.insert(vo);
        if (res != 1) {
            throw new Exception("review_keep_insert_fail"); 
        }

        return res;
    };

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int deleteReKeep(ReviewKeepVo vo,ReviewVo rev_vo) throws Exception {
        
        int res = 0;

        res = review_dao.updateHeaNum(rev_vo);
        if (res != 1) {
            throw new Exception("review_update_fail"); 
        }
        
        res = 0;
        res = review_keep_dao.delete(vo);
        if (res != 1) {
            throw new Exception("review_keep_delete_fail"); 
        }

        return res;
    };




}
