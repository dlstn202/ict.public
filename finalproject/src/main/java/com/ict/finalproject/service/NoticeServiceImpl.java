package com.ict.finalproject.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ict.finalproject.dao.NoticeFileMapper;
import com.ict.finalproject.dao.NoticeMapper;
import com.ict.finalproject.vo.NoticeFileVo;
import com.ict.finalproject.vo.NoticeVo;

@Service
public class NoticeServiceImpl implements NoticeService {


    @Autowired
    NoticeMapper notice_dao;

    @Autowired
    NoticeFileMapper notice_file_dao;


    //전체조회
    @Override
    public List<NoticeVo> selectList(){

        List<NoticeVo> list = notice_dao.selectList();

        return list;
    };

    //검색조회
    @Override
    public List<NoticeVo> selectListMap(Map<String, Object> map){

        List<NoticeVo> list = notice_dao.selectListMap(map);

        return list;
    };

    //색조회(페이징) 삭제된 공지사항은 안불러옴
    @Override
    public List<NoticeVo> selectListMapDelNo(Map<String, Object> map){

        List<NoticeVo> list = notice_dao.selectListMapDelNo(map);

        return list;
    };

    //검색조회 갯수
    @Override
    public int selectRowTotal(Map<String, Object> map){

        int row = notice_dao.selectRowTotal(map);

        return row;
    };

    //검색조회 갯수 삭제된 공지사항은 안불러옴
    @Override
    public int selectRowTotalDelNo(Map<String, Object> map){

        int row = notice_dao.selectRowTotalDelNo(map);

        return row;
    };

    //게시물 한건 조회
    @Override
    public NoticeVo selectOne(int not_idx){

        NoticeVo vo = notice_dao.selectOne(not_idx);
        
        return vo;
    };

    //idx 조회
    public int not_idx(){

        int res = notice_dao.not_idx();

        return res;
    };

    @Override
    public List<NoticeFileVo>  selectList_not_idx(int not_idx){

        List<NoticeFileVo> file_name_list = notice_file_dao.selectList_not_idx(not_idx);
        
        return file_name_list;
    };

    //등록
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int insert(NoticeVo notice_vo, List<NoticeFileVo> notice_file_list) throws Exception {
        
        int res = 0;

        res = notice_dao.insert(notice_vo);
        if (res != 1) {
            throw new Exception("notice_fail_insert"); 
        }
        
        res = 0;
        for(NoticeFileVo vo :notice_file_list){
            res += notice_file_dao.insert(vo);
        }

        // System.out.println("파일 리스트 : "+notice_file_list.size());
        if (res != notice_file_list.size()) {
            throw new Exception("notice_file_insert_fail"); 
        }
        

        return res;
    };

    //수정
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int update(NoticeVo notice_vo, List<NoticeFileVo> notice_file_list) throws Exception {
        
        int res = 0;

        res = notice_dao.update(notice_vo);
        // System.out.println(res);
        // System.out.println("하이");
        if (res != 1) {
            throw new Exception("notice_fail_update"); 
        }
        
        res = 0;
        for(NoticeFileVo vo :notice_file_list){
            res += notice_file_dao.insert(vo);
        }
        //System.out.println(res);
        // System.out.println("파일 리스트 : "+notice_file_list.size());
        if (res != notice_file_list.size()) {
            throw new Exception("notice_file_insert_fail"); 
        }
        

        return res;
    };

    //파일삭제
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int delete(int not_idx) throws Exception {

        int res = 0;

        res = notice_dao.delete(not_idx);
        if (res != 1) {
            throw new Exception("notice_delete_fail"); 
        }

        return res;
    };

    //파일삭제
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int file_del_idx(int file_idx) throws Exception {

        int res = 0;

        res = notice_file_dao.delete(file_idx);
        if (res != 1) {
            throw new Exception("notice_file_delete_fail"); 
        }

        return res;
    };



}
