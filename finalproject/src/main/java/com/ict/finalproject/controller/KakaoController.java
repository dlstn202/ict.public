package com.ict.finalproject.controller;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ict.finalproject.dao.MemberMapper;
import com.ict.finalproject.service.MemberService;
import com.ict.finalproject.util.KakaoLogin;
import com.ict.finalproject.vo.MemberVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class KakaoController {

	@Autowired
	HttpServletRequest request;

	@Autowired
	MemberMapper member_dao;

	@Autowired
	MemberService mem_ser_dao;

	@Autowired
	HttpSession session;

	@RequestMapping("kakao_url.do")
	public String kakao_url() {
		String client_id ="";
		String redirect_uri ="https://camprover.store/kakao_login.do";
		return String.format("redirect:https://kauth.kakao.com/oauth/authorize?client_id=%s&redirect_uri=%s&response_type=code", client_id,redirect_uri);
	}

	@RequestMapping(value = "kakao_login.do", method = RequestMethod.GET)
	public String kakaoLogin(@RequestParam(value = "code", required = false) String code, RedirectAttributes attr)
			throws Throwable {
		// 카카오 토큰 받기
		JSONObject json = KakaoLogin.kakao_get_token(code);
		String access_token = json.optString("access_token");

		if (!access_token.isEmpty()) {
			// 카카오 사용자 정보 요청
			JSONObject json_info = KakaoLogin.kakao_get_info(access_token);
			String kakaoId = json_info.optString("id"); // 카카오 ID

			if (kakaoId != null) {
				String mem_kakao = String.valueOf(json_info.getLong("id"));
				MemberVo vo = member_dao.selectOneKakaoId(mem_kakao);
				if (vo == null) { // 신규 회원인 경우
					String mem_grade = "general";

					// 회원가입 페이지로 리다이렉션하면서 필요한 정보를 전달
					attr.addFlashAttribute("mem_kakao", mem_kakao);
					attr.addAttribute("mem_grade", mem_grade);

					return "redirect:join_agree.do"; // 회원가입 동의 페이지 또는 직접 회원가입 처리 페이지
				} else { // 이미 가입된 회원인 경우
					// 로그인 처리
					session.setAttribute("user", vo);
					return "redirect:main.do"; // 메인 페이지로 리다이렉션
				}
			} else {
				// 사용자 정보 요청 실패 처리
				return "redirect:login_main.do";
			}
		} else {
			// 액세스 토큰 요청 실패 처리
			return "redirect:login_main.do";
		}
	}

	@RequestMapping(value = "kakao_sns.do", method = RequestMethod.GET)
	public String kakao_sns(@RequestParam(value = "code", required = false) String code, RedirectAttributes attr,Model model)
			throws Throwable {
		// 카카오 토큰 받기
		JSONObject json = KakaoLogin.kakao_get_token_sns(code);
		String access_token = json.optString("access_token");
		Map<String,Object> sns_map = new HashMap<String,Object>();
		int res = 0;

		if (!access_token.isEmpty()) {
			// 카카오 사용자 정보 요청
			JSONObject json_info = KakaoLogin.kakao_get_info(access_token);
			String kakaoId = json_info.optString("id"); // 카카오 ID

			if (kakaoId != null) {
				String mem_kakao = String.valueOf(json_info.getLong("id"));
				MemberVo user = (MemberVo)session.getAttribute("user");
				if (user == null) {
					model.addAttribute("timeout", true);
					return "redirect:login_main.do";
				}
				sns_map.put("mem_idx", user.getMem_idx());
				sns_map.put("kakao", mem_kakao);
				res = mem_ser_dao.insert_sns(sns_map);
				if (res==1) {
					MemberVo u = member_dao.selectOneGeneralId(user.getMem_id());
                    session.setAttribute("user", u);
					attr.addFlashAttribute("kakao_insert",true);
				}

			} 
		} else {
			// 액세스 토큰 요청 실패 처리
			attr.addFlashAttribute("kakao_insert_error",true);
		}

		return "redirect:mypage_main.do";
	}//end


}