package com.ict.finalproject.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ict.finalproject.vo.CampVo;

@Mapper
public interface CampMapper {

    public List<CampVo> selectList(); //캠프 전체 리스트
    
    public CampVo selectOne(int contentId); //하나의 장소 정보

    public CampVo selectOneBizrnoVo(String bizrno); //하나의 장소 정보

    public List<CampVo> selectListSi();//시군구 분류 리스트

    public List<CampVo> selectOneListSi(String doNm); //시에 해당하는 시군구 리스트

    public List<CampVo> selectListDo(); //도 분류 리스트

    public List<CampVo> selectByLocal(String doNm, String sigunguNm); // 지역필터 리스트

    public List<CampVo> selectByFilter(Map<String, Object> params); // 해쉬태그필터 리스트

    public  int camp_update(CampVo vo); 

    public  int camp_insert(CampVo vo);
    
    public int photo_delete(int pho_idx) throws Exception; 

    // 사업자번호 검색
    public String selectOneBizrno(String bizrno) throws Exception;

    public int rowTotal();
}
