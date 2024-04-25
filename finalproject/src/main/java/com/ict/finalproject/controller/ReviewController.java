package com.ict.finalproject.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ict.finalproject.dao.ReviewKeepMapper;
import com.ict.finalproject.service.ReviewService;
import com.ict.finalproject.vo.MemberVo;
import com.ict.finalproject.vo.PhotoVo;
import com.ict.finalproject.vo.ReviewVo;
import com.vane.badwordfiltering.BadWordFiltering;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
@RequestMapping("review/")
public class ReviewController {

   @Autowired 
   ReviewService review_dao;

   @Autowired
   ReviewKeepMapper review_keep_dao;

   @Autowired
   HttpServletRequest request;

   @Autowired
   ServletContext application;
   
   @Autowired
   HttpSession session;

      
      @RequestMapping("list.do")
      public String selectList(Model model, int contentId) {

        MemberVo user = (MemberVo)session.getAttribute("user");
    
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("contentId", contentId);
        if (user != null) {
            map.put("mem_idx", user.getMem_idx());
        }

      List<ReviewVo> list = review_dao.selectListMap(map);

      model.addAttribute("review_list", list);

      double reviewCount = review_dao.selectReviewCount(contentId);
   
      Double sum = review_dao.selectReviewSum(contentId);
      double reviewSum = (sum != null) ? sum : 0.0;

      double reviewAverage = reviewCount > 0 ? reviewSum / reviewCount : 0;

      model.addAttribute("reviewAverage", reviewAverage);

      return "detail/detail_container_review";

      }


      @RequestMapping("insert_form.do")
      public String insert_form() {

         return "review_insert_form";

      }

      @RequestMapping("insert.do")
      @ResponseBody
      public Map<String, Object> review_insert(ReviewVo review_vo, @RequestParam("photo") List<MultipartFile> photo_list,Model model) throws IllegalStateException, IOException {

         Map<String, Object> map = new HashMap<String, Object>();

         MemberVo user = (MemberVo) session.getAttribute("user");
         if (user == null) {
             
             map.put("result", "time_out");

             return map;
 
         }
         //댓글필터링
         String content = review_vo.getRev_content();
         BadWordFiltering badWordFiltering = new BadWordFiltering();
         boolean test = badWordFiltering.blankCheck(content);

         if (test) {
            map.put("review_no", true);
            return map;
         }


         review_vo.setMem_idx(user.getMem_idx());
         review_vo.setMem_id(user.getMem_id());
         
         List<String> filenameList = new ArrayList<String>();

         String abs_path = application.getRealPath("/review_file_upload/");
         // System.out.println(photo_list.size());
         for(MultipartFile file: photo_list) {

            if (!file.isEmpty()) {
                    
                    String filename = file.getOriginalFilename(); //클라이언트가 준 파일네임
                    //스프링은 같은 파일네임이 있으면 덮어버림
                    
                    //화일정보관리객체(File)
                    File f = new File(abs_path, filename);
                    
                    //동일화일 존재유무 체크
                    //exists = 존재하다
                    //만에하나  System.currentTimeMillis() 불안하면 while문 돌리면 됨
                    if (f.exists()) {
                        long tm = System.currentTimeMillis(); //현재 시간을 millisecond단위로 구한다
                        
                        //시간_filename형식으로 이름 변경
                        //filename = "1709863996231_a.jpg"
                        filename = String.format("%d_%s", tm,filename);
                        f = new File(abs_path, filename);
                        
                    }
                    
                    // 임시정화일 ->내가저장된 위치 + 화일명으로 복사
                    file.transferTo(f);
                    
                    filenameList.add(filename);
                    
                }
         
      }//end for

        
        // 파일네임 리스트의 첫번째값이 비어있으면 파일이 없는거니까 파일 존재유무는 n
        String photo_yn = filenameList.isEmpty()?"n":"y";
        review_vo.setPhoto_yn(photo_yn);

        int rev_idx = review_dao.rev_idx();

        review_vo.setMem_idx((Integer) review_vo.getMem_idx());

        review_vo.setRev_idx(rev_idx);

     
        
        List<PhotoVo> rev_photo_list = new ArrayList<PhotoVo>();

        for(String file_name: filenameList){
            PhotoVo vo = new PhotoVo();
            vo.setRev_idx(rev_idx);
            // vo.setMem_idx(mem_idx);
            vo.setPho_name(file_name);
            rev_photo_list.add(vo);
    
        }
        
        int res = 0;
        try {
           res=review_dao.review_insert(review_vo, rev_photo_list);
        }catch(Exception e){

        }
        
        boolean bResult = res==1?true:false;
        
        map.put("result", bResult);
        
        return map;
       
    }

      @RequestMapping("rev_photo_one.do")
      @ResponseBody
      public ReviewVo rev_photo_one(int rev_idx) {
          
          ReviewVo vo = review_dao.selectOne(rev_idx);
          
          return (vo);
      }
      
