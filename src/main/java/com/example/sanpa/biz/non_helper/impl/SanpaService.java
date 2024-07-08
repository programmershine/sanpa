package com.example.sanpa.biz.non_helper.impl;

import com.example.sanpa.biz.ConnectionVO;
import com.example.sanpa.biz.helper.HelperVO;
import com.example.sanpa.biz.mother.MotherVO;

public interface SanpaService {

    public void insertHelper(HelperVO vo);
    public HelperVO login(HelperVO vo);
    public HelperVO checkDuplicationIdWhenInsertHelper(HelperVO vo);
    public HelperVO findId(HelperVO vo);
    public HelperVO getEmailFromId(HelperVO vo);
    public void changePassword(HelperVO vo);
    public void insertMother(MotherVO vo2);
    //위치동의 수정
    public String selectTableName(ConnectionVO cvo);
    public void updateLocationAllowHtm(ConnectionVO cvo);
    public void updateLocationAllowMth(ConnectionVO cvo);


}
