package com.example.sanpa.biz.helper.impl;

import com.example.sanpa.biz.admin.impl.AdminDAO_mybatis;
import com.example.sanpa.biz.helper.HelperVO;
import com.example.sanpa.biz.mother.MotherVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("helperService")
public class HelperServiceImpl implements HelperService{


    @Autowired
    HelperDAO_mybatis helperDAO;
    @Autowired
    AdminDAO_mybatis adminDAO;

    @Override
    public HelperVO helper_setUpdateForm(HelperVO vo) {
        System.out.println("HelperServiceImpl의 helper_setUpdateForm()를 실행합니다.");
        return helperDAO.helper_setUpdateForm(vo);
    }//helper_setUpdateForm()-end

    @Override
    public MotherVO mother_setUpdateForm(MotherVO vo2) {
        System.out.println("HelperServiceImpl의 mother_setUpdateForm()를 실행합니다.");
        return helperDAO.mother_setUpdateForm(vo2);
    }//mother_setUpdateForm()-end

    @Override
    public void helper_update(HelperVO vo) {
        System.out.println("HelperServiceImpl의 helper_update()를 실행합니다.");
        helperDAO.helper_update(vo);
    }//helper_update()-end

    @Override
    public MotherVO changeHelperToMother(MotherVO vo2) {
        System.out.println("HelperServiceImpl의 helper_update()를 실행합니다.");
        return helperDAO.changeHelperToMother(vo2);
    }//changeHelperToMother()-end

    @Override
    public void mother_dismissMother(HelperVO vo) {
        System.out.println("HelperServiceImpl의 mother_dismissMother()를 실행합니다.");
        helperDAO.mother_dismissMother(vo);
    }//mother_dismissMother()-end

    @Override
    public List<HelperVO> helperVO() {
        System.out.println("HelperServiceImpl의 helperVO()를 실행합니다.");
        return helperDAO.helperVO();
    }//helperVO()-end

    @Override
    public List<HelperVO> getHelperList() {
        System.out.println("HelperServiceImpl의 getHelperList를 실행합니다.");
        return adminDAO.getHelperList();
    }//getHelperList()-end

    @Override
    public List<HelperVO> getMotherList() {
        System.out.println("HelperServiceImpl의 getMotherList를 실행합니다.");
        return adminDAO.getMotherList();
    }//getMotherList()-end

    @Override
    public List<HelperVO> getSearchKeyword(String searchKeyword) {
        System.out.println("HelperServiceImpl의 getSearchKeyword를 실행합니다.");
        return adminDAO.getSearchKeyword(searchKeyword);
    }//getSearchKeyword()-end


    //친구요청 거절
    @Override
    public void refuseInvite(HelperVO vo){
        System.out.println("HelperServiceImpl의 refuseInvite()를 실행합니다.");
        helperDAO.refuseInvite(vo);
    }
    //친구요청 수락하고 삭제처리
    @Override
    public void acceptInvite(HelperVO vo){
        System.out.println("HelperServiceImpl의 acceptInvite()를 실행합니다.");
        helperDAO.acceptInvite(vo);
    }

    //친구요청 중복확인
    @Override
    public boolean isExistInvite(HelperVO vo) {

        return helperDAO.isExistInvite(vo) > 0;
    }

    //친구요청
    @Override
    public void insertInvite(HelperVO vo){
        System.out.println("HelperServiceImpl의 getInvitationList()를 실행합니다.");
        helperDAO.insertInvite(vo);
    }

    //받은요청목록조회
    @Override
    public List<HelperVO> getInvitationList(HelperVO vo){
        System.out.println("HelperServiceImpl의 getInvitationList()를 실행합니다.");
        return  helperDAO.getInvitationList(vo);
    }
    //
    @Override
    public boolean isExistInConnectionListHtm(String helper_id, String mother_id) {
        HelperVO vo = new HelperVO();
        vo.setHelper_id(helper_id);
        vo.setMother_id(mother_id);
        return helperDAO.isExistInConnectionListHtm(vo);
    }
    @Override
    public boolean isExistInConnectionListMth(String helper_id, String mother_id) {
        HelperVO vo = new HelperVO();
        vo.setHelper_id(helper_id);
        vo.setMother_id(mother_id);
        return helperDAO.isExistInConnectionListMth(vo);
    }

    // 산모목록에서 특정 산모를 connection_list_htm 테이블에서 삭제
    @Override
    public void deleteSanmoListFromHtm(String helper_id, String mother_id) {
        System.out.println("HelperServiceImpl의 deleteSanmoListFromHtm 실행합니다.");
        HelperVO vo = new HelperVO();
        vo.setHelper_id(helper_id);
        vo.setMother_id(mother_id);
        helperDAO.deleteSanmoListFromHtm(vo);
    }

    // 산모목록에서 특정 산모를 connection_list_mth 테이블에서 삭제
    @Override
    public void deleteSanmoListFromMth(String helper_id, String mother_id) {
        System.out.println("HelperServiceImpl의 deleteSanmoListFromMth 실행합니다.");
        HelperVO vo = new HelperVO();
        vo.setHelper_id(helper_id);
        vo.setMother_id(mother_id);
        helperDAO.deleteSanmoListFromMth(vo);
    }


    //산모 검색
    @Override
    public HelperVO getSanmoByPhoneNumber(String phoneNumber){
        System.out.println("HelperServiceImpl의 getSanmoByPhoneNumber()를 실행합니다.");
        return  helperDAO.getSanmoByPhoneNumber(phoneNumber);

    }

    //산모 목록
    @Override
    public List<HelperVO> getSanmoListWithReports( HelperVO vo){
        System.out.println("HelperServiceImpl의 getSanmoListWithReports()를 실행합니다.");
        return  helperDAO.helper_sanmoList(vo);

    }

    @Override
    public List<HelperVO> getButtonList(HelperVO vo){
        return helperDAO.getButtonList(vo);
    }

    @Override
    public HelperVO getMotherName(HelperVO vo){
        return helperDAO.getMotherName(vo);
    }


    @Override
    public void dismissSanpa(HelperVO vo) {
        helperDAO.dismissSanpa(vo);
    }


}//HelperServiceImpl()-end
