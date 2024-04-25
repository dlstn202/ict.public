package com.ict.finalproject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ict.finalproject.vo.CampCeoVo;

@Mapper
public interface CampCeoMapper {

    public CampCeoVo selectOne(int mem_idx);

    //사장 객실 조회
    public List<CampCeoVo> selectLisIdxRoom(int mem_idx);

    //사장 예약내역 조회
    public List<CampCeoVo> selectListRev(int mem_idx);

    //사장 예약내역 조회(과거)
    public List<CampCeoVo> selectListRevOld(int mem_idx);

    // 등록
    public int insertCampCeo(CampCeoVo camp_ceo_vo) throws Exception;

    // 등록
    public int deleteCampCeo(int mem_idx) throws Exception;

    // 사업자번호 검색
    public String selectOneBizrno(String bizrno) throws Exception;



    

}
