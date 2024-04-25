package com.ict.finalproject.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ict.finalproject.dao.MemberMapper;
import com.ict.finalproject.service.MemberService;
import com.ict.finalproject.util.GoogleLogin;
import com.ict.finalproject.vo.MemberVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class GoogleController {

    @Autowired
    HttpServletRequest request;

    @Autowired
	MemberMapper member_dao;

    @Autowired
	HttpSession session;
    
    @Autowired
	MemberService mem_ser_dao;

    @RequestMapping("/google_login.do")
    public String google_login(RedirectAttributes attr) throws IOException{

        String code     = request.getParameter("code");
        String scope    = request.getParameter("scope");
        String authuser = request.getParameter("authuser");
        String prompt   = request.getParameter("prompt");

        try {code       = request.getParameter("code");} catch (Exception e) {}
        try {scope      = request.getParameter("scope");} catch (Exception e) {}
        try {authuser   = request.getParameter("authuser");} catch (Exception e) {}
        try {prompt     = request.getParameter("prompt");} catch (Exception e) {}

        // String url = request.getParameter("url");
        // System.out.println(url);

        // code가 있다는건 정상적으로 로그인 되었다는뜻
        if (code != null) {
            JSONObject json = GoogleLogin.google_get_token(code);

            // System.out.println(json.toString());

            String access_token = "";
            try {access_token = json.getString("access_token");} catch (Exception e) {}

            

            if (access_token != null) {
                JSONObject json_info = GoogleLogin.google_get_info(access_token);

                if (json_info.getString("id") != null) {//연결 성공시 코드  
                    // db에 있나 확인 있으면 url 없으면 join_agree
                    String mem_google   = json_info.getString("id");

                    MemberVo vo = member_dao.selectOneGoogleId(mem_google);

                    if(vo==null){   // 회원가입해야함
                        String mem_name     = json_info.getString("name");
                        String email        = json_info.getString("email");
                        String mem_grade    = "general";
    
                        // System.out.println(mem_grade);
    
                        String emailParts[] = email.split("@");
    
                        if(emailParts.length == 2) {
                            String mem_email_first = emailParts[0];
                            String mem_email_domain = emailParts[1];
    
                            attr.addFlashAttribute("mem_email_first", mem_email_first);
                            attr.addFlashAttribute("mem_email_domain", mem_email_domain);
    
                            // System.out.println(mem_email_first);
                            // System.out.println(mem_email_domain);
        
                        }

                        //	Model을 통해서 DS에게 데이터 전달 -> redirect이면 parameter로 처리
                        //	SpringBoot에서 redirect시 parameter는 RedirectAttribute를 이용해서 parameter처리한다
                        //	SpringBoot에서 model은 request binding만 한다.

                        //  addFlashAttribute   : 복잡한 타입의 데이터 전달, 리다이렉션을 거친직후의 요청에서만 사용
                        //  addAttribute        : 리다이렉션 URL에 쿼리 파라미터로 추가됨
                        attr.addFlashAttribute("mem_google", mem_google);
                        attr.addFlashAttribute("mem_name", mem_name);
                        attr.addAttribute("mem_grade", mem_grade);
    
                        // System.out.println(json_info.getString("id"));
                        // System.out.println(json_info.getString("name"));
                    
    
                        return "redirect:join_agree.do";

                    }else{  // 이미 회원가입 되어있음 -> 로그인

                        //	세션 정보 얻어오기 -> 로그인 유저 정보 저장
                        session.setAttribute("user", vo);


                        // String queryString = request.getQueryString();
                        // System.out.println("----------");
                        // System.out.println(queryString);
                        // System.out.println("----------");

                        return "redirect:main.do";

                    }

                }else{  // 연결실패
                    String message = json_info.getJSONObject("error").getString("message");
                    return "redirect:login_main.do";

                }

            }   // access 토큰 없음

        }   // 코드 없음

        return "redirect:login_main.do";
    }

    @RequestMapping("/google_sns.do")
    public String google_sns(RedirectAttributes attr,Model model) throws Throwable{

        String code     = request.getParameter("code");
        String scope    = request.getParameter("scope");
        String authuser = request.getParameter("authuser");
        String prompt   = request.getParameter("prompt");
        Map<String,Object> sns_map = new HashMap<String,Object>();
		int res = 0;

        try {code       = request.getParameter("code");} catch (Exception e) {}
        try {scope      = request.getParameter("scope");} catch (Exception e) {}
        try {authuser   = request.getParameter("authuser");} catch (Exception e) {}
        try {prompt     = request.getParameter("prompt");} catch (Exception e) {}

        // String url = request.getParameter("url");
        // System.out.println(url);

        // code가 있다는건 정상적으로 로그인 되었다는뜻
        if (code != null) {
            JSONObject json = GoogleLogin.google_get_token_s(code);

            // System.out.println(json.toString());

            String access_token = "";
            try {access_token = json.getString("access_token");} catch (Exception e) {}

            

            if (access_token != null) {
                JSONObject json_info = GoogleLogin.google_get_info(access_token);

                if (json_info.getString("id") != null) {//연결 성공시 코드  
                    // db에 있나 확인 있으면 url 없으면 join_agree
                    String mem_google   = json_info.getString("id");
                    MemberVo user = (MemberVo)session.getAttribute("user");
                    if (user == null) {
                        model.addAttribute("timeout", true);
                        return "redirect:login_main.do";
                    }
                    sns_map.put("mem_idx", user.getMem_idx());
                    sns_map.put("google", mem_google);
                    res = mem_ser_dao.insert_sns(sns_map);
                    if (res==1) {
                        MemberVo u = member_dao.selectOneGeneralId(user.getMem_id());
                        session.setAttribute("user", u);
                        attr.addFlashAttribute("google_insert",true);
                    }
                   

                    

                }else{  // 연결실패
                    String message = json_info.getJSONObject("error").getString("message");
                    System.out.println(message);
                    attr.addFlashAttribute("google_insert_error",true);

                }

            }   // access 토큰 없음

        }   // 코드 없음

        return "redirect:mypage_main.do";
    }


    // 여기 redirect client_id 가 들어갈곳이 있어요!..
    @RequestMapping("/google_url.do")
    public String google_url(){
        String client_id="";
        String redirect_uri ="https://camprover.store/google_login.do";
        return String.format("redirect:https://accounts.google.com/o/oauth2/v2/auth?client_id=%s&redirect_uri=%s&response_type=code&scope=email profile", client_id, redirect_uri);
    }

}
