package com.example.sanpa.biz.mother.impl;

import com.example.sanpa.biz.mother.MotherVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class MotherDAO_mybatis {

    @Autowired
    SqlSessionTemplate mybatis;



    public int preventTooManyResultsExceptionWhenEnterIntoMotherMainPageDueToEmergencyAlaram (MotherVO vo) {
        System.out.println("MyBatis의 preventTooManyResultsExceptionWhenEnterIntoMotherMainPageDueToEmergencyAlaram을 실행합니다.");
        Integer chk = mybatis.selectOne("MotherDAO_mybatis.preventTooManyResultsExceptionWhenEnterIntoMotherMainPageDueToEmergencyAlaram", vo);
        if(chk == null) {
            return 0;
        }
        return chk.intValue();
    }//preventTooManyResultsExceptionWhenEnterIntoMotherMainPageDueToEmergencyAlaram()-end

    public List<MotherVO> getMotherVO() {
        System.out.println("MyBatis의 getMotherVO을 실행합니다.");
        return mybatis.selectList("MotherDAO_mybatis.getMotherVO");
    }//getMotherVO()-end

    public List<MotherVO> getBBtnStatus() {
        System.out.println("MyBatis의 getBBtnStatus을 실행합니다.");
        return mybatis.selectList("MotherDAO_mybatis.getBBtnStatus");
    }//getBBtnStatus()-end

    public List<MotherVO> getABtnStatus() {
        System.out.println("MyBatis의 getABtnStatus을 실행합니다.");
        return mybatis.selectList("MotherDAO_mybatis.getABtnStatus");
    }//getABtnStatus()-end

    public MotherVO mother_mainPageInfo(MotherVO vo) {
        System.out.println("MyBatis의 mother_mainPageInfo을 실행합니다.");
        return mybatis.selectOne("MotherDAO_mybatis.mother_mainPageInfo", vo);
    }//mother_mainPageInfo()-end

    public List<MotherVO> mother_mainPageHelperList(MotherVO vo) {
        System.out.println("MyBatis의 mother_mainPageHelperList을 실행합니다.");
        return mybatis.selectList("MotherDAO_mybatis.mother_mainPageHelperList", vo);
    }//mother_mainPageHelperList()-end

    public Integer helpers_list_show_inHTM(MotherVO vo) {
        System.out.println("MyBatis의 helpers_list_show_inHTM을 실행합니다.");
        Integer result = mybatis.selectOne("MotherDAO_mybatis.helpers_list_show_inHTM", vo);
        return Optional.ofNullable(result).orElse(null);
    }//helpers_list_show_inHTM()-end


    public List<MotherVO> mother_mainPageHelperListSearchKeyword(MotherVO vo) {
        System.out.println("MyBatis의 mother_mainPageHelperListSearchKeyword을 실행합니다.");
        return mybatis.selectList("MotherDAO_mybatis.mother_mainPageHelperListSearchKeyword", vo);
    }//mother_mainPageHelperListSearchKeyword()-end

    public int mother_mainPageHelperNum(MotherVO vo) {
        System.out.println("MyBatis의 mother_mainPageHelperNum을 실행합니다.");
        return mybatis.selectOne("MotherDAO_mybatis.mother_mainPageHelperNum", vo);
    }//mother_mainPageHelperNum()-end


    public MotherVO getConnectionListhtm(MotherVO cvo){
        MotherVO result = mybatis.selectOne("MotherDAO_mybatis.getConnectionListhtm", cvo);
        if (result != null) {
            return result;
        } else {
            return null; // 결과가 없을 경우
        }
    }
    public MotherVO getConnectionListmth(MotherVO cvo){
        MotherVO result = mybatis.selectOne("MotherDAO_mybatis.getConnectionListmth", cvo);
        if (result != null) {
            return result;
        } else {
            return null; // 결과가 없을 경우
        }
    }

    public void updateNicknameRelationByhtm(MotherVO cvo){
        mybatis.update("MotherDAO_mybatis.updateNicknameRelationByhtm",cvo);
    }

    public void updateNicknameRelationBymth(MotherVO cvo){
        mybatis.update("MotherDAO_mybatis.updateNicknameRelationBymth",cvo);
    }




    public void helpers_list_delete(MotherVO vo) {
        System.out.println("MyBatis의 helpers_list_delete를 실행합니다.");
        int delete1 = mybatis.delete("MotherDAO_mybatis.helpers_list_delete1" ,vo);
        if(delete1 == 0) {
            mybatis.delete("MotherDAO_mybatis.helpers_list_delete2" ,vo);
        }
    }//helpers_list_delete()-end

    public List<MotherVO> helpers_invite_list(MotherVO vo) {
        System.out.println("MyBatis의 helpers_invite_list를 실행합니다.");
        return  mybatis.selectList("MotherDAO_mybatis.helpers_invite_list", vo);
    }//helpers_invite_list()-end

    public void invite_list_accept_invitation(MotherVO vo) {
        System.out.println("MyBatis의 invite_list_accept_invitation를 실행합니다.");
        mybatis.update("MotherDAO_mybatis.invite_list_accept_invitation", vo);
    }//invite_list_accept_invitation()-end

    public void after_invite_list_accept_invitation_to_delete_record_from_invite_list_HTM(MotherVO vo) {
        System.out.println("MyBatis의 after_invite_list_accept_invitation_to_delete_record_from_invite_list_HTM를 실행합니다.");
        mybatis.delete("MotherDAO_mybatis.after_invite_list_accept_invitation_to_delete_record_from_invite_list_HTM" ,vo);
    }//after_invite_list_accept_invitation_to_delete_record_from_invite_list_HTM()-end

    public void invite_HTM_refuse(MotherVO vo) {
        System.out.println("MyBatis의 invite_HTM_refuse를 실행합니다.");
        mybatis.delete("MotherDAO_mybatis.invite_HTM_refuse", vo);
    }//invite_HTM_refuse()-end

    public List<MotherVO> helpers_add_searchKeyword(MotherVO vo) {
        System.out.println("MyBatis의 helpers_add_searchKeyword를 실행합니다.");
        return mybatis.selectList("MotherDAO_mybatis.helpers_add_searchKeyword", vo);
    }//helpers_add_searchKeyword()-end

    public void helpers_add_helper(MotherVO vo) {
        System.out.println("MyBatis의 helpers_add_helper를 실행합니다.");
        mybatis.insert("MotherDAO_mybatis.helpers_add_helper", vo);
    }//helpers_add_helper()-end

    public List<MotherVO> helpers_list_add_chk_duplicatedId(MotherVO vo) {
        System.out.println("MyBatis의 helpers_list_add_chk_duplicatedId를 실행합니다.");
        return mybatis.selectList("MotherDAO_mybatis.helpers_list_add_chk_duplicatedId", vo);
    }//helpers_list_add_chk_duplicatedId()-end

    public MotherVO helpers_duplicatedId(MotherVO vo) {
        System.out.println("MyBatis의 helpers_list_add_chk_duplicatedId를 실행합니다.");
        return mybatis.selectOne("MotherDAO_mybatis.helpers_duplicatedId", vo);
    }//helpers_duplicatedId()-end

    public List<MotherVO> helpers_list_add_chk_addedId(MotherVO vo) {
        System.out.println("MyBatis의 helpers_list_add_chk_addedId를 실행합니다.");
        return mybatis.selectList("MotherDAO_mybatis.helpers_list_add_chk_addedId", vo);
    }//helpers_list_add_chk_addedId()-end

    public MotherVO helpers_addedId(MotherVO vo) {
        System.out.println("MyBatis의 helpers_addedId를 실행합니다.");
        return mybatis.selectOne("MotherDAO_mybatis.helpers_addedId", vo);
    }//helpers_addedId()-end

    public List<MotherVO> helpers_add_helper_list(MotherVO vo) {
        System.out.println("MyBatis의 helpers_add_helper_list를 실행합니다.");
        return mybatis.selectList("MotherDAO_mybatis.helpers_add_helper_list", vo);
    }//helpers_add_helper_list()-end

    public void helpers_add_cancel(MotherVO vo) {
        System.out.println("MyBatis의 helpers_add_cancel을 실행합니다.");
        mybatis.delete("MotherDAO_mybatis.helpers_add_cancel", vo);
    }//helpers_add_cancel()-end


    public void AButtonClick(MotherVO vo) {
        System.out.println("MyBatis의 AButtonClick을 실행합니다.");
        mybatis.update("MotherDAO_mybatis.AButtonClick", vo);
    }//AButtonClick()-end

    public MotherVO A_status_check(MotherVO vo) {
        System.out.println("MyBatis의 A_status_check을 실행합니다.");
        return mybatis.selectOne("MotherDAO_mybatis.A_status_check", vo);
    }//A_status_check()-end

    public void release_A_status(MotherVO vo) {
        System.out.println("MyBatis의 release_A_status을 실행합니다.");
        mybatis.delete("MotherDAO_mybatis.release_A_status", vo);
    }//release_A_status()-end


    public void BButtonClick(MotherVO vo) {
        System.out.println("MyBatis의 BButtonClick을 실행합니다.");
        mybatis.update("MotherDAO_mybatis.BButtonClick", vo);
    }//BButtonClick()-end

    public MotherVO B_status_check(MotherVO vo) {
        System.out.println("MyBatis의 B_status_check을 실행합니다.");
        return mybatis.selectOne("MotherDAO_mybatis.B_status_check", vo);
    }//B_status_check()-end

    public void release_B_status(MotherVO vo) {
        System.out.println("MyBatis의 release_B_status을 실행합니다.");
        mybatis.delete("MotherDAO_mybatis.release_B_status", vo);
    }//release_B_status()-end

    /* mother_daily_report 부분 */
    public List<MotherVO> mother_daily_report_info(MotherVO vo) {
        System.out.println("MyBatis의 mother_daily_report_info를 실행합니다.");
        return mybatis.selectList("MotherDAO_mybatis.mother_daily_report_info", vo);
    }//mother_daily_report_info()-end

    public List<MotherVO> mother_daily_report_month_count(MotherVO vo) {
        System.out.println("MyBatis의 mother_daily_report_month_count를 실행합니다.");
        return mybatis.selectList("MotherDAO_mybatis.mother_daily_report_month_count", vo);
    }//mother_daily_report_month_count()-end

    public void mother_daily_report_insert(MotherVO vo) {
        System.out.println("MyBatis의 mother_daily_report_insert를 실행합니다.");
        mybatis.insert("MotherDAO_mybatis.mother_daily_report_insert", vo);
    }//mother_daily_report_insert()-end

    public void mother_daily_report_update(MotherVO vo) {
        System.out.println("MyBatis의 mother_daily_report_update를 실행합니다.");
        mybatis.update("MotherDAO_mybatis.mother_daily_report_update", vo);
    }//mother_daily_report_update()-end

    public void mother_daily_report_delete(MotherVO vo) {
        System.out.println("MyBatis의 mother_daily_report_delete를 실행합니다.");
        mybatis.delete("MotherDAO_mybatis.mother_daily_report_delete", vo);
    }//mother_daily_report_delete()-end


    /* A 버튼 상황 시 문자보낼 전화번호 추출 */
    public List<MotherVO> selectHelper_tel_When_A_status(MotherVO vo){
        System.out.println("MyBatis의 selectHelper_tel_When_A_status를 실행합니다.");
        return mybatis.selectList("MotherDAO_mybatis.selectHelper_tel_When_A_status", vo);
    }//selectHelper_tel_When_A_status()-end


    /* B 버튼 상황 시 문자보낼 전화번호 추출 */
    public List<MotherVO> selectHelper_tel_When_B_status(MotherVO vo){
        System.out.println("MyBatis의 selectHelper_tel_When_B_status를 실행합니다.");
        return mybatis.selectList("MotherDAO_mybatis.selectHelper_tel_When_B_status", vo);
    }//selectHelper_tel_When_B_status()-end



    /* mother_health_report 부분 */
    public List<MotherVO> mother_health_report(MotherVO vo) {
        System.out.println("MyBatis의 mother_health_report를 실행합니다.");
        return mybatis.selectList("MotherDAO_mybatis.mother_health_report", vo);
    }//mother_health_report()-end




}//MotherDAO_mybatis()-end
