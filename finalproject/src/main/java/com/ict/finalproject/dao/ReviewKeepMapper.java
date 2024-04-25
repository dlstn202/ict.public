package com.ict.finalproject.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ict.finalproject.vo.ReviewKeepVo;
 
@Mapper
public interface ReviewKeepMapper {

    public List<ReviewKeepVo> selectList(int mem_idx);

    public ReviewKeepVo selectOneCheck(Map<String, Object> map);
    
    public int insert(ReviewKeepVo vo);

    public int delete(ReviewKeepVo vo);

  



    
}
