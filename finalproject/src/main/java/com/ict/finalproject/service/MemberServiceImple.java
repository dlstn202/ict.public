package com.ict.finalproject.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ict.finalproject.dao.CampCeoMapper;
import com.ict.finalproject.dao.CampMapper;
import com.ict.finalproject.dao.MemberCeoMapper;
import com.ict.finalproject.dao.MemberGeneralMapper;
import com.ict.finalproject.dao.MemberManagerMapper;
import com.ict.finalproject.dao.MemberMapper;
import com.ict.finalproject.dao.PreferMapper;
import com.ict.finalproject.vo.CampCeoVo;
import com.ict.finalproject.vo.MemberVo;
import com.ict.finalproject.vo.PreferVo;

@Service
public class MemberServiceImple implements MemberService{
    
    @Autowired
    MemberMapper member_dao;

    @Autowired
    MemberGeneralMapper member_general_dao;

    @Autowired
    MemberCeoMapper member_ceo_dao;

    @Autowired
    MemberManagerMapper member_manager_dao;

    @Autowired
    PreferMapper prefer_dao;

    @Autowired
    CampCeoMapper camp_ceo_dao;

    @Autowired
    CampMapper camp_dao;

    @Override
    public List<MemberVo> selectGL(){

        List<MemberVo> list = member_general_dao.selectList();
        
        return list;
    }

    @Override
    public List<MemberVo> selectCL(){

        List<MemberVo> list = member_ceo_dao.selectList();
        
        return list;
    }


    
    // 사업자번호 조회
    @Override
    public Map<String, String> check_bizrno(String bizrno) throws Exception {

        Map<String, String> map = new HashMap<String, String>();

        map.put("bizrno", bizrno);
        map.put("bizrno1",camp_dao.selectOneBizrno(bizrno));
        map.put("bizrno2",camp_ceo_dao.selectOneBizrno(bizrno));
    
        return map;
    };


    // 일반 등록
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int insert_general(MemberVo member_vo, PreferVo prefer_vo, Map<String, String> pre_map) throws Exception {
        
        int res = 0;

        // 회원 공통 정보 및 일반 정보 삽입
        res = member_dao.insertCommon(member_vo);
        if (res != 1) {
            throw new Exception("insert_common_fail");
        }

        res = member_general_dao.insertGeneral(member_vo);
        if (res != 1) {
            throw new Exception("insert_general_fail");
        }

        // prefer에 mem_idx 넣기
        prefer_vo.setMem_idx(member_vo.getMem_idx());

        // 선호지역 삽입
        // 1
        if (pre_map.containsKey("pre_si1") && pre_map.containsKey("pre_gun1")) {
            res=0;
            prefer_vo.setPre_si(pre_map.get("pre_si1"));
            prefer_vo.setPre_gun(pre_map.get("pre_gun1"));
            res = prefer_dao.insert(prefer_vo);

            if (res != 1){
                throw new Exception("insert_prefer1_fail");
            }
        }
        

        // 2
        if (pre_map.containsKey("pre_si2") && pre_map.containsKey("pre_gun2")) {
            res=0;
            prefer_vo.setPre_si(pre_map.get("pre_si2"));
            prefer_vo.setPre_gun(pre_map.get("pre_gun2"));
            res = prefer_dao.insert(prefer_vo);

            if (res != 1){
                throw new Exception("insert_prefer2_fail");
            }
        }
        

        // 3
        if (pre_map.containsKey("pre_si3") && pre_map.containsKey("pre_gun3")) {
            res=0;
            prefer_vo.setPre_si(pre_map.get("pre_si3"));
            prefer_vo.setPre_gun(pre_map.get("pre_gun3"));
            res = prefer_dao.insert(prefer_vo);

            if (res != 1){
                throw new Exception("insert_prefer3_fail");
            }
        }
        

        return res;
    };


    // 사장 등록
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int insert_ceo(MemberVo member_vo, CampCeoVo camp_ceo_vo) throws Exception {
        
        int res = 0;

        res = member_dao.insertCommon(member_vo);

        if (res != 1) {
            throw new Exception("insert_common_fail"); 
        }

        res = member_ceo_dao.insertCeo(member_vo);
        if (res != 1) {
            throw new Exception("insert_ceo_fail"); 
        }

        camp_ceo_vo.setMem_idx(member_vo.getMem_idx());
        res = camp_ceo_dao.insertCampCeo(camp_ceo_vo);
        if (res != 1) {
            throw new Exception("insert_camp_ceo_fail"); 
        }
 
        return res;
    };


