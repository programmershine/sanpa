package com.example.sanpa.biz.non_helper.impl;

import com.example.sanpa.biz.ConnectionVO;
import com.example.sanpa.biz.helper.HelperVO;
import com.example.sanpa.biz.mother.MotherVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("sanpaService")
public class SanpaServiceImpl implements SanpaService {

    @Autowired
    private SanpaDAO_mybatis sanpaDAO;

    @Override
    public void insertHelper(HelperVO vo) {
        System.out.println("SanpaServiceImpl의 insertHelper()를 실행합니다.");
        sanpaDAO.insertHelper(vo);
    }//insertHelper()-end

    @Override
    public void insertMother(MotherVO vo2) {
        System.out.println("SanpaServiceImpl의 insertMother()를 실행합니다.");
        sanpaDAO.insertMother(vo2);
    }

    @Override
    public HelperVO login(HelperVO vo) {
        System.out.println("SanpaServiceImpl의 login()를 실행합니다.");
        return sanpaDAO.login(vo);
    }//login()-end

    @Override
    public HelperVO checkDuplicationIdWhenInsertHelper(HelperVO vo) {
        System.out.println("SanpaServiceImpl의 checkDuplicationIdWhenInsertHelper()를 실행합니다.");
        return sanpaDAO.checkDuplicationIdWhenInsertHelper(vo);
    }//checkDuplicationIdWhenInsertHelper()-end

    @Override
    public HelperVO findId(HelperVO vo) {
        System.out.println("SanpaServiceImpl의 findId()를 실행합니다.");
        return sanpaDAO.findId(vo);
    }//logout()-end

    @Override
    public HelperVO getEmailFromId(HelperVO vo) {
        System.out.println("SanpaServiceImpl의 getEmailFromId()를 실행합니다.");
        HelperVO helperVO = null;
        try {
            helperVO = sanpaDAO.getEmailFromId(vo);
            if(helperVO == null) {
                helperVO = new HelperVO();
                helperVO.setHelper_email("");
                return helperVO;
            }
        } catch (NullPointerException e) {
            e.printStackTrace();
        }
        return helperVO;
    }//getEmailFromId()-end

    @Override
    public void changePassword(HelperVO vo) {
        System.out.println("SanpaServiceImpl의 changePassword()를 실행합니다.");
        sanpaDAO.changePassword(vo);
    }//changePassword()-end

    //위치동의 수정
    @Override
    public String selectTableName(ConnectionVO cvo) {
        System.out.println("SanpaServiceImpl의 selectTableName()를 실행합니다.");
        return sanpaDAO.selectTableName(cvo);
    }

    @Override
    public void updateLocationAllowHtm(ConnectionVO cvo) {
        System.out.println("SanpaServiceImpl의 updateLocationAllowHtm()를 실행합니다.");
        sanpaDAO.updateLocationAllowHtm(cvo);
    }
    @Override
    public void updateLocationAllowMth(ConnectionVO cvo) {
        System.out.println("SanpaServiceImpl의 updateLocationAllowMth()를 실행합니다.");
        sanpaDAO.updateLocationAllowMth(cvo);
    }


}
