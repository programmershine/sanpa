package com.example.sanpa.biz.mother.impl;

import com.example.sanpa.biz.mother.MotherVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("motherService")
public class MotherServiceImpl implements MotherService{

    @Autowired
    MotherDAO_mybatis motherDAO;



    @Override
    public int preventTooManyResultsExceptionWhenEnterIntoMotherMainPageDueToEmergencyAlaram (MotherVO vo) {
        System.out.println("MotherServiceImpl의 preventTooManyResultsExceptionWhenEnterIntoMotherMainPageDueToEmergencyAlaram()를 실행합니다.");
        return motherDAO.preventTooManyResultsExceptionWhenEnterIntoMotherMainPageDueToEmergencyAlaram(vo);
    }//preventTooManyResultsExceptionWhenEnterIntoMotherMainPageDueToEmergencyAlaram()-end
    @Override
    public List<MotherVO> getMotherVO() {
        System.out.println("MotherServiceImpl의 getMotherVO()를 실행합니다.");
        return motherDAO.getMotherVO();
    }//getMotherVO()-end

    @Override
    public List<MotherVO> getBBtnStatus() {
        System.out.println("MotherServiceImpl의 getBBtnStatus()를 실행합니다.");
        return motherDAO.getBBtnStatus();
    }//getBBtnStatus()-end

    @Override
    public List<MotherVO> getABtnStatus() {
        System.out.println("MotherServiceImpl의 getABtnStatus()를 실행합니다.");
        return motherDAO.getABtnStatus();
    }//getABtnStatus()-end


    @Override
    public MotherVO mother_mainPageInfo(MotherVO vo) {
        System.out.println("MotherServiceImpl의 mother_mainPageInfo()를 실행합니다.");
        return motherDAO.mother_mainPageInfo(vo);
    }//getABtnStatus()-end

    @Override
    public List<MotherVO> mother_mainPageHelperList(MotherVO vo) {
        System.out.println("MotherServiceImpl의 mother_mainPageHelperList()를 실행합니다.");
        return motherDAO.mother_mainPageHelperList(vo);
    }//mother_mainPageHelperList()-end



    @Override
    public List<MotherVO> mother_mainPageHelperListSearchKeyword(MotherVO vo) {
        System.out.println("MotherServiceImpl의 mother_mainPageHelperListSearchKeyword()를 실행합니다.");
        return motherDAO.mother_mainPageHelperListSearchKeyword(vo);
    }//mother_mainPageHelperListSearchKeyword()-end

    @Override
    public int mother_mainPageHelperNum(MotherVO vo) {
        System.out.println("MotherServiceImpl의 mother_mainPageHelperNum()를 실행합니다.");
        return motherDAO.mother_mainPageHelperNum(vo);
    }//mother_mainPageHelperNum()-end




    @Override
    public MotherVO getConnectionListhtm(MotherVO cvo){
        System.out.println(cvo.helper_id +"제대로들어가냐구");
        return motherDAO.getConnectionListhtm(cvo);
    }
    @Override
    public MotherVO getConnectionListmth(MotherVO cvo){
        System.out.println(cvo.helper_id +"제대로들어가냐구222");
        return motherDAO.getConnectionListmth(cvo);
    }
    @Override
    public void updateNicknameRelationByhtm(MotherVO cvo){
        motherDAO.updateNicknameRelationByhtm(cvo);
    }
    @Override
    public void updateNicknameRelationBymth(MotherVO cvo){
        motherDAO.updateNicknameRelationBymth(cvo);
    }




    @Override
    public void helpers_list_delete(MotherVO vo) {
        System.out.println("MotherServiceImpl의 helpers_list_delete()를 실행합니다.");
        motherDAO.helpers_list_delete(vo);
    }//helpers_list_delete()-end

    @Override
    public List<MotherVO> helpers_invite_list(MotherVO vo) {
        System.out.println("MotherServiceImpl의 helpers_invite_list()를 실행합니다.");
        return motherDAO.helpers_invite_list(vo);
    }//helpers_invite_list()-end


    @Override
    public void invite_list_accept_invitation(MotherVO vo) {
        System.out.println("MotherService의 invite_list_accept_invitation()를 실행합니다.");
        motherDAO.invite_list_accept_invitation(vo);
    }//invite_list_accept_invitation()-end

