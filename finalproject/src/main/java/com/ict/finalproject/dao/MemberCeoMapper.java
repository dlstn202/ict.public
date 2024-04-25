package com.ict.finalproject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ict.finalproject.vo.CampCeoVo;
import com.ict.finalproject.vo.CampVo;
import com.ict.finalproject.vo.MemberVo;
import com.ict.finalproject.vo.PhotoVo;

@Mapper
public interface MemberCeoMapper {

    public List<MemberVo> selectList();
    
    // 사장 insert
    public int insertCeo(MemberVo vo) throws Exception;


    // 사장 update
    public int updateCeo(MemberVo vo) throws Exception;

    // 사장 delete
    // public int deleteCeo(int mem_idx) throws Exception;

    // 사장별 사업자 번호 리스트와 각 사업자 번호에 해당하는 캠핑장 정보 조회
    List<CampCeoVo> selectCampCeosByMemberIdx(int mem_idx);

     // 특정 사업자 번호에 해당하는 캠핑장 정보 조회
     CampVo selectCampByBizrno(String bizrno);
     
     List<PhotoVo> selectPhotosByBizrno(String bizrno);
}

