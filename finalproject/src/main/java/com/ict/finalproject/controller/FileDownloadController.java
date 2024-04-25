package com.ict.finalproject.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class FileDownloadController {
	
	@Autowired
	ServletContext application; //절대경로 구하기용
	
	@RequestMapping("/FileDownload.do")
	public void FileDownload(String filename,String dir,HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, IOException {
		
		String abs_path = application.getRealPath(dir);
		String fullpathname = String.format("%s/%s", abs_path,filename);
		File file = new File(fullpathname);
		byte [] b = new byte[1024*1024*100];
		
		String strAgent = request.getHeader("User-Agent");
		String userCharset = request.getCharacterEncoding();
	    if(userCharset==null)userCharset="utf-8";
		
	    
	    String value = "";
	 // IE 일 경우
        //if (strAgent.indexOf("MSIE") > -1) 
        if (strAgent.indexOf("Gecko") > -1) 
        {
            // IE 5.5 일 경우
            if (strAgent.indexOf("MSIE 5.5") > -1) 
            {
                value = "filename=" + filename ;
            }
            // 그밖에
            else if (strAgent.indexOf("MSIE 7.0") > -1) 
            {
                if ( userCharset.equalsIgnoreCase("UTF-8") ) 
                {
                	filename = URLEncoder.encode(filename,userCharset);
                	filename = filename.replaceAll("\\+", " ");
                    value = "attachment; filename=\"" + filename + "\"";

                }    
                else 
                {
                    value = "attachment; filename=" + new String(filename.getBytes(userCharset), "ISO-8859-1");
                   
                }
            }
            else{
            	//IE 8.0이상에서는 2회 호출됨..
            	if ( userCharset.equalsIgnoreCase("UTF-8") ) 
                {
                	filename = URLEncoder.encode(filename,"utf-8");
                	filename = filename.replaceAll("\\+", " ");
                    value = "attachment; filename=\"" + filename + "\"";
            		
                }    
                else 
                {
                    value = "attachment; filename=" + new String(filename.getBytes(userCharset), "ISO-8859-1");
                   
                }
            }
            
            
        }else if(strAgent.indexOf("Firefox") > -1){
        	//Firefox : 공백문자이후은 인식안됨...
        	value = "attachment; filename=" + new String(filename.getBytes(), "ISO-8859-1");
        }
       else {
            // IE 를 제외한 브라우저
            value = "attachment; filename=" + new String(filename.getBytes(), "ISO-8859-1");
        }
        
   
        response.setContentType("Pragma: no-cache"); 

		//전송 데이터가 stream 처리되도록 : 웹상전송 문자셋은 : 8859_1
		response.setContentType("application/octet-stream;charset=8859_1;");
		//모든 화일에 대하고 다운로드 대화상자가 열리게 설정
		//Content-Disposition : attachment
		 response.setHeader("Content-Disposition", value);
		//전송타입은 binary(이진화일)
		response.setHeader("Content-Transfer-Encoding", "binary;");
		if(file.isFile())
		{
			BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
			BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
			int i=0;
			try
			{
				while((i=bis.read(b))!=-1)
				{
					bos.write(b,0,i);
				}
			}catch(Exception e){
				//e.printStackTrace();
			}finally {
				if(bos!=null)bos.close();
				if(bis!=null)bis.close();
				
			}
		}
		
	}

}
