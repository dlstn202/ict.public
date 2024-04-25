package com.ict.finalproject.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("reservation")
public class ReservationVo {

	long   res_idx;					//예약번호
	int    contentId;					
	String bizrno;					//사업자번호
	int	   mem_idx;					//회원번호
	String facltNm;					//캠핑장명
	String res_date;				//예약일
	String res_paymentdate;			//결제일
	String res_checkindate;			//체크인일자
	String res_checkoutdate;		//체크아웃일자
	int	   res_stayday;				//숙박기간
	int	   res_peopleadult;			//인원(성인)
	int	   res_peoplechild;			//인원(소인)
	int	   res_peopletoddler;		//인원(유아)
	String animalCmgCl;				//반려동물동행여부(y/n)
	String room_name;				//예약 객실 명
	int	   room_idx;				//객실 번호
	String mem_name;				//예약자 명
	String mem_tel;					//휴대폰번호
	String mem_email;				//이메일
	String res_request;				//요청사항
	String res_use_agree_yn;		//이용안내 체크(y/n)
	String res_can_cagree_yn;		//취소수수료 체크(y/n)
	String res_check;				//입퇴실 체크
	String res_payment_type;		//결제정보타입
	long   res_supply_price;		//공급가액
	long   res_vat;					//부가세
	long   res_payment;				//결제 금액
	String res_payment_result;		//결제 승인 결과
	String res_can_yn;				//취소여부
	String res_candate;				//취소일자
	String res_can_reason;			//취소사유
	String paymentKey;				//결제키
	String receipt;					//영수증url
	int	   dday;					//취소수수료 일자 확인용
	long   res_can_payment;			//취소금액
	long   res_can_supply_price;	//취소공급가액
	long   res_can_vat;				//취소부가세


}
