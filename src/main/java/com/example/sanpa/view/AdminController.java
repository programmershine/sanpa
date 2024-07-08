package com.example.sanpa.view;

import com.example.sanpa.biz.admin.impl.AdminService;
import com.example.sanpa.biz.helper.HelperVO;
import com.example.sanpa.biz.helper.impl.HelperService;
import com.example.sanpa.biz.mother.MotherVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AdminController {

    @Autowired
    AdminService adminService;

    @Autowired
    HelperService helperService;


    @ModelAttribute("conditionMap")
    public Map<String, String> searchConditionMap() {
        Map<String, String> conditionMap = new LinkedHashMap<>();
        conditionMap.put("유저목록", "userList");
        conditionMap.put("헬퍼목록", "helperList");
        conditionMap.put("산모목록", "motherList");
        return conditionMap;
    }

    @ModelAttribute("conditionMap2")
    public Map<String, String> searchConditionMap2() {
        Map<String, String> conditionMap2 = new LinkedHashMap<>();
        conditionMap2.put("모든버튼", "allButtonList");
        conditionMap2.put("A 버튼", "AButtonList");
        conditionMap2.put("B 버튼", "BButtonList");
        return conditionMap2;
    }

    @GetMapping("admin_dashboard")
    public String admin_dashboard() {
        return "admin/dashboard";
    }




    @GetMapping("admin_motherDetail")
    public String admin_helperDetail(MotherVO vo, Model model) {
        model.addAttribute("motherBox1", adminService.motherDetailBox1(vo));
        model.addAttribute("motherBox2", adminService.motherDetailBox2(vo));
        model.addAttribute("motherBox3", adminService.motherDetailBox3(vo));
        return "admin/motherDetail";
    }//admin_helperDetail()-end



    @GetMapping("admin_listAllMember")
    public String listAllMember(HelperVO vo ,Model model) {
        if(vo.getSearchCondition() == null) {
            vo.setSearchCondition("userList");
        }
        model.addAttribute("helperVO", helperService.helperVO());
        return "admin/listAllMember";
    }

    @PostMapping("admin_changeListMember")
    @ResponseBody
    public List<HelperVO> changeListMember(HelperVO vo) {
        if(vo.getSearchCondition().equals("userList")) {
            return helperService.helperVO();
        } else if(vo.getSearchCondition().equals("helperList")) {
            return helperService.getHelperList();
        } else if(vo.getSearchCondition().equals("motherList")) {
            return helperService.getMotherList();
        }
        return new ArrayList<>();
    }

    @PostMapping("admin_searchListMember")
    @ResponseBody
    public List<HelperVO> searchListMember(@RequestParam("searchKeyword") String searchKeyword) {
        if(searchKeyword != null) {
            return helperService.getSearchKeyword(searchKeyword);
        }
        return new ArrayList<>();
    }


    @GetMapping("/admin_motherHealthReport")
    public String motherHealthReport(MotherVO vo, Model model) {
        model.addAttribute("motherHealthReport", adminService.motherHealthReport(vo));
        model.addAttribute("motherInfo", adminService.motherInfo(vo));
        return "admin/motherHealthReport";
    }


    @GetMapping("/admin_buttonStatus")
    public String buttonStatus(MotherVO vo,Model model) {
        if(vo.getSearchCondition() == null) {
            vo.setSearchCondition("allButtonList");
        }
        model.addAttribute("buttonStatus", adminService.buttonStatus());

//        model.addAttribute("aButtonStatus", adminService.aButtonStatus());
//        model.addAttribute("bButtonStatus", adminService.bButtonStatus());
        return "admin/buttonStatus";
    }


    @PostMapping("admin_changeButtonList")
    @ResponseBody
    public List<MotherVO> changeButtonList(MotherVO vo) {
        if(vo.getSearchCondition().equals("allButtonList")) {
            return adminService.buttonStatus();
        } else if(vo.getSearchCondition().equals("AButtonList")) {
            return adminService.aButtonStatus();
        } else if(vo.getSearchCondition().equals("BButtonList")) {
            return adminService.bButtonStatus();
        }
        return new ArrayList<>();
    }

    @PostMapping("admin_searchButtonList")
    @ResponseBody
    public List<MotherVO> searchButtonList(@RequestParam("searchKeyword") String searchKeyword) {
        if(searchKeyword != null) {
            return adminService.searchButtonList(searchKeyword);
        }
        return new ArrayList<>();
    }


}//AdminController()-end
