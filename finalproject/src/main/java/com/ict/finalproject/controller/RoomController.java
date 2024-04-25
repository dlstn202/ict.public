package com.ict.finalproject.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ict.finalproject.dao.FeeMapper;
import com.ict.finalproject.service.MemberService;
import com.ict.finalproject.service.RoomService;
import com.ict.finalproject.vo.CampCeoVo;
import com.ict.finalproject.vo.MemberVo;
import com.ict.finalproject.vo.PhotoVo;
import com.ict.finalproject.vo.RoomVo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("room/")
public class RoomController {

    @Autowired
    MemberService member_dao;

    @Autowired
    RoomService room_dao;

    @Autowired
	HttpSession session;

    @Autowired
	ServletContext application; //절대경로 구하기용

    @Autowired
    FeeMapper fee_dao;

    @RequestMapping("list.do")
    public String list(Model model) {

        MemberVo user = (MemberVo) session.getAttribute("user");

        if (user == null) {
           
            model.addAttribute("timeout", true);
            
            return "redirect:login_main.do";

        }

        List<CampCeoVo> camp_list = member_dao.selectList_idx_room(user.getMem_idx());

        model.addAttribute("camp_list", camp_list);


        return "room/room_list";
    }

    @RequestMapping("insert_form.do")
    public String insert_form(Model model) {

        MemberVo user = (MemberVo) session.getAttribute("user");

        if (user == null) {
           
            model.addAttribute("timeout", true);
            
            return "redirect:login_main.do";

        }

        return "room/room_insert_form";
    }

    @RequestMapping("insert.do")
    public String insert(Model model, RoomVo vo, @RequestParam("photo") List<MultipartFile> file_list) throws IllegalStateException, IOException {

        MemberVo user = (MemberVo) session.getAttribute("user");

        if (user == null) {
           
            model.addAttribute("timeout", true);
            
            return "redirect:login_main.do";

        }

        vo.setMem_idx(user.getMem_idx());

        String abs_path = application.getRealPath("/room_photo_upload/");
        
        List<String> filename_list = new ArrayList<String>();
		
		for(MultipartFile file: file_list) {

            if (!file.isEmpty()) {
                
                String filename = file.getOriginalFilename(); //클라이언트가 준 파일네임
                //스프링은 같은 파일네임이 있으면 덮어버림
                
                //화일정보관리객체(File)
                File f = new File(abs_path, filename);
                
                //동일화일 존재유무 체크
                //exists = 존재하다
                //만에하나  System.currentTimeMillis() 불안하면 while문 돌리면 됨
                if (f.exists()) {
                    long tm = System.currentTimeMillis(); //현재 시간을 millisecond단위로 구한다
                    
                    //시간_filename형식으로 이름 변경
                    //filename = "1709863996231_a.jpg"
                    filename = String.format("%d_%s", tm,filename);
                    f = new File(abs_path, filename);
                    
                }
                
                // 임시정화일 ->내가저장된 위치 + 화일명으로 복사
                file.transferTo(f);
                
                filename_list.add(filename);
            }
			
		}//end for

        int room_idx = room_dao.room_idx();

        vo.setRoom_idx(room_idx);

        List<PhotoVo> Photo_file_list = new ArrayList<PhotoVo>();

        for(String file_name: filename_list){
            PhotoVo photo_vo = new PhotoVo();
            photo_vo.setRoom_idx(room_idx);
            photo_vo.setPho_name(file_name);
            photo_vo.setMem_idx(user.getMem_idx());
            Photo_file_list.add(photo_vo);    
        }
        
        try {

            room_dao.insert(vo, Photo_file_list);
            
        } catch (Exception e) {
            
            System.out.println(e.getMessage());
            model.addAttribute("error", e.getMessage());
            
        }

        return "redirect:../mypage_main.do";
    }

    @RequestMapping("modify_form.do")
    public String modify_form(Model model, int room_idx) {

        MemberVo user = (MemberVo) session.getAttribute("user");

        if (user == null) {
           
            model.addAttribute("timeout", true);
            
            return "redirect:login_main.do";

        }

        RoomVo vo = room_dao.selectOneRoomIdx(room_idx);

        model.addAttribute("vo", vo);

        return "room/room_modify_form";
    }

    @RequestMapping("modify.do")
    public String modify(Model model, RedirectAttributes attr,RoomVo room_vo,@RequestParam("photo") List<MultipartFile> photo_list,@RequestParam(value = "photo_idx", defaultValue = "")  int [] photo_idx) throws IllegalStateException, IOException {

        MemberVo user = (MemberVo) session.getAttribute("user");

        if (user == null) {
           
            model.addAttribute("timeout", true);
            
            return "redirect:login_main.do";

        }
        String abs_path = application.getRealPath("/room_photo_upload/");
        List<PhotoVo> photo_origin_list = room_dao.selectphoto_idx(room_vo.getRoom_idx());
        
        if (photo_origin_list.size() != 0) {
            
            outerLoop:
            for(PhotoVo vo : photo_origin_list){
                for(int idx : photo_idx){
                    if (vo.getPho_idx() == idx) {
                        continue outerLoop;
                    }
                }

                try {
                    File f = new File(abs_path, vo.getPho_name());
                    f.delete();
                    room_dao.pho_del_idx(vo.getPho_idx());
                } catch (Exception e) {
                    model.addAttribute("error", e.getMessage());
                    return "redirect:../mypage_main.do";
                }
            }
        }

        List<String> filename_list = new ArrayList<String>();
		
		for(MultipartFile file: photo_list) {

            if (!file.isEmpty()) {
                
                String filename = file.getOriginalFilename(); //클라이언트가 준 파일네임
                //스프링은 같은 파일네임이 있으면 덮어버림
                
                //화일정보관리객체(File)
                File f = new File(abs_path, filename);
                
                //동일화일 존재유무 체크
                //exists = 존재하다
                //만에하나  System.currentTimeMillis() 불안하면 while문 돌리면 됨
                if (f.exists()) {
                    long tm = System.currentTimeMillis(); //현재 시간을 millisecond단위로 구한다
                    
                    //시간_filename형식으로 이름 변경
                    //filename = "1709863996231_a.jpg"
                    filename = String.format("%d_%s", tm,filename);
                    f = new File(abs_path, filename);
                    
                }
                
                // 임시정화일 ->내가저장된 위치 + 화일명으로 복사
                file.transferTo(f);
                
                filename_list.add(filename);
            }
			
		}//사진등록 완료


        List<PhotoVo> photo_file_list = new ArrayList<PhotoVo>();

        for(String file_name: filename_list){
            PhotoVo vo = new PhotoVo();
            vo.setRoom_idx(room_vo.getRoom_idx());
            vo.setPho_name(file_name);
            photo_file_list.add(vo);    
        }
        
        try {
            
            room_dao.update(room_vo, photo_file_list);
            
        } catch (Exception e) {
            
            System.out.println(e.getMessage());
            model.addAttribute("error", e.getMessage());

            
        }

        

        return "redirect:../mypage_main.do";
    }

    @RequestMapping("delete.do")
    public String delete(int room_idx, Model model){

        try {
            int res = room_dao.delete(room_idx);
        } catch (Exception e) {

            System.out.println(e.getMessage());
            model.addAttribute("error", e.getMessage());
        }


        return "redirect:../mypage_main.do";
    }

    





}
