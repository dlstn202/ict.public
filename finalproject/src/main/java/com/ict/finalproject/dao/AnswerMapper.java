package com.ict.finalproject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ict.finalproject.vo.AnswerVo;

@Mapper
public interface AnswerMapper {

    public List<AnswerVo> selectList();

    public int insert(AnswerVo vo);

    public int update(AnswerVo vo);
    
}
