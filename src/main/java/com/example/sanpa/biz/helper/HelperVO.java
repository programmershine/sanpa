package com.example.sanpa.biz.helper;

import com.example.sanpa.biz.mother.MotherVO;
import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.Email;
import javax.validation.constraints.Pattern;
import java.time.LocalDate;

@Getter
@Setter
@Alias("HelperVO")
public class HelperVO {

    // 전화번호 출력형식 설정
    public String helper_tel() {
        // 전화번호에서 숫자만 추출
        String cleaned = this.helper_tel.replaceAll("\\D", "");

        // 정규식을 사용하여 전화번호에 하이픈(-) 추가
        return cleaned.replaceFirst("(\\d{3})(\\d{4})(\\d{4})", "$1-$2-$3");
    }



    /* 헬퍼 테이블 */


    public String helper_id;

    public String helper_password;

    public String helper_name;

    @Email(message = "유효한 이메일을 입력해 주세요.")
    public String helper_email;

    @Pattern(regexp = "^\\d{11}$", message = "- 를 제외한 11자리 숫자를 입력해주세요.")
    public String helper_tel;

    public String helper_address;

    public String helper_address_detail;

    public String helper_address_postcode;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public LocalDate helper_birth;

    public int helper_alaram;

    public int helper_location;

    public int helper_info;

    public int helper_status;

    public String searchCondition;
    public String searchKeyword;



    //임시로추가
    public String mother_id;
    public String mother_babyName;




    @Override
    public String toString() {
        return "HelperVO {" +
                "helper_id" + helper_id +
                ", helper_password'" + helper_password +
                ", helper_tel'" + helper_tel +
                ", helper_address'" + helper_address +
                ", helper_address_detail'" + helper_address_detail +
                ", helper_birth'" + helper_birth +
                ", helper_name'" + helper_name +
                ", helper_email'" + helper_email +
                " } ";
    }



    // 전화번호 출력형식 설정
    public String getFormattedHelper_tel() {
        // 전화번호에서 숫자만 추출
        String cleaned = this.helper_tel.replaceAll("\\D", "");

        // 정규식을 사용하여 전화번호에 하이픈(-) 추가
        return cleaned.replaceFirst("(\\d{3})(\\d{4})(\\d{4})", "$1-$2-$3");
    }

    // MotherVO 참조
    private MotherVO mother;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate mother_due_date;
    private int mother_d_day;

    //
    private String general_status;
    private String hospital_name;
    private String medicine_name;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate visited_date;

    private String buttonType;

    private int locationallowhtm;
    private int locationallowmth;




}
