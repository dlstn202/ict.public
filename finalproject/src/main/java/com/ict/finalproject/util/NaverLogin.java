package com.ict.finalproject.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.json.JSONObject;

public class NaverLogin {

    // static String NAVER_URL     = "";
    static String CLIENT_ID     = "";
    static String CLIENT_SECRET = "";
    static String CALL_BACK_URL = "https://camprover.store/naver_login.do";


    //네이버 로그인을 위한 url
    public static String naver_login_url() throws IOException{

        String state = "test";
        
        String str_url = String.format("https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=%s&redirect_uri=%s&state=%s",CLIENT_ID,URLEncoder.encode(CALL_BACK_URL, "UTF-8"),URLEncoder.encode(state, "UTF-8"));

        return str_url;
    }

    /*
        인증 과정에 대한 구분값-grant_type
        1) 발급:'authorization_code'
        2) 갱신:'refresh_token'
        3) 삭제: 'delete' 
    */

    //토큰 받아올 시 code, state은 필수 입력임
    public static JSONObject naver_get_token(String code) throws IOException{

        String state = "test";
        String grant_type = "authorization_code";
        String naever_url = "https://nid.naver.com/oauth2.0/token";

        String str_url = String.format("%s?grant_type=%s&client_id=%s&client_secret=%s&code=%s&state=%s",
                                       naever_url,grant_type,CLIENT_ID,CLIENT_SECRET,code,
                                       URLEncoder.encode(state, "UTF-8"));

        URL url_url = new URL(str_url);
		HttpURLConnection urlConn = (HttpURLConnection) url_url.openConnection();
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

    public static JSONObject naver_get_info(String access_token) throws IOException{

        String naever_url = "https://openapi.naver.com/v1/nid/me";
        String Authorization = String.format("Bearer %s", access_token);

        URL url = new URL(naever_url);
        
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
