package com.ict.finalproject.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.json.JSONObject;

public class GoogleLogin {

    // static String 
    static String CLIENT_ID     = "";
    static String CLIENT_SECRET = "";
    static String CALL_BACK_URL = "https://camprover.store/google_login.do";
    
    public static JSONObject google_get_token(String code) throws IOException{

        String postData = String.format("code=%s&client_id=%s&client_secret=%s&redirect_uri=%s&grant_type=authorization_code",
                                    URLEncoder.encode(code, "UTF-8"), 
                                    URLEncoder.encode(CLIENT_ID, "UTF-8"), 
                                    URLEncoder.encode(CLIENT_SECRET, "UTF-8"), 
                                    URLEncoder.encode(CALL_BACK_URL, "UTF-8"));

        URL url = new URL("https://oauth2.googleapis.com/token");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
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

    public static JSONObject google_get_token_s(String code) throws IOException{

        String postData = String.format("code=%s&client_id=%s&client_secret=%s&redirect_uri=%s&grant_type=authorization_code",
                                    URLEncoder.encode(code, "UTF-8"), 
                                    URLEncoder.encode(CLIENT_ID, "UTF-8"), 
                                    URLEncoder.encode(CLIENT_SECRET, "UTF-8"), 
                                    URLEncoder.encode("https://camprover.store/google_sns.do", "UTF-8"));

        URL url = new URL("https://oauth2.googleapis.com/token");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
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

    public static JSONObject google_get_info(String access_token) throws IOException{

        String google_url = "https://www.googleapis.com/userinfo/v2/me";
        String Authorization = String.format("Bearer %s", access_token);


    //    System.out.println(access_token);
        
        URL url = new URL(google_url);
        
        HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();
        urlConn.setRequestMethod("GET");
        urlConn.setRequestProperty("Authorization", Authorization);

        urlConn.connect();

        InputStream			is 	= urlConn.getInputStream();
		InputStreamReader	isr = new InputStreamReader(is,"utf-8");
		BufferedReader		br 	= new BufferedReader(isr); //성능향상 읽는속도가 빠름 라인단위로 읽기
		
		StringBuffer		sb	= new StringBuffer();
        while(true) {
			
			String data = br.readLine(); //라인단위로 읽기 라인단위로 읽지만 엔터빼고 읽음(어차피 엔터 노의미)
			if(data==null) break;
			sb.append(data); //라인단위로 읽은 데이터 스트링버퍼 넣기
			
		}
        JSONObject json = new JSONObject(sb.toString());




        return json;
    }

}
