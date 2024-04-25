package com.ict.finalproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class StoryController {

    @RequestMapping("story_main.do")
    public String story_main(){

        return "story/story_main";
    }

    @RequestMapping("story_header.do")
    public String story_header(){

        return "story/story_header";
    }

    @RequestMapping("story_container.do")
    public String story_container(){

        return "story/story_container";
    }
}
