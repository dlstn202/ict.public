package com.ict.finalproject.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ict.finalproject.vo.MemberVo;

@Mapper
public interface MemberGeneralMapper {

    public List<MemberVo> selectList();

    // 일반 insert
    public int insertGeneral(MemberVo vo) throws Exception;

    // 일반 update
    public int updateGeneral(MemberVo vo) throws Exception;

    // 일반 update(관리자가 y/n수정)
    public int updateGeneralM(MemberVo vo) throws Exception;

    // 일반 delete
    public int deleteGeneral(int mem_idx) throws Exception;

    public int deleteSns(Map<String, Object> sns_map) throws Exception; //sns 계정 삭제

    public int insertSns(Map<String, Object> sns_map) throws Exception; //sns 계정내용 추가

    
}
