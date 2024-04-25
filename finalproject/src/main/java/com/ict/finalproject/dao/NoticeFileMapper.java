package com.ict.finalproject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ict.finalproject.vo.NoticeFileVo;

@Mapper
public interface NoticeFileMapper {

    public int insert(NoticeFileVo vo);

    public List<NoticeFileVo> selectList_not_idx(int not_idx);

    public int delete(int file_idx);

}
