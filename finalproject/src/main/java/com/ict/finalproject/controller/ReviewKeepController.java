package com.ict.finalproject.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ict.finalproject.dao.ReviewKeepMapper;
import com.ict.finalproject.service.ReviewService;
import com.ict.finalproject.vo.MemberVo;
import com.ict.finalproject.vo.ReviewKeepVo;
import com.ict.finalproject.vo.ReviewVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class ReviewKeepController {

    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpServletResponse response;

    @Autowired
    HttpSession session;

    @Autowired
    ReviewKeepMapper review_keep_dao;

	@Autowired
	ReviewService review_dao;


    @RequestMapping(value="review_keep_check.do" , produces="application/json; charset=utf-8;")
	@ResponseBody
	public Map<String, Object> review_keep_check(int contentId) {

		MemberVo user = (MemberVo) session.getAttribute("user");
		
		int mem_idx = user.getMem_idx();
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("mem_idx", mem_idx);
		map.put("contentId", contentId);

		ReviewKeepVo vo = review_keep_dao.selectOneCheck(map);
		
		boolean bResult = (vo!=null);
		
		map.put("result", bResult);	//	{ "result" : true }
		
		return map;
	}//end 

    	
	@RequestMapping(value="review_keep_delete.do", produces="application/json; charset=utf-8;")
	@ResponseBody
	public Map<String, Object> review_keep_delete(ReviewKeepVo vo) {
		
		MemberVo user = (MemberVo) session.getAttribute("user");
		Map<String, Object> map = new HashMap<String, Object>();
        if (user == null) {
            
            map.put("user",true);
            return map;
            
        }

		ReviewVo rev_vo = review_dao.selectOne(vo.getRev_idx());

		int hea_num = rev_vo.getHea_num()-1;

		rev_vo.setHea_num(hea_num);
		
		int res = 0;

		try {
			res = review_dao.deleteReKeep(vo,rev_vo);
		} catch (Exception e) {
			map.put("error", e.getMessage());
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


		boolean bResult = (res==1);
		

		map.put("result", bResult);	//	{ "result" : true }
		map.put("hea_num", hea_num);	//	{ "result" : true }

		
		return map;
	}//end 
	
	@RequestMapping(value="review_keep_insert.do", produces="application/json; charset=utf-8;")
	@ResponseBody
	public Map<String, Object> review_keep_insert(ReviewKeepVo vo) {
		
		MemberVo user = (MemberVo) session.getAttribute("user");
		Map<String, Object> map = new HashMap<String, Object>();
        if (user == null) {
            
            map.put("user",true);
            return map;
            
        }

		ReviewVo rev_vo = review_dao.selectOne(vo.getRev_idx());

		int hea_num = rev_vo.getHea_num()+1;

		rev_vo.setHea_num(hea_num);
		
		int res = 0;

		try {
			res = review_dao.insertReKeep(vo,rev_vo);
		} catch (Exception e) {
			map.put("error", e.getMessage());
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


		boolean bResult = (res==1);
		

		map.put("result", bResult);	//	{ "result" : true }
		map.put("hea_num", hea_num);	//	{ "result" : true }

		
		return map;
	}//end 

	




}
