package com.ict.finalproject.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ict.finalproject.dao.CampCeoMapper;
import com.ict.finalproject.dao.CampMapper;
import com.ict.finalproject.dao.MemberMapper;
import com.ict.finalproject.dao.PreferMapper;
import com.ict.finalproject.service.EmailService;
import com.ict.finalproject.service.MemberService;
import com.ict.finalproject.vo.CampCeoVo;
import com.ict.finalproject.vo.CampVo;
import com.ict.finalproject.vo.MemberVo;
import com.ict.finalproject.vo.PreferVo;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;



@Controller
public class JoinController {

    @Autowired
	MemberService member_service;

    @Autowired
	MemberMapper member_dao;

    @Autowired
    PreferMapper prefer_dao;

    @Autowired
    CampMapper camp_dao;
	
    @Autowired
    CampCeoMapper camp_ceo_dao;
	
	@Autowired
	HttpServletRequest request;

    @Autowired
    EmailService emailService;
    
    // 약관 동의
    @RequestMapping("join_agree.do")
    public String join_agree_main(Model model, String mem_grade, String url){
        
        model.addAttribute("mem_grade", mem_grade);
        model.addAttribute("url", url);

        return "loginjoin/join_agree_main";
    }

    @RequestMapping("join_agree_container.do")
    public String join_agree_container(Model model, String mem_grade, String url, String mem_name, String mem_tel,String mem_email_first, String mem_email_domain){
        
        model.addAttribute("mem_grade", mem_grade);
        model.addAttribute("url", url);
        model.addAttribute("mem_name", mem_name);
        model.addAttribute("mem_tel", mem_tel);
        model.addAttribute("mem_email_first", mem_email_first);
        model.addAttribute("mem_email_domain", mem_email_domain);

        return "loginjoin/join_agree_container";
    }


    // 정보 입력 - 일반회원
    @RequestMapping("join_input.do")
    public String join_input_main(Model model, String url,MemberVo vo, String mem_email_first, String mem_email_domain){

        model.addAttribute("url", url);
        model.addAttribute("vo", vo);
        model.addAttribute("mem_email_first", mem_email_first);
        model.addAttribute("mem_email_domain", mem_email_domain);

        return "loginjoin/join_input_main";
    }

    @RequestMapping("join_input_container.do")
    public String join_input_container(Model model, String url, MemberVo vo, String mem_email_first, String mem_email_domain){

        model.addAttribute("url", url);
        model.addAttribute("vo", vo);
        model.addAttribute("mem_email_first", mem_email_first);
        model.addAttribute("mem_email_domain", mem_email_domain);

        List<CampVo> listdo = camp_dao.selectListDo();

        model.addAttribute("listdo", listdo);

        return "loginjoin/join_input_container";
    }

    @RequestMapping("listsi_json.do")
    @ResponseBody
    public List<CampVo> listsi_json(String doNm){

        List<CampVo> list = camp_dao.selectOneListSi(doNm);
        
        return list;
    }

    // 정보입력 - 사장 회원
    @RequestMapping("join_input_ceo.do")
    public String join_input_ceo_main(Model model, MemberVo vo){

        model.addAttribute("vo", vo);

        return "loginjoin/join_input_main_ceo";
    }

    @RequestMapping("join_input_container_ceo.do")
    public String join_input_forceo_container(Model model, MemberVo vo){
       
        model.addAttribute("vo", vo);
        
        return "loginjoin/join_input_container_ceo";
    }


    //	회원가입
	@RequestMapping("join_insert_general.do")
	public String join_insert_general(Model model, MemberVo vo, PreferVo pre_vo, String url){

        // email 합치기
        String mem_email_first = request.getParameter("mem_email_first");
        String mem_email_domain = request.getParameter("mem_email_domain");

        String mem_email = String.format("%s@%s", mem_email_first, mem_email_domain);

        vo.setMem_email(mem_email);

        // 비밀번호 암호화
        // String plainTextPassword = vo.getMem_pwd(); // MemberVo에서 비밀번호 가져오기
        // String hashedPassword = BCrypt.hashpw(plainTextPassword, BCrypt.gensalt()); // 비밀번호 해싱
        // vo.setMem_pwd(hashedPassword); // 해싱된 비밀번호를 객체에 설정

        //	IP
        String mem_ip = request.getRemoteAddr();
        vo.setMem_ip(mem_ip);

        // url
        model.addAttribute("url", url);

        // 선호지역
        Map<String, String> pre_map = new HashMap<>();

        String pre_si1 = request.getParameter("pre_si1");
        String pre_gun1 = request.getParameter("pre_gun1");

        if(pre_si1 != "" && pre_gun1 != ""){
            pre_map.put("pre_si1", pre_si1);
            pre_map.put("pre_gun1", pre_gun1);
        }

        String pre_si2 = request.getParameter("pre_si2");
        String pre_gun2 = request.getParameter("pre_gun2");

        if(pre_si2 != "" && pre_gun2 != ""){
            pre_map.put("pre_si2", pre_si2);
            pre_map.put("pre_gun2", pre_gun2);
        }

        String pre_si3 = request.getParameter("pre_si3");
        String pre_gun3 = request.getParameter("pre_gun3");

        if(pre_si3 != "" && pre_gun3 != ""){
            pre_map.put("pre_si3", pre_si3);
            pre_map.put("pre_gun3", pre_gun3);
        }

   //     pre_map.put("no_pre", "no_pre");

        //	DB insert
        try {
            member_service.insert_general(vo, pre_vo, pre_map);
            
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return "redirect:join_agree.do?mem_grade=general&url=" + url;
            
        }

        

        return "redirect:join_finish.do?url=" + url; 
	}//end:join_insert_general

