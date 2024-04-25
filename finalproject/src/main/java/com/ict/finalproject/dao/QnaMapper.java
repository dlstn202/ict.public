package com.ict.finalproject.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ict.finalproject.vo.QnaVo;

@Mapper
public interface QnaMapper {

    public int         insert(QnaVo vo);                             //추가
    public List<QnaVo> selectListMap(Map<String, Object> map);       //검색조건으로 조회
    public int         selectRowTotal(Map<String, Object> map);      //검색조건으로 조회갯수
    public int         update_condition(int qna_idx);                //qna_condition : 답변완료




    //public List<QnaVo> selectListAll();

}
