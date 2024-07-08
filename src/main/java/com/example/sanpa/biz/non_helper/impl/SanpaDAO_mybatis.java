package com.example.sanpa.biz.non_helper.impl;

import com.example.sanpa.biz.ConnectionVO;
import com.example.sanpa.biz.helper.HelperVO;
import com.example.sanpa.biz.mother.MotherVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class SanpaDAO_mybatis {

    @Autowired
    private SqlSessionTemplate mybatis;

    public void insertHelper(HelperVO vo) {
        System.out.println("MyBatis의 insertHelper를 실행합니다.");
        mybatis.insert("Non_HelperDAO_mybatis.insertHelper", vo);
    }//insertHelper()-end

    public void insertMother(MotherVO vo2) {
        System.out.println("MyBatis의 insertMother를 실행합니다.");
        mybatis.update("Non_HelperDAO_mybatis.insertMother", vo2);
    }//=insertMother()-end

    public HelperVO login(HelperVO vo) {
        System.out.println("MyBatis의 login을 실행합니다.");
        return mybatis.selectOne("Non_HelperDAO_mybatis.login", vo);
    }

    public HelperVO  checkDuplicationIdWhenInsertHelper(HelperVO vo) {
        System.out.println("MyBatis의 checkDuplicationIdWhenInsertHelper을 실행합니다.");
        return mybatis.selectOne("Non_HelperDAO_mybatis.checkDuplicationIdWhenInsertHelper", vo);
    }//checkDuplicationIdWhenInsertHelper()-end

    public HelperVO findId(HelperVO vo) {
        System.out.println("MyBatis의 findId를 실행합니다.");
        return mybatis.selectOne("Non_HelperDAO_mybatis.findId", vo);
    }

    public HelperVO getEmailFromId(HelperVO vo) {
        System.out.println("MyBatis의 getEmailFromId를 실행합니다.");
        return mybatis.selectOne("Non_HelperDAO_mybatis.getEmailFromId", vo);
    }

    public void changePassword(HelperVO vo) {
        System.out.println("MyBatis의 changePassword를 실행합니다.");
        mybatis.update("Non_HelperDAO_mybatis.changePassword", vo);
    }

    public MotherVO findMotherByHelperId(HelperVO vo) {
        System.out.println("MyBatis의 findMotherByHelperId를 실행합니다.");
        return mybatis.selectOne("Non_HelperDAO_mybatis.findMotherByHelperId", vo);
    }

    public List<ConnectionVO> connectionList(ConnectionVO cvo){

        return mybatis.selectList("ConnectionDAO_mybatis.connection_getList", cvo);
    }

    public List<ConnectionVO> connectionListUnion(ConnectionVO cvo){

        return mybatis.selectList("ConnectionDAO_mybatis.connection_getListUnion", cvo);
    }

    //위치동의 수정
    public String selectTableName(ConnectionVO cvo){
        System.out.println("selectTableName");
        return mybatis.selectOne("ConnectionDAO_mybatis.selectTableName", cvo);
    }
    public void updateLocationAllowHtm(ConnectionVO cvo) {
        System.out.println("MyBatis의 updateLocationAllowHtm 실행합니다.");
        mybatis.update("ConnectionDAO_mybatis.updateLocationAllowHtm", cvo);
    }
    public void updateLocationAllowMth(ConnectionVO cvo) {
        System.out.println("MyBatis의 updateLocationAllowMth 실행합니다.");
        mybatis.update("ConnectionDAO_mybatis.updateLocationAllowMth", cvo);
    }
    public HelperVO getHelper(HelperVO vo){

        return mybatis.selectOne("HelperDAO_mybatis.helper_setUpdateForm", vo);
    }

    public List<ConnectionVO> connection_getMotherListNameUnion(ConnectionVO cvo){
        System.out.println("요기까지오냐구ㅜ우우 555555555555555555555555555"+cvo.helper_id);
        return mybatis.selectList("ConnectionDAO_mybatis.connection_getMotherListNameUnion", cvo);
    }

}//SanpaDAO_mybatis
