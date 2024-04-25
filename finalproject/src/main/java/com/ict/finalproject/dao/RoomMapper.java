package com.ict.finalproject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ict.finalproject.vo.RoomVo;

@Mapper
public interface RoomMapper {

    public int room_idx();

    public int insert(RoomVo vo);

    public int update(RoomVo vo);

    public int delete(int room_idx);

    public RoomVo selectOneRoomIdx(int room_idx);

    public RoomVo selectBizrno(String bizrno);

    public List<RoomVo> selectListBizrno(String bizrno);
    
}
