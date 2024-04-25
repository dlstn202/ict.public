package com.ict.finalproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ict.finalproject.dao.CampCeoMapper;
import com.ict.finalproject.dao.CampMapper;
import com.ict.finalproject.dao.PhotoMapper;
import com.ict.finalproject.vo.CampCeoVo;
import com.ict.finalproject.vo.CampVo;
import com.ict.finalproject.vo.PhotoVo;

@Service 
public class CampServiceImple implements CampService{

    @Autowired
    PhotoMapper photo_dao;

    @Autowired
    CampMapper camp_dao;

    @Autowired
    CampCeoMapper camp_ceo_dao;

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int camp_insert_one(CampVo camp_vo, List<PhotoVo> camp_photo_list) throws Exception {
       
        int res = 0;

        res = camp_dao.camp_insert(camp_vo);
        if (res != 1) {
            throw new Exception("revire_insert_fail"); 
        }

        res = 0;
        CampCeoVo cmap_ceo_vo = new CampCeoVo();
        cmap_ceo_vo.setMem_idx(camp_vo.getMem_idx());
        cmap_ceo_vo.setBizrno(camp_vo.getBizrno());
        res = camp_ceo_dao.insertCampCeo(cmap_ceo_vo);
        if (res != 1) {
            throw new Exception("camp_ceo_insert_fail"); 
        }


        
        res = 0;
        for(PhotoVo vo : camp_photo_list ){
                  
            //vo.setContentId(review_vo.getContentId());
            res += photo_dao.photo_insert(vo);
        }


        if (res != camp_photo_list.size()) {
            throw new Exception("rev_photo_list_insert_fail"); 
        }

        System.out.println("res : "+res);
        System.out.println("photo_size : "+camp_photo_list.size());
   
        res = 1;

        return res;


    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int camp_insert(CampVo camp_vo, List<PhotoVo> camp_photo_list) throws Exception {
       
        int res = 0;

        res = camp_dao.camp_insert(camp_vo);
        if (res != 1) {
            throw new Exception("revire_insert_fail"); 
        }
        
        res = 0;
        for(PhotoVo vo : camp_photo_list ){
                  
            //vo.setContentId(review_vo.getContentId());
            res += photo_dao.photo_insert(vo);
        }


        if (res != camp_photo_list.size()) {
            throw new Exception("rev_photo_list_insert_fail"); 
        }

        System.out.println("res : "+res);
        System.out.println("photo_size : "+camp_photo_list.size());
   
        res = 1;

        return res;


    }
    

    @Override
    public List<PhotoVo> selectphoto_idx(String bizrno) {
        
        List<PhotoVo> list = photo_dao.selectList_pho_idx(bizrno);
        
        return list;
    }
    
    //파일삭제
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int photo_delete(int pho_idx) throws Exception {

        //System.out.println("딜리트가 들어와?...");
        int res = 0;

        res = photo_dao.photo_delete(pho_idx);
        if (res != 1) {
            throw new Exception("photo_delete_fail"); 
        }
        

        return res;
    }

    @Override
    public CampVo selectOneBizrnoVo(String bizrno) {
        
        CampVo vo = camp_dao.selectOneBizrnoVo(bizrno);

        return vo;
    };

    //캠핑장,캠핑장사진 수정
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int update(List<PhotoVo> Photo_file_list) throws Exception {
        
        int res = 0;
            
        res = 0;
        for(PhotoVo pho_vo :Photo_file_list){
            res += photo_dao.photo_insert(pho_vo);
        }
        //System.out.println(res);
        // System.out.println("파일 리스트 : "+notice_file_list.size());
        if (res != Photo_file_list.size()) {
            throw new Exception("room_file_insert_fail"); 
        }


        return res;
    }

}



