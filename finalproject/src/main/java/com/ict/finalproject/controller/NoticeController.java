package com.ict.finalproject.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ict.finalproject.constant.PagingConstant;
import com.ict.finalproject.service.NoticeService;
import com.ict.finalproject.util.Paging;
import com.ict.finalproject.vo.MemberVo;
import com.ict.finalproject.vo.NoticeFileVo;
import com.ict.finalproject.vo.NoticeVo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
public class NoticeController {

    @Autowired
    NoticeService notice_dao;

    @Autowired
	ServletContext application; //절대경로 구하기용
	
	@Autowired
	HttpSession session;

    @Autowired
    HttpServletRequest request;

    @RequestMapping("notice_main.do")
    public String main(){

        return "notice/notice_main";
    }

    @RequestMapping("notice_header.do")
    public String header(){

        return "notice/notice_header";
    }

    @RequestMapping("notice_container.do")
    public String container(Model model, String search_text, Integer page){

        int nowPage = 1;
        
        if (page != null) {
            nowPage = page;
        }

    
		// start / end 계산
		int start = (nowPage - 1) * PagingConstant.notice_menu.BLOCK_LIST + 1;
		int end = start + PagingConstant.notice_menu.BLOCK_LIST - 1;

		// 검색조건에 대한 정보 맵으로 포장
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);

		if (search_text!=null) {// 제목+내용
			map.put("subject", search_text);
			map.put("content", search_text);
		}


        List<NoticeVo> notice_list = notice_dao.selectListMapDelNo(map);

        model.addAttribute("notice_list", notice_list);

        // Page Menu생성
		int rowTotal = notice_dao.selectRowTotalDelNo(map);

		String pageMenu = Paging.getAjaxPaging(nowPage, // 현재페이지
				rowTotal, // 전체게시물수
				PagingConstant.notice_menu.BLOCK_LIST, // 한화면에 보여질 게시물수
				PagingConstant.notice_menu.BLOCK_PAGE);  // 한화면에 보여질 페이지수


        model.addAttribute("pageMenu", pageMenu);

        // 마지막페이지 빈칸 추가
		int binPage = PagingConstant.notice_menu.BLOCK_LIST - rowTotal%PagingConstant.notice_menu.BLOCK_LIST; 
		int rastPage = rowTotal/PagingConstant.notice_menu.BLOCK_LIST; 
		if(binPage!=0)rastPage++;
		
		model.addAttribute("rastPage", rastPage);
		model.addAttribute("binPage", binPage);
		model.addAttribute("page", page);
        model.addAttribute("rowTotal", rowTotal);
        model.addAttribute("search_text", search_text);

