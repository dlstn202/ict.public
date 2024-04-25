package com.ict.finalproject.vo;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("camp")
public class CampVo {

	int	   contentId;			//캠핑장코드
	int	   mem_idx;				//사장회원 번호
	String facltNm;				//캠핑장명
	String lineIntro;			//한줄소개
	String intro;				//소개
	String trsagntNo;			//관광사업자번호
	String bizrno;				//사업자등록번호
	String facltDivNm;			//사업주체.구분
	String hvofBgnde;			//휴장기간.휴무기간.시작일
	String hvofEnddle;			//휴장기간.휴무기간.종료일
	String featureNm;			//특징
	String induty;				//업종
	String lctCl;				//입지구분
	String doNm;				//도
	String sigunguNm;			//시군구
	String zipcode;				//우편번호
	String addr1;				//주소
	String addr2;				//주소상세
	double mapX;				//경도
	double mapY;				//위도
	String tel;					//전화
	String homepage;			//홈페이지
	String resveUrl;			//예약페이지
	String resveCl;				//예약구분
	int	   gnrlSiteCo;			//주요시설 일반야영양
	int	   autoSiteCo;			//주요시설 자동차야영장
	int	   glampSiteCo;			//주요시설 글램핑
	int	   caravSiteCo;			//주요시설 카라반
	int	   siteBottomCl1;		//잔디
	int    siteBottomCl2;		//파쇄석
	int    siteBottomCl3;		//테크
	int	   siteBottomCl4;		//자갈
	int	   siteBottomCl5;		//맨흙
	String tooltip;				//툴팁
	String glampInnerFclty;		//글램핑 - 내부시설
	String caravInnerFclty;		//카라반 - 내부시설
	int	   toiletCo;			//화장실 개수
	int	   swrmCo;				//샤워실 개수
	int	   wtrplCo;				//개수대 개수
	String brazierCl;			//화로대
	String sbrsCl;				//부대시설
	String sbrsEtc;				//부대시설 기타
	String posblFcltyCl;		//주변이용가능시설
	String exprnProgrmAt;		//체험프로그램여부(Y사용 N미사용)
	String exprnProgrm;			//체험프로그램명
	String themaEnvrnCl;		//테마환경
	String eqpmnLendCl;			//캠핑장비대여
	String animalCmgCl;			//애완동물출입
	String firstImageUrl;		//대표이미지
	String createdtime;			//등록일
	String modifiedtime;		//수정일
	String cam_reser_yn;		//예약가능여부
	String cam_reserdate;		//예약불가 마지막일자
	int	   si_count;			//시군구별 캠핑장 갯수	
	int	   do_count;			//selectListSi 도별 캠핑장 갯수
	int	   count;				//selectListDo 도별 캠핑장 갯수
	String filters;				//필터조건이 담긴 배열
	List<PhotoVo> photo_list;
}