    // 관리자 등록
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int insert_manager(MemberVo member_vo) throws Exception {
        
        int res = 0;

        res = member_dao.insertCommon(member_vo);
        if (res != 1) {
            throw new Exception("insert_common_fail"); 
        }

        res = member_manager_dao.insertManager(member_vo);
        if (res != 1) {
            throw new Exception("insert_manager_fail"); 
        }
        
        return res;
    };

    // 일반 수정
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int update_general(MemberVo member_vo, PreferVo prefer_vo, Map<String, String> pre_map) throws Exception {

        int res = 0;

        res = member_dao.updateCommon(member_vo);

        if (res != 1) {
            throw new Exception("update_common_fail"); 
        }

        res = member_general_dao.updateGeneral(member_vo);
        if (res != 1) {
            throw new Exception("update_general_fail"); 
        }
 
        // prefer에 mem_idx 넣기
        prefer_vo.setMem_idx(member_vo.getMem_idx());

        // 1
        if(pre_map.containsKey("pre_si1") && pre_map.containsKey("pre_gun1")){
            if (pre_map.containsKey("pre_idx1") ) {
                int pre_idx1 = Integer.parseInt(pre_map.get("pre_idx1")); 
    
                res=0;
                prefer_vo.setPre_si(pre_map.get("pre_si1"));
                prefer_vo.setPre_gun(pre_map.get("pre_gun1"));
                prefer_vo.setPre_idx(pre_idx1);

                res = prefer_dao.update(prefer_vo);

                
                if (res != 1){
                    throw new Exception("update_prefer1_fail");
                }
            }else if(!pre_map.containsKey("pre_idx1")){
                res=0;
                prefer_vo.setPre_si(pre_map.get("pre_si1"));
                prefer_vo.setPre_gun(pre_map.get("pre_gun1"));
                res = prefer_dao.insert(prefer_vo);

                if (res != 1){
                    throw new Exception("insert_prefer1_fail");
                }
            }
        }

        //2
        if(pre_map.containsKey("pre_si2") && pre_map.containsKey("pre_gun2")){
            if (pre_map.containsKey("pre_idx2") ) {
                int pre_idx2 = Integer.parseInt(pre_map.get("pre_idx2")); 

                res=0;
                prefer_vo.setPre_si(pre_map.get("pre_si2"));
                prefer_vo.setPre_gun(pre_map.get("pre_gun2"));
                prefer_vo.setPre_idx(pre_idx2);

                res = prefer_dao.update(prefer_vo);


                if (res != 1){
                    throw new Exception("update_prefer2_fail");
                }

            }else if (!pre_map.containsKey("pre_idx2") ) {

                res=0;
                prefer_vo.setPre_si(pre_map.get("pre_si2"));
                prefer_vo.setPre_gun(pre_map.get("pre_gun2"));
                res = prefer_dao.insert(prefer_vo);

                if (res != 1){
                    throw new Exception("insert_prefer2_fail");
                }

            }
        }

        // 3
        if(pre_map.containsKey("pre_si3") && pre_map.containsKey("pre_gun3")){
            if (pre_map.containsKey("pre_idx3") ) {
                int pre_idx3 = Integer.parseInt(pre_map.get("pre_idx3"));

                res=0;
                prefer_vo.setPre_si(pre_map.get("pre_si3"));
                prefer_vo.setPre_gun(pre_map.get("pre_gun3"));
                prefer_vo.setPre_idx(pre_idx3);

                res = prefer_dao.update(prefer_vo);
                
                if (res != 1){
                    throw new Exception("update_prefer3_fail");
                }
            }else if (!pre_map.containsKey("pre_idx3") ) {

                res=0;
                prefer_vo.setPre_si(pre_map.get("pre_si3"));
                prefer_vo.setPre_gun(pre_map.get("pre_gun3"));
                res = prefer_dao.insert(prefer_vo);

                if (res != 1){
                    throw new Exception("insert_prefer3_fail");
                }
            }
        }


        return res;
    };
    // 일반 수정
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int update_general_m(MemberVo member_vo) throws Exception {

        int res = 0;

        res = member_general_dao.updateGeneralM(member_vo);

        return res;
    };