      @RequestMapping("delete.do")
      @ResponseBody
      public String delete(int rev_idx) throws Exception {
   
         int res = review_dao.review_delete(rev_idx);
   
         boolean bResult = false;
         bResult = res != 0;
         /* return "redirect:list.do?contentId=" + contentId; */
         JSONObject json = new JSONObject();
         json.put("result", bResult);// {"result":true}
   
         return json.toString();
      }// end:delete


     @RequestMapping("modify_form.do")
      public String modify_form(int rev_idx, Model model) {

      ReviewVo vo = review_dao.selectOne(rev_idx);

      String rev_content = vo.getRev_content().replaceAll("<br>", "\n");
      vo.setRev_content(rev_content);

      model.addAttribute("vo", vo);

      return "review_modify_form";

   }// end:modify_form

   @RequestMapping("modify.do")
   @ResponseBody
  //  public Map<String, Object> review_update(ReviewVo review_vo, @RequestParam("photo") List<MultipartFile> photo_list,Model model,int[] pho_idx) throws IllegalStateException, IOException {
   public Map<String, Object> review_update(ReviewVo review_vo, @RequestParam("photo") List<MultipartFile> photo_list,Model model, @RequestParam(value = "photo_idx", defaultValue = "") int [] photo_idx) throws IllegalStateException, IOException {
      
      //System.out.println("modify start "+review_vo.getRev_idx());
      Map<String, Object> map = new HashMap<String, Object>();

      MemberVo user = (MemberVo) session.getAttribute("user");
      if (user == null) {
          
          map.put("result", "time_out");

          return map;

      }

      //댓글필터링
      String content = review_vo.getRev_content();
         BadWordFiltering badWordFiltering = new BadWordFiltering();
         boolean test = badWordFiltering.blankCheck(content);

         if (test) {
            map.put("review_no", true);
            return map;
         }


      if(review_vo.getPhoto_yn().equals("y")){
         List<PhotoVo> filenamelist = review_dao.selectList_pho_idx(review_vo.getRev_idx());
                  
         
         if (photo_idx.length == 0) {
             System.out.println("photo_idx.length : "+photo_idx.length);
             review_vo.setPhoto_yn("n");
         }

         outerLoop:
         for(PhotoVo vo : filenamelist){
             for(int idx : photo_idx){
                 if (vo.getPho_idx() == idx) {
                     
                     continue outerLoop;
                 }
             }
             try {

                 review_dao.photo_delete(vo.getPho_idx());
             } catch (Exception e) {
              System.out.println(e);
                 model.addAttribute("error", e.getMessage());
                 return map;
             }
         }//end for

         
      }

      review_vo.setMem_idx(user.getMem_idx());
      review_vo.setMem_id(user.getMem_id());
      
     //  review_vo.setContentId((Integer) review_vo.getContentId());
      
      List<String> filenameList = new ArrayList<String>();

      String abs_path = application.getRealPath("/review_file_upload/");
      // System.out.println(photo_list.size());
      for(MultipartFile file: photo_list) {

         if (!file.isEmpty()) {
                 
                 String filename = file.getOriginalFilename(); //클라이언트가 준 파일네임
                 //스프링은 같은 파일네임이 있으면 덮어버림
                 
                 //화일정보관리객체(File)
                 File f = new File(abs_path, filename);
                 
                 //동일화일 존재유무 체크
                 //exists = 존재하다
                 //만에하나  System.currentTimeMillis() 불안하면 while문 돌리면 됨
                 if (f.exists()) {
                     long tm = System.currentTimeMillis(); //현재 시간을 millisecond단위로 구한다
                     
                     //시간_filename형식으로 이름 변경
                     //filename = "1709863996231_a.jpg"
                     filename = String.format("%d_%s", tm,filename);
                     f = new File(abs_path, filename);
                     
                 }
                 
                 // 임시정화일 ->내가저장된 위치 + 화일명으로 복사
                 file.transferTo(f);
                 
                 filenameList.add(filename);
                 
             }
      
   }//end for

     
   String not_file_yn = review_vo.getPhoto_yn();
   // 파일네임 리스트의 첫번째값이 비어있으면 파일이 없는거니까 파일 존재유무는 n
   if (photo_list.size() !=0 && !filenameList.isEmpty()) {
       not_file_yn = "y";
       review_vo.setPhoto_yn(not_file_yn);
   }

     int rev_idx = review_vo.getRev_idx();

     review_vo.setMem_idx((Integer) review_vo.getMem_idx());


     
     List<PhotoVo> rev_photo_list = new ArrayList<PhotoVo>();

     for(String file_name: filenameList){
         PhotoVo vo = new PhotoVo();
         vo.setRev_idx(rev_idx);
         // vo.setMem_idx(mem_idx);
         vo.setPho_name(file_name);
         rev_photo_list.add(vo);

 
     }


     int res = 0;
     try {
        //  System.err.println(filenameList.toString());
        res=review_dao.review_update(review_vo, rev_photo_list);
     }catch(Exception e){
             System.out.println(e.getMessage());

     }

     
     boolean bResult = res==1?true:false;
     
     map.put("result", bResult);
     
     

     return map;

    
 }


}