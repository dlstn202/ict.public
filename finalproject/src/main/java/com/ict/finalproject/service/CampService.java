package com.ict.finalproject.service;

import java.util.List;

import com.ict.finalproject.vo.CampVo;
import com.ict.finalproject.vo.PhotoVo;

public interface CampService {

    int camp_insert(CampVo camp_vo, List<PhotoVo> camp_photo_list) throws Exception;

    int camp_insert_one(CampVo camp_vo, List<PhotoVo> camp_photo_list) throws Exception;

    List<PhotoVo> selectphoto_idx(String bizrno);

    int photo_delete(int pho_idx) throws Exception;

    CampVo selectOneBizrnoVo(String bizrno);

    int update(List<PhotoVo> Photo_file_list) throws Exception;



    
}
