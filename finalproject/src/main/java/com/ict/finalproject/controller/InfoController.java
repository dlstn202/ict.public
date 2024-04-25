package com.ict.finalproject.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ict.finalproject.dao.CampMapper;
import com.ict.finalproject.vo.CampVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class InfoController {

    @Autowired
    CampMapper camp_dao;

    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    @RequestMapping("info_main.do")
    public String main(Model model, String doNm, String sigunguNm,String[] induty, String[] lctCl,
    String[] SiteCo, String[] sbrsCl) {

        if (request.getParameter("doNm") != null) {
            doNm = request.getParameter("doNm");
            sigunguNm = request.getParameter("sigunguNm");
            
        }
        model.addAttribute("doNm", doNm);
        model.addAttribute("sigunguNm", sigunguNm);

        
        return "info/info_main";
    }

    @RequestMapping("info_nav.do")
    public String info_nav() {

        return "all/all_nav";
    }

    @RequestMapping("info_container1.do")
    public String info_container1(Model model,String[] induty, String[] lctCl,
    String[] SiteCo, String[] sbrsCl) {

        if (request.getParameter("doNm") != null) {
            String doNm = request.getParameter("doNm");
            String sigunguNm = request.getParameter("sigunguNm");

            model.addAttribute("doNm", doNm);
            model.addAttribute("sigunguNm", sigunguNm);

            

        }

        return "info/info_container1";
    }

    @RequestMapping("info_container_list.do")

    public String info_container_list(@RequestParam(value = "doNm", required = false, defaultValue = "") String doNm,
                                     @RequestParam(value = "sigunguNm", required = false, defaultValue = "") String sigunguNm,
                                     String[] induty, String[] lctCl,
                                     String[] SiteCo, String[] sbrsCl,
                                     Model model) {

        Map<String, Object> map = new HashMap<String, Object>();
    
        if (doNm != null && !doNm.isEmpty()) {
            System.out.println(doNm);
            map.put("doNm", doNm);
        }
        System.out.println(sigunguNm);
        if (sigunguNm != null && !sigunguNm.isEmpty())
            map.put("sigunguNm", sigunguNm);
        // induty 업종
        if (induty != null && induty.length > 0)
            map.put("induty", induty);

        // lctCl 입지구분
        if (lctCl != null && lctCl.length > 0)
            map.put("lctCl", lctCl);

        // SiteCo 사이트재질
        if (SiteCo != null && SiteCo.length > 0) {
            for (String g : SiteCo) {
                System.out.println(g);
            }
            map.put("SiteCo", SiteCo);
        }

        // sbrsCl 부대시설
        if (sbrsCl != null && sbrsCl.length > 0)
            map.put("sbrsCl", sbrsCl);

        model.addAttribute("doNm", doNm);
        model.addAttribute("sigunguNm", sigunguNm);
        model.addAttribute("induty", induty);
        model.addAttribute("lctCl", lctCl);
        model.addAttribute("SiteCo", SiteCo);
        model.addAttribute("sbrsCl", sbrsCl);

        List<CampVo> list_filter = camp_dao.selectByFilter(map);

        model.addAttribute("list_filter", list_filter);

        return "info/info_container_list";
    }

    // 테스트
    @RequestMapping("info_container_filter_test.do")
    public String requestMethodName(@RequestParam(value = "doNm", required = false, defaultValue = "") String doNm,
                                    @RequestParam(value = "sigunguNm", required = false, defaultValue = "") String sigunguNm,
                                    String[] induty, String[] lctCl,
                                    String[] SiteCo, String[] sbrsCl,
                                    Model model) {
        
        Map<String, Object> map = new HashMap<String, Object>();
        if (doNm != null && !doNm.isEmpty()) {
            
            map.put("doNm", doNm);
        }
        if (sigunguNm != null && !sigunguNm.isEmpty())
            map.put("sigunguNm", sigunguNm);

        // induty 업종
        if (induty != null && induty.length > 0){
            map.put("induty", induty);
        }

        // lctCl 입지구분
        if (lctCl != null && lctCl.length > 0)
            map.put("lctCl", lctCl);

        // SiteCo 사이트재질
        if (SiteCo != null && SiteCo.length > 0) {
            for (String g : SiteCo) {
                System.out.println(g);
            }
            map.put("SiteCo", SiteCo);
        }

        // sbrsCl 부대시설
        if (sbrsCl != null && sbrsCl.length > 0)
            map.put("sbrsCl", sbrsCl);

        List<CampVo> list_filter = camp_dao.selectByFilter(map);
        model.addAttribute("list_filter", list_filter);

        //System.out.println("갯수 : " + list_filter.size());
        for (CampVo campVo : list_filter) {
            // System.out.println(campVo.getFacltNm());
        }
        model.addAttribute("doNm", doNm);
        model.addAttribute("sigunguNm", sigunguNm);
        model.addAttribute("induty", induty);
        model.addAttribute("lctCl", lctCl);
        model.addAttribute("SiteCo", SiteCo);
        model.addAttribute("sbrsCl", sbrsCl);

        // session.setAttribute("induty", induty);
        // session.setAttribute("lctCl", lctCl);
        // session.setAttribute("SiteCo", SiteCo);
        // session.setAttribute("sbrsCl", URLEncoder.encode(sbrsCl.toString(), "utf-8"));

        // String sdf = sbrsCl.toString();
        

        return "info/info_container_list";
    }

    @RequestMapping("info_container_filter.do")
    public String info_container_filter(String type, Model model,String[] induty, String[] lctCl,
    String[] SiteCo, String[] sbrsCl) {
        if ("local".equals(type)) {

            List<CampVo> listsi = camp_dao.selectListSi();
            List<CampVo> listdo = camp_dao.selectListDo();

            String doNm = request.getParameter("doNm");
            String sigunguNm = request.getParameter("sigunguNm");

            model.addAttribute("listsi", listsi);
            model.addAttribute("listdo", listdo);
            model.addAttribute("doNm", doNm);
            model.addAttribute("sigunguNm", sigunguNm);
            model.addAttribute("induty", induty);
            model.addAttribute("lctCl", lctCl);
            model.addAttribute("SiteCo", SiteCo);
            model.addAttribute("sbrsCl", sbrsCl);

            return "info/info_container_local";
        }

        else if ("filter".equals(type)) {

            return "info/info_container_filter";
        } else {

            return "info/info_container_list";
        }
    }

    @RequestMapping("info_container_place_json.do")
    @ResponseBody
    public List<CampVo> info_container_place_json(String doNm,
            String sigunguNm) {
        List<CampVo> list_local = camp_dao.selectByLocal(doNm, sigunguNm);

        return list_local;
    }

    @RequestMapping("info_container_place.do")
    public String info_container_place(@RequestParam(value = "doNm", required = false, defaultValue = "") String doNm,
            @RequestParam(value = "sigunguNm", required = false, defaultValue = "") String sigunguNm,
            String type, String[] induty, String[] lctCl,
            String[] SiteCo, String[] sbrsCl,
            Model model) {

            if ("camping".equals(type)) {

            List<CampVo> list_local = camp_dao.selectByLocal(doNm, sigunguNm);

            model.addAttribute("list_local", list_local);

            if (request.getParameter("doNm") != null) {
                doNm = request.getParameter("doNm");
                sigunguNm = request.getParameter("sigunguNm");

                model.addAttribute("doNm", doNm);
                model.addAttribute("sigunguNm", sigunguNm);

            }

            return "info/info_camping";
        }

        else if ("HP8".equals(type)) {

            return "info/info_hospital";

        } else if ("PM9".equals(type)) {

            return "info/info_drug";
        }

        else if ("CS2".equals(type)) {

            return "info/info_store";
        }
        // 마트 페이지
        else if ("MT1".equals(type)) {

            return "info/info_mart";
        } else {

            return "info/info_container_list";
        }
    }
}