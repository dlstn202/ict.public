package com.ict.finalproject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ict.finalproject.vo.ReservationVo;

@Mapper
public interface ReservationMapper {
    
    // public Long res_idx();

    public ReservationVo selectOneIdx(Long res_idx);

    public int insert(ReservationVo res_vo);

    public int deleteNoPayment();

    public int updateToss(ReservationVo res_vo);

    public int cancelUpate(ReservationVo res_vo);

    public int updateCheckout();

    public List<ReservationVo> selectRes(ReservationVo res_vo);

    public List<ReservationVo> selectResList(int room_idx);

    public List<ReservationVo> selectMemIdx(int mem_idx);

}
