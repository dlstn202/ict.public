package com.ict.finalproject.service;

import java.util.List;
import java.util.Map;

import com.ict.finalproject.vo.AnswerVo;
import com.ict.finalproject.vo.QnaVo;

public interface QnaAnswerService {


    int         insertQna(QnaVo vo);                            //문의 등록
    int         insertAnswer(AnswerVo vo) throws Exception;     //답변 등록
    List<QnaVo> selectListMap(Map<String, Object> map);         //검색 리스트 조회(mem_idx 있을시 본인것만 조회됨)
    int         selectRowTotal(Map<String, Object> map);        //검색 리스트 조회갯수(mem_idx 있을시 본인것만 조회됨)
    int         updateAnswer(AnswerVo vo); 

    //List<QnaVo> SelectList(); 

}
