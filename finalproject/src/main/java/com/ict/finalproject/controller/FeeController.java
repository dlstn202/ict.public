package com.ict.finalproject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ict.finalproject.dao.FeeMapper;
import com.ict.finalproject.service.MemberService;
import com.ict.finalproject.service.RoomService;
import com.ict.finalproject.vo.FeeVo;
import com.ict.finalproject.vo.MemberVo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("fee/")
public class FeeController {

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

    @Autowired
    HttpServletRequest request;

    @RequestMapping("list.do")
    public String list(int room_idx, Model model){

        if (request.getParameter("room_idx") != null) {
            room_idx = Integer.parseInt(request.getParameter("room_idx") );
        }

        if (request.getParameter("room_idx") == null) {
            model.addAttribute("room_result", true);
        }

        // System.out.println("idx"+room_idx);

        MemberVo user = (MemberVo) session.getAttribute("user");

        if (user == null) {
           
            model.addAttribute("timeout", true);
            
            return "redirect:../login_main.do";

        }

        List<FeeVo> list = fee_dao.selectList(room_idx);

        if (list != null) {
            model.addAttribute("fee_list", list);
        }

        if (list.size() == 4) {
            model.addAttribute("fee_full", true);
        }
        
        model.addAttribute("room_idx", room_idx);

        return "fee/fee_list";
        // return "redirect:../main.do";
    }

    @RequestMapping("insert_form.do")
    public String insert_form(int room_idx, Model model){
        MemberVo user = (MemberVo) session.getAttribute("user");

        if (user == null) {
           
            model.addAttribute("timeout", true);
            
            return "redirect:../login_main.do";

        }

        model.addAttribute("room_idx", room_idx);

        return "fee/fee_insert_form";
    }

    @RequestMapping("insert.do")
    public String insert(FeeVo vo, Model model,RedirectAttributes attr){

        MemberVo user = (MemberVo) session.getAttribute("user");

        if (user == null) {
           
            model.addAttribute("timeout", true);
            
            return "redirect:../login_main.do";

        }
        vo.setMem_idx(user.getMem_idx());

        List<FeeVo> origin = fee_dao.selectListVo(vo);

        if (origin.size() > 0) {

            attr.addFlashAttribute("fee_no",true);

            return "redirect:list.do?room_idx="+vo.getRoom_idx();
        }


        int res = fee_dao.insert(vo);

        return "redirect:list.do?room_idx="+vo.getRoom_idx();
    }

    @RequestMapping("modify_form.do")
    public String modify_form(Model model,int fee_idx){

        FeeVo vo = fee_dao.selectOneIdx(fee_idx);

        model.addAttribute("vo", vo);
        model.addAttribute("fee_weekend_yn", vo.getFee_weekend_yn());
        model.addAttribute("fee_peak_yn", vo.getFee_peak_yn());


        return "fee/fee_modify_form";
    }

    @RequestMapping("modify.do")
    public String modify(Model model,FeeVo vo,RedirectAttributes attr){

        List<FeeVo> origin = fee_dao.selectListVo(vo);

        if (origin.size() > 1) {

            attr.addFlashAttribute("modify_no",true);

            return "redirect:list.do?room_idx="+vo.getRoom_idx();
        }

        int res = fee_dao.update(vo);

        if (res != 1) {
            attr.addFlashAttribute("fee_udpate",false);
        }else{
            attr.addFlashAttribute("fee_udpate",true);
        }


        return "redirect:list.do?room_idx="+vo.getRoom_idx();
    }
    @RequestMapping("delete.do")
    public String delete(Model model,int fee_idx, int room_idx,RedirectAttributes attr){

        int res = fee_dao.delete(fee_idx);

        if (res != 1) {
            attr.addFlashAttribute("fee_del",false);
        }else{
            attr.addFlashAttribute("fee_del",true);
        }


        return "redirect:list.do?room_idx="+room_idx;
    }
    
}
