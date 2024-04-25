package com.ict.finalproject.vo;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("member")
public class MemberVo {

	//회원공통사항 common
	int	   mem_idx;			//회원번호
	String mem_id;			//아이디
	String mem_name;		//이름
	String mem_pwd;			//비밀번호
	String mem_email;		//이메일
	String mem_grade;		//회원등급
	String mem_tel;			//전화번호
	String mem_joindate;	//가입일자
	String mem_ip;			//아이피
	String mem_quit_yn;		//탈퇴여부
	String mem_quitdate;	//탈퇴일

	//일반회원 general
	String mem_kakao;		//카카오연동
	String mem_naver;		//네이버연동
	String mem_google;		//구글연동
	String agree1_yn;		//약관동의1
	String agree2_yn;		//약관동의2
	String agree3_yn;		//약관동의3
	String mem_reserv_yn;	//예약가능여부
	String mem_reservdate;	//예역정지일자 마지막
	String mem_review_yn;	//리뷰가능여부
	String mem_reviewdate;	//리뷰정지일자 마지막
	String mem_photo;		//프로필사진

	//관리자회원 manager
	String not_man_yn;		//공지사항 및 FAQ
	String mem_man_yn;		//회원관리
	String rep_man_yn;		//신고
	String qna_man_yn;		//온라인문의

	//사장
	List<CampCeoVo> camp_ceo_list;

	List<PreferVo> prefer_list;
	

}
