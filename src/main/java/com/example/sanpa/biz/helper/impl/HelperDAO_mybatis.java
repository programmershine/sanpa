package com.example.sanpa.biz.helper.impl;

import com.example.sanpa.biz.helper.HelperVO;
import com.example.sanpa.biz.mother.MotherVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class HelperDAO_mybatis {

    @Autowired
    SqlSessionTemplate mybatis;

    public HelperVO helper_setUpdateForm(HelperVO vo) {
        System.out.println("MyBatis의 helper_setUpdateForm을 실행합니다.");
        return mybatis.selectOne("HelperDAO_mybatis.helper_setUpdateForm", vo);
    }//helper_setUpdateForm()-end

    public MotherVO mother_setUpdateForm(MotherVO vo2) {
        System.out.println("MyBatis의 mother_setUpdateForm을 실행합니다.");
        return mybatis.selectOne("HelperDAO_mybatis.mother_setUpdateForm", vo2);
    }//mother_setUpdateForm()-end

    public void helper_update(HelperVO vo) {
        System.out.println("MyBatis의 helper_update을 실행합니다.");
        mybatis.update("HelperDAO_mybatis.helper_update", vo);
    }//helper_update()-end

    public MotherVO changeHelperToMother(MotherVO vo2) {
        System.out.println("MyBatis의 changeHelperToMother을 실행합니다.");
        return mybatis.selectOne("HelperDAO_mybatis.changeHelperToMother", vo2);
    }//changeHelperToMother()-end

    public void mother_dismissMother(HelperVO vo) {
        System.out.println("MyBatis의 mother_dismissMother을 실행합니다.");
        mybatis.update("HelperDAO_mybatis.mother_dismissMother", vo);
    }//mother_dismissMother()-end

    public List<HelperVO> helperVO() {
        System.out.println("MyBatis의 helperVO를 실행합니다.");
        return mybatis.selectList("HelperDAO_mybatis.helperVO");
    }//helperVO()-end

    //친구요청 거절하면 삭제
    public void refuseInvite(HelperVO vo){
        System.out.println("MyBatis의 deleteInvite 실행합니다.");
        mybatis.delete("Non_HelperDAO_mybatis.deleteInvite",vo);
    }
    //invite 테이블 수락처리- 및 삭제처리
    public void acceptInvite (HelperVO vo){
        System.out.println("MyBatis의 acceptInvite 실행합니다.");
        // invite_list 테이블 업데이트
        mybatis.update("Non_HelperDAO_mybatis.acceptInvite", vo);

        // invite_list 테이블에서 삭제
        mybatis.delete("Non_HelperDAO_mybatis.deleteAfterAccept", vo);
    }
    // 중복 체크 메서드(친구요청테이블)
    public int isExistInvite(HelperVO vo) {
        System.out.println("MyBatis의 isExistInvite 실행합니다.");
        return mybatis.selectOne("Non_HelperDAO_mybatis.isExistInvite", vo);
    }

    // 친구요청보내기
    public void insertInvite(HelperVO vo) {
        System.out.println("MyBatis의 insertInvite 실행합니다.");
        mybatis.insert("Non_HelperDAO_mybatis.addInvitation", vo);
    }

    //받은 요청 목록 조회
    public List<HelperVO> getInvitationList(HelperVO vo){
        System.out.println("MyBatis의 invitationList 실행합니다.");

        List<HelperVO> invitationList = mybatis.selectList("Non_HelperDAO_mybatis.invitationList", vo);

        return invitationList;
    }
    //connection_list 조회
    public boolean isExistInConnectionListHtm(HelperVO vo) {
        System.out.println("MyBatis의 isExistInConnectionListHtm 실행합니다.");
        int count = mybatis.selectOne("Non_HelperDAO_mybatis.isExistInConnectionListHtm", vo);
        return (count > 0); // 0보다 크면 true, 중복임
    }
    public boolean isExistInConnectionListMth(HelperVO vo) {
        System.out.println("MyBatis의 isExistInConnectionListMth 실행합니다.");
        int count = mybatis.selectOne("Non_HelperDAO_mybatis.isExistInConnectionListMth", vo);
        return (count > 0); // 0보다 크면 true, 중복임
    }

    // 산모목록에서 특정 산모를 connection_list_htm 테이블에서 삭제
    public void deleteSanmoListFromHtm(HelperVO vo) {
        System.out.println("MyBatis의 deleteSanmoListFromHtm 실행합니다.");
        mybatis.delete("Non_HelperDAO_mybatis.deleteSanmoListFromHtm", vo);
    }

    // 산모목록에서 특정 산모를 connection_list_mth 테이블에서 삭제
    public void deleteSanmoListFromMth(HelperVO vo) {
        System.out.println("MyBatis의 deleteSanmoListFromMth 실행합니다.");
        mybatis.delete("Non_HelperDAO_mybatis.deleteSanmoListFromMth", vo);
    }

    // 전화번호로 특정 산모 정보를 가져오는 메서드
    public HelperVO getSanmoByPhoneNumber(String phoneNumber) {
        System.out.println("MyBatis의 getSanmoByPhoneNumber을 실행합니다.");

        HelperVO vo = new HelperVO();
        vo.setHelper_tel(phoneNumber);

        return mybatis.selectOne("Non_HelperDAO_mybatis.getSanmoByPhoneNumber", vo);
    }


    //산모 목록 조회
    public List<HelperVO> helper_sanmoList(HelperVO vo){
        System.out.println("MyBatis의 helper_sanmoList 실행합니다.");

        List<HelperVO> sanmoList = mybatis.selectList("Non_HelperDAO_mybatis.getSanmoList", vo);

        return sanmoList;
    }
    public List<HelperVO> getButtonList(HelperVO vo){
        System.out.println("MyBatis의 getButtonList 실행합니다.");

        List<HelperVO> buttonList = mybatis.selectList("Non_HelperDAO_mybatis.getButtonList", vo);

        return buttonList;
    }
    public HelperVO getMotherName(HelperVO vo){

        return mybatis.selectOne("Non_HelperDAO_mybatis.getMotherName", vo);
    }

    public void dismissSanpa(HelperVO vo) {
        mybatis.delete("Non_HelperDAO_mybatis.dismissSanpa", vo);
    }//dismissSanpa()-end



}//HelperDAO_mybatis()-end
