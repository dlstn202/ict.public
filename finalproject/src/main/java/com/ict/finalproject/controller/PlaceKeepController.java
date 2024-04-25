package com.ict.finalproject.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ict.finalproject.dao.PlaceKeepMapper;
import com.ict.finalproject.vo.MemberVo;
import com.ict.finalproject.vo.PlaceKeepVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class PlaceKeepController {

    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpServletResponse response;

    @Autowired
    HttpSession session;

    @Autowired
    PlaceKeepMapper place_keep_dao;


    @RequestMapping(value="place_keep_check.do" , produces="application/json; charset=utf-8;")
	@ResponseBody
	public Map<String, Object> place_keep_check(int contentId) {

		MemberVo user = (MemberVo) session.getAttribute("user");
		
		int mem_idx = user.getMem_idx();
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("mem_idx", mem_idx);
		map.put("contentId", contentId);

		PlaceKeepVo vo = place_keep_dao.selectOneCheck(map);
		
		boolean bResult = (vo!=null);
		
		map.put("result", bResult);	//	{ "result" : true }
		
		return map;
	}//end 

    	
	@RequestMapping(value="place_keep_delete.do", produces="application/json; charset=utf-8;")
	@ResponseBody
	public Map<String, Object> place_keep_delete(int contentId) {

		MemberVo user = (MemberVo) session.getAttribute("user");
		
		int mem_idx = user.getMem_idx();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mem_idx", mem_idx);
		map.put("contentId", contentId);
		
		int res = place_keep_dao.delete(map);
		
		boolean bResult = (res>=1);
		
		map.put("result", bResult);	//	{ "result" : true }
		
		return map;
	}//end 
	
	@RequestMapping(value="place_keep_insert.do", produces="application/json; charset=utf-8;")
	@ResponseBody
	public Map<String, Object> place_keep_insert(PlaceKeepVo vo) {
		
		MemberVo user = (MemberVo) session.getAttribute("user");
		
		int mem_idx 		= user.getMem_idx();
        vo.setMem_idx(mem_idx);
		
		int res = place_keep_dao.insert(vo);
		
		boolean bResult = (res==1);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", bResult);	//	{ "result" : true }
		
		return map;
	}//end 

    @RequestMapping("mypage_container_general_keep_list.do")
    public String mypage_container_general_keep_list(Model model){
        
        MemberVo user = (MemberVo) session.getAttribute("user");
        int mem_idx = user.getMem_idx();
        List<PlaceKeepVo> keep_list = place_keep_dao.selectList(mem_idx);
		model.addAttribute("keep_list", keep_list);

        return "mypage/mypage_container_general_keep_list";
    }

}
