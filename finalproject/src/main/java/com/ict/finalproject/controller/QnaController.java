package com.ict.finalproject.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ict.finalproject.constant.PagingConstant;
import com.ict.finalproject.service.QnaAnswerService;
import com.ict.finalproject.util.Paging;
import com.ict.finalproject.vo.MemberVo;
import com.ict.finalproject.vo.QnaVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
public class QnaController {

    @Autowired
	HttpSession session;

    @Autowired
    QnaAnswerService qna_dao;

    @Autowired
    HttpServletRequest request;


    
    @RequestMapping("qna_main.do")
    public String qna_main(Model model){

        MemberVo user = (MemberVo) session.getAttribute("user");

        if (user == null) {
           
            model.addAttribute("timeout", true);
            
            return "redirect:login_main.do";

        }

        return "qna/qna_main";
    }


    @RequestMapping("qna_header.do")
    public String qna_header(){

        return "qna/qna_header";
    }

    @RequestMapping("qna_container.do")
    public String qna_container(Model model,@RequestParam(value = "mypage", required = false, defaultValue = "") String mypage){

        model.addAttribute("mypage", mypage);

        return "qna/qna_container";
    }

    @RequestMapping("qna_insert.do")
    public String qna_insert(Model model, QnaVo vo, RedirectAttributes attr,@RequestParam(value = "mypage", required = false, defaultValue = "") String mypage){

        MemberVo user = (MemberVo) session.getAttribute("user");


        if (user == null) {
           
            model.addAttribute("timeout", true);
            
            return "redirect:login_main.do";

        }

        String email = String.format("%s@%s", vo.getQna_email_first(), vo.getQna_email_domain());
        vo.setQna_email(email);

       int res = qna_dao.insertQna(vo);

       Boolean bResult = res==1;
        
       attr.addFlashAttribute("qna_result",bResult);

        if (mypage != null && !mypage.isEmpty()) {
            return "redirect:mypage_main.do";
        }else{
            return "redirect:qna_main.do";
        }

    }

    @RequestMapping("qna_mypage_list_general_ceo.do")
    public String qna_mypage_list_general_ceo(Model model, String search, String search_text, Integer page) {

        MemberVo user = (MemberVo) session.getAttribute("user");

        if (user == null) {
            model.addAttribute("timeout", true);
            return "redirect:login_main.do";
        }

        int nowPage = 1;


        if (page != null) {
            nowPage = page;
        }

		if (search == null || search.isEmpty())
			search = "all"; // 서치종류가 비어있거나 값이 없으면 all로 검색할랭

		// start / end 계산
		int start = (nowPage - 1) * PagingConstant.qna_mypage.BLOCK_LIST + 1;
		int end = start + PagingConstant.qna_mypage.BLOCK_LIST - 1;

        // 검색조건에 대한 정보 맵으로 포장
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
        map.put("mem_idx", user.getMem_idx());

		if (search.equals("subject_content")) {// 제목+내용
			map.put("subject", search_text);
			map.put("content", search_text);
		} else if (search.equals("name")) {// 이름
			map.put("name", search_text);
		} else if (search.equals("subject")) {// 제목
			map.put("subject", search_text);
		} else if (search.equals("content")) {// 내용
			map.put("content", search_text);
		}


        List<QnaVo> qna_list = qna_dao.selectListMap(map);

        model.addAttribute("qna_list", qna_list);

        // Page Menu생성
		int rowTotal = qna_dao.selectRowTotal(map);

		String pageMenu = Paging.getAjaxPaging(nowPage, // 현재페이지
				rowTotal, // 전체게시물수
				PagingConstant.notice_mypage.BLOCK_LIST, // 한화면에 보여질 게시물수
				PagingConstant.notice_mypage.BLOCK_PAGE);  // 한화면에 보여질 페이지수


        model.addAttribute("pageMenu", pageMenu);

        // 마지막페이지 빈칸 추가
		int binPage = PagingConstant.notice_mypage.BLOCK_LIST - rowTotal%PagingConstant.notice_mypage.BLOCK_LIST; 
		int rastPage = rowTotal/PagingConstant.notice_mypage.BLOCK_LIST; 
		if(binPage!=0)rastPage++;
		
		model.addAttribute("rastPage", rastPage);
		model.addAttribute("binPage", binPage);
		model.addAttribute("page", page);
        model.addAttribute("search", search);
        model.addAttribute("search_text", search_text);
		

        


        return "qna/qna_mypage_list_general_ceo";
    }
    





}
