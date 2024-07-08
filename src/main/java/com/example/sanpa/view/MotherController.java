package com.example.sanpa.view;

import com.example.sanpa.biz.helper.HelperVO;
import com.example.sanpa.biz.helper.impl.HelperService;
import com.example.sanpa.biz.mother.MotherVO;
import com.example.sanpa.biz.mother.impl.MotherDAO_mybatis;
import com.example.sanpa.biz.mother.impl.MotherService;
import com.example.sanpa.biz.non_helper.impl.SanpaService;
import com.example.sanpa.view.helper.CoolsmsService;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.beans.Transient;
import java.util.List;

@Controller
public class MotherController {

    @Autowired
    HelperService helperService;
    @Autowired
    MotherService motherService;
    @Autowired
    MotherDAO_mybatis motherDAO_mybatis;
    @Autowired
    SanpaService sanpaService;
    @Autowired
    CoolsmsService coolsmsService;




    @GetMapping("/mother_myPage")
    public String mother_myPage(MotherVO mvo, HelperVO vo, Model model, HttpSession session) {
        String helper_id = (String)session.getAttribute("helper_id");
        if(helper_id != null) {
            vo.setHelper_id(helper_id);
            HelperVO helper = helperService.helper_setUpdateForm(vo);
            model.addAttribute("helper", helper);
            mvo.setMother_id(helper_id);
            model.addAttribute("chk", motherService.preventTooManyResultsExceptionWhenEnterIntoMotherMainPageDueToEmergencyAlaram(mvo));
            model.addAttribute("mother", motherService.mother_mainPageInfo(mvo));
            return "mother/myPage";
        }
        return "redirect:login";
    }



    @GetMapping("/mother_myask")
    public String mother_myask(MotherVO mvo, HelperVO vo, Model model, HttpSession session) {
        String helper_id = (String)session.getAttribute("helper_id");

        return "mother/motherMyAsk";
    }

    @GetMapping("/mother_myaskdetail")
    public String mother_myaskdetail(MotherVO mvo, HelperVO vo, Model model, HttpSession session) {
        String helper_id = (String)session.getAttribute("helper_id");

        return "mother/motherMyAskDetail";
    }

    @GetMapping("/mother_subscribe")
    public String mother_subscribe(MotherVO mvo, HelperVO vo, Model model, HttpSession session) {
        String helper_id = (String)session.getAttribute("helper_id");

        return "mother/subscribe";
    }

    @GetMapping("/mother_ask")
    public String mother_ask(MotherVO mvo, HelperVO vo, Model model, HttpSession session) {
        String helper_id = (String)session.getAttribute("helper_id");

        return "mother/motherAsk";
    }


