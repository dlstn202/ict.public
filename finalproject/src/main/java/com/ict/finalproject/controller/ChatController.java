package com.ict.finalproject.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ict.finalproject.util.ChatBot;


@Controller
public class ChatController {

    @RequestMapping("chat_start.do") 
    @ResponseBody
    public Map<String, String> chat_start() throws IOException{

        // 스레드 생성(시작)
        JSONObject json = ChatBot.start_gpt();
        String thread_id = json.getString("id");

        Map<String, String> map = new HashMap<String, String>();
        map.put("thread_id", thread_id);

        return map;

    }

    @RequestMapping("chat_send.do") 
    @ResponseBody
    public Map<String, String> chat_send(String content, Model model, String thread_id) throws IOException, InterruptedException{


        // 메세지 생성
        JSONObject json1 = ChatBot.post_gpt(content, thread_id);

        // 실행
        JSONObject json2 = ChatBot.run_gpt(thread_id);

        // 요청 지연시키기(4000 X)
        Thread.sleep(6000);

        // 리스트 get
        JSONObject json3 = ChatBot.get_gpt(thread_id);
        //System.out.println("json3:"+json3);

        Map<String, String> map = new HashMap<String, String>();

        if(json3!=null){
            JSONArray data = json3.getJSONArray("data");
            JSONArray content1 = data.getJSONObject(0).getJSONArray("content");
            JSONObject text = content1.getJSONObject(0).getJSONObject("text");

            // 답변
            String message = text.getString("value");
            // System.out.println("message :" + message);
            map.put("message", message);
        }else{
            map.put("message", "죄송합니다. 오류가 발생했습니다.");
        }
        // 파싱
    
        return map;

    }


    @RequestMapping("chat_finish.do") 
    @ResponseBody
    public Map<String, String> chat_finish(String thread_id) throws IOException{

        // 스레드 삭제(종료)
        JSONObject json = ChatBot.end_gpt(thread_id);
        Boolean deleted = json.getBoolean("deleted");

        Map<String, String> map = new HashMap<String, String>();
        map.put("deleted", String.valueOf(deleted));

        return map;
   
    }


}

