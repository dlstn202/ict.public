package com.ict.finalproject.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;

public class ChatBot {

    static String API_KEY = "";
    static String assistant_id = "";

    public static JSONObject start_gpt() throws IOException{
        
        URL url0 = new URL("https://api.openai.com/v1/threads");
        HttpURLConnection conn = (HttpURLConnection) url0.openConnection();

        // 헤더
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("Authorization", API_KEY);
        conn.setRequestProperty("OpenAI-Beta", "assistants=v1");

        // 응답을 읽습니다.
        StringBuilder response = new StringBuilder();
        try(BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"))) {
            String line;
            while ((line = br.readLine()) != null) {
                response.append(line);
            }
        }
        
        JSONObject json = new JSONObject(response.toString());
        return json;
    
    }


    public static JSONObject post_gpt(String content, String thread_id) throws IOException{

        URL url1 = new URL(String.format("https://api.openai.com/v1/threads/%s/messages", thread_id));
        HttpURLConnection conn1 = (HttpURLConnection) url1.openConnection();

        // 헤더
        conn1.setRequestMethod("POST");
        conn1.setRequestProperty("Content-Type", "application/json");
        conn1.setRequestProperty("Authorization", API_KEY);
        conn1.setRequestProperty("OpenAI-Beta", "assistants=v1");

        // 바디
        JSONObject jsonBody1 = new JSONObject();
        jsonBody1.put("role", "user");
        jsonBody1.put("content", content);

        String requestBody1 = jsonBody1.toString();
        conn1.setDoOutput(true);

        // 요청 본문에 데이터를 씁니다.
        try(OutputStream os = conn1.getOutputStream()) {
            byte[] postDataBytes = requestBody1.getBytes("UTF-8");
            os.write(postDataBytes, 0, postDataBytes.length);
        }

        // 응답을 읽습니다.
        StringBuilder response1 = new StringBuilder();
        try(BufferedReader br = new BufferedReader(new InputStreamReader(conn1.getInputStream(), "UTF-8"))) {
            String line;
            while ((line = br.readLine()) != null) {
                response1.append(line);
            }
        }

        JSONObject json = new JSONObject(response1.toString());
        return json;

    }

    public static JSONObject run_gpt(String thread_id) throws IOException{
        URL url2 = new URL(String.format("https://api.openai.com/v1/threads/%s/runs", thread_id));
        HttpURLConnection conn2 = (HttpURLConnection) url2.openConnection();

        // 헤더
        conn2.setRequestMethod("POST");
        conn2.setRequestProperty("Content-Type", "application/json");
        conn2.setRequestProperty("Authorization", API_KEY);
        conn2.setRequestProperty("OpenAI-Beta", "assistants=v1");

        JSONObject jsonBody2 = new JSONObject();
        jsonBody2.put("assistant_id", assistant_id);

        String requestBody2 = jsonBody2.toString();
        conn2.setDoOutput(true);

        // 요청 본문에 데이터를 씁니다.
        try(OutputStream os = conn2.getOutputStream()) {
            byte[] postDataBytes = requestBody2.getBytes("UTF-8");
            os.write(postDataBytes, 0, postDataBytes.length);
        }

        // 응답을 읽습니다.
        StringBuilder response2 = new StringBuilder();
        try(BufferedReader br = new BufferedReader(new InputStreamReader(conn2.getInputStream(), "UTF-8"))) {
            String line;
            while ((line = br.readLine()) != null) {
                response2.append(line);
            }
        }
        

        JSONObject json = new JSONObject(response2.toString());
        return json;

    }

    public static JSONObject get_gpt(String thread_id) throws IOException{

        URL url3 = new URL(String.format("https://api.openai.com/v1/threads/%s/messages", thread_id));
        HttpURLConnection conn3 = (HttpURLConnection) url3.openConnection();

        // 헤더
        conn3.setRequestMethod("GET");
        conn3.setRequestProperty("Content-Type", "application/json");
        conn3.setRequestProperty("Authorization", API_KEY);
        conn3.setRequestProperty("OpenAI-Beta", "assistants=v1");

        conn3.connect();

        int status = conn3.getResponseCode();
        if (status == HttpURLConnection.HTTP_OK) {
            // 응답이 성공적임, 응답을 읽습니다.
            StringBuilder response = new StringBuilder();
            try(BufferedReader br = new BufferedReader(new InputStreamReader(conn3.getInputStream(), "UTF-8"))) {
                String line;
                while ((line = br.readLine()) != null) {
                    response.append(line);
                }
            }
            JSONObject json = new JSONObject(response.toString());
            return json;

        } else {
            // 오류 처리
            JSONObject json = null;
            return json;
        }
    }


    


    public static JSONObject end_gpt(String thread_id) throws IOException{
        
        // HttpClient client = HttpClient.newHttpClient();
        // HttpRequest request = HttpRequest.newBuilder()
        //         .uri(URI.create("https://api.openai.com/v1/threads/" + thread_id))
        //         .header("Authorization", API_KEY)
        //         .header("OpenAI-Beta", "assistants=v1")
        //         .DELETE() // 명시적으로 DELETE 요청을 설정
        //         .build();

        URL url4 = new URL(String.format("https://api.openai.com/v1/threads/%s",thread_id));
        HttpURLConnection conn = (HttpURLConnection) url4.openConnection();

        // 헤더
        conn.setRequestMethod("DELETE");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("Authorization", API_KEY);
        conn.setRequestProperty("OpenAI-Beta", "assistants=v1");

        conn.setDoOutput(true);

        // 응답을 읽습니다.
        StringBuilder response = new StringBuilder();
        try(BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"))) {
            String line;
            while ((line = br.readLine()) != null) {
                response.append(line);
            }
        }

        JSONObject json = new JSONObject(response.toString());
        return json;
        
    
    }

    
}
