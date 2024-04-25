package com.ict.finalproject.service;

import java.util.List;

import com.ict.finalproject.vo.PhotoVo;
import com.ict.finalproject.vo.RoomVo;
public interface RoomService {
 
    int room_idx(); //등록할 idx조회

    int insert(RoomVo vo, List<PhotoVo> Photo_file_list) throws Exception;

    int pho_del_idx(int pho_idx) throws Exception;

    int update(RoomVo vo, List<PhotoVo> Photo_file_list) throws Exception;

    RoomVo selectOneRoomIdx(int room_idx);

    RoomVo selectBizrno(String bizrno);

    List<PhotoVo> selectphoto_idx(int room_idx);
    
    List<RoomVo> selectListBizrno(String bizrno); //사업자등록번호와 매칭되는 객실 리스트 조회

    int delete(int room_idx) throws Exception;



}
