package com.ict.finalproject.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ict.finalproject.vo.PlaceKeepVo;

@Mapper
public interface PlaceKeepMapper {

    public List<PlaceKeepVo> selectList(int mem_idx);

    public int delete(Map<String, Object> map);

    public int insert(PlaceKeepVo vo);

    public PlaceKeepVo selectOneCheck(Map<String, Object> map);
    
}
