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

import com.ict.finalproject.dao.CampCeoMapper;
import com.ict.finalproject.dao.CampMapper;
import com.ict.finalproject.dao.MemberCeoMapper;
import com.ict.finalproject.dao.MemberManagerMapper;
import com.ict.finalproject.dao.PhotoMapper;
import com.ict.finalproject.dao.PreferMapper;
import com.ict.finalproject.dao.ReservationMapper;
import com.ict.finalproject.service.CampService;
import com.ict.finalproject.service.MemberService;
import com.ict.finalproject.service.NoticeService;
import com.ict.finalproject.service.ReviewService;
import com.ict.finalproject.vo.CampCeoVo;
import com.ict.finalproject.vo.CampVo;
import com.ict.finalproject.vo.MemberVo;
import com.ict.finalproject.vo.PhotoVo;
import com.ict.finalproject.vo.ReservationVo;
import com.ict.finalproject.vo.ReviewVo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;


@Controller
public class MypageController {

    
    @Autowired
    NoticeService notice_dao;

    @Autowired
    CampMapper camp_dao;

    @Autowired
    CampService campservice_dao;

    @Autowired
    PhotoMapper photo_dao;

    @Autowired 
    ReviewService review_dao;

    @Autowired
    CampCeoMapper camp_ceo_dao;

    @Autowired
    PreferMapper prefer_dao;
    
    @Autowired
    MemberCeoMapper member_ceo_dao;

    @Autowired
    MemberService member_dao;

    @Autowired
    MemberManagerMapper member_manager_dao;

    @Autowired
	HttpSession session;

    @Autowired
    ServletContext application;

    @Autowired
    ReservationMapper res_dao;
    

    @RequestMapping("mypage_header.do")
    public String mypage_header(){

        return "mypage/mypage_header";
    }

    @RequestMapping("mypage_main.do")
    public String main_general(){

        res_dao.updateCheckout();

        return "mypage/mypage_main";
    }

    @RequestMapping("mypage_container_list.do")
    public String mypage_container_list(){

        return "mypage/mypage_container_list";
    }

    @RequestMapping("mypage_container_info.do")
    public String mypage_container_info(Model model){

        List<CampVo> listdo = camp_dao.selectListDo();
        model.addAttribute("listdo", listdo);
        
        return "mypage/mypage_container_info";
    }

    // @RequestMapping("mypage_container_general_keep_list.do")
    // public String mypage_container_general_keep_list(){

    //     return "mypage/mypage_container_general_keep_list";
    // }

    @RequestMapping("mypage_container_general_reserve.do")
    public String mypage_container_general_reserv() {
        return "mypage/mypage_container_general_reserve";
    }

    @RequestMapping("mypage_container_inquiry.do")
    public String mypage_container_inquiry() {
        return "mypage/mypage_container_inquiry";
    }
    @RequestMapping("mypage_container_inquiry_insertform.do")
    public String mypage_container_inquiry_insertform() {   

        

        return "mypage/mypage_container_inquiry_insertform";
    }
            



    @RequestMapping("mypage_container_general_review.do")
    public String mypage_container_general_review(ReviewVo vo, Model model) {

        MemberVo user = (MemberVo) session.getAttribute("user");
        if (user == null) {
            model.addAttribute("timeout", true);  
            return "redirect:login_main.do";
        }
        
            List<ReviewVo> review_list = review_dao.selectListMember(user.getMem_idx());
            model.addAttribute("review_list", review_list);


        return "mypage/mypage_container_general_review";

        
    }

