package com.ict.finalproject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ict.finalproject.vo.MemberVo;

@Mapper
public interface MemberManagerMapper {

    // 관리자 조회
    public List<MemberVo> selectListManager();
    
    // 관리자 insert
    public int insertManager(MemberVo vo) throws Exception;

    // 관리자 update
    public int updateManager(MemberVo member_vo) throws Exception;

    // 관리자 delete(y<->n)
    public int deleteManager(MemberVo member_vo) throws Exception;


    
}