    @PostMapping("/mother_setUpdateForm")
    public String helper_update(@Valid HelperVO vo,@Valid MotherVO vo2 , HttpSession session, Model model) {
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
            return "mother/update";
        } else {
            return null;
        }
    }

    @PostMapping("/mother_update")
    public String helper_update(@Valid HelperVO vo, @Valid MotherVO vo2) {
        if(vo != null) {
            helperService.helper_update(vo);
            sanpaService.insertMother(vo2);

            return "redirect:/mother_myPage";
        }
        return null;
    }


    @GetMapping("/changeMotherToHelper")
    public String changeMotherToHelper(HelperVO vo, HttpSession session, Model model) {
        String helper_id = (String)session.getAttribute("helper_id");
        vo.setHelper_id(helper_id);
        HelperVO helper = helperService.helper_setUpdateForm(vo);
            model.addAttribute("helper", helper);
            return "redirect:/getButtonList";

    }


    @GetMapping("/dismissMother")
    public String dismissMother(HelperVO vo, HttpSession session) {
        String helper_id = (String)session.getAttribute("helper_id");
        vo.setHelper_id(helper_id);
        helperService.mother_dismissMother(vo);
        return "redirect:helper_myPage";
    }

    @GetMapping("/helpers_list")
    public String helpers_list(MotherVO vo, Model model, HttpSession session) {
        String helper_id = (String)session.getAttribute("helper_id");
        vo.setMother_id(helper_id);
        List<MotherVO> helper = motherService.mother_mainPageHelperList(vo);
        model.addAttribute("helperInfo", helper);
        model.addAttribute("numOfInHTM", motherDAO_mybatis.helpers_list_show_inHTM(vo));
        return "mother/helpers_list";
    }

    @PostMapping("/helperListSearchKeyword")
    public String helperListSearchKeyword(MotherVO vo, Model model, HttpSession session) {
        String helper_id = (String)session.getAttribute("helper_id");
        vo.setMother_id(helper_id);
        if(vo.getSearchKeyword() != null) {
            List<MotherVO> helper = motherService.mother_mainPageHelperListSearchKeyword(vo);
            model.addAttribute("numOfInHTM", motherDAO_mybatis.helpers_list_show_inHTM(vo));
            model.addAttribute("helperInfo", helper);
            return "mother/helpers_list";
        }
        return null;
    }

    @GetMapping("/helpers_list_edit")
    public String helpers_list_edit(MotherVO vo, Model model, HttpSession session) {
        String helper_id = (String)session.getAttribute("helper_id");
        vo.setMother_id(helper_id);
        List<MotherVO> helper = motherService.mother_mainPageHelperList(vo);
        model.addAttribute("helperInfo", helper);
        return "mother/helpers_list_edit";
    }//helpers_list_edit()-end

    @PostMapping("/helpers_list_edit")
    public String helpers_List_edit(MotherVO vo, HttpServletRequest request) {

        int itemCount = Integer.parseInt(request.getParameter("itemCount"));

        // 리스트들의 크기만큼 반복
        for (int i = 0; i < itemCount; i++) {
            MotherVO newCvo = new MotherVO();
            newCvo.setHelper_id( request.getParameter("helper_id"+i));
            newCvo.setMother_id( request.getParameter("mother_id"+i));

            // nicknameOfHelper와 relation이 null인 경우를 처리
            String nicknameOfHelper = request.getParameter("nicknameOfHelper"+i);
            String relation = request.getParameter("relation"+i);
            newCvo.setNicknameOfHelper(nicknameOfHelper != null ? nicknameOfHelper : "");
            newCvo.setRelation(relation != null ? relation : "");


            String helperId = newCvo.getHelper_id();
            // if문에서 helperId를 어떻게 가져와서 사용할 것인지에 따라서 아래 로직을 수정해야 합니다.
            MotherVO cvo2 = motherService.getConnectionListhtm(newCvo);
            MotherVO cvo3 = motherService.getConnectionListmth(newCvo);
            try {
                if (cvo2 != null && helperId.equals(cvo2.getHelper_id())) {
                    motherService.updateNicknameRelationByhtm(newCvo);
                } else if (cvo3 != null && helperId.equals(cvo3.getHelper_id())) {
                    motherService.updateNicknameRelationBymth(newCvo);
                }
            } catch (NullPointerException e) {
                // NullPointerException 예외 처리
                // 예외가 발생하면 로그를 출력하고, 필요에 따라서 다른 처리를 추가할 수 있습니다.
                e.printStackTrace();
            }
        }

        return "redirect:/helpers_list";
    }



    @PostMapping("/helpers_list_delete")
    public String helpers_list_delete(MotherVO vo) {
        String helper_id = vo.getHelper_id();
        String mother_id = vo.getMother_id();
       motherService.helpers_list_delete(vo);
        return "redirect:/helpers_list";
    }

    @PostMapping("/helperListEditSearchKeyword")
    public String helperListEditSearchKeyword(MotherVO vo, Model model, HttpSession session) {
        String helper_id = (String)session.getAttribute("helper_id");
        vo.setMother_id(helper_id);
        if(vo.getSearchKeyword() != null) {
            List<MotherVO> helper = motherService.mother_mainPageHelperListSearchKeyword(vo);
            model.addAttribute("helperInfo", helper);
            return "mother/helpers_list";
        }
        return null;
    }

    @GetMapping("/mother_helpers_invite_list")
    public String helpers_invite_list(MotherVO vo, Model model, HttpSession session) {
        String helper_id = (String)session.getAttribute("helper_id");
        vo.setMother_id(helper_id);
        model.addAttribute("helperInfo", motherService.helpers_invite_list(vo));
        return "mother/helpers_invite_list";
    }//helpers_invite_list()-end

    @Transient
    @PostMapping("/helpers_invite_list_accept_invitation")
    public String invite_list_accept_invitation(MotherVO vo) {
        motherService.invite_list_accept_invitation(vo);
        motherDAO_mybatis.after_invite_list_accept_invitation_to_delete_record_from_invite_list_HTM(vo);
        return "redirect:/mother_helpers_invite_list";
    }

    @PostMapping("/helpers_invite_HTM_refuse")
    public String invite_HTM_refuse(MotherVO vo) {
        String helper_id = vo.getHelper_id();
        String mother_id = vo.getMother_id();
        motherService.invite_HTM_refuse(vo);
        return "redirect:/mother_helpers_invite_list";
    }

    @GetMapping("/helpers_add")
    public String helpers_add(HttpSession session, MotherVO vo, Model model) {
        String helper_id = (String)session.getAttribute("helper_id");
        vo.setMother_id(helper_id);
        model.addAttribute("helperAddList", motherDAO_mybatis.helpers_add_helper_list(vo));
        return "mother/helpers_add";
    }

    @PostMapping("/helpers_add_searchKeyword")
    public String helpers_add_searchKeyword(MotherVO vo, Model model) {

        model.addAttribute("helperInfo_duplicatedId", motherDAO_mybatis.helpers_list_add_chk_duplicatedId(vo));
        model.addAttribute("helperInfo_addedId", motherDAO_mybatis.helpers_list_add_chk_addedId(vo));
        model.addAttribute("helperInfo", motherService.helpers_add_searchKeyword(vo));
        model.addAttribute("dupped", motherDAO_mybatis.helpers_duplicatedId(vo));
        model.addAttribute("added", motherDAO_mybatis.helpers_addedId(vo));



        return "mother/helpers_add";
    }

    @PostMapping("/helpers_add_helper")
    public String helpers_add_helper(MotherVO vo) {
        motherService.helpers_add_helper(vo);
        return "redirect:/helpers_add";
    }//helpers_add_helper()-end

    @PostMapping("/helpers_add_cancel")
    public String helpers_add_cancel(MotherVO vo) {
        motherService.helpers_add_cancel(vo);
        return "redirect:/helpers_add";
    }//helpers_add_cancel()-end



    @GetMapping("/AButtonClick")
    public String AButtonClick(MotherVO vo, HttpSession session) throws NurigoMessageNotReceivedException{
        try {
            String mother_id = (String)session.getAttribute("helper_id");
            vo.setMother_id(mother_id);
            motherService.AButtonClick(vo);

//            List<MotherVO> telList = motherService.selectHelper_tel_When_A_status(vo);
//            if (telList != null && !telList.isEmpty()) {
//                coolsmsService.sendAStatusToMany(telList);
//                coolsmsService.getBalance();
//            } // 이거 주석 풀면 버튼 누를때 친구들한테 문자 보내짐 돈 많이 들어감!!!! 함부로 풀지마요!!!

        } catch (Exception e) {
            e.printStackTrace();;
        }//try~catch()-end
        return "redirect:/mother_A_status";
    }//AButtonClick()-end


    @GetMapping("/mother_A_status")
    public String mother_A_status(MotherVO vo, HttpSession session,Model model) {
        String mother_id = (String)session.getAttribute("helper_id");
        vo.setMother_id(mother_id);
        model.addAttribute("mother", motherService.mother_mainPageInfo(vo));
        model.addAttribute("mother2", motherService.mother_mainPageHelperNum(vo));
        return "mother/mother_A_status";
    }//mother_A_status()-end

    @GetMapping("/release_A_status")
    public String release_A_status(MotherVO vo, HttpSession session) {
        String mother_id = (String)session.getAttribute("helper_id");
        vo.setMother_id(mother_id);
        motherService.release_A_status(vo);
        return "redirect:/login_move";
    }//release_B_status()-end

    @GetMapping("/BButtonClick")
    public String BButtonClick(MotherVO vo, HttpSession session) throws NurigoMessageNotReceivedException{
        try {
            String mother_id = (String)session.getAttribute("helper_id");
            vo.setMother_id(mother_id);
            motherService.BButtonClick(vo);

//            List<MotherVO> telList = motherService.selectHelper_tel_When_B_status(vo);
//            if (telList != null && !telList.isEmpty()) {
//                coolsmsService.sendBStatusToMany(telList);
//                coolsmsService.getBalance();
//            } // 이거 주석 풀면 버튼 누를때 친구들한테 문자 보내짐 돈 많이 들어감!!!! 함부로 풀지마요!!!

        } catch (Exception e) {
            e.printStackTrace();;
        }//try~catch()-end
        return "redirect:/mother_B_status";
    }//AButtonClick()-end

    @GetMapping("/mother_B_status")
    public String mother_B_status(MotherVO vo, HttpSession session,Model model) {
        String mother_id = (String)session.getAttribute("helper_id");
        vo.setMother_id(mother_id);
        model.addAttribute("mother", motherService.mother_mainPageInfo(vo));
        model.addAttribute("mother2", motherService.mother_mainPageHelperNum(vo));
        return "mother/mother_B_status";
    }//mother_B_status()-end

    @GetMapping("/release_B_status")
    public String release_B_status(MotherVO vo, HttpSession session) {
        String mother_id = (String)session.getAttribute("helper_id");
        vo.setMother_id(mother_id);
        motherService.release_B_status(vo);
        return "redirect:/login_move";
    }//release_B_status()-end

    /* mother_daily_report 페이지 */
    @GetMapping("/mother_daily_report")
    public String mother_daily_report(MotherVO vo, Model model, HttpSession session) {
        String mother_id = (String)session.getAttribute("helper_id");
        vo.setMother_id(mother_id);
        model.addAttribute("motherInfo", motherService.mother_daily_report_info(vo));
        model.addAttribute("motherInfo_month", motherService.mother_daily_report_month_count(vo));
        model.addAttribute("mother", motherService.mother_mainPageInfo(vo));
        return "mother/daily_report";
    }//mother_daily_report()-end

    @PostMapping("/mother_daily_report_insert")
    public String mother_daily_report_insert(MotherVO vo, HttpSession session) {
        String mother_id = (String)session.getAttribute("helper_id");
        vo.setMother_id(mother_id);
            motherService.mother_daily_report_insert(vo);
        return "redirect:/mother_daily_report";
    }//mother_daily_report_update()-end

    @PostMapping("/mother_daily_report_update")
    public String mother_daily_report_update(MotherVO vo, HttpSession session) {
        String mother_id = (String) session.getAttribute("helper_id");
        vo.setMother_id(mother_id);
        motherService.mother_daily_report_update(vo);
        return "redirect:/mother_daily_report";
    }

    @PostMapping("/mother_daily_report_delete")
    public String mother_daily_report_delete(MotherVO vo, HttpSession session) {
        String mother_id = (String) session.getAttribute("helper_id");
        vo.setMother_id(mother_id);
        motherService.mother_daily_report_delete(vo);
        return "redirect:/mother_daily_report";
    }//mother_daily_report_delete()-end


    /* mother_health_report 부분 */
    @GetMapping("/mother_health_report")
    public String mother_health_report(MotherVO vo, HttpSession session, Model model) {
        String mother_id = (String) session.getAttribute("helper_id");
        vo.setMother_id(mother_id);
        model.addAttribute("motherInfo", motherService.mother_mainPageInfo(vo));
        model.addAttribute("mother_healthInfo", motherService.mother_health_report(vo));
        return "mother/mother_health_report";
    }









}//MotherController()-end
