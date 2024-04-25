package com.ict.finalproject.vo;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("review")
public class ReviewVo {

	int	   rev_idx;			//리뷰번호
	int	   mem_idx;			//회원번호
	int	   contentId;		//콘텐츠아이디
	String rev_date;		//등록일자
	String rev_content;		//리뷰내용
	Double rev_grade;		//리뷰점수
	int	   hea_num;			//하트갯수
	String facltNm;			//장소명
	String addr1;			//주소
	double mapY;			//위도
	double mapX;			//경도
	String rep_yn;			//신고여부
	String rep_result;		//신고처리결과
	String rev_modify_yn;	//수정여부
	String rev_modifydate;	//수정일자
	String rev_del_yn;		//삭제여부
	String rev_deldate;		//삭제일자
	String	re_star;		//리뷰별
	String  mem_id;			//회원아이디
	String photo_yn;		//사진유무
	int hea;
	List<PhotoVo> photo_list;


	public String getRe_star() {
		
		StringBuffer sb = new StringBuffer();
		
		if(rev_grade==5.0) {
			sb.append("<fieldset class=\" rateRed\" disabled=\"disabled\">");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"5.0\" checked=\"checked\"><label class=\"full\" title=\"5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"4.5\" checked=\"checked\"><label class=\"half\" title=\"4.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"4.0\" checked=\"checked\" ><label class=\"full\" title=\"4점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"3.5\" checked=\"checked\" ><label class=\"half\" title=\"3.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"3.0\"checked=\"checked\" ><label class=\"full\" title=\"3점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"2.5\" checked=\"checked\" ><label class=\"half\" title=\"2.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"2.0\" checked=\"checked\" ><label class=\"full\" title=\"2점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"1.5\" checked=\"checked\" ><label class=\"half\" title=\"1.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"1\" checked=\"checked\" ><label class=\"full\" title=\"1점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"0.5\" checked=\"checked\" ><label class=\"half\" title=\"0.5점\"></label>");
			sb.append("</fieldset>");

			}else if(rev_grade==4.5){
			sb.append("<fieldset class=\" rateRed\" disabled=\"disabled\">");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"5.0\" ><label  class=\"full\" title=\"5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"4.5\" checked=\"checked\"><label class=\"half\" title=\"4.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"4.0\" checked=\"checked\" ><label  class=\"full\" title=\"4점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"3.5\" checked=\"checked\" ><label class=\"half\" title=\"3.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"3.0\"checked=\"checked\" ><label  class=\"full\" title=\"3점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"2.5\" checked=\"checked\" ><label class=\"half\" title=\"2.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"2.0\" checked=\"checked\" ><label  class=\"full\" title=\"2점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"1.5\" checked=\"checked\" ><label class=\"half\" title=\"1.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"1\" checked=\"checked\" ><label  class=\"full\" title=\"1점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"0.5\" checked=\"checked\" ><label class=\"half\" title=\"0.5점\"></label>");
			sb.append("</fieldset>");

			}else if(rev_grade==4.0){
			sb.append("<fieldset class=\" rateRed\" disabled=\"disabled\">");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"5.0\" ><label  class=\"full\" title=\"5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"4.5\" ><label class=\"half\" title=\"4.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"4.0\" checked=\"checked\"><label  class=\"full\" title=\"4점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"3.5\" checked=\"checked\" ><label class=\"half\" title=\"3.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"3.0\"checked=\"checked\" ><label  class=\"full\" title=\"3점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"2.5\" checked=\"checked\" ><label class=\"half\" title=\"2.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"2.0\" checked=\"checked\" ><label  class=\"full\" title=\"2점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"1.5\" checked=\"checked\" ><label class=\"half\" title=\"1.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"1\" checked=\"checked\" ><label  class=\"full\" title=\"1점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"0.5\" checked=\"checked\" ><label class=\"half\" title=\"0.5점\"></label>");
			sb.append("</fieldset>");

			}else if(rev_grade==3.5){
			sb.append("<fieldset class=\" rateRed\" disabled=\"disabled\">");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"5.0\" ><label  class=\"full\" title=\"5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"4.5\" ><label class=\"half\" title=\"4.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"4.0\" ><label  class=\"full\" title=\"4점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"3.5\" checked=\"checked\"><label class=\"half\" title=\"3.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"3.0\"checked=\"checked\" ><label  class=\"full\" title=\"3점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"2.5\" checked=\"checked\" ><label class=\"half\" title=\"2.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"2.0\" checked=\"checked\" ><label  class=\"full\" title=\"2점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"1.5\" checked=\"checked\" ><label class=\"half\" title=\"1.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"1\" checked=\"checked\" ><label  class=\"full\" title=\"1점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"0.5\" checked=\"checked\" ><label class=\"half\" title=\"0.5점\"></label>");
			sb.append("</fieldset>");

			}else if(rev_grade==3.0){
			sb.append("<fieldset class=\" rateRed\" disabled=\"disabled\">");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"5.0\" ><label  class=\"full\" title=\"5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"4.5\" ><label class=\"half\" title=\"4.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"4.0\" ><label  class=\"full\" title=\"4점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"3.5\" ><label class=\"half\" title=\"3.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"3.0\" checked=\"checked\"><label  class=\"full\" title=\"3점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"2.5\" checked=\"checked\" ><label class=\"half\" title=\"2.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"2.0\" checked=\"checked\" ><label  class=\"full\" title=\"2점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"1.5\" checked=\"checked\" ><label class=\"half\" title=\"1.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"1\" checked=\"checked\" ><label  class=\"full\" title=\"1점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"0.5\" checked=\"checked\" ><label class=\"half\" title=\"0.5점\"></label>");
			sb.append("</fieldset>");

			}else if(rev_grade==2.5){
			sb.append("<fieldset class=\" rateRed\" disabled=\"disabled\">");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"5.0\" ><label  class=\"full\" title=\"5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"4.5\" ><label class=\"half\" title=\"4.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"4.0\" ><label  class=\"full\" title=\"4점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"3.5\" ><label class=\"half\" title=\"3.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"3.0\"><label  class=\"full\" title=\"3점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"2.5\" checked=\"checked\"><label class=\"half\" title=\"2.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"2.0\" checked=\"checked\" ><label  class=\"full\" title=\"2점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"1.5\" checked=\"checked\" ><label class=\"half\" title=\"1.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"1\" checked=\"checked\" ><label  class=\"full\" title=\"1점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"0.5\" checked=\"checked\" ><label class=\"half\" title=\"0.5점\"></label>");
			sb.append("</fieldset>");

			}else if(rev_grade==2.0){
			sb.append("<fieldset class=\" rateRed\" disabled=\"disabled\">");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"5.0\" ><label  class=\"full\" title=\"5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"4.5\" ><label class=\"half\" title=\"4.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"4.0\" ><label  class=\"full\" title=\"4점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"3.5\" ><label class=\"half\" title=\"3.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"3.0\"><label  class=\"full\" title=\"3점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"2.5\" ><label class=\"half\" title=\"2.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"2.0\" checked=\"checked\"><label  class=\"full\" title=\"2점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"1.5\" checked=\"checked\" ><label class=\"half\" title=\"1.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"1\" checked=\"checked\" ><label  class=\"full\" title=\"1점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"0.5\" checked=\"checked\" ><label class=\"half\" title=\"0.5점\"></label>");
			sb.append("</fieldset>");

			}else if(rev_grade==1.5){
			sb.append("<fieldset class=\" rateRed\" disabled=\"disabled\">");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"5.0\" ><label  class=\"full\" title=\"5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"4.5\" ><label class=\"half\" title=\"4.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"4.0\" ><label  class=\"full\" title=\"4점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"3.5\" ><label class=\"half\" title=\"3.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"3.0\"><label  class=\"full\" title=\"3점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"2.5\" ><label class=\"half\" title=\"2.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"2.0\" ><label  class=\"full\" title=\"2점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"1.5\" checked=\"checked\"><label class=\"half\" title=\"1.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"1\" checked=\"checked\" ><label  class=\"full\" title=\"1점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"0.5\" checked=\"checked\" ><label class=\"half\" title=\"0.5점\"></label>");
			sb.append("</fieldset>");

			}else if(rev_grade==1.0){
			sb.append("<fieldset class=\" rateRed\" disabled=\"disabled\">");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"5.0\" ><label  class=\"full\" title=\"5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"4.5\" ><label class=\"half\" title=\"4.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"4.0\" ><label  class=\"full\" title=\"4점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"3.5\" ><label class=\"half\" title=\"3.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"3.0\"><label  class=\"full\" title=\"3점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"2.5\" ><label class=\"half\" title=\"2.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"2.0\" ><label  class=\"full\" title=\"2점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"1.5\" ><label class=\"half\" title=\"1.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"1\" checked=\"checked\"><label  class=\"full\" title=\"1점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"0.5\" checked=\"checked\" ><label class=\"half\" title=\"0.5점\"></label>");
			sb.append("</fieldset>");

			}else if(rev_grade==0.5){
			sb.append("<fieldset class=\" rateRed\" disabled=\"disabled\">");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"5.0\" ><label  class=\"full\" title=\"5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"4.5\" ><label class=\"half\" title=\"4.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"4.0\" ><label  class=\"full\" title=\"4점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"3.5\" ><label class=\"half\" title=\"3.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"3.0\"><label  class=\"full\" title=\"3점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"2.5\" ><label class=\"half\" title=\"2.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"2.0\" ><label  class=\"full\" title=\"2점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"1.5\" ><label class=\"half\" title=\"1.5점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"1\" ><label  class=\"full\" title=\"1점\"></label>");
			sb.append("<input readonly=\"readonly\" type=\"checkbox\" name=\"rev_grade\" value=\"0.5\"checked=\"checked\" ><label class=\"half\" title=\"0.5점\"></label>");
			sb.append("</fieldset>");

			}


		return sb.toString();
	}
}

