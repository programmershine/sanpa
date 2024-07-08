package com.example.sanpa.view;

import com.example.sanpa.biz.helper.HelperVO;
import com.example.sanpa.biz.helper.impl.HelperService;
import com.example.sanpa.biz.mother.MotherVO;
import com.example.sanpa.biz.non_helper.impl.SanpaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class HelperController {

    @Autowired
    HelperService helperService;

    @Autowired
    SanpaService sanpaService;


    @GetMapping("/helper_mainPage")
    public String helper_mainPage(HelperVO vo, Model model, HttpSession session) {
        String helper_id = (String)session.getAttribute("helper_id");
        vo.setHelper_id(helper_id);
        HelperVO helper = helperService.helper_setUpdateForm(vo);
        model.addAttribute("helper", helper);
        return "helper/mainPage";
    }




    @GetMapping("/helper_myPage")
    public String helper_myPage(HelperVO vo, Model model, HttpSession session) {
        String helper_id = (String)session.getAttribute("helper_id");
        if(helper_id != null) {
            vo.setHelper_id(helper_id);
            HelperVO helper = helperService.helper_setUpdateForm(vo);
            model.addAttribute("helper", helper);
            return "helper/myPage";
        }
        return "redirect:login";
    }

    @GetMapping("/helper_subscribe")
    public String helper_subscribe(HttpSession session, Model model, HelperVO vo) {
        String helper_id = (String)session.getAttribute("helper_id");
        vo.setHelper_id(helper_id);
        HelperVO helper = helperService.helper_setUpdateForm(vo);
        model.addAttribute("helper", helper);
        return "helper/subscribe";
    }


    @GetMapping("/helper_ask")
    public String helper_ask(HttpSession session) {
        return "helper/helperAsk";
    }

    @GetMapping("/helper_myask")
    public String helper_myask(HttpSession session) {
        return "helper/helperMyAsk";
    }

    @GetMapping("/helper_myaskdetail")
    public String helper_myaskdetail() {
        return "helper/helperMyAskDetail";
    }
    @PostMapping("/helper_setUpdateForm")
    public String helper_update(HelperVO vo, MotherVO vo2 , HttpSession session, Model model) {
        String helper_id = (String)session.getAttribute("helper_id");
        if(helper_id.equals(vo.getHelper_id())) {
            // 헬퍼의 정보를 가져와 뿌리기
            vo.setHelper_id(helper_id);
            HelperVO helper = helperService.helper_setUpdateForm(vo);
            model.addAttribute("helper", helper);

            // 산모의 정보를 가져와 뿌리기
            vo2.setHelper_id(helper_id);
            MotherVO mother = helperService.mother_setUpdateForm(vo2);
            model.addAttribute("mother", mother);

            return "helper/update";
        } else {
            return null;
        }
    }


    @PostMapping("/helper_update")
    public String helper_update(HelperVO vo, MotherVO vo2, HttpSession session) {
        if(vo != null) {
            String helper_id = (String)session.getAttribute("helper_id");
            vo.setHelper_id(helper_id);
            helperService.helper_update(vo);
            sanpaService.insertMother(vo2);
            return "redirect:helper_myPage";
        }
        return null;
    }


    @GetMapping("/changeHelperToMother")
    public String changeHelperToMother(HelperVO vo, HttpSession session, Model model) {
        String helper_id = (String)session.getAttribute("helper_id");
        vo.setHelper_id(helper_id);
        HelperVO helper = helperService.helper_setUpdateForm(vo);
        model.addAttribute("helper", helper);
        if(helper.getHelper_status()==1) {
            session.setAttribute("helper_status", helper.getHelper_status());
            return "redirect:/login_move";
        }

        return null;
    }



    @GetMapping("/logout")
    public String logout(HttpSession session) {

        if(session.getAttribute("helper_id") != null) {
            session.invalidate();
            return "redirect:/";
        }
        return null;
    }

    //친구요청 거절
    @GetMapping("/refuse.do")
    public  String refuseRequest(Model model, HelperVO vo, HttpSession session, @RequestParam("id") String mother_id){
        String helper_id = (String)session.getAttribute("helper_id");
        vo.setHelper_id(helper_id);
        vo.setMother_id(mother_id);
        if (helperService.isExistInvite(vo)) {
            // 해당되는 데이터가 있으면 삭제처리
            helperService.refuseInvite(vo);
        }
        return "redirect:/invitationList"; //다시 받은요청페이지
    }
    //받은친구요청 수락하기
    @GetMapping("/accept.do")
    public String acceptRequest(Model model, HelperVO vo, HttpSession session, @RequestParam("id") String mother_id){
        String helper_id = (String)session.getAttribute("helper_id");
        if(helper_id != null && mother_id !=null){
            vo.setHelper_id(helper_id);
            vo.setMother_id(mother_id);
            //invite_list테이블에 있는지 확인
            if (helperService.isExistInvite(vo)) {
                // 해당되는 데이터가 있으면 수락 처리 및 삭제처리
                helperService.acceptInvite(vo);
                return "redirect:/invitationList"; //다시 받은요청페이지
            }
        }//if_end
        return null;
    }
    //친구요청보내기
    @GetMapping("/invite.do")
    public String addSamo(Model model, HelperVO vo, HttpSession session, @RequestParam("id") String mother_id){
        String helper_id = (String)session.getAttribute("helper_id");

        vo.setHelper_id(helper_id);
        vo.setMother_id(mother_id);

        // 중복 확인
        if (!helperService.isExistInvite(vo)) {
            // 중복이 없으면 삽입
            helperService.insertInvite(vo);
            return "helper/inviteSucess";
        }else{
            //중복있으면
            model.addAttribute("errorMessage", "이미 요청을 보냈거나, 등록이 되어있습니다.");
            return "helper/searchSanmo";
        }


    }


    //삭제하기: connection_list_htm 과 mth 테이블에서 해당 helper_id, mother_id
    @GetMapping("/delete.do")
    public String deleteSanmoList(HttpSession session,@RequestParam("id") String mother_id){
        try {
            String helper_id = (String) session.getAttribute("helper_id");

            // connection_list_htm 테이블에서 해당 행이 있는지 조회
            boolean isExistInHtm = helperService.isExistInConnectionListHtm(helper_id, mother_id);

            // connection_list_mth 테이블에서 해당 행이 있는지 조회
            boolean isExistInMth = helperService.isExistInConnectionListMth(helper_id, mother_id);

            // 행이 존재하는 테이블을 특정하여 삭제 수행
            if (isExistInHtm) {
                helperService.deleteSanmoListFromHtm(helper_id, mother_id);
            } else if (isExistInMth) {
                helperService.deleteSanmoListFromMth(helper_id, mother_id);
            }

        } catch (Exception e) {
            // 예외 처리
            e.printStackTrace();
        }
        return "redirect:/sanmoz";
    }

    //받은 요청리스트 조회
    @GetMapping("/invitationList")
    public String invitationList(HttpSession session, Model model, HelperVO vo){
        //helper_id로 invite_list테이블 조회해서 accept=0인 테이블리스트 조회
        String helper_id = (String)session.getAttribute("helper_id");
        if(helper_id != null) {
            vo.setHelper_id(helper_id);
            List<HelperVO> inviteList = helperService.getInvitationList(vo);
            model.addAttribute("inviteList", inviteList);

            return "helper/invite_list";
        }
        return null;
    }


    //전화번호로 산모 검색
    @PostMapping("/search.do")
    public String searchSanmo(@RequestParam("phoneNumber") String phoneNumber, HttpSession session, Model model, RedirectAttributes redirectAttributes){
        // 전화번호로 산모 정보 검색
        HelperVO sanmo = helperService.getSanmoByPhoneNumber(phoneNumber);

        if (sanmo != null) {
            model.addAttribute("searchResult", sanmo);
        } else {
            // 검색된 산모가 없을 경우
            redirectAttributes.addFlashAttribute("errorMessage", "해당 전화번호로 등록된 산모가 없습니다.");


        }
        return "helper/searchSanmo";
    }

    //산모추가 클릭시 산모검색페이지 이동
    @GetMapping("/searchPage")
    public String goToSearch(){

        return "helper/searchSanmo";
    }
    //footer 산모즈 클릭시 산모리스트 출력
    @GetMapping("/sanmoz")
    public String helper_sanmoList(HelperVO vo, Model model, HttpSession session){
        String helper_id = (String)session.getAttribute("helper_id");
        if(helper_id != null) {
            vo.setHelper_id(helper_id);

            List<HelperVO> motherList = helperService.getSanmoListWithReports(vo);

            model.addAttribute("motherList", motherList);

            // 각 mother_id에 대한 getMotherName 결과를 리스트로 저장
            List<HelperVO> motherNameList = new ArrayList<>();
            for (HelperVO button : motherList) {
                vo.setHelper_id(button.getMother_id());
                HelperVO sanmoName = helperService.getMotherName(vo);
                motherNameList.add(sanmoName);
            }
            model.addAttribute("motherNameList", motherNameList);

            return "helper/sanmoList";
        }
        return "non_helper/index";
    }
    @GetMapping("/getButtonList")
    public String getButtonList(HelperVO vo, Model model, HttpSession session){
        String helper_id = (String)session.getAttribute("helper_id");
        vo.setHelper_id(helper_id);
        List<HelperVO> buttonList = helperService.getButtonList(vo);
        model.addAttribute("buttonList", buttonList);

        // 각 mother_id에 대한 getMotherName 결과를 리스트로 저장
        List<HelperVO> motherNameList = new ArrayList<>();
        for (HelperVO button : buttonList) {
            vo.setHelper_id(button.getMother_id());
            HelperVO sanmoName = helperService.getMotherName(vo);
            motherNameList.add(sanmoName);
        }
        model.addAttribute("motherNameList", motherNameList);

        return "helper/mainPage";

    }

    @GetMapping("/dismissSanpa")
    public String dismissSanpa(HelperVO vo, HttpSession session) {
        String helper_id = (String)session.getAttribute("helper_id");
        vo.setHelper_id(helper_id);
        helperService.dismissSanpa(vo);
        return "redirect:/";
    }//dismissSanpa()-end

    //이동
    @GetMapping("/premium")
    public String goToPremium(){
        return "helper/premium";
    }
    //tip이동
    @GetMapping("/tip")
    public String goToTip(){
        return "helper/tip";
    }




}//HelperController()-end
