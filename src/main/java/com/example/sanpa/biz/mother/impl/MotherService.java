package com.example.sanpa.biz.mother.impl;

import com.example.sanpa.biz.mother.MotherVO;

import java.util.List;

public interface MotherService {
    public int preventTooManyResultsExceptionWhenEnterIntoMotherMainPageDueToEmergencyAlaram(MotherVO vo);
    public List<MotherVO> getMotherVO();
    public List<MotherVO> getBBtnStatus();
    public List<MotherVO> getABtnStatus();
    public MotherVO mother_mainPageInfo(MotherVO vo);
    public List<MotherVO> mother_mainPageHelperList(MotherVO vo);
    public List<MotherVO> mother_mainPageHelperListSearchKeyword(MotherVO vo);
    public int mother_mainPageHelperNum(MotherVO vo);
    public MotherVO getConnectionListhtm(MotherVO cvo);
    public MotherVO getConnectionListmth(MotherVO cvo);
    public void updateNicknameRelationByhtm(MotherVO cvo);
    public void updateNicknameRelationBymth(MotherVO cvo);
    public void AButtonClick(MotherVO vo);
    public void release_A_status(MotherVO vo);
    public void BButtonClick(MotherVO vo);
    public void release_B_status(MotherVO vo);
    public void helpers_list_delete(MotherVO vo);
    public List<MotherVO> helpers_invite_list(MotherVO vo);
    public void invite_list_accept_invitation(MotherVO vo);
    public void invite_HTM_refuse(MotherVO vo);
    public List<MotherVO> helpers_add_searchKeyword(MotherVO vo);
    public void helpers_add_helper(MotherVO vo);
    public void helpers_add_cancel(MotherVO vo);

    /* mother_daily_report 부분 */
    public List<MotherVO> mother_daily_report_info(MotherVO vo);
    public List<MotherVO> mother_daily_report_month_count(MotherVO vo);
    public void mother_daily_report_insert (MotherVO vo);
    public void mother_daily_report_update (MotherVO vo);
    public void mother_daily_report_delete (MotherVO vo);

    /* 버튼 상황 발동 시 문자보낼 전화번호 추출 */
    public List<MotherVO> selectHelper_tel_When_A_status(MotherVO vo);
    public List<MotherVO> selectHelper_tel_When_B_status(MotherVO vo);

    /* mother_health_report 부분 */
    public List<MotherVO> mother_health_report(MotherVO vo);


}
