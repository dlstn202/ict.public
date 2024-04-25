package com.ict.finalproject.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ict.finalproject.constant.PagingConstant;
import com.ict.finalproject.service.EmailService;
import com.ict.finalproject.service.QnaAnswerService;
import com.ict.finalproject.util.Paging;
import com.ict.finalproject.vo.AnswerVo;
import com.ict.finalproject.vo.MemberVo;
import com.ict.finalproject.vo.QnaVo;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("answer/")
public class AnswerController {

    @Autowired
    QnaAnswerService qna_dao;

    @Autowired
	HttpSession session;

    @Autowired
    EmailService emailService;

    @RequestMapping("mypage_list.do")
    public String mypage_container_manager_qna(Model model, String search, String search_text, Integer page, Boolean bReult) {

        MemberVo user = (MemberVo) session.getAttribute("user");

        if (user == null) {
            model.addAttribute("timeout", true);
            return "redirect:../login_main.do";
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
        model.addAttribute("bReult", bReult);

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

        return "answer/answer_mypage";
    }

    @RequestMapping("mypage_list_json.do")
    @ResponseBody
    public List<QnaVo> mypage_container_manager_qna_json(Model model, String search, String search_text, Integer page) {

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

        return qna_list;
    }

    @RequestMapping("insert.do")
    public String answer_insert(RedirectAttributes attr, AnswerVo answer_vo, 
                                String search, String search_text,Integer page,
                                QnaVo qna_vo,String qna_email,Model model){
        
        MemberVo user = (MemberVo) session.getAttribute("user");

        if (user == null) {
            model.addAttribute("timeout", true);
            return "redirect:../login_main.do";
        }

        answer_vo.setMem_idx(user.getMem_idx());
        answer_vo.setMem_name(user.getMem_name());
 
        attr.addAttribute("search", search);
        attr.addAttribute("search_text", search_text);
        attr.addAttribute("page", page);

        //System.out.println(answer_vo.getAns_content());
        int res = 0;
       
        try {
            res = qna_dao.insertAnswer(answer_vo);
        } catch (Exception e) {
            e.printStackTrace();
        }

        String mail = "dlstn202@naver.com";
        //String mail = qna_vo.getQna_email();

        try {
            emailService.sendInsertAnswer(mail, qna_vo);
        } catch (MessagingException e) {

            e.printStackTrace();
        }
        

        boolean bReult = res==1;
        attr.addAttribute("bReult",bReult);


        return "redirect:mypage_list.do";
    }

    @RequestMapping("modify.do")
    public String answer_modify(RedirectAttributes attr, AnswerVo answer_vo,
                                String search, String search_text,Integer page, 
                                QnaVo qna_vo,String qna_email,Model model){
        
        MemberVo user = (MemberVo) session.getAttribute("user");

        if (user == null) {
            model.addAttribute("timeout", true);
            return "redirect:../login_main.do";
        }

        answer_vo.setMem_idx(user.getMem_idx());
        answer_vo.setMem_name(user.getMem_name());

        attr.addAttribute("search", search);
        attr.addAttribute("search_text", search_text);
        attr.addAttribute("page", page);

        
        
        int res = qna_dao.updateAnswer(answer_vo);

        boolean bReult = res==1;

        attr.addAttribute("bReult",bReult);

        String mail = qna_vo.getQna_email();

        try {
            emailService.sendModifyAnswer(mail, qna_vo);
        } catch (MessagingException e) {
            e.printStackTrace();
        }


        return "redirect:mypage_list.do";
    }

}
