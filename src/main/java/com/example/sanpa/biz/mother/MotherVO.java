package com.example.sanpa.biz.mother;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;
import org.hibernate.validator.constraints.Length;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.lang.Nullable;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.Pattern;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Alias("MotherVO")
public class MotherVO {

    /* 산모 테이블 */

    // 외래키는 helper 테이블에서 helper_id를 가져옴
    public String helper_id;

    public String helper_name;

    @Pattern(regexp = "^\\d{11}$", message = "- 를 제외한 11자리 숫자를 입력해주세요.")
    public String helper_tel;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public LocalDate helper_birth;

    public int helper_status;

    public String mother_id;

    public String mother_obHospital_name;

    public String mother_obHospital_tel;

    public String mother_babyName;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public LocalDate mother_due_date;

    public int mother_d_day;

    public int mother_info;

    public int mother_emergency_alaram;



    /* 산모 오늘의 상태 테이블 */

    // 외래키는 mother 테이블에서 mother_id를 가져옴

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public LocalDate report_date;

    public String general_status;

    @Length(max = 300, message = "최소 1글자에서 300글자를 넘지 말아주세요.")
    public String status_detail;



    /* 산모의 개인 검진 일지 테이블 */

    // 외래키는 mother 테이블에서 mother_id를 가져옴

    public MultipartFile prescription; // 처방전 사진, 현재 복용중인 약봉투 사진으로써, 올리기 위한 경로 컬럼

    public String hospital_name;

    public String medicine_name;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public LocalDate visited_date;

    @Length(max = 30, message = "최소 1글자에서 30글자를 넘지 말아주세요.")
    public String result;

    @Length(max = 100, message = "최소 1글자에서 100글자를 넘지 말아주세요.")
    public String result_detail;
    

    
    
    /* 병원 테이블과 약 테이블은 개인 검진 일지 테이블에 모두 포함됨 */
    
    
    
    /* 초대 수락 대기중인 리스트 테이블 */
    public int accept;
    
    
    /* 초대를 수락한 사용자들 테이블 */
    @Nullable
    public String nicknameOfMother;
    @Nullable
    public String nicknameOfHelper;
    public String nickname;
    @Nullable
    public String relation;
    @Nullable
    public String relationHTM;
    @Nullable
    public String relationMTH;

    
    
    /* 나머지 테이블도 중복된 필드값 */
    public LocalDateTime whenToClick;
    public int num; /* admin_buttonStatus에서 헬퍼 수 구할 때 사용 */


    public String searchCondition;
    public String searchKeyword;

    /* 업데이트를 하기 위해 배열을 sql문에서 사용함*/
    public List<MotherVO> array = new ArrayList<>();
    public List<MotherVO> list = new ArrayList<>();

    private int locationallowhtm;
    private int locationallowmth;

    public String month; /* mother_daily_report에서 사용 */
    public int month_count;  /* mother_daily_report에서 사용 */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public LocalDate pre_report_date;  /* mother_daily_report에서 사용 */
    public String pre_general_status;  /* mother_daily_report에서 사용 */
    public String pre_status_detail;  /* mother_daily_report에서 사용 */

    // 전화번호 출력형식 설정
    public String getFormattedHelper_tel() {
        // 전화번호에서 숫자만 추출
        String cleaned = this.helper_tel.replaceAll("\\D", "");

        // 정규식을 사용하여 전화번호에 하이픈(-) 추가
        return cleaned.replaceFirst("(\\d{3})(\\d{4})(\\d{4})", "$1-$2-$3");
    }


}
