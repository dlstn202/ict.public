package com.ict.finalproject.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ict.finalproject.dao.MemberManagerMapper;
import com.ict.finalproject.dao.MemberMapper;
import com.ict.finalproject.dao.PreferMapper;
import com.ict.finalproject.service.EmailService;
import com.ict.finalproject.service.MemberService;
import com.ict.finalproject.vo.CampCeoVo;
import com.ict.finalproject.vo.MemberVo;
import com.ict.finalproject.vo.PreferVo;

import jakarta.mail.MessagingException;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;



@Controller
public class MemberController {

    @Autowired
    HttpSession session;

    @Autowired
	ServletContext application;
    
	@Autowired
	HttpServletRequest request;

    @Autowired
	MemberService member_service;

    @Autowired
	PreferMapper prefer_dao;

    @Autowired
    MemberMapper member_dao;

    @Autowired
	MemberManagerMapper member_manager_dao;

    @Autowired
    EmailService emailService;


    @RequestMapping("member_modify.do")
    public String member_modify(Model model, 
                                MemberVo member_vo, 
                                PreferVo prefer_vo, 
                                CampCeoVo camp_ceo_vo, 
                                @RequestParam(value="photo",required = false) MultipartFile photo) throws IllegalStateException, IOException {

        MemberVo user = (MemberVo) session.getAttribute("user");
        if (user == null) {
            model.addAttribute("timeout", true);
            return "redirect:login_main.do";
        }

        member_vo.setMem_idx(user.getMem_idx());
        String mem_grade = user.getMem_grade();

        // ip
        String mem_ip = request.getRemoteAddr();
		member_vo.setMem_ip(mem_ip);

        // 비밀번호 암호화
        // String plainTextPassword = member_vo.getMem_pwd(); // 사용자가 입력한 비밀번호
        // String hashedPassword = BCrypt.hashpw(plainTextPassword, BCrypt.gensalt());
        // member_vo.setMem_pwd(hashedPassword); // 암호화된 비밀번호 설정


        // email 합치기
        String mem_email_first = request.getParameter("mem_email_first");
        String mem_email_domain = request.getParameter("mem_email_domain");

        String mem_email = String.format("%s@%s", mem_email_first, mem_email_domain);

        member_vo.setMem_email(mem_email);

        if(mem_grade.equals("general")){

            // 프로필 사진 -----------------------
            String abs_path = application.getRealPath("/member_photo_upload/");	//	절대 경로

            //if(deletePhoto.equals("on")) {
                //	예전 이미지 삭제 절차
                if(user.getMem_photo() != null && member_vo.getMem_photo() == null){
                    File oldFile = new File(abs_path, user.getMem_photo());
                    oldFile.delete();
                    user.setMem_photo(null);
                    session.setAttribute("user", user);
                }
            //}

            if(photo != null && !photo.isEmpty()) {	// 업로드된 파일이 존재하면

                // if(deletePhoto.equals("false") && user.getMem_photo() != null) {
                if(user.getMem_photo() != null) {
                    //	예전 이미지 삭제 절차
                    File oldFile = new File(abs_path, user.getMem_photo());
                    oldFile.delete();
                }
		
                //	클라이언트 측에서 업로드된 파일명
                String mem_photo = photo.getOriginalFilename();
                
                //	같은 이름의 파일이 있으면 이름을 다르게 줘야 함
                //	파일정보관리객체(File)
                File f = new File(abs_path, mem_photo);
                
                //	동일파일 존재 유무 체크
                if(f.exists()) {	// ms임에도 걱정된다면 while(f.exists()){}
                    //	시간을 붙여서 저장하면 중복될 일이 없음(ms단위)
                    long tm = System.currentTimeMillis();	//	-> 현재 시간을 millisecond단위로 구한다
                    
                    //	시간_filename형식으로 이름 변경
                    //	filename = "234567891_a.jpg"
                    mem_photo = String.format("%d_%s", tm, mem_photo);
                    
                    f = new File(abs_path, mem_photo);
                }
                
                //	임시 저장 파일 -> 내가 지정한 위치 + 파일명으로 복사
                photo.transferTo(f);
                member_vo.setMem_photo(mem_photo);

            }else{
                member_vo.setMem_photo(user.getMem_photo());
            }

            // 선호지역 --------------------------
            Map<String, String> pre_map = new HashMap<>();
            
            String pre_si1  = "";
            String pre_gun1 = "";
            String pre_idx1 = "";

            if (request.getParameter("pre_si1") !=null) 
                pre_si1 = request.getParameter("pre_si1");
            if (request.getParameter("pre_gun1") !=null) 
                pre_gun1 = request.getParameter("pre_gun1");
            if (request.getParameter("pre_idx1") !=null) 
                pre_idx1 = request.getParameter("pre_idx1");

            if(!pre_si1.isEmpty() && !pre_gun1.isEmpty()){
                pre_map.put("pre_si1", pre_si1);
                pre_map.put("pre_gun1", pre_gun1);

                if(!pre_idx1.isEmpty()){
                    pre_map.put("pre_idx1", pre_idx1);
                }

            }

            String pre_si2 = "";
            String pre_gun2 = "";
            String pre_idx2 = "";

            if (request.getParameter("pre_si2") !=null) 
                pre_si2 = request.getParameter("pre_si2");
            if (request.getParameter("pre_gun2") !=null) 
                pre_gun2 = request.getParameter("pre_gun2");
            if (request.getParameter("pre_idx2") !=null) 
                pre_idx2 = request.getParameter("pre_idx2");

            if(!pre_si2.isEmpty() && !pre_gun2.isEmpty()){
                pre_map.put("pre_si2", pre_si2);
                pre_map.put("pre_gun2", pre_gun2);
                
                if(!pre_idx2.isEmpty()){
                    pre_map.put("pre_idx2", pre_idx2);
                }

            }

            String pre_si3  = "";
            String pre_gun3 = "";
            String pre_idx3 = "";

            if (request.getParameter("pre_si3") !=null) 
                pre_si3 = request.getParameter("pre_si3");
            if (request.getParameter("pre_gun3") !=null) 
                pre_gun3 = request.getParameter("pre_gun3");
            if (request.getParameter("pre_idx3") !=null) 
                pre_idx3 = request.getParameter("pre_idx3");

            if(!pre_si3.isEmpty() && !pre_gun3.isEmpty()){
                pre_map.put("pre_si3", pre_si3);
                pre_map.put("pre_gun3", pre_gun3);

                if(!pre_idx3.isEmpty()){
                    pre_map.put("pre_idx3", pre_idx3);
                }

            }

            try {
                member_service.update_general(member_vo, prefer_vo, pre_map);

                member_vo = member_dao.selectOneGeneralId(user.getMem_id());
                session.setAttribute("user", member_vo);
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }

        }else if(mem_grade.equals("ceo")){
            try {
                member_service.update_ceo(member_vo); 
                
                member_vo = member_dao.selectOneCeoId(user.getMem_id());
                session.setAttribute("user", member_vo); 
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }else if(mem_grade.equals("manager")){
            try {
                member_dao.updateCommon(member_vo);

                member_vo = member_dao.selectOneManagerId(user.getMem_id());
                session.setAttribute("user", member_vo);
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
  

        return "redirect:mypage_container_manager_authorize.do";
    }

    @RequestMapping("admin_modify.do")
    public String admin_modify(MemberVo member_vo) {

        if(member_vo.getMem_quit_yn().equals("y")){
            try {
                member_service.delete_manager(member_vo);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }else{
            try {
                member_manager_dao.updateManager(member_vo);
            } catch (Exception e) {
                e.printStackTrace();
            }

        }

        
        return "redirect:mypage_main.do";
    }

    @RequestMapping("reset_pwd_admin.do")
    public String rest_pwd(Model model, int mem_idx, String new_pwd) {

        MemberVo member_vo = member_dao.selectOneManager(mem_idx);
        member_vo.setMem_pwd(new_pwd);

        try {
            member_dao.updateCommon(member_vo);
        } catch (Exception e) {
            e.printStackTrace();
        }

        model.addAttribute("member_vo", member_vo);
        
        return "redirect:mypage_main.do";
    }
    


    @RequestMapping("member_delete.do")
    public String member_delete(Model model) { // int mem_idx, String mem_grade

        MemberVo user = (MemberVo) session.getAttribute("user");
        if (user == null) {
            model.addAttribute("timeout", true);  
            return "redirect:login_main.do";
        }
        
      //  int mem_idx = member_vo.getMem_idx();
        String mem_grade = user.getMem_grade();

        if(mem_grade.equals("general")){

            String abs_path = application.getRealPath("/member_photo_upload/");	//	절대 경로

            if(user.getMem_photo() != null && !user.getMem_photo().isEmpty()){
                File oldFile = new File(abs_path, user.getMem_photo());
                oldFile.delete();
            }
        }

        try {
            member_service.delete_general(user.getMem_idx());
        //   member_dao.deleteCommon(user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        

        return "redirect:logout.do";
    }

    @RequestMapping("member_del_m.do")
    public String member_del_m(Model model, MemberVo vo,RedirectAttributes attr) { // int mem_idx, String mem_grade

        MemberVo user = (MemberVo) session.getAttribute("user");
        if (user == null) {
            model.addAttribute("timeout", true);  
            return "redirect:login_main.do";
        }

        
        
      //  int mem_idx = member_vo.getMem_idx();
        String mem_grade = vo.getMem_grade();

        if(mem_grade.equals("general")){

            String abs_path = application.getRealPath("/member_photo_upload/");	//	절대 경로

            if(user.getMem_photo() != null && !user.getMem_photo().isEmpty()){
                File oldFile = new File(abs_path, user.getMem_photo());
                oldFile.delete();
            }
        }

        try {
            member_service.delete_general(vo.getMem_idx());
            attr.addFlashAttribute("mem_del", "del");
        //   member_dao.deleteCommon(user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        

        return "redirect:mypage_main.do";
    }



    @RequestMapping("find_id.do")
    public String find_id(){
        return "member/find_id_main";
    }

    @RequestMapping("find_id_header.do")
    public String find_id_header(){
        return "member/find_id_header";
    }

    @RequestMapping("find_id_container.do")
    public String find_id_container(){
        return "member/find_id_container";
    }

    @RequestMapping("search_id.do")
    @ResponseBody
    public Map<String,Object> search_id(MemberVo vo){

        Map<String,Object> map = new HashMap<String,Object>();

        MemberVo result_vo = member_service.selectOneNameEmail(vo);

        if (result_vo != null) {
            map.put("result", true);
            map.put("id", result_vo.getMem_id());
            map.put("regdate", result_vo.getMem_joindate());
        }

        return map;
    }

    @RequestMapping("change_pwd.do")
    @ResponseBody
    public Map<String,Object> change_pwd(MemberVo vo){

        Map<String,Object> map = new HashMap<String,Object>();

        String pwd = "";
        int res = 0;

        try {
            pwd = emailService.sendPWD(vo.getMem_email());
            vo.setMem_pwd(pwd);
            try {
                res = member_service.update_pwd(vo);
            } catch (Exception e) {
                
                e.printStackTrace();
            }

            if (res == 1) {
                map.put("result", true);
            }else{
                map.put("error", "비밀번호 초기화 실패");
            }
            map.put("result", true);
        } catch (MessagingException e) {
            map.put("error", "메일전송 실패");
            e.printStackTrace();
        }

        
        return map;
    }

    @RequestMapping("find_pwd.do")
    public String find_pwd(){
        return "member/find_pwd_main";
    }

    @RequestMapping("find_pwd_header.do")
    public String find_pwd_header(){
        return "member/find_pwd_header";
    }

    @RequestMapping("find_pwd_container.do")
    public String find_pwd_container(){
        return "member/find_pwd_container";
    }

    @RequestMapping("change_pwd_id.do")
    @ResponseBody
    public Map<String,Object> change_pwd_id(MemberVo vo){

        Map<String,Object> map = new HashMap<String,Object>();

        MemberVo result_vo = member_service.selectOneNaIdEm(vo);

        if (result_vo == null) {
            map.put("result", false);
            return map;
        }

        String pwd = "";
        int res = 0;

        try {
            pwd = emailService.sendPWD(vo.getMem_email());
            vo.setMem_pwd(pwd);
            try {
                res = member_service.update_pwd(vo);
            } catch (Exception e) {
                
                e.printStackTrace();
            }

            if (res == 1 && !pwd.isEmpty()) {
                map.put("result", true);
                map.put("pwd", true);
            }else{
               
                map.put("error", "비밀번호 초기화 실패");
            }
        } catch (MessagingException e) {
            map.put("error", "메일전송 실패");
            e.printStackTrace();
        }

        
        return map;
    }

    @RequestMapping("change_pwd_m.do")
    public String change_pwd_m(MemberVo vo,RedirectAttributes attr,Model model){

        MemberVo result_vo = member_service.selectOneNaIdEm(vo);

        if (result_vo == null) {
            model.addAttribute("timeout", true);  
            return "redirect:login_main.do";
        }

        String pwd = "";
        int res = 0;

        try {
            pwd = emailService.sendPWD(vo.getMem_email());
            vo.setMem_pwd(pwd);
            try {
                res = member_service.update_pwd(vo);
            } catch (Exception e) {
                
                e.printStackTrace();
            }

            if (res == 1 && !pwd.isEmpty()) {
                attr.addFlashAttribute("change_pwd_result", true);
                attr.addFlashAttribute("change_pwd_pwd", true);
            }else{
               
                attr.addFlashAttribute("change_pwd_error", "비밀번호 초기화 실패");
            }
        } catch (MessagingException e) {
            attr.addFlashAttribute("change_pwd_error", "메일전송 실패");
            e.printStackTrace();
        }

        
        return "redirect:mypage_main.do";
    }

    @RequestMapping("member_modify_m.do")
    public String member_modify_m(MemberVo vo,RedirectAttributes attr,Model model){

        MemberVo result_vo = member_service.selectOneNaIdEm(vo);

        if (result_vo == null) {
            model.addAttribute("timeout", true);  
            return "redirect:login_main.do";
        }

        int res = 0;

        try {
            res = member_service.update_general_m(vo);
        
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (res==1) {
            attr.addFlashAttribute("mem_update_g",true);
        }else{
            attr.addFlashAttribute("mem_update_g",false);
        }

        
        return "redirect:mypage_main.do";
    }

    
    
}
