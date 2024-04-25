package com.ict.finalproject.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ict.finalproject.vo.NoticeVo;

@Mapper
public interface NoticeMapper {

    public List<NoticeVo> selectList();                                  //전체 게시물 조회

    public List<NoticeVo> selectListMap(Map<String, Object> map);        //조회 게시물 조회(페이징)

    public List<NoticeVo> selectListMapDelNo(Map<String, Object> map);   //조회 게시물 조회(삭제된공지사항은 안불러옴(페이징))

    public int selectRowTotal(Map<String, Object> map);                  //조회 게시물 건수 조회

    public int selectRowTotalDelNo(Map<String, Object> map);             //조회 게시물 건수 조회(삭제된공지사항은 안불러옴)

    public NoticeVo selectOne(int not_idx);                              //게시물 1건 조회;

    public int rowTotal();                                               //전체 게시물 수 조회

    public int not_idx();                                                //idx 조회(insert용)

    public int insert(NoticeVo vo)  throws Exception;                    //공지사항 등록

    public int update(NoticeVo vo)  throws Exception;                    //공지사항 수정

    public int delete(int not_idx)  throws Exception;                    //공지사항 삭제
    
}
