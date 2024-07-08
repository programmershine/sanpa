package com.example.sanpa.view;

import com.example.sanpa.biz.helper.HelperVO;
import com.example.sanpa.biz.mother.MotherVO;
import com.example.sanpa.biz.non_helper.impl.SanpaDAO_mybatis;
import com.example.sanpa.biz.non_helper.impl.SanpaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@RestController
public class SanpaLoginController {

    @Autowired
    private SanpaService sanpaService;

    @Autowired
    private SanpaDAO_mybatis sanpaDAO;

    @PostMapping("/login")
    public ResponseEntity<HelperVO> login(@RequestBody HelperVO vo, HttpSession session) {
        HelperVO result = sanpaDAO.login(vo);
        if (result != null) {
            // 로그인 성공 시 세션에 아이디 설정
            session.setAttribute("helper_id", result.getHelper_id());
            session.setAttribute("helper_status", result.getHelper_status()); // helper_status도 세션에 저장
            session.setAttribute("helper_name", result.getHelper_name());


            MotherVO result2 = sanpaDAO.findMotherByHelperId(vo);
            // mother table에서 helper_id와 일치하는 행을 찾음
            if (result2 != null && result.getHelper_id() == result2.getMother_id()) {
                // mother_babyName 값을 세션에 저장
                session.setAttribute("mother_babyName", result2.getMother_babyName());
            }



            // 로그인 성공 응답 반환
            return ResponseEntity.ok(result);
        } else {
            // 로그인 실패 시 실패 이유와 함께 응답 반환
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }


    }


}