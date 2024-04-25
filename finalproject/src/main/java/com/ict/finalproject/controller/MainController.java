package com.ict.finalproject.controller;

import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ict.finalproject.dao.CampMapper;
import com.ict.finalproject.dao.PreferMapper;
import com.ict.finalproject.dao.ReviewMapper;
import com.ict.finalproject.vo.CampVo;
import com.ict.finalproject.vo.MemberVo;
import com.ict.finalproject.vo.PreferVo;
import com.ict.finalproject.vo.ReviewVo;

import jakarta.servlet.http.HttpSession;



@Controller
public class MainController {

    @Autowired
    HttpSession session;
    
    @Autowired
    ReviewMapper review_dao;

    @Autowired
	PreferMapper prefer_dao;

    @Autowired 
    CampMapper camp_dao;


    @RequestMapping("main.do")
    public String main(){

        return "main/main";
    }

    @RequestMapping("header.do")
    public String header(){

        return "main/main_header";
    }

    @RequestMapping("container1.do")
    public String conteiner1(Model model){

        Random random = new Random();

        MemberVo user = (MemberVo) session.getAttribute("user");
       
        List<CampVo> camp_list1 = null;
        List<CampVo> camp_list2 = null;

        int n1 = 0;
        int n2 = 0;

        if(user != null){

            List<PreferVo> prefer_list = prefer_dao.selectListMemIdx(user.getMem_idx());

            if(prefer_list.size() == 0){
                camp_list1 = camp_dao.selectList();
                camp_list2 = camp_dao.selectList();


            }else{

                n1 = random.nextInt(prefer_list.size());
                n2 = random.nextInt(prefer_list.size());

                if(prefer_list.size() == 3){

                    camp_list1 = camp_dao.selectByLocal(prefer_list.get(n1).getPre_si(), prefer_list.get(n1).getPre_gun());
                    camp_list2 = camp_dao.selectByLocal(prefer_list.get(n2).getPre_si(), prefer_list.get(n2).getPre_gun());
                    
                }else if(prefer_list.size() == 2){

                    camp_list1 = camp_dao.selectByLocal(prefer_list.get(0).getPre_si(), prefer_list.get(0).getPre_gun());
                    camp_list2 = camp_dao.selectByLocal(prefer_list.get(1).getPre_si(), prefer_list.get(1).getPre_gun());

                }else if(prefer_list.size() == 1){

                    camp_list1 = camp_dao.selectByLocal(prefer_list.get(0).getPre_si(), prefer_list.get(0).getPre_gun());

                    if(camp_list1.size() <= 1){
                        camp_list2 = camp_dao.selectList();
                    }else{
                        camp_list2 = camp_dao.selectByLocal(prefer_list.get(0).getPre_si(), prefer_list.get(0).getPre_gun());
                    }
                
                }
            }

        }else{
                    
            camp_list1 = camp_dao.selectList();
            camp_list2 = camp_dao.selectList();

        }

        int m1 = random.nextInt(camp_list1.size());
        int m2 = random.nextInt(camp_list2.size());

        CampVo camp_vo1 = camp_list1.get(m1);
        CampVo camp_vo2 = camp_list2.get(m2);

        model.addAttribute("camp_vo1", camp_vo1);
        model.addAttribute("camp_vo2", camp_vo2);


        return "main/main_container1";
    }

    @RequestMapping("container2.do")
    public String conteiner2( ReviewVo vo, Model model){
        
        List<ReviewVo> list = review_dao.selectList();
        model.addAttribute("review_list", list);

   

        return "main/main_container2";
    }

}