        return "notice/notice_container";
    }

    @RequestMapping("notice_show_one.do")
    public String notice_show_one(Model model, int not_idx,String search_text, Integer page) {

        NoticeVo notice_vo = notice_dao.selectOne(not_idx);

        model.addAttribute("notice_vo", notice_vo);
        model.addAttribute("search_text", search_text);
        model.addAttribute("page", page);


        return "notice/notice_show_one";
    }
    

    @RequestMapping("notice_myapge_list.do")
    public String notice_myapge_list(Model model, String search, String search_text, Integer page) {

        int nowPage = 1;


        if (page != null) {
            nowPage = page;
        }

		if (search == null || search.isEmpty())
			search = "all"; // 서치종류가 비어있거나 값이 없으면 all로 검색할랭

		// start / end 계산
		int start = (nowPage - 1) * PagingConstant.notice_mypage.BLOCK_LIST + 1;
		int end = start + PagingConstant.notice_mypage.BLOCK_LIST - 1;

        // System.out.println("start : "+start);
        // System.out.println("end : "+end);


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


        List<NoticeVo> notice_list = notice_dao.selectListMap(map);

        model.addAttribute("notice_list", notice_list);

        // Page Menu생성
		int rowTotal = notice_dao.selectRowTotal(map);

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
		


        return "notice/notice_myapge_list";
    }

    @RequestMapping("notice_insert_form.do")
    public String notice_insert_form(String search, String search_text, Integer page, Model model){

        model.addAttribute("search", search);
        model.addAttribute("search_text", search_text);
        model.addAttribute("page", page);

        return "notice/notice_mypage_insert_form";
    }

    @RequestMapping("notice_insert.do")
    public String notice_insert(NoticeVo notice_vo,@RequestParam("not_file") List<MultipartFile> file_list,Model model) throws IllegalStateException, IOException {
        
        MemberVo user = (MemberVo) session.getAttribute("user");
        if (user == null) {
            
            model.addAttribute("timeout", true);
            
            return "redirect:login_main.do";

        }

        notice_vo.setMem_idx(user.getMem_idx());
        notice_vo.setMem_name(user.getMem_name());

        List<String> filename_list = new ArrayList<String>();

        String abs_path = application.getRealPath("/notice_file_upload/");
		
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


        // 파일네임 리스트의 첫번째값이 비어있으면 파일이 없는거니까 파일 존재유무는 n
        String not_file_yn = filename_list.isEmpty()?"n":"y";
        notice_vo.setNot_file_yn(not_file_yn);

        int not_idx = notice_dao.not_idx();

        notice_vo.setNot_idx(not_idx);
        
        List<NoticeFileVo> notice_file_list = new ArrayList<NoticeFileVo>();

        for(String file_name: filename_list){
            NoticeFileVo vo = new NoticeFileVo();
            vo.setNot_idx(not_idx);
            vo.setFile_name(file_name);
            notice_file_list.add(vo);

            //System.out.println(vo.getNot_idx());
            //System.out.println(vo.getFile_name());
    
        }
        
        try {

            notice_dao.insert(notice_vo, notice_file_list);
            
        } catch (Exception e) {
            
            System.out.println(e.getMessage());
            model.addAttribute("error", e.getMessage());
            
        }

        return "redirect:notice_myapge_list.do";
    }



    @RequestMapping("notice_mypage_one.do")
    public String notice_mypage_one(int not_idx,String search, String search_text, Integer page, Model model) {

        NoticeVo notice_vo = notice_dao.selectOne(not_idx);

        model.addAttribute("notice_vo", notice_vo);
        model.addAttribute("search", search);
        model.addAttribute("search_text", search_text);
        model.addAttribute("page", page);

        return "notice/notice_mypage_one";
    }

    @RequestMapping("notice_modify_form.do")
    public String notice_modify_form(int not_idx,String search, String search_text, Integer page, Model model) {

        

        NoticeVo notice_vo = notice_dao.selectOne(not_idx);
        

        model.addAttribute("notice_vo", notice_vo);
        model.addAttribute("search", search);
        model.addAttribute("search_text", search_text);
        model.addAttribute("page", page);

        return "notice/notice_mypage_modify_form";
    }

    @RequestMapping("notice_modify.do")
    public String notice_modify(RedirectAttributes attr,NoticeVo notice_vo,@RequestParam("not_file") List<MultipartFile> file_list,@RequestParam(value = "file_idx", defaultValue = "")  int [] file_idx, String search, String search_text, Integer page,Model model) throws IllegalStateException, IOException{

        MemberVo user = (MemberVo) session.getAttribute("user");

        if (user == null) {
           
            model.addAttribute("timeout", true);
            
            return "redirect:login_main.do";

        }
        
        String abs_path = application.getRealPath("/notice_file_upload/");
        
        if(notice_vo.getNot_file_yn().equals("y")){
            List<NoticeFileVo> file_name_list = notice_dao.selectList_not_idx(notice_vo.getNot_idx());
            String filename ="";
            outerLoop:
            for(NoticeFileVo vo : file_name_list){
                for(int idx : file_idx){
                    if (vo.getFile_idx() == idx) {
                        continue outerLoop;
                    }
                }
                filename = vo.getFile_name();
                try {
                    File f = new File(abs_path, filename);
                    f.delete();
                    notice_dao.file_del_idx(vo.getFile_idx());
                } catch (Exception e) {
                    model.addAttribute("error", e.getMessage());
                    return "redirect:mypage_main.do";
                }
            }//end for

            //System.out.println("file_name_list : "+file_name_list.size());
            //System.out.println("file_idx : "+file_idx.length);
            
            if (file_idx.length == 0) {
                //System.out.println("하이");
                notice_vo.setNot_file_yn("n");
            }
            
        }

        notice_vo.setMem_idx(user.getMem_idx());
        notice_vo.setMem_name(user.getMem_name());

        List<String> filename_list = new ArrayList<String>();

		
		for(MultipartFile file: file_list) {

           
            if (!file.isEmpty()) {
                    
                    String filename = file.getOriginalFilename(); //클라이언트가 준 파일네임
                    //스프링은 같은 파일네임이 있으면 덮어버림
                    System.out.println("filename :"+filename);
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

        String not_file_yn = notice_vo.getNot_file_yn();
        // 파일네임 리스트의 첫번째값이 비어있으면 파일이 없는거니까 파일 존재유무는 n
        if (not_file_yn.equals("n") && !filename_list.isEmpty()) {
            not_file_yn = "y";
            notice_vo.setNot_file_yn(not_file_yn);
        }
       
        
        List<NoticeFileVo> notice_file_list = new ArrayList<NoticeFileVo>();

        for(String file_name: filename_list){
            NoticeFileVo vo = new NoticeFileVo();
            vo.setNot_idx(notice_vo.getNot_idx());
            vo.setFile_name(file_name);
            notice_file_list.add(vo);

            //System.out.println(vo.getNot_idx());
            //System.out.println(vo.getFile_name());
    
        }
        
        try {
            
            notice_dao.update(notice_vo, notice_file_list);
            
        } catch (Exception e) {
            
            System.out.println(e.getMessage());
            model.addAttribute("error", e.getMessage());

            
        }
        attr.addAttribute("search", search);
        attr.addAttribute("search_text", search_text);
        attr.addAttribute("page", page);
        attr.addAttribute("not_idx", notice_vo.getNot_idx());

        return "redirect:notice_mypage_one.do";
    }//notice_modify

    
    @RequestMapping("notice_delete.do")
    public String notice_delete(RedirectAttributes attr,int not_idx,String search, String search_text, Integer page, Model model){
        
        MemberVo user = (MemberVo) session.getAttribute("user");

        if (user == null) {
           
            model.addAttribute("timeout", true);
            
            return "redirect:login_main.do";

        }

        try {
            
            notice_dao.delete(not_idx);
            
        } catch (Exception e) {
            
            System.out.println(e.getMessage());
            model.addAttribute("error", e.getMessage());
            
        }

        attr.addAttribute("search", search);
        attr.addAttribute("search_text", search_text);
        attr.addAttribute("page", page);

        //String url = String.format("redirect:notice_myapge_list.do?search=%s&search_text=%s&page=%d", search,search_text,page);

        return "redirect:notice_myapge_list.do";
    }


}
