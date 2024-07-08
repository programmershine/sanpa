package com.example.sanpa.biz.admin.impl;

import com.example.sanpa.biz.helper.HelperVO;
import com.example.sanpa.biz.mother.MotherVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class AdminDAO_mybatis {

    @Autowired
    SqlSessionTemplate mybatis;

    public List<HelperVO> getHelperList () {
        System.out.println("MyBatis의 getHelperList을 실행합니다.");
        return mybatis.selectList("AdminDAO_mybatis.getHelperList");
    }//getHelperList()-end

    public List<HelperVO> getMotherList () {
        System.out.println("MyBatis의 getMotherList을 실행합니다.");
        return mybatis.selectList("AdminDAO_mybatis.getMotherList");
    }//getMotherList()-end

    public List<HelperVO> getSearchKeyword (String searchKeyword) {
        System.out.println("MyBatis의 getSearchKeyword을 실행합니다.");
        return mybatis.selectList("AdminDAO_mybatis.getSearchKeyword", searchKeyword);
    }//getSearchKeyword()-end

    public MotherVO motherDetailBox1 (MotherVO vo) {
        System.out.println("MyBatis의 motherDetailBox1을 실행합니다.");
        return mybatis.selectOne("AdminDAO_mybatis.motherDetailBox1", vo);
    }//motherDetailBox1()-end

    public List<MotherVO> motherDetailBox2 (MotherVO vo) {
        System.out.println("MyBatis의 motherDetailBox2을 실행합니다.");
        return mybatis.selectList("AdminDAO_mybatis.motherDetailBox2", vo);
    }//motherDetailBox2()-end

    public List<MotherVO> motherDetailBox3 (MotherVO vo) {
        System.out.println("MyBatis의 motherDetailBox3을 실행합니다.");
        return mybatis.selectList("AdminDAO_mybatis.motherDetailBox3", vo);
    }//motherDetailBox3()-end

    public List<MotherVO> motherHealthReport (MotherVO vo) {
        System.out.println("MyBatis의 motherHealthReport를 실행합니다.");
        return mybatis.selectList("AdminDAO_mybatis.motherHealthReport", vo);
    }//motherHealthReport()-end

    public MotherVO motherInfo (MotherVO vo) {
        System.out.println("MyBatis의 motherInfo를 실행합니다.");
        return mybatis.selectOne("AdminDAO_mybatis.motherInfo", vo);
    }//motherInfo()-end

    public List<MotherVO> aButtonStatus() {
        System.out.println("Mybatis의 aButtonStatus를 실행합니다.");
        return mybatis.selectList("AdminDAO_mybatis.aButtonStatus");
    }//aButtonStatus()-end

    public List<MotherVO> bButtonStatus() {
        System.out.println("Mybatis의 bButtonStatus를 실행합니다.");
        return mybatis.selectList("AdminDAO_mybatis.bButtonStatus");
    }//bButtonStatus()-end

    public List<MotherVO> buttonStatus() {
        System.out.println("Mybatis의 buttonStatus를 실행합니다.");
        return mybatis.selectList("AdminDAO_mybatis.buttonStatus");
    }//buttonStatus()-end

    public List<MotherVO> searchButtonList(String searchKeyword) {
        System.out.println("Mybatis의 searchButtonList를 실행합니다.");
        return mybatis.selectList("AdminDAO_mybatis.searchButtonList", searchKeyword);
    }//searchButtonList()-end



}
