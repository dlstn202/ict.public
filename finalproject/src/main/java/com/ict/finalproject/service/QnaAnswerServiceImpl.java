package com.ict.finalproject.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.finalproject.dao.AnswerMapper;
import com.ict.finalproject.dao.QnaMapper;
import com.ict.finalproject.vo.AnswerVo;
import com.ict.finalproject.vo.QnaVo;

@Service
public class QnaAnswerServiceImpl implements QnaAnswerService {

    @Autowired
    QnaMapper qna_dao;

    @Autowired
    AnswerMapper answer_dao;

    @Override
    public int insertQna(QnaVo vo) {
        
        int res = qna_dao.insert(vo);

        return res;
    }

    @Override
    public List<QnaVo> selectListMap(Map<String, Object> map) {
        
        List<QnaVo> list = qna_dao.selectListMap(map);

        return list;
    }

    @Override
    public int selectRowTotal(Map<String, Object> map) {
        
        int res = qna_dao.selectRowTotal(map);

        return res;
    }

    @Override
    public int insertAnswer(AnswerVo vo) throws Exception {
        
        int res = answer_dao.insert(vo);

        if (res != 1) {
            throw new Exception("answer_insert_fail"); 
        }else{
            res = qna_dao.update_condition(vo.getQna_idx());
        }
        if (res != 1) {
            throw new Exception("qna_update_condition_fail"); 
        }
        
        return res;
    }

    @Override
    public int updateAnswer(AnswerVo vo) {

        int res = answer_dao.update(vo);

        return res;
    }

    

    


    

}
