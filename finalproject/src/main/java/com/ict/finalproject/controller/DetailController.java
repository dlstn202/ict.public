package com.ict.finalproject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ict.finalproject.dao.CampMapper;
import com.ict.finalproject.dao.ReviewKeepMapper;
import com.ict.finalproject.service.RoomService;
import com.ict.finalproject.vo.CampVo;
import com.ict.finalproject.vo.RoomVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
public class DetailController {
	@Autowired 
	CampMapper camp_dao;

	@Autowired
	ReviewKeepMapper review_keep_dao;

	@Autowired
	RoomService room_dao;

	@Autowired
    HttpSession session;

	@Autowired
	HttpServletRequest request;
		
		@RequestMapping("detail_main.do")
		public String main(int contentId, Model model) {
			
            model.addAttribute("contentId",contentId);

			
			return "detail/detail_main";
		}

		@RequestMapping("detail_container_info.do")
		public String container_info( Model model){
			
			int contentId = Integer.parseInt(request.getParameter("contentId"));

			CampVo vo = camp_dao.selectOne(contentId);

			String bizrno = vo.getBizrno();

			List<RoomVo> room_list = room_dao.selectListBizrno(bizrno);
			int fee = 0;

			model.addAttribute("vo",vo);
			
			for(RoomVo room :room_list){
				fee += room.getFee_list().size();
			}

			if (fee >= 4) {
				model.addAttribute("Rreservation","true");
			}
			

			return "detail/detail_container_info";
		}

		@RequestMapping("detail_container_notice.do")
		public String container_notice(){
	
			return "detail/detail_container_notice";
		}

		@RequestMapping("detail_container_insert_review.do")
		public String container_insert_review(Model model){
			
			int contentId = Integer.parseInt(request.getParameter("contentId"));

			CampVo camp_vo = camp_dao.selectOne(contentId);

			CampVo vo = camp_dao.selectOne(contentId);

			model.addAttribute("camp_vo",camp_vo);
			model.addAttribute("vo",vo);
			model.addAttribute("contentId",contentId);
	
			return "detail/detail_container_insert_review";
		}

		@RequestMapping("detail_container_review.do")
		public String container_review(Model model){

			int contentId = Integer.parseInt(request.getParameter("contentId"));

			CampVo camp_vo = camp_dao.selectOne(contentId);

			CampVo vo = camp_dao.selectOne(contentId);
			
			model.addAttribute("camp_vo",camp_vo);
			model.addAttribute("vo",vo);
			model.addAttribute("contentId",contentId);

			return "detail/detail_container_review";
		}

			

	
		
	}//end clas



