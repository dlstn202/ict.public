package com.ict.finalproject.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ict.finalproject.dao.MemberMapper;
import com.ict.finalproject.util.NaverLogin;
import com.ict.finalproject.vo.MemberVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired
	MemberMapper member_dao;
	
	@Autowired
	HttpSession session;

	@Autowired
	HttpServletRequest request;
	
    @RequestMapping("login_main.do")
    public String login_main(String url,Model model){

		model.addAttribute("url", url);

        return "loginjoin/login_main";
    }


    @RequestMapping("login_container.do")
    public String login_container(String url,Model model) throws IOException{

		String naver_login_url = NaverLogin.naver_login_url();

		//System.out.println(url);
		model.addAttribute("url", url);
		model.addAttribute("naver_login_url", naver_login_url);
		
        return "loginjoin/login_container";
    }

    @RequestMapping("login_header.do")
    public String login_header(){

        return "loginjoin/login_header";
    }

    @RequestMapping(value = "login_manager.do", produces="application/json; charset=utf-8;")
    @ResponseBody
    public Map<String, Object> login_manager(MemberVo vo){

        //	1. parameter 받기
		String mem_id	= vo.getMem_id();
		String mem_pwd	= vo.getMem_pwd();
		
		//	2. pl_mem_id에 해당되는 유저정보 읽어오기
		MemberVo user = member_dao.selectOneManagerId(mem_id);
		
		Map<String, Object> map = new HashMap<String, Object>();
		

		if(user==null) {
			map.put("reason", "fail_id");
			return map;
		}
		
		//	비밀번호가 틀린 경우
		if(user.getMem_pwd().equals(mem_pwd)==false) {
			map.put("reason", "fail_pwd");
			map.put("mem_id", mem_id);
			return map;
		}
				
		//	세션 정보 얻어오기 -> 로그인 유저 정보 저장
		session.setAttribute("user", user);

		return map;
    }

    @RequestMapping(value = "login_ceo.do", produces="application/json; charset=utf-8;")
    @ResponseBody
    public Map<String, Object> login_ceo(MemberVo vo){

        //	1. parameter 받기
		String mem_id	= vo.getMem_id();
		String mem_pwd	= vo.getMem_pwd();
		
		//	2. pl_mem_id에 해당되는 유저정보 읽어오기
		MemberVo user = member_dao.selectOneCeoId(mem_id);		
		Map<String, Object> map = new HashMap<String, Object>();
		

		if(user==null) {
			map.put("reason", "fail_id");
			return map;
		}
		
		//	비밀번호가 틀린 경우
		if(user.getMem_pwd().equals(mem_pwd)==false) {
			map.put("reason", "fail_pwd");
			map.put("mem_id", mem_id);
			return map;
		}
				
		//	세션 정보 얻어오기 -> 로그인 유저 정보 저장
		session.setAttribute("user", user);

		// if (user.getCamp_ceo_list() != null) {
		// 	for(CampCeoVo camp_ceo_vo:user.getCamp_ceo_list()){
		// 		System.out.println(camp_ceo_vo.getBizrno());
		// 	}
		// }

		return map;
    }


    @RequestMapping(value = "login_general.do", produces="application/json; charset=utf-8;")
    @ResponseBody
    public Map<String, Object> login_general(MemberVo vo){

        //	1. parameter 받기
		String mem_id	= vo.getMem_id();
		String mem_pwd	= vo.getMem_pwd();
		
		//	2. pl_mem_id에 해당되는 유저정보 읽어오기
		MemberVo user = member_dao.selectOneGeneralId(mem_id);
		
		Map<String, Object> map = new HashMap<String, Object>();
		

		if(user==null) {
			map.put("reason", "fail_id");
			return map;
		}
		
		//	비밀번호가 틀린 경우
		if(user.getMem_pwd().equals(mem_pwd)==false) {
			map.put("reason", "fail_pwd");
			map.put("mem_id", mem_id);
			return map;
		}
		// if(!BCrypt.checkpw(mem_pwd, user.getMem_pwd())) {
		// 	map.put("reason", "fail_pwd");
		// 	map.put("mem_id", mem_id);
		// 	return map;
		// }
				
		//	세션 정보 얻어오기 -> 로그인 유저 정보 저장
		session.setAttribute("user", user);

		return map;
    }

	@RequestMapping(value = "logout.do", produces="application/json; charset=utf-8;")
    @ResponseBody
    public Map<String, Object> logout(){

		session.removeAttribute("user");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if (session.getAttribute("user") == null) {
			map.put("result", true);
		}
		

		return map;
    }

}
