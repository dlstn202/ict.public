package com.ict.finalproject.service;

import java.util.List;
import java.util.Map;

import com.ict.finalproject.vo.CampCeoVo;
import com.ict.finalproject.vo.MemberVo;
import com.ict.finalproject.vo.PreferVo;

public interface MemberService {

    MemberVo selectOneNameEmail(MemberVo vo);
    MemberVo selectOneNaIdEm(MemberVo vo);
    MemberVo selectOneGeneralId(String mem_id);
    List<CampCeoVo> selectList_idx_room(int mem_idx);
    List<CampCeoVo> selectList_Rev(int mem_idx);
    List<CampCeoVo> selectList_Rev_old(int mem_idx);
    List<MemberVo> selectGL();
    List<MemberVo> selectCL();


    
    int insert_general(MemberVo member_vo, PreferVo prefer_vo, Map<String, String> pre_map) throws Exception ;
    int insert_ceo(MemberVo member_vo, CampCeoVo camp_ceo_vo) throws Exception ;
    int insert_manager(MemberVo member_vo) throws Exception ;

    Map<String, String> check_bizrno(String bizrno) throws Exception ;

    int update_general(MemberVo member_vo, PreferVo prefer_vo, Map<String, String> pre_map) throws Exception ;
    int update_general_m(MemberVo member_vo) throws Exception ;
    int update_ceo(MemberVo member_vo) throws Exception ;
    int update_pwd(MemberVo vo) throws Exception ;
    int delete_manager(MemberVo member_vo) throws Exception ;

    int delete_sns(Map<String,Object> sns_map) throws Exception;
    int insert_sns(Map<String,Object> sns_map) throws Exception;


   int delete_general(int mem_idx) throws Exception;
  //  int delete_ceo(int mem_idx) throws Exception;

    
}