    @Override
    public void invite_HTM_refuse(MotherVO vo) {
        System.out.println("MotherService의 invite_list_accept_invitation()를 실행합니다.");
        motherDAO.invite_HTM_refuse(vo);
    }//invite_list_accept_invitation()-end

    @Override
    public List<MotherVO> helpers_add_searchKeyword(MotherVO vo) {
        System.out.println("MotherService의 helpers_add_searchKeyword()를 실행합니다.");
        return motherDAO.helpers_add_searchKeyword(vo);
    }//helpers_add_searchKeyword()-end

    @Override
    public void helpers_add_helper (MotherVO vo) {
        System.out.println("MotherService의 helpers_add_helper()를 실행합니다.");
        motherDAO.helpers_add_helper(vo);
    }//helpers_add_helper()-end

    @Override
    public void helpers_add_cancel (MotherVO vo) {
        System.out.println("MotherService의 helpers_add_cancel()를 실행합니다.");
        motherDAO.helpers_add_cancel(vo);
    }//helpers_add_cancel ()-end


    @Override
    public void AButtonClick(MotherVO vo) {
        System.out.println("MotherServiceImpl의 AButtonClick()를 실행합니다.");
        motherDAO.AButtonClick(vo);
    }//AButtonClick()-end

    @Override
    public void release_A_status(MotherVO vo) {
        System.out.println("MotherServiceImpl의 release_A_status()를 실행합니다.");
        motherDAO.release_A_status(vo);
    }//release_A_status()-end

    @Override
    public void BButtonClick(MotherVO vo) {
        System.out.println("MotherServiceImpl의 BButtonClick()를 실행합니다.");
        motherDAO.BButtonClick(vo);
    }//BButtonClick()-end

    @Override
    public void release_B_status(MotherVO vo) {
        System.out.println("MotherServiceImpl의 release_B_status()를 실행합니다.");
        motherDAO.release_B_status(vo);
    }//release_B_status()-end

    /* mother_daily_report 부분 */
    @Override
    public List<MotherVO> mother_daily_report_info(MotherVO vo) {
        System.out.println("MotherServiceImpl의 mother_daily_report_info()를 실행합니다.");
        return motherDAO.mother_daily_report_info(vo);
    }//mother_daily_report_info()-end

    @Override
    public List<MotherVO> mother_daily_report_month_count(MotherVO vo) {
        System.out.println("MotherServiceImpl의 mother_daily_report_month_count()를 실행합니다.");
        return motherDAO.mother_daily_report_month_count(vo);
    }//mother_daily_report_month_count()-end

    @Override
    public void mother_daily_report_insert(MotherVO vo) {
        System.out.println("MotherServiceImpl의 mother_daily_report_insert()를 실행합니다.");
        motherDAO.mother_daily_report_insert(vo);
    }//mother_daily_report_insert()-end
    @Override
    public void mother_daily_report_update(MotherVO vo) {
        System.out.println("MotherServiceImpl의 mother_daily_report_update()를 실행합니다.");
        motherDAO.mother_daily_report_update(vo);
    }//mother_daily_report_update()-end

    @Override
    public void mother_daily_report_delete(MotherVO vo) {
        System.out.println("MotherServiceImpl의 mother_daily_report_delete()를 실행합니다.");
        motherDAO.mother_daily_report_delete(vo);
    }//mother_daily_report_delete()-end

    /* 버튼 상황 발동 시 문자 보낼 전화번호 추출 */
    public List<MotherVO> selectHelper_tel_When_A_status(MotherVO vo) {
        System.out.println("MotherServiceImpl의 selectHelper_tel_When_A_status()를 실행합니다.");
        return motherDAO.selectHelper_tel_When_A_status(vo);
    }//selectHelper_tel_When_A_status()-end

    public List<MotherVO> selectHelper_tel_When_B_status(MotherVO vo) {
        System.out.println("MotherServiceImpl의 selectHelper_tel_When_B_status()를 실행합니다.");
        return motherDAO.selectHelper_tel_When_B_status(vo);
    }//selectHelper_tel_When_B_status()-end


    /* mother_health_report 부분 */
    public List<MotherVO> mother_health_report(MotherVO vo) {
        System.out.println("MotherServiceImpl의 mother_health_report()를 실행합니다.");
        return motherDAO.mother_health_report(vo);
    }//mother_health_report()-end



}
