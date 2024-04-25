package com.ict.finalproject.controller;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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

import com.ict.finalproject.dao.ReservationMapper;
import com.ict.finalproject.service.CampService;
import com.ict.finalproject.service.EmailService;
import com.ict.finalproject.service.MemberService;
import com.ict.finalproject.service.RoomService;
import com.ict.finalproject.util.Tosspayment;
import com.ict.finalproject.vo.CampCeoVo;
import com.ict.finalproject.vo.CampVo;
import com.ict.finalproject.vo.FeeVo;
import com.ict.finalproject.vo.MemberVo;
import com.ict.finalproject.vo.RoomVo;
import com.ict.finalproject.vo.ReservationVo;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("reservation/")
public class ReservationController {

    @Autowired
	HttpSession session;

    @Autowired
    RoomService room_dao;

    @Autowired
    CampService camp_dao;

    @Autowired
    ReservationMapper res_dao;

    @Autowired
    EmailService emailService;

    @Autowired
    MemberService member_dao;

    @RequestMapping("header.do")
    public String header(){

        return "reservation/reservation_header";
    }

    @RequestMapping("main.do")
    public String main(String bizrno, Model model){

        MemberVo user = (MemberVo) session.getAttribute("user");
        if (user == null) {
            
            model.addAttribute("timeout", true);
            
            return "redirect:../login_main.do";

        }
        
        model.addAttribute("bizrno", bizrno);

        return "reservation/reservation_main";
    }

    // @RequestMapping("reservation_input.do")
    // public String main_input(){

    //     return "reservation/reservation_input";
        
    // }

    @RequestMapping("reservation_finish.do")
    public String reservation_finish(Long res_idx, Model model){
        
        ReservationVo res_vo = res_dao.selectOneIdx(res_idx);

        model.addAttribute("res_vo", res_vo);

        return "reservation/reservation_finish";
    }


    @RequestMapping("select_room.do")
    public String select_room(String bizrno, Model model){

        List<RoomVo> list = room_dao.selectListBizrno(bizrno);

        List<RoomVo> room_list = new ArrayList<RoomVo>();

        for (RoomVo roomVo : list) {
            if (roomVo.getFee_list().size() == 4) {
                room_list.add(roomVo);
            }
        }

        model.addAttribute("list", room_list);
        model.addAttribute("bizrno", bizrno);

        return "reservation/reservation_select_room";
    }

    @RequestMapping("date.do")
    public String container_date(String bizrno, Model model, 
                                 @RequestParam(value = "room_idx", required = false, defaultValue = "0")int  room_idx){
        
        res_dao.deleteNoPayment();

        List<ReservationVo> res_list = res_dao.selectResList(room_idx);
        
        //맨처음엔 room_idx가 안들어오니 사업자번호로 조회해서 첫번째값으로 room_idx설정
        List<RoomVo> list = room_dao.selectListBizrno(bizrno);
        if(room_idx == 0){
            room_idx = list.get(0).getRoom_idx();
        }
        RoomVo room_vo = room_dao.selectOneRoomIdx(room_idx);
        

        model.addAttribute("room_idx", room_idx);
        model.addAttribute("res_list", res_list);
        model.addAttribute("room_vo", room_vo);

        return "reservation/reservation_date";
    }

    @RequestMapping("select_res_list.do")
    @ResponseBody
    public List<ReservationVo> select_res_list(Integer room_idx){
        List<ReservationVo> res_list = res_dao.selectResList(room_idx);
        return res_list;
    }



    @RequestMapping("isert_form.do")
    public String isert_form(ReservationVo res_vo, Model model,
                            @RequestParam(value = "checkDays", required = false, defaultValue = "0") int checkDays, 
                            String[] checkDate) throws ParseException {

        RoomVo room_vo = room_dao.selectOneRoomIdx(res_vo.getRoom_idx());
        List<FeeVo> fee_list = room_vo.getFee_list();
        CampVo camp_vo = camp_dao.selectOneBizrnoVo(room_vo.getBizrno());
        String res_checkindate = res_vo.getRes_checkindate();
        String res_checkoutdate = res_vo.getRes_checkoutdate();
        int res_peopleadult = res_vo.getRes_peopleadult();
        int res_peoplechild = res_vo.getRes_peoplechild();
        int res_peopletoddler = res_vo.getRes_peopletoddler();

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        Date checkindate = format.parse(res_checkindate);
        Date heckoutdate = format.parse(res_checkoutdate);
        Calendar in_calendar = Calendar.getInstance();
        in_calendar.setTime(checkindate);
        Calendar out_calendar = Calendar.getInstance();
        out_calendar.setTime(heckoutdate);
        
        //총계
        int amount = 0;


        for(String date : checkDate){
            SimpleDateFormat date_format = new SimpleDateFormat("yyyy-MM-dd");
            Date date_cal = date_format.parse(date);
            Calendar date_calendar = Calendar.getInstance();
            date_calendar.setTime(date_cal);

            int month = date_calendar.get(Calendar.MONTH) + 1;

            //성수기 여부(7,8월)
            String Peak = (month == 7 || month == 8)?"y":"n";

            // 1 (일요일) ~ 7 (토요일) 주말 확인
            String Weekend = (date_calendar.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY || date_calendar.get(Calendar.DAY_OF_WEEK) == Calendar.FRIDAY)?"y":"n";

            for(FeeVo fee : fee_list){
                if (fee.getFee_peak_yn().equals(Peak) && fee.getFee_weekend_yn().equals(Weekend)) {
                    amount += fee.getFee_adult()*res_peopleadult + fee.getFee_child()*res_peoplechild + fee.getFee_infant()*res_peopletoddler;
                }
            }
        }

        // model.addAttribute("res_idx", res_idx);
        model.addAttribute("checkDays", checkDays);
        model.addAttribute("amount", amount);
        model.addAttribute("room_vo", room_vo);
        model.addAttribute("res_vo", res_vo);
        model.addAttribute("camp_vo", camp_vo);
        

        return "reservation/reservation_isert_form";
    }

