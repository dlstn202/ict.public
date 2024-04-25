package com.ict.finalproject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ict.finalproject.vo.FeeVo;


@Mapper
public interface FeeMapper {

    public List<FeeVo> selectList(int room_idx);

    public List<FeeVo> selectListVo(FeeVo vo);         //등록,수정시 중복 요금 있는지 확인

    public FeeVo selectOneIdx(int fee_idx);

    public int insert(FeeVo vo);

    public int delete(int fee_idx);

    public int deleteRoom_idx(int room_idx);

    public int update(FeeVo vo);

    
}
