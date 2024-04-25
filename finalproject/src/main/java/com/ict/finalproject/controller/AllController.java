package com.ict.finalproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AllController {

    @RequestMapping("nav.do")
    public String nav(){

        return "all/all_nav";
    }

    
    @RequestMapping("footer.do")
    public String footer(){

        return "all/all_footer";
    }
}