    // 사장 수정
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int update_ceo(MemberVo member_vo) throws Exception {
        
        int res = 0;

        res = member_dao.updateCommon(member_vo);

        if (res != 1) {
            throw new Exception("update_common_fail"); 
        }

        res = member_ceo_dao.updateCeo(member_vo);
        if (res != 1) {
            throw new Exception("update_ceo_fail"); 
        }
        
        // res = camp_ceo_dao.updateCeo(member_vo);
        // if (res != 1) {
        //     throw new Exception("update_ceo_fail"); 
        // }
        
        return res;
    };

    // 관리자 수정
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int delete_manager(MemberVo member_vo) throws Exception {
        
        int res = 0;
        res = member_dao.deleteCommon(member_vo.getMem_idx());

        if (res != 1) {
            throw new Exception("delete_email_fail"); 
        }

        res = member_manager_dao.deleteManager(member_vo);
        if (res != 1) {
            throw new Exception("delete_manager_fail"); 
        }
        
        return res;
    };

    // 일반 삭제
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int delete_general(int mem_idx) throws Exception {

        // 선호지역 날리기
        // List<PreferVo> list = prefer_dao.selectListMemIdx(mem_idx);
        // boolean bResult1 = (list == null);
        // if(bResult1 == true){
        //     int res = prefer_dao.delete(mem_idx);

        //     if (res != 1) {
        //         throw new Exception("delete_prefer_fail"); 
        //     }
        // }

        int res = 0;

        // general에서 sns 연동값 날리기 & 사진 지우기
        res = member_general_dao.deleteGeneral(mem_idx);

        if (res != 1) {
            throw new Exception("delete_general_fail"); 
        }

        // common에서 
        res = member_dao.deleteCommon(mem_idx);
        if (res != 1) {
            throw new Exception("delete_common_fail"); 
        }
        
        return res;
    };

    // 사장 삭제
    // @Transactional(rollbackFor = Exception.class)
    // @Override
    // public int delete_ceo(int mem_idx) throws Exception {
        
    //     int res = 0;
    //     res = camp_ceo_dao.deleteCampCeo(mem_idx);
    //     if (res != 1) {
    //         throw new Exception("camp_ceo_delete_fail"); 
    //     }

    //     res = member_ceo_dao.deleteCeo(mem_idx);

    //     if (res != 1) {
    //         throw new Exception("delete_ceo_fail"); 
    //     }

    //     res = member_dao.deleteCommon(mem_idx);
    //     if (res != 1) {
    //         throw new Exception("delete_common_fail"); 
    //     }
        
    //     return res;
    // };
    
    @Override
    public MemberVo selectOneNameEmail(MemberVo vo) {
        
        MemberVo mem_vo = member_dao.selectOneNameEmail(vo);

        return mem_vo;
    }
    
    @Override
    public MemberVo selectOneNaIdEm(MemberVo vo) {
        
        MemberVo mem_vo = member_dao.selectOneNaIdEm(vo);

        return mem_vo;
    }


    @Override
    public int update_pwd(MemberVo vo) throws Exception {
        
        int res = member_dao.updatePwd(vo);

        return res;
    }


    @Override
    public List<CampCeoVo> selectList_idx_room(int mem_idx) {
        
        List<CampCeoVo> list = camp_ceo_dao.selectLisIdxRoom(mem_idx);
        
        return list;
    }

    @Override
    public List<CampCeoVo> selectList_Rev(int mem_idx) {
        
        List<CampCeoVo> list = camp_ceo_dao.selectListRev(mem_idx);
        
        return list;
    }

    @Override
    public List<CampCeoVo> selectList_Rev_old(int mem_idx) {
        
        List<CampCeoVo> list = camp_ceo_dao.selectListRevOld(mem_idx);
        
        return list;
    }

    @Override
    public int delete_sns(Map<String, Object> sns_map) throws Exception {
        
        int res = 0;

        res = member_general_dao.deleteSns(sns_map);

        if (res != 1) {
            throw new Exception("sns_delete_fail"); 
        }

        return res;
    };

    @Override
    public int insert_sns(Map<String, Object> sns_map) throws Exception {
        
        int res = 0;

        res = member_general_dao.insertSns(sns_map);

        if (res != 1) {
            throw new Exception("sns_insert_fail"); 
        }

        return res;
    }

    @Override
    public MemberVo selectOneGeneralId(String mem_id) {
        
        MemberVo vo = member_dao.selectOneGeneralId(mem_id);

        return vo;
    };


}