    //	회원가입
	@RequestMapping("join_insert_ceo.do")
	public String join_insert_ceo(MemberVo vo, CampCeoVo camp_ceo_vo) {
        
        String mem_email_first = request.getParameter("mem_email_first");
        String mem_email_domain= request.getParameter("mem_email_domain");

        String mem_email = String.format("%s@%s", mem_email_first, mem_email_domain);

        vo.setMem_email(mem_email);

        // 비밀번호 암호화
        // String plainTextPassword = vo.getMem_pwd(); // MemberVo에서 비밀번호 가져오기
        // String hashedPassword = BCrypt.hashpw(plainTextPassword, BCrypt.gensalt()); // 비밀번호 해싱
        // vo.setMem_pwd(hashedPassword); // 해싱된 비밀번호를 객체에 설정

        //	IP
        String mem_ip = request.getRemoteAddr();
        vo.setMem_ip(mem_ip);

        // 사업자번호
        String b_no = camp_ceo_vo.getBizrno();
        String bizrno = String.format("%s-%s-%s", b_no.substring(0,3), b_no.substring(3,5), b_no.substring(5,10));  
        camp_ceo_vo.setBizrno(bizrno);

        //	DB insert
        try {
            member_service.insert_ceo(vo, camp_ceo_vo);
            
        } catch (Exception e) {
            
            System.out.println(e.getMessage());
            return "redirect:join_agree.do?mem_grade=ceo";
            
        }

        return "redirect:join_finish.do";
	}//end:join_insert_general


    //	회원가입
	@RequestMapping("join_insert_manager.do")
	public String join_insert_manager(MemberVo vo) {
        
        String mem_email_first = request.getParameter("mem_email_first");
        String mem_email_domain= request.getParameter("mem_email_domain");

        String mem_email = String.format("%s@%s", mem_email_first, mem_email_domain);

        vo.setMem_email(mem_email);
        
        //	IP
        String mem_ip = request.getRemoteAddr();
        vo.setMem_ip(mem_ip);

        //	DB insert
        try {
            member_service.insert_manager(vo);
            
        } catch (Exception e) {
            
            System.out.println(e.getMessage());
            
        }

        return "redirect:mypage_main.do";
	}//end:join_insert_general



    //	아이디 체크
	@RequestMapping(value="check_id.do", produces="application/json;charset=utf-8;")
	@ResponseBody
	public Map<String, Boolean> check_id(String mem_id) {
		
		//	/member/check_id.do?mem_id=one
		MemberVo vo = member_dao.selectOneMemId(mem_id);
		
		//	true	: 사용 가능한 아이디
		//	false	: 사용 불가능한 아이디
		boolean bResult = (vo==null);
		
		Map<String, Boolean> map = new HashMap<String,Boolean>();
        map.put("result", bResult);
		
		return map;
	}

    //	이메일 체크
	@RequestMapping(value="check_email.do", produces="application/json;charset=utf-8;")
	@ResponseBody
	public Map<String, Object> check_email(String mem_email_first, String mem_email_domain) {
		
        String mem_email = String.format("%s@%s", mem_email_first, mem_email_domain);

		MemberVo vo = member_dao.selectOneMemEmail(mem_email);
		
		//	true	: 사용 가능한 email
		//	false	: 사용 불가능한 email
		boolean bResult = (vo==null);
		
		Map<String, Object> map = new HashMap<String,Object>();
        map.put("result", bResult);

        int code = 0;

        try {
            code = emailService.sendCheck(mem_email);
        } catch (MessagingException e) {

            e.printStackTrace();
        }

        if(code!=0){
            map.put("code", code);
        }
		
		return map;
	}

    // 사업자번호 db에 있는지 확인
    @RequestMapping("check_db_bizrno.do")
    @ResponseBody
    public Map<String, String> check_db_bizrno (String b_no){

        //0000000000 -> 000-00-00000
        String bizrno = String.format("%s-%s-%s", b_no.substring(0,3), b_no.substring(3,5), b_no.substring(5,10));

        Map<String, String> map = new HashMap<String, String>();

        //	check DB
        try {
            map = member_service.check_bizrno(bizrno);
            
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return map;
        
    }


    //  회원가입 완료
    @RequestMapping("join_finish.do")
    public String join_finish(Model model, String url){

        model.addAttribute("url", url);

        return "loginjoin/join_finish_main";
    }

    @RequestMapping("join_finish_container.do")
    public String join_finish_container(Model model, String url){

        model.addAttribute("url", url);

        return "loginjoin/join_finish_container";
    }

    //  header
    @RequestMapping("join_header.do")
    public String join_header(){

        return "loginjoin/join_header";
    }

    


}