    @RequestMapping("tossSuccess.do")
    public String tossSuccess(String paymentType,String orderId, String paymentKey, Integer amount,Model model){

        JSONObject json = Tosspayment.payment(paymentKey, orderId, amount);
        JSONObject receipt = json.getJSONObject("receipt");

        ReservationVo res_vo = res_dao.selectOneIdx(Long.parseLong(orderId));
        res_vo.setPaymentKey(paymentKey);
        res_vo.setRes_payment_type(json.getString("method"));
        res_vo.setRes_supply_price(json.getLong("suppliedAmount"));
        res_vo.setRes_vat(json.getLong("vat"));
        res_vo.setRes_payment(json.getLong("totalAmount"));
        res_vo.setRes_paymentdate(json.getString("approvedAt"));
        res_vo.setReceipt(receipt.getString("url"));
        // String requestedAt = json.getString("requestedAt");
        // String approvedAt = json.getString("approvedAt");

        int res = 0;

        res = res_dao.updateToss(res_vo);

        String receipt_html = Tosspayment.receipt(receipt.getString("url"));

        
        try {
            emailService.sendReceipt(res_vo,receipt_html);
        } catch (MessagingException e) {

            e.printStackTrace();
        }

        if (res==1) {
            
            model.addAttribute("res_vo", res_vo);   
            model.addAttribute("tossSuccess", true);
        }
        CampVo camp_vo = camp_dao.selectOneBizrnoVo(res_vo.getBizrno());
        model.addAttribute("bizrno", camp_vo.getBizrno());

        return "reservation/reservation_main";
    }

    @RequestMapping("insert.do")
    @ResponseBody
    public Map<String, Object> insert(ReservationVo res_vo, Model model){

        MemberVo user = (MemberVo) session.getAttribute("user");
        Map<String, Object> map = new HashMap<String, Object>();
        if (user == null) {
            
            map.put("user",true);
            return map;
            
        }
        res_vo.setMem_idx(user.getMem_idx());

        List<ReservationVo> res_list = res_dao.selectRes(res_vo);

        for(ReservationVo vo:res_list){
            if (vo.getPaymentKey() != null) {

                map.put("reservation",true);
                return map;
            }
        }


        int res = 0;
        // System.err.println("size : "+res_list.size());
        if (res_list.size() == 0) {
            res = res_dao.insert(res_vo);
        }

        if (res_list.size() == 1 && res_list.get(0).getMem_idx() == user.getMem_idx()) {
            res = 1;
        }
        boolean bResult = res==1;
        map.put("orderId", res_vo.getRes_idx());
        map.put("mem_name", res_vo.getMem_name());
        map.put("mem_email", res_vo.getMem_email());
        map.put("mem_tel", res_vo.getMem_tel());
        map.put("result", bResult);       

        return map;
    }

    @RequestMapping("mypage_general.do")
    public String mypage_general( Model model) {

        MemberVo user = (MemberVo) session.getAttribute("user");
        if (user == null) { 
            
            model.addAttribute("timeout", true);
            
            return "redirect:../login_main.do";

        }
        res_dao.deleteNoPayment();

        List<ReservationVo> res_list = res_dao.selectMemIdx(user.getMem_idx());
        

        model.addAttribute("res_list", res_list);

        return "reservation/reservation_mypage_general";
    }

    @RequestMapping("mypage_ceo.do")
    public String mypage_ceo( Model model) {

        MemberVo user = (MemberVo) session.getAttribute("user");
        if (user == null) { 
            
            model.addAttribute("timeout", true);
            
            return "redirect:../login_main.do";

        }
        res_dao.deleteNoPayment();

        List<CampCeoVo> camp_list = member_dao.selectList_Rev(user.getMem_idx());

        model.addAttribute("camp_list", camp_list);
        
        return "reservation/reservation_mypage_ceo";
    }

    @RequestMapping("mypage_ceo_old.do")
    public String mypage_ceo_old( Model model) {

        MemberVo user = (MemberVo) session.getAttribute("user");
        if (user == null) { 
            
            model.addAttribute("timeout", true);
            
            return "redirect:../login_main.do";

        }
        res_dao.deleteNoPayment();

        List<CampCeoVo> camp_list = member_dao.selectList_Rev_old(user.getMem_idx());

        model.addAttribute("camp_list", camp_list);
        
        return "reservation/reservation_mypage_ceo";
    }

    @RequestMapping("cancle.do")
    @ResponseBody
    public Map<String, Object> cancle(Long res_idx,Integer dday){

        Map<String, Object> map = new HashMap<String, Object>();

        ReservationVo vo = res_dao.selectOneIdx(res_idx);

        String paymentKey = vo.getPaymentKey();
        long res_payment = vo.getRes_payment();

        if (dday <=14) {
            res_payment = (long) (res_payment*0.3);
        }

        JSONObject json = Tosspayment.cancle(paymentKey, res_payment);

        int res = 0 ;
        
        if (json.getString("status").equals("CANCELED")) {
            vo.setRes_can_payment(-res_payment);
            vo.setRes_can_supply_price(-(vo.getRes_supply_price()-json.getLong("suppliedAmount")));
            vo.setRes_can_vat(-(vo.getRes_vat()-json.getLong("vat")));
            res =res_dao.cancelUpate(vo);
        }

        try {
            emailService.sendResCancle(vo);
        } catch (MessagingException e) {

            e.printStackTrace();
        }
        
        Boolean bRsult = res==1;

        map.put("result", bRsult);

        return map;
    }



}
