package com.example.sanpa.biz.admin.impl;

import com.example.sanpa.biz.mother.MotherVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("adminService")
public class AdminServiceImpl implements AdminService{

    @Autowired
    AdminDAO_mybatis adminDAO;

    @Override
    public MotherVO motherDetailBox1(MotherVO vo) {
        System.out.println("AdminServiceImpl의 motherDetailBox1를 실행합니다.");
        return adminDAO.motherDetailBox1(vo);
    }//motherDetailBox1()-end

    @Override
    public List<MotherVO> motherDetailBox2(MotherVO vo) {
        System.out.println("AdminServiceImpl의 motherDetailBox2를 실행합니다.");
        return adminDAO.motherDetailBox2(vo);
    }//motherDetailBox2()-end

    @Override
    public List<MotherVO> motherDetailBox3(MotherVO vo) {
        System.out.println("AdminServiceImpl의 motherDetailBox3를 실행합니다.");
        return adminDAO.motherDetailBox3(vo);
    }//motherDetailBox3()-end

    @Override
    public List<MotherVO> motherHealthReport(MotherVO vo) {
        System.out.println("AdminServiceImpl의 motherHealthReport를 실행합니다.");
        return adminDAO.motherHealthReport(vo);
    }//motherHealthReport()-end

    @Override
    public MotherVO motherInfo(MotherVO vo) {
        System.out.println("AdminServiceImpl의 motherInfo를 실행합니다.");
        return adminDAO.motherInfo(vo);
    }//motherInfo()-end

    @Override
    public List<MotherVO> aButtonStatus() {
        System.out.println("AdminServiceImpl의 aButtonStatus를 실행합니다.");
        return adminDAO.aButtonStatus();
    }//aButtonStatus()-end

    @Override
    public List<MotherVO> bButtonStatus() {
        System.out.println("AdminServiceImpl의 bButtonStatus를 실행합니다.");
        return adminDAO.bButtonStatus();
    }//bButtonStatus()-end

    @Override
    public List<MotherVO> buttonStatus() {
        System.out.println("AdminServiceImpl의 buttonStatus를 실행합니다.");
        return adminDAO.buttonStatus();
    }//buttonStatus()-end

    @Override
    public List<MotherVO> searchButtonList(String searchKeyword) {
        System.out.println("AdminServiceImpl의 searchButtonList를 실행합니다.");
        return adminDAO.searchButtonList(searchKeyword);
    }//searchButtonList()-end




}//AdminServiceImpl()-end