        @RequestMapping("mypage_container_general_review_modify.do")
        @ResponseBody
        public Map<String, Object> review_update(ReviewVo review_vo, @RequestParam("photo") List<MultipartFile> photo_list,Model model, @RequestParam(value = "pho_name", defaultValue = "") String [] pho_name) throws IllegalStateException, IOException {
           
           Map<String, Object> map = new HashMap<String, Object>();
     
           MemberVo user = (MemberVo) session.getAttribute("user");
           if (user == null) {
               
               map.put("result", "time_out");
     
               return map;
     
           }
     
           if(review_vo.getPhoto_yn().equals("y")){
              List<PhotoVo> filenamelist = review_dao.selectList_pho_idx(review_vo.getRev_idx());


              if (pho_name.length == 0) {
                  System.out.println("photo_idx.length : "+pho_name.length);
                  review_vo.setPhoto_yn("n");
              }
     
              outerLoop:
              for(PhotoVo vo : filenamelist){
                  for(String name : pho_name){
                      if (vo.getPho_name().equals(name)) {
                          
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




    //리뷰 삭제
    @RequestMapping("mypage_container_general_review_delete.do")
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
        








    
    @RequestMapping("mypage_container_ceo_business.do")
       
        public String mypage_container_ceo_business(Model model ) {


        MemberVo user =(MemberVo) session.getAttribute("user");
        int mem_idx = user.getMem_idx();
        // 세션에서 mem_idx를 정상적으로 가져올 수 없는 경우, 로그인 페이지나 오류 페이지로 리다이렉트 할 수 있습니다.
        
        // mem_idx를 사용하여 사업자번호 리스트를 조회합니다.
        List<CampCeoVo> campCeoList = member_ceo_dao.selectCampCeosByMemberIdx(mem_idx);
       
        // 조회한 사업자번호 리스트를 모델에 추가합니다.     
        model.addAttribute("campCeoList", campCeoList);
        List<CampVo> campList = camp_dao.selectList();
        boolean isBizrnoMatched = false;

        for (CampCeoVo campceoVo : campCeoList) {
            // 각 사업자 번호에 해당하는 사진 리스트를 조회합니다.
            List<PhotoVo> camp_photo_list = member_ceo_dao.selectPhotosByBizrno(campceoVo.getBizrno());
    
            for (CampVo campVo : campList) {
                if (campceoVo.getBizrno() != null && campceoVo.getBizrno().equals(campVo.getBizrno())) {
                    isBizrnoMatched = true;
                    // 사진 리스트를 campVo 객체에 설정합니다.
                    campVo.setPhoto_list(camp_photo_list);
                    // System.out.println(campVo.getBizrno());
                    // System.out.println(campVo.getPhoto_list());
                    return "mypage/mypage_container_ceo_business";
                }
            }
    
            if (!isBizrnoMatched) {
                session.setAttribute("selectedBizrno", campceoVo.getBizrno());
                return "mypage/mypage_container_ceo_business_form";
            }
    
            isBizrnoMatched = false; // 다음 CampCeoVo 객체를 위해 isBizrnoMatched를 초기화
        }

        // for(CampCeoVo vo:campCeoList){
        //      System.out.println(vo.getBizrno());
        // }
        return "mypage/mypage_container_ceo_business";
    }
    //사장 자신의 캠핑장정보 수정
    @RequestMapping("mypage_container_ceo_business_modify.do")
    public String mypage_container_ceo_business_modify(CampVo camp_vo,
                                                       @RequestParam("photo") List<MultipartFile> photo_list,
                                                       @RequestParam(value = "photo_idx", defaultValue = "") int [] photo_idx,
                                                       Model model) throws IllegalStateException, IOException {
    MemberVo user =(MemberVo) session.getAttribute("user");
    
    if (photo_idx != null && photo_idx.length > 0) {
        for (int idx : photo_idx) {

            System.out.println("사진번호"+idx);
        }
    }    
    String abs_path = application.getRealPath("/camp_photo_upload/");
    List<PhotoVo> photo_origin_list = member_ceo_dao.selectPhotosByBizrno(camp_vo.getBizrno());
    
    if (photo_origin_list.size() != 0) {
            
        outerLoop:
        for(PhotoVo vo : photo_origin_list){
            for(int idx : photo_idx){
                if (vo.getPho_idx() == idx) {
                    continue outerLoop;
                }
            }

            try {
                File f = new File(abs_path, vo.getPho_name());
                f.delete();
                campservice_dao.photo_delete(vo.getPho_idx());
            } catch (Exception e) {
                model.addAttribute("error", e.getMessage());
                return "redirect:../mypage_main.do";
            }
        }
    }

     // int res = camp_dao.camp_insert(vo);
     List<String> filenameList = new ArrayList<String>();

    
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
     }//사진등록완료
     
     List<PhotoVo> photo_file_list = new ArrayList<PhotoVo>();

     for(String file_name: filenameList){
         PhotoVo vo = new PhotoVo();
        vo.setMem_idx(user.getMem_idx());
        vo.setBizrno(camp_vo.getBizrno());
        vo.setPho_name(file_name);
        photo_file_list.add(vo);    
     }
     
     try {
         
        campservice_dao.update( photo_file_list);
         
     } catch (Exception e) {
         
         System.out.println(e.getMessage());
         model.addAttribute("error", e.getMessage());

         
     }
  
    int res = camp_dao.camp_update(camp_vo);

        return "mypage/mypage_container_ceo_business";
    }

    @RequestMapping("business_insert_form.do")
    public String business_insert_form(){

        return "mypage/mypage_container_ceo_business_insert_form";
    }
    
    @RequestMapping("ceo_business_insert.do")
    public String ceo_business_insert(CampVo camp_vo, @RequestParam("photo") List<MultipartFile> photo_list) throws IllegalStateException, IOException {
    
    MemberVo user = (MemberVo)session.getAttribute("user");
    
    String b_no = camp_vo.getBizrno();
    String bizrno = String.format("%s-%s-%s", b_no.substring(0,3), b_no.substring(3,5), b_no.substring(5,10));  
    camp_vo.setBizrno(bizrno);
    camp_vo.setMem_idx(user.getMem_idx());

    // int res = camp_dao.camp_insert(vo);
    List<String> filenameList = new ArrayList<String>();

    String abs_path = application.getRealPath("/camp_photo_upload/");
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
    }


    
    List<PhotoVo> camp_photo_list = new ArrayList<PhotoVo>();

    for(String file_name: filenameList){
        PhotoVo vo = new PhotoVo();
        vo.setBizrno(camp_vo.getBizrno());
        vo.setPho_name(file_name);
        camp_photo_list.add(vo);

      
         System.out.println(vo.getPho_name());

    }
    
    int res = 0;
    try {
        // System.err.println(filenameList.toString());
       res=campservice_dao.camp_insert_one(camp_vo, camp_photo_list);
    }catch(Exception e){
            System.out.println("땡"+e.getMessage());
            System.out.println(e.getMessage());

    }

    
        return "mypage/mypage_container_ceo_business";
    }


    @RequestMapping("mypage_container_ceo_business_insert.do")
    public String mypage_container_ceo_business_insert(CampVo camp_vo, @RequestParam("photo") List<MultipartFile> photo_list) throws IllegalStateException, IOException {

    
    System.out.println("캠핑장명:"+ camp_vo.getFacltNm());
    System.out.println("사업자번호:"+ camp_vo.getBizrno());
    System.out.println("화로대:"+ camp_vo.getBrazierCl());
    System.out.println("잔디:"+ camp_vo.getSiteBottomCl1());

    // int res = camp_dao.camp_insert(vo);
    List<String> filenameList = new ArrayList<String>();

    String abs_path = application.getRealPath("/camp_photo_upload/");
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
    }


    
    List<PhotoVo> camp_photo_list = new ArrayList<PhotoVo>();

    for(String file_name: filenameList){
        PhotoVo vo = new PhotoVo();
        vo.setBizrno(camp_vo.getBizrno());
        vo.setPho_name(file_name);
        camp_photo_list.add(vo);

      
         System.out.println(vo.getPho_name());

    }
    
    int res = 0;
    try {
        // System.err.println(filenameList.toString());
       res=campservice_dao.camp_insert(camp_vo, camp_photo_list);
    }catch(Exception e){
            System.out.println("땡"+e.getMessage());
            System.out.println(e.getMessage());

    }

    
        return "mypage/mypage_container_ceo_business";
    }
  
    @RequestMapping("mypage_container_ceo_business_room.do")
    public String mypage_container_ceo_business_room() {
        return "mypage/mypage_container_ceo_business_room";
    }

    @RequestMapping("mypage_container_ceo_business_room_roomform.do")
    public String mypage_container_ceo_business_room_roomform() {
        return "mypage/mypage_container_ceo_business_room_roomform";
    }
    @RequestMapping("mypage_container_ceo_business_room_feeform.do")
    public String mypage_container_ceo_business_room_feeform() {
        return "mypage/mypage_container_ceo_business_room_feeform";
    }

    @RequestMapping("mypage_container_ceo_business_room_feelist.do")
    public String mypage_container_ceo_business_room_feelist() {
        return "mypage/mypage_container_ceo_business_room_feelist";
    }

    @RequestMapping("mypage_container_ceo_business_room_roominsert.do")
    public String mypage_container_ceo_business_room_roominsert() {
        return "mypage/mypage_container_ceo_business_room_roominsert";
    }
    @RequestMapping("mypage_container_ceo_business_room_feeinsert.do")
    public String mypage_container_ceo_business_room_feeinsert() {
        return "mypage/mypage_container_ceo_business_room_feeinsert";
    }
        
    @RequestMapping("mypage_container_manager_member.do")
    public String mypage_container_manager_member(Model model) {

        List<MemberVo> general_list = member_dao.selectGL();
        List<MemberVo> ceo_list = member_dao.selectCL();

        model.addAttribute("general_list", general_list);
        model.addAttribute("ceo_list", ceo_list);

        return "mypage/mypage_container_manager_member";
    }
        
    @RequestMapping("mypage_container_manager_qna.do")
    public String mypage_container_manager_qna() {
        return "mypage/mypage_container_manager_qna";
    }
        
    @RequestMapping("mypage_container_manager_faq.do")
    public String mypage_container_manager_faq() {
        return "mypage/mypage_container_manager_faq";
    }
        
    @RequestMapping("mypage_container_manager_req_content.do")
    public String mypage_container_manager_req_content() {
        return "mypage/mypage_container_manager_req_content";
    }

    @RequestMapping("mypage_container_manager_req_one.do")
    public String mypage_container_manager_req_one() {
        return "mypage/mypage_container_manager_req_one";
    }
        
    @RequestMapping("mypage_container_manager_report.do")
    public String mypage_container_manager_report() {
        return "mypage/mypage_container_manager_report";
    }

    @RequestMapping("mypage_container_manager_report_one.do")
    public String mypage_container_manager_report_one() {
        return "mypage/mypage_container_manager_report_one";
    }

    @RequestMapping("mypage_container_manager_report_send.do")
    public String mypage_container_manager_report_send() {
        return "redirect:mypage_container_manager_report.do";
    }

    //[S] authorize 권한/계정
    @RequestMapping("mypage_container_manager_authorize.do")
    public String mypage_container_manager_authorize(Model model) {

        List<MemberVo> admin_list = member_manager_dao.selectListManager();
        model.addAttribute("admin_list", admin_list);

        return "mypage/mypage_container_manager_authorize";
    }
    
    @RequestMapping("mypage_container_manager_modify_camp.do")
    public String mypage_container_manager_modify_camp() {
        return "mypage/mypage_container_manager_modify_camp";
    }


    @RequestMapping("sns.do")
    @ResponseBody
    public Map<String,Object> sns(String sns){

        Map<String,Object> map = new HashMap<String,Object>();
        Map<String,Object> sns_map = new HashMap<String,Object>();
        MemberVo user = (MemberVo) session.getAttribute("user");
        if (user == null) {
            map.put("result", "time_out");
            return map;
        }

        sns_map.put("mem_idx", user.getMem_idx());
        Boolean bResult = false;
        int res = 0;
        
        // 넘어온 sns 가 naver일때
        if (sns.equals("naver")) {
            //기존에 등록되어있는지 확인 있다면 삭제
            if (user.getMem_naver() != null) {
                sns_map.put("naver", "naver");
                try {
                    res = member_dao.delete_sns(sns_map);
                    bResult = res==1;
                    if (bResult) {
                        MemberVo u = member_dao.selectOneGeneralId(user.getMem_id());
                        session.setAttribute("user", u);
                        map.put("sns_del", bResult);
                    }
                } catch (Exception e) {
                    map.put("sns_del", bResult);
                    map.put("error", e.getMessage());
                    e.printStackTrace();
                }
            }else{
                //없다면 연결 url 반환
                String client_id ="";
		        String redirect_uri ="https://camprover.store/naver_sns.do";
                String url = String.format("https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=%s&redirect_uri=%s&response_type=code", client_id,redirect_uri);
                map.put("url", url);
            }
        }
        
        if (sns.equals("kakao")) {
            if (user.getMem_kakao() != null ) {
                sns_map.put("kakao", "kakao");
                try {
                    res = member_dao.delete_sns(sns_map);
                    bResult = res==1;
                    if (bResult) {
                        MemberVo u = member_dao.selectOneGeneralId(user.getMem_id());
                        session.setAttribute("user", u);
                        map.put("sns_del", bResult);
                    }
                } catch (Exception e) {
                    map.put("error", e.getMessage());
                    e.printStackTrace();
                }
            }else{
                String client_id ="";
		        String redirect_uri ="https://camprover.store/kakao_sns.do";
                String url = String.format("https://kauth.kakao.com/oauth/authorize?client_id=%s&redirect_uri=%s&response_type=code", client_id,redirect_uri);
                map.put("url", url);
            }
        }
        
        if (sns.equals("google")) {
            if (user.getMem_google() != null ) {
                sns_map.put("google", "google");
                try {
                    res = member_dao.delete_sns(sns_map);
                    bResult = res==1;
                    if (bResult) {
                        MemberVo u = member_dao.selectOneGeneralId(user.getMem_id());
                        session.setAttribute("user", u);
                        map.put("sns_del", bResult);
                    }
                } catch (Exception e) {
                    map.put("error", e.getMessage());
                    e.printStackTrace();
                }
            }else{
                String client_id ="";
		        String redirect_uri ="https://camprover.store/google_sns.do";
                String url = String.format("https://accounts.google.com/o/oauth2/v2/auth?client_id=%s&redirect_uri=%s&response_type=code&scope=email profile", client_id,redirect_uri);
                map.put("url", url);
            }
        }

       


        return map;
    }


}
