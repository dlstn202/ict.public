package com.ict.finalproject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ict.finalproject.vo.PhotoVo;

@Mapper
public interface PhotoMapper {

    public List<PhotoVo> selectList();							//전체 조회

    public List<PhotoVo> selectList_pho_idx(int rev_idx);	

    public List<PhotoVo> selectList_pho_idx(String bizrno);	


    public List<PhotoVo> selectListRoom(int room_idx);			//객실 idx에 대한 포토 리스트 가져오기			

	public int photo_insert(PhotoVo vo) throws Exception; ; 	//사진등록
 
	public int photo_delete(int pho_idx) throws Exception; ;	//사진 삭제

	public int photo_delete_room(int room_idx) throws Exception; ;	//사진 삭제

	public int photo_update(PhotoVo vo) throws Exception; ;		//사진 수정


}
