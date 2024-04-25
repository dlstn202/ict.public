package com.ict.finalproject.service;

import java.util.List;
import java.util.Map;

import com.ict.finalproject.vo.NoticeFileVo;
import com.ict.finalproject.vo.NoticeVo;

public interface NoticeService {

    List<NoticeVo>      selectList();	                                                                        //전체조회

    List<NoticeVo>      selectListMap(Map<String, Object> map);	                                           //검색조회(페이징)

    List<NoticeVo>      selectListMapDelNo(Map<String, Object> map);	                                        //검색조회(페이징) 삭제된 공지사항은 안불러옴

    int                 selectRowTotal(Map<String, Object> map);	                                            //검색조회 갯수 조회(페이징)

    int                 selectRowTotalDelNo(Map<String, Object> map);	                                            //검색조회 갯수 조회(페이징) 삭제된 공지사항은 안불러옴

    NoticeVo            selectOne(int not_idx);	                                                                //게시물 1건 조회

    List<NoticeFileVo>  selectList_not_idx(int not_idx);                                                        //파일리스트 불러오기

    int                 insert(NoticeVo notice_vo, List<NoticeFileVo> notice_file_list) throws Exception ;      //공지사항 등록

    int                 update(NoticeVo notice_vo, List<NoticeFileVo> notice_file_list) throws Exception ;      //공시사항 수정

    int                 delete(int not_idx) throws Exception;                                                   //공지사항 삭제

    int                 not_idx();                                                                              //idx 조회(insert용)

    int                 file_del_idx(int file_idx) throws Exception ;                                           //파일삭제

}
