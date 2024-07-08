package com.example.sanpa.biz.admin.impl;

import com.example.sanpa.biz.mother.MotherVO;

import java.util.List;

public interface AdminService {
    public MotherVO motherDetailBox1(MotherVO vo);
    public List<MotherVO> motherDetailBox2(MotherVO vo);
    public List<MotherVO> motherDetailBox3(MotherVO vo);
    public List<MotherVO> motherHealthReport(MotherVO vo);
    public MotherVO motherInfo (MotherVO vo);
    public List<MotherVO> aButtonStatus();
    public List<MotherVO> bButtonStatus();
    public List<MotherVO> buttonStatus();
    public List<MotherVO> searchButtonList(String searchKeyword);
}
