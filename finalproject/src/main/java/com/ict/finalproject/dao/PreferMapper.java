package com.ict.finalproject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ict.finalproject.vo.PreferVo;

@Mapper
public interface PreferMapper {

    public List<PreferVo> selectList();

    public List<PreferVo> selectListMemIdx(int mem_idx);

    public PreferVo selectOnePreIdx(int pre_idx);

    public int insert(PreferVo prefer_vo) throws Exception;

    public int update(PreferVo prefer_vo) throws Exception;

    // public int delete(int mem_idx) throws Exception;


    

}
