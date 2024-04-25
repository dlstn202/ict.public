package com.ict.finalproject.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.json.JSONObject;

public class KakaoLogin {

    static String CLIENT_ID     = "";
    static String CALL_BACK_URL = "https://camprover.store/kakao_login.do";

    public static JSONObject kakao_get_token(String code) throws IOException{

        String postData = String.format("code=%s&client_id=%s&redirect_uri=%s&grant_type=authorization_code",
                                    URLEncoder.encode(code, "UTF-8"), 
                                    URLEncoder.encode(CLIENT_ID, "UTF-8"), 
                                    URLEncoder.encode(CALL_BACK_URL, "UTF-8"));

        URL url = new URL("https://kauth.kakao.com/oauth/token");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
        conn.setDoOutput(true); // 요청 본문에 데이터를 쓰기 위해 필요합니다.

        // 요청 본문에 데이터를 씁니다.
        try(OutputStream os = conn.getOutputStream()) {
            byte[] postDataBytes = postData.getBytes("UTF-8");
            os.write(postDataBytes, 0, postDataBytes.length);
        }

        // 응답을 읽습니다.
        StringBuilder response = new StringBuilder();
        try(BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"))) {
            String line;
            while ((line = br.readLine()) != null) {
                response.append(line);
            }
        }

        // 응답 문자열을 JSON 객체로 변환합니다.
        JSONObject json = new JSONObject(response.toString());
        return json;


    }
    public static JSONObject kakao_get_token_sns(String code) throws IOException{

        String postData = String.format("code=%s&client_id=%s&redirect_uri=%s&grant_type=authorization_code",
                                    URLEncoder.encode(code, "UTF-8"), 
                                    URLEncoder.encode(CLIENT_ID, "UTF-8"), 
                                    URLEncoder.encode("https://camprover.store/kakao_sns.do", "UTF-8"));

        URL url = new URL("https://kauth.kakao.com/oauth/token");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
        conn.setDoOutput(true); // 요청 본문에 데이터를 쓰기 위해 필요합니다.

        // 요청 본문에 데이터를 씁니다.
        try(OutputStream os = conn.getOutputStream()) {
            byte[] postDataBytes = postData.getBytes("UTF-8");
            os.write(postDataBytes, 0, postDataBytes.length);
        }

        // 응답을 읽습니다.
        StringBuilder response = new StringBuilder();
        try(BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"))) {
            String line;
            while ((line = br.readLine()) != null) {
                response.append(line);
            }
        }

        // 응답 문자열을 JSON 객체로 변환합니다.
        JSONObject json = new JSONObject(response.toString());
        return json;


    }
    public static JSONObject kakao_get_info(String accessToken) throws IOException {
        URL url = new URL("https://kapi.kakao.com/v2/user/me");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", "Bearer " + accessToken); // 액세스 토큰을 헤더에 포함
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
        
        // 추가
        int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

        // 응답을 읽습니다.
        StringBuilder response = new StringBuilder();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"))) {
            String line;
            String result="";
            while ((line = br.readLine()) != null) {
                response.append(line);
            }
            System.out.println("response body : " + result);
			System.out.println("result type" + result.getClass().getName());
        }
    
        // 응답 문자열을 JSON 객체로 변환합니다.
        JSONObject json = new JSONObject(response.toString());
        return json;
    }

    
}
