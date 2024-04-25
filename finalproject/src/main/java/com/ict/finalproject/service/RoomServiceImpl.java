package com.ict.finalproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ict.finalproject.dao.FeeMapper;
import com.ict.finalproject.dao.PhotoMapper;
import com.ict.finalproject.dao.RoomMapper;
import com.ict.finalproject.vo.PhotoVo;
import com.ict.finalproject.vo.RoomVo;

@Service
public class RoomServiceImpl implements RoomService {

    @Autowired
    RoomMapper room_dao;

    @Autowired
    PhotoMapper photo_dao;

    @Autowired
    FeeMapper fee_dao;

    //등록할 idx 조회
    @Override
    public int room_idx() {
        
        int room_idx = room_dao.room_idx();
        
        return room_idx;
    }

    @Override
    public RoomVo selectBizrno(String bizrno) {
        
        RoomVo room_vo = room_dao.selectBizrno(bizrno);
        
        return room_vo;
    }

    //객실, 객실사진 등록
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int insert(RoomVo vo, List<PhotoVo> Photo_file_list) throws Exception {
        
        int res = 0;

        res = room_dao.insert(vo);

        if (res != 1) {
            throw new Exception("room_fail_insert"); 
        }

        res = 0;
        for(PhotoVo pho_vo :Photo_file_list){
            res += photo_dao.photo_insert(pho_vo);
        }

        // System.out.println("파일 리스트 : "+notice_file_list.size());
        if (res != Photo_file_list.size()) {
            throw new Exception("room_file_insert_fail"); 
        }

        return res;
    }

    //객실, 객실사진 수정
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int update(RoomVo vo, List<PhotoVo> Photo_file_list) throws Exception {
        
        int res = 0;

        res = room_dao.update(vo);
        // System.out.println(res);
        // System.out.println("하이");
        if (res != 1) {
            throw new Exception("room_fail_update"); 
        }
        
        res = 0;
        for(PhotoVo pho_vo :Photo_file_list){
            res += photo_dao.photo_insert(pho_vo);
        }
        //System.out.println(res);
        // System.out.println("파일 리스트 : "+notice_file_list.size());
        if (res != Photo_file_list.size()) {
            throw new Exception("room_file_insert_fail"); 
        }


        return res;
    }
    
    @Override
    public RoomVo selectOneRoomIdx(int room_idx) {
        
        RoomVo vo = room_dao.selectOneRoomIdx(room_idx);
        
        return vo;
    }

    @Override
    public List<PhotoVo> selectphoto_idx(int room_idx) {
        
        List<PhotoVo> list = photo_dao.selectListRoom(room_idx);
        
        return list;
    }
    
    @Override
    public int pho_del_idx(int pho_idx) throws Exception {
        
        int res = photo_dao.photo_delete(pho_idx);
        if (res != 1) {
            throw new Exception("photo_delete_fail"); 
        }
        
        return res;
    }
    
    //객실 삭제
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int delete(int room_idx) throws Exception{
        
        int res = 0;
    
        res = room_dao.delete(room_idx);
        // System.out.println(res);
        // System.out.println("하이");
        if (res != 1) {
            throw new Exception("room_fail_delete"); 
        }
        
        res = -1;
        res = photo_dao.photo_delete_room(room_idx);


        if (res == -1) {
            throw new Exception("room_file_delete_fail"); 
        }

        res = -1;
        res = fee_dao.deleteRoom_idx(room_idx);

        if (res == -1) {
            throw new Exception("room_fee_delete_fail"); 
        }
    
    
        return res;
    }

    @Override
    public List<RoomVo> selectListBizrno(String bizrno) {
        
        List<RoomVo> list = room_dao.selectListBizrno(bizrno);

        return list;
    }



}
