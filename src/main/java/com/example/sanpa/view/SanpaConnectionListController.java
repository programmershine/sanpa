package com.example.sanpa.view;

import com.example.sanpa.biz.ConnectionVO;
import com.example.sanpa.biz.helper.HelperVO;
import com.example.sanpa.biz.helper.impl.HelperService;
import com.example.sanpa.biz.mother.impl.MotherService;
import com.example.sanpa.biz.non_helper.impl.SanpaDAO_mybatis;
import com.example.sanpa.biz.non_helper.impl.SanpaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/data")
public class SanpaConnectionListController {

    @Autowired
    private SanpaService sanpaService;

    @Autowired
    private SanpaDAO_mybatis sanpaDAO;

    @Autowired
    private MotherService motherService;
    @Autowired
    private HelperService helperService;

    @PostMapping("connectionList")
    public ResponseEntity<List<ConnectionVO>> connectionList(@RequestBody ConnectionVO cvo) {
        List<ConnectionVO> result = sanpaDAO.connectionList(cvo);
        return ResponseEntity.ok(result);
    }



    //헬퍼가 산모 위치동의 변경
    @PostMapping("updateLocationAllowhtm.do")
    public String updateLocationAllowhtm(@RequestBody Map<String, Object> payload,
                                         HttpSession session) {
        String mother_id = (String) payload.get("motherId");
        int allowLocation = (int) payload.get("locationallowhtm");

        System.out.println("updateLocationAllow.do 컨트롤러");
        String helper_id = (String) session.getAttribute("helper_id");

        ConnectionVO cvo = new ConnectionVO();
        cvo.setHelper_id(helper_id);
        cvo.setMother_id(mother_id);
        cvo.setLocationallowhtm(allowLocation);
        String tableName = sanpaService.selectTableName(cvo);
        cvo.setTableName(tableName);

        // 받아온 테이블명을 사용하여 updateLocationAllow 메서드 호출하여 업데이트 수행
        if (tableName != null) {
            System.out.println("테이블명을 받아와서 업데이트 실행"+tableName);
            sanpaService.updateLocationAllowHtm(cvo);
        } else {
            System.out.println("테이블명을 가져오지 못했습니다.");
            // 실패 처리 또는 리다이렉트 등을 수행할 수 있습니다.
        }

        return "redirect:/sanmoz"; // 업데이트 후 리다이렉트할 페이지 경로
    }
    //산모가 헬퍼에 대한 위치동의 변경
    @PostMapping("updateLocationAllowmth.do")
    public String updateLocationAllowmth(@RequestBody Map<String, Object> payload,
                                         HttpSession session) {
        String helper_id = (String) payload.get("helperId");
        int allowLocation = (int) payload.get("locationallowmth");

        System.out.println("updateLocationAllow.do 컨트롤러");
        String mother_id = (String) session.getAttribute("helper_id");

        ConnectionVO cvo = new ConnectionVO();
        cvo.setHelper_id(helper_id);
        cvo.setMother_id(mother_id);
        cvo.setLocationallowmth(allowLocation);
        String tableName = sanpaService.selectTableName(cvo);
        cvo.setTableName(tableName);

        // 받아온 테이블명을 사용하여 updateLocationAllow 메서드 호출하여 업데이트 수행
        if (tableName != null) {
            System.out.println("mth 테이블명을 받아와서 업데이트 실행"+tableName);
            System.out.println( helper_id+mother_id+allowLocation);
            sanpaService.updateLocationAllowMth(cvo);
        } else {
            System.out.println("테이블명을 가져오지 못했습니다.");
            // 실패 처리 또는 리다이렉트 등을 수행할 수 있습니다.
        }

        return "redirect:/helpers_list"; // 업데이트 후 리다이렉트할 페이지 경로
    }


    @PostMapping("connectionListUnion")
    public ResponseEntity<List<ConnectionVO>> connectionListUnion(@RequestBody ConnectionVO cvo) {
        List<ConnectionVO> result = sanpaDAO.connectionListUnion(cvo);
        return ResponseEntity.ok(result);
    }

    @PostMapping("getHelper")
    public ResponseEntity<HelperVO> getHelper(@RequestBody HelperVO vo) {
        HelperVO result = sanpaDAO.getHelper(vo);
        return ResponseEntity.ok(result);
    }

    @PostMapping("connection_getMotherListNameUnion")
    public ResponseEntity<List<ConnectionVO>> connection_getMotherListNameUnion(@RequestBody ConnectionVO cvo) {
        System.out.println("여기왔니????????????????");
        List<ConnectionVO> result = sanpaDAO.connection_getMotherListNameUnion(cvo);
        return ResponseEntity.ok(result);
    }


}