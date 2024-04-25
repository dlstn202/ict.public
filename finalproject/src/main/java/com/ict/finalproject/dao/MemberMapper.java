package com.ict.finalproject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ict.finalproject.vo.MemberVo;

@Mapper
public interface MemberMapper {

    public List<MemberVo> selectList();

    public MemberVo selectOneManager(int mem_idx);

    // public MemberVo selectOneFromMemIdx(int mem_idx);
    
    public MemberVo selectOneManagerId(String mem_id);

    public MemberVo selectOneCeoId(String mem_id);
    
    public MemberVo selectOneGeneralId(String mem_id);

    public MemberVo selectOneNameEmail(MemberVo vo); //아이디 찾기용

    public MemberVo selectOneNaIdEm(MemberVo vo); //비밀번호 찾기용

    // google id 체크
    public MemberVo selectOneGoogleId(String mem_google);
    
    // kakao id 체크
    public MemberVo selectOneKakaoId(String mem_kakao);

    // naver id 체크
    public MemberVo selectOneNaverId(String mem_naver);

    // 아이디체크 mem_id 검색
    public MemberVo selectOneMemId(String mem_id);
    
    // 공통 insert
    public int insertCommon(MemberVo vo) throws Exception;
    
    // 공통 update
    public int updateCommon(MemberVo vo) throws Exception;

    // 비밀번호 초기화
    public int updatePwd(MemberVo vo) throws Exception;

    // 공통 delete(y<->n)
    public int deleteCommon(int mem_idx) throws Exception;


    // 이메일 체크 mem_email 검색
    public MemberVo selectOneMemEmail(String mem_email);

}
