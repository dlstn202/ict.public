package com.ict.finalproject.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ict.finalproject.dao.MemberMapper;
import com.ict.finalproject.service.MemberService;
import com.ict.finalproject.util.NaverLogin;
import com.ict.finalproject.vo.MemberVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class NaverController {

	@Autowired
    HttpServletRequest request;

	@Autowired
	MemberMapper member_dao;

	@Autowired
	HttpSession session;

    @Autowired
	MemberService mem_ser_dao;

    @RequestMapping("naver_url.do")
	public String naver_url() throws IOException{
        String client_id = "";
        String redirect_uri = "https://camprover.store/naver_login.do";
        return String.format("redirect:https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=%s&redirect_uri=%s&response_type=code", client_id,redirect_uri);
	}

    @RequestMapping("naver_login.do")
    public String naver_login(@RequestParam String state, RedirectAttributes attr) throws IOException{

        String code = "";
        String error = "";
        String error_description = "";

        try {code              = request.getParameter("code");} catch (Exception e) {}
        try {error             = request.getParameter("error");} catch (Exception e) {}
        try {error_description = request.getParameter("error_description");} catch (Exception e) {}

        // code가 있다는건 정상적으로 로그인 되었다는뜻
        if (code != null) {
            JSONObject json = NaverLogin.naver_get_token(code);

            String access_token = "";
            String refresh_token = "";
            String expires_in = "";

            try {access_token    = json.getString("access_token");} catch (Exception e) {}
            try {refresh_token   = json.getString("refresh_token");} catch (Exception e) {}
            try {expires_in      = json.getString("expires_in");} catch (Exception e) {}

            if (access_token != null) {
                JSONObject json_info = NaverLogin.naver_get_info(access_token);
                JSONObject jsos_user =json_info.getJSONObject("response");

                if (jsos_user.getString("id") != null) {//연결 성공시 코드  

                    String mem_naver   = jsos_user.getString("id");
                    MemberVo vo        = member_dao.selectOneNaverId(mem_naver);

                    if (vo == null){ //신규회원일 경우

                        String mem_name   = jsos_user.getString("name");
                        String mem_tel    = jsos_user.getString("mobile").replaceAll("-", "");
                        String mem_email  = jsos_user.getString("email");
                        String mem_grade  = "general";

                        String emailParts[] = mem_email.split("@");

                        if(emailParts.length == 2) {
                            String mem_email_first = emailParts[0];
                            String mem_email_domain = emailParts[1];
    
                            attr.addFlashAttribute("mem_email_first", mem_email_first);
                            attr.addFlashAttribute("mem_email_domain", mem_email_domain);
    
                      
        
                        }

                        //회원가입 페이지로 리다이렉션하면서 필요한 정보를 전달
                        attr.addFlashAttribute("mem_naver", mem_naver);
                        attr.addFlashAttribute("mem_name", mem_name);
                        attr.addFlashAttribute("mem_tel", mem_tel);
                        attr.addFlashAttribute("mem_email", mem_email);
                        attr.addAttribute("mem_grade", mem_grade);

                      
                   
                        return "redirect:join_agree.do"; // 회원가입 동의 페이지 또는 직접 회원가입 처리 페이지

                    }else{ //이미 회원일 경우
                        //로그인 처리
                        session.setAttribute("user", vo);
                        return "redirect:main.do"; // 메인 페이지로 리다이렉션
                    }

                }else{
                    // 사용자 정보 요청 실패 처리
                    String message = json_info.getJSONObject("error").getString("message");
                     return "redirect:login_main.do";
                }
                }else{
                    // 액세스 토큰 요청 실패 처리
                    return "redirect:login_main.do";
                }


            }
            
            return "redirect:main.do";
    }

    @RequestMapping("naver_sns.do")
    public String naver_sns(@RequestParam String state, RedirectAttributes attr,Model model) throws Throwable{

        String code = "";
        String error = "";
        String error_description = "";
        Map<String,Object> sns_map = new HashMap<String,Object>();
		int res = 0;

        try {code              = request.getParameter("code");} catch (Exception e) {}
        try {error             = request.getParameter("error");} catch (Exception e) {}
        try {error_description = request.getParameter("error_description");} catch (Exception e) {}

        // code가 있다는건 정상적으로 로그인 되었다는뜻
        if (code != null) {
            JSONObject json = NaverLogin.naver_get_token(code);

            String access_token = "";
            String refresh_token = "";
            String expires_in = "";

            try {access_token    = json.getString("access_token");} catch (Exception e) {}
            try {refresh_token   = json.getString("refresh_token");} catch (Exception e) {}
            try {expires_in      = json.getString("expires_in");} catch (Exception e) {}

            if (access_token != null) {
                JSONObject json_info = NaverLogin.naver_get_info(access_token);
                JSONObject jsos_user =json_info.getJSONObject("response");


                if (jsos_user.getString("id") != null) {//연결 성공시 코드

                    String mem_naver = jsos_user.getString("id");
                    MemberVo user = (MemberVo)session.getAttribute("user");
                    if (user == null) {
                        model.addAttribute("timeout", true);
                        return "redirect:login_main.do";
                    }
                    sns_map.put("mem_idx", user.getMem_idx());
                    sns_map.put("naver", mem_naver);
                    res = mem_ser_dao.insert_sns(sns_map);
                    if (res==1) {
                        MemberVo u = member_dao.selectOneGeneralId(user.getMem_id());
                        session.setAttribute("user", u);
                        attr.addFlashAttribute("naver_insert",true);
                    }

                    

                }else{
                    // 사용자 정보 요청 실패 처리
                    String message = json_info.getJSONObject("error").getString("message");
                    System.out.println(message);
                }
            }else{
                // 액세스 토큰 요청 실패 처리
                attr.addFlashAttribute("naver_insert_error",true);
                }


            }
            
            return "redirect:mypage_main.do";
    }

}
