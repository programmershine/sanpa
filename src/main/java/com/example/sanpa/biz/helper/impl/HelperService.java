package com.example.sanpa.biz.helper.impl;

import com.example.sanpa.biz.helper.HelperVO;
import com.example.sanpa.biz.mother.MotherVO;

import java.util.List;

public interface HelperService {

    public HelperVO helper_setUpdateForm(HelperVO vo);
    public MotherVO mother_setUpdateForm(MotherVO vo2);
    public void helper_update(HelperVO vo);
    public MotherVO changeHelperToMother(MotherVO vo2);
    public void mother_dismissMother(HelperVO vo);
    public List<HelperVO> helperVO();
    public List<HelperVO> getHelperList();
    public List<HelperVO> getMotherList();
    public List<HelperVO> getSearchKeyword(String searchKeyword);
    //친구요청 거절
    public void refuseInvite(HelperVO vo);

    //친구요청 수락하고 삭제처리
    public void acceptInvite(HelperVO vo);

    //중복 체크(친구요청테이블)
    public boolean isExistInvite(HelperVO vo);
    //친구요청보내기
    public void insertInvite(HelperVO vo);

    //받은요청목록조회
    public List<HelperVO> getInvitationList(HelperVO vo);
    // 중복 체크(connection_list_htm)
    public boolean isExistInConnectionListHtm(String helper_id, String mother_id);
    public boolean isExistInConnectionListMth(String helper_id, String mother_id);

    //산모목록삭제
    public void deleteSanmoListFromHtm(String helper_id, String mother_id);

    public void deleteSanmoListFromMth(String helper_id, String mother_id);

    //산모검색
    public HelperVO getSanmoByPhoneNumber(String phoneNumber);

    //산모리스트
    public List<HelperVO> getSanmoListWithReports(HelperVO vo);

    //이멀전시 리스트
    public List<HelperVO> getButtonList(HelperVO vo);

    public HelperVO getMotherName(HelperVO vo);

    public void dismissSanpa(HelperVO vo);


}
