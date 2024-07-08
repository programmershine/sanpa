/*


	★	시연 전 필수 준비 사항	  ★
- 앱 실행시 나오는 이미지 시간 설정
- 문자 메세지(MotherController > AButtonClick과 BButtonClick의 주석 풀기
- coolsms에 ip등록hh


*/



/* 중요!★중요!★중요!★중요!★중요!★ mother 테이블의 날짜 변경 이벤트 설정하기 중요!★중요!★중요!★중요!★ */
SHOW VARIABLES LIKE 'event_scheduler';
SET GLOBAL event_scheduler = ON;



drop database sanpa;

/*	헬퍼 테이블 생성     */
create database sanpa;

use sanpa;




create table helper (
                        helper_id varchar(30) primary key comment '아이디',
                        helper_password varchar(30) not null comment '비밀번호',
                        helper_name varchar(30) not null comment '이름',
                        helper_email varchar(30) unique not null comment '이메일',
                        helper_tel varchar(14) unique not null comment '연락처',
                        helper_address varchar(50) not null comment '주소',
                        helper_address_detail varchar(50) comment '상세주소',
                        helper_address_postcode varchar(50) comment '우편번호',
                        helper_birth date not null comment '생년월일',
                        helper_alaram int default 0 comment '알림설정 0이면 거부, 1이면 동의',
                        helper_location int default 1 comment '위치동의 0이면 거부, 1이면 동의',
                        helper_info int default 1 comment '개인정보동의 0이면 거부, 1이면 동의',
                        helper_status int default 0 comment '0이면 헬퍼, 1이면 산모, 9면 관리자'
);





/*	산모 테이블 생성     */
create table mother (
                        helper_id varchar(30),
                        mother_id varchar(30) primary key comment '산모아이디',
                        mother_babyName varchar(30) default 'baby' comment '태명',
                        mother_obHospital_name varchar(30) comment '산모가 다니는 산부인과 이름',
                        mother_obHospital_tel varchar(14) comment '산모가 다니는 산부인과의 전화번호',
                        mother_due_date date comment '출산 예정일',
                        mother_d_day int comment '출산까지의 d-day, 출산 예정일을 입력하면 트리거가 자동으로 날짜를 계산해줌',
                        mother_info int default 1 comment '산모개인정보 1이면 동의, 0이면 거부',
                        mother_emergency_alaram int default 0 comment '0일 경우 이상없음, 1일 경우 A버튼, 2일 경우 B버튼',
                        constraint helper_id foreign key (helper_id) references helper (helper_id) on delete cascade
);




/* 산모 오늘의 상태 테이블 생성 */
create table mother_daily_report (
                                     mother_id varchar(30) not null comment '산모아이디',
                                     report_date date comment '오늘의 상태 입력 날짜',
                                     general_status varchar(30) comment '상태란, 예: 좋음, 나쁨, 그냥그럼, 어디가 아픔',
                                     status_detail varchar(300) comment '상태에 대한 자세한 설명(비고)',
                                     constraint daily_report_mother_id foreign key (mother_id) references mother (mother_id) on delete cascade
);




/* 산모의 개인 검진 일지 테이블 */
create table mother_health_report (
                                      mother_id varchar(30) not null comment '산모아이디',
                                      prescription varchar(100) comment '처방전 사진, 현재 복용중인 약봉투 사진으로써, 올리기 위한 경로 컬럼',
                                      hospital_name varchar(30) comment '산모가 다녀온 병원',
                                      medicine_name varchar(30) comment '병원에서 처방해준 약',
                                      visited_date date comment '산모가 병원에 다녀온 날짜',
                                      result varchar(30) comment '당일 컨디션 상태 danger(위험), bad(조금위험), caution(주의), good(양호), very good(매우양호)',
                                      result_detail varchar(100) comment '상태에 대한 자세한 설명 (비고)',
                                      constraint report_mother_id foreign key (mother_id) references mother (mother_id) on delete cascade
);



/* 병원 테이블 */
create table hospital (
                          mother_id varchar(30) not null comment '산모아이디',
                          hospital_name varchar(30) comment '산모가 다녀온 병원',
                          visited_date date comment '산모가 병원에 다녀온 날짜',
                          constraint hospital_mother_id foreign key (mother_id) references mother (mother_id) on delete cascade
);



/* 약 테이블 */
create table medicine (
                          mother_id varchar(30) not null comment '산모아이디',
                          medicine_name varchar(30) comment '병원에서 처방해준 약',
                          visited_date date comment '산모가 병원에 다녀온 날짜',
                          constraint medicine_mother_id foreign key (mother_id) references mother (mother_id) on delete cascade
);




/* 헬퍼가 산모에게 친추를 보내고 산모 입장에서 초대 수락 대기중인 리스트 */
/* accept값이 1로 변하면 connection_list에 자동 추가되는 트리거만 제작함, 2로 변하면 삭제되는건 java에서 진행해야함 */
/* accept의 값이 0에서 변하면 invite_list에서 삭제되는것도 제작해야함 */
create table invite_list_HTM (
                                 helper_id varchar(30) not null comment '헬퍼테이블에서의 기본키',
                                 mother_id varchar(30) not null comment '산모테이블에서의 기본키',
                                 accept int default 0 comment '0일때는 대기중, 1일때는 수락, 2일때는 거절 ',
                                 constraint invite_list_HTM_helper_id foreign key (helper_id) references helper (helper_id) on delete cascade,
                                 constraint invite_list_HTM_mother_id foreign key (mother_id) references mother (mother_id) on delete cascade
);
/* 산모가 헬퍼에게 친추를 보내고 헬퍼 입장에서 초대 수락 대기중인 리스트 */
create table invite_list_MTH (
                                 mother_id varchar(30) not null comment '산모테이블에서의 기본키',
                                 helper_id varchar(30) not null comment '헬퍼테이블에서의 기본키',
                                 accept int default 0 comment '0일때는 대기중, 1일때는 수락, 2일때는 거절 ',
                                 constraint invite_list_MTH_helper_id foreign key (helper_id) references helper (helper_id) on delete cascade,
                                 constraint invite_list__MTH_mother_id foreign key (mother_id) references mother (mother_id) on delete cascade
);



/* 헬퍼가 보낸 친추 요청을 산모가 초대를 수락한 테이블 */
create table connection_list_HTM (
                                     helper_id varchar(30) not null comment '헬퍼테이블에서의 기본키',
                                     mother_id varchar(30) not null comment '산모테이블에서의 기본키',
                                     nicknameOfHelper varchar(30) comment '산모가 헬퍼의 별칭을 지어주는 컬럼',
                                     relation varchar(30) comment '산모입장에서의 헬퍼의 관계',
                                     constraint connection_list_HTM_helper_id foreign key (helper_id) references helper (helper_id) on delete cascade,
                                     constraint connection_list_HTM_mother_id foreign key (mother_id) references mother (mother_id) on delete cascade
);
/* 산모가 보낸 친추 요청을 헬퍼가 초대를 수락한 테이블 */
create table connection_list_MTH (
                                     mother_id varchar(30) not null comment '산모테이블에서의 기본키',
                                     helper_id varchar(30) not null comment '헬퍼테이블에서의 기본키',
                                     nicknameOfHelper varchar(30) comment '헬퍼가 산모의 별칭을 지어주는 컬럼',
                                     relation varchar(30) comment '산모입장에서의 헬퍼의 관계',
                                     constraint connection_list_MTH_helper_id foreign key (helper_id) references helper (helper_id) on delete cascade,
                                     constraint connection_list_MTH_mother_id foreign key (mother_id) references mother (mother_id) on delete cascade
);



/* A버튼을 누른 산모들 테이블(emergency_alaram이 1인 상태) // connection_list에서 엮인 헬퍼들 묶어서 사용 */
create table A_button_list (
                               mother_id varchar(30) not null comment '산모테이블에서의 기본키',
                               whenToClick timestamp DEFAULT CURRENT_TIMESTAMP comment '언제 A 버튼이 눌렸는지 시간 확인',
                               constraint A_button_mother_id foreign key (mother_id) references mother (mother_id) on delete cascade
);



/* B버튼을 누른 산모들 테이블(emergency_alaram이 2인 상태) // connection_list에서 엮인 헬퍼들 묶어서 사용 */
create table B_button_list (
                               mother_id varchar(30) not null comment '산모테이블에서의 기본키',
                               whenToClick timestamp DEFAULT CURRENT_TIMESTAMP comment '언제 A 버튼이 눌렸는지 시간 확인',
                               constraint B_button_mother_id foreign key (mother_id) references mother (mother_id) on delete cascade
);







/* 트리거 부분	트리거 부분		트리거 부분	트리거 	부분	트리거 부분 */
/* 트리거 부분	트리거 부분		트리거 부분	트리거 	부분	트리거 부분 */
/* 트리거 부분	트리거 부분		트리거 부분	트리거 	부분	트리거 부분 */


/* 헬퍼id가 생성되면 mother테이블에 자동 id생성 */
DELIMITER $$
CREATE TRIGGER helper_after_insert
    AFTER insert ON helper
    FOR EACH ROW
BEGIN
    IF NEW.helper_status = 1 THEN
        SET @new_mother_id = NEW.helper_id;
        INSERT INTO mother (mother_id, helper_id)
        VALUES (@new_mother_id, NEW.helper_id);
    END IF;
END; $$
DELIMITER ;



/* 헬퍼의 status가 0에서 1이 될 때 mother테이블에 자동 id생성 */
DELIMITER $$
CREATE TRIGGER helper_after_update
    AFTER update ON helper
    FOR EACH ROW
BEGIN
    IF NEW.helper_status = 1 THEN
        SET @new_mother_id = NEW.helper_id;

        IF (SELECT COUNT(*) FROM mother WHERE mother_id = @new_mother_id) = 0 THEN
            INSERT INTO mother (mother_id, helper_id)
            VALUES (@new_mother_id, NEW.helper_id);
        END IF;
    END IF;
END; $$
DELIMITER ;




/* 날짜로 바로 출력하는 프로시저 *//* 날짜로 바로 출력하는 프로시저 */
DELIMITER $$
CREATE TRIGGER mother_dDay_update
    BEFORE UPDATE ON mother
    FOR EACH ROW
BEGIN
    IF NEW.mother_due_date IS NOT NULL THEN
        SET NEW.mother_d_day = datediff(CURDATE(), new.mother_due_date);
    END IF;
END; $$
DELIMITER ;


/* mother 테이블의 mother_d_day의 열을 현재 날짜를 업데이트하는 이벤트 */
/* 만약 where 절이 없어 한번에 업데이트 할 수 없다는 오류가 나면 "SET SQL_SAFE_UPDATES = 0;" 또는 우측 하단에 excute로 강제 실행 */
DELIMITER $$
CREATE EVENT update_mother_d_day
    ON SCHEDULE EVERY 1 DAY STARTS CURDATE() + INTERVAL 1 DAY
    DO
    UPDATE mother SET mother_d_day = DATEDIFF(CURDATE(), mother_due_date);
$$
DELIMITER ;



/* mother_health_report에서 visited_date의 기본값이 current_date입력이 안돼서 트리거로 작성 */
DELIMITER $$
CREATE TRIGGER before_insert_mother_health_report
    BEFORE INSERT ON mother_health_report
    FOR EACH ROW
BEGIN
    IF NEW.visited_date IS NULL THEN
        SET NEW.visited_date = CURDATE();
    END IF;
END$$
DELIMITER ;


select * from invite_list_HTM;

/* invite_list_HTM에서 accept의 값이 1로 변하면 connection_list_HTM에 추가 */
DELIMITER $$
CREATE TRIGGER invite_list_HTM_after_update
    AFTER update ON invite_list_HTM
    FOR EACH ROW
BEGIN
    IF NEW.accept = 1 THEN
        INSERT INTO connection_list_HTM (helper_id, mother_id)
        VALUES (NEW.helper_id, NEW.mother_id);
    END IF;
END; $$
DELIMITER ;

/* invite_list_MTH에서 accept의 값이 1로 변하면 connection_list_MTH에 추가 */
DELIMITER $$
CREATE TRIGGER invite_list_MTH_after_update
    AFTER update on invite_list_MTH
    FOR EACH ROW
BEGIN
    IF NEW.accept = 1 then
        INSERT INTO connection_list_MTH (mother_id, helper_id)
        VALUES (NEW.mother_id, NEW.helper_id);
    END IF;
END; $$
DELIMITER ;




/* 산모테이블에서 mother_emergency_alaram이 1이 되면 A_button_list에 자동 추가 */
DELIMITER $$
CREATE TRIGGER A_button_list_after_update
    AFTER update ON mother
    FOR EACH ROW
BEGIN
    IF NEW.mother_emergency_alaram = 1 THEN
        INSERT INTO A_button_list (mother_id, whenToClick)
        VALUES (NEW.mother_id, now());
    END IF;
END; $$
DELIMITER ;


/* 산모테이블에서 mother_emergency_alaram이 2이 되면 B_button_list에 자동 추가 */
DELIMITER $$
CREATE TRIGGER B_button_list_after_update
    AFTER update ON mother
    FOR EACH ROW
BEGIN
    IF NEW.mother_emergency_alaram = 2 THEN
        INSERT INTO B_button_list (mother_id, whenToClick)
        VALUES (NEW.mother_id, now());
    END IF;
END; $$
DELIMITER ;



/* A_button_list에서 id가 지워지면 mother테이블의 E_alaram의 값이 0으로 바뀐다. */
DELIMITER $$
CREATE TRIGGER motherTable_update_E_alaram_into_0_2
    AFTER delete ON A_button_list
    FOR EACH ROW
BEGIN
    IF old.mother_id is not null THEN
        update mother set mother_emergency_alaram = '0' where old.mother_id = mother.mother_id;
    END IF;
END; $$
DELIMITER ;




/* B_button_list에서 id가 지워지면 mother테이블의 E_alaram의 값이 0으로 바뀐다. */
DELIMITER $$
CREATE TRIGGER motherTable_update_E_alaram_into_0
    AFTER delete ON B_button_list
    FOR EACH ROW
BEGIN
    IF old.mother_id is not null THEN
        update mother set mother_emergency_alaram = '0' where old.mother_id = mother.mother_id;
    END IF;
END; $$
DELIMITER ;




/* 산모의 개인 검진 일지 테이블에서 병원과 약 값이 할당되면 hospital 테이블에 자동 입력 */
DELIMITER $$
CREATE TRIGGER mother_health_report_after_insert_hospital
    AFTER insert ON mother_health_report
    FOR EACH ROW
BEGIN
    IF NEW.hospital_name IS NOT NULL THEN
        INSERT INTO hospital (mother_id, hospital_name, visited_date)
        VALUES (NEW.mother_id, NEW.hospital_name, NEW.visited_date);
    END IF;
END; $$
DELIMITER ;



/* 산모의 개인 검진 일지 테이블에서 병원과 약 값이 할당되면 medicine 테이블에 자동 입력 */
DELIMITER $$
CREATE TRIGGER mother_health_report_after_insert_medicine
    AFTER insert ON mother_health_report
    FOR EACH ROW
BEGIN
    IF NEW.medicine_name IS NOT NULL THEN
        INSERT INTO medicine (mother_id, medicine_name, visited_date)
        VALUES (NEW.mother_id, NEW.medicine_name, NEW.visited_date);
    END IF;
END; $$
DELIMITER ;




/* 쿼리문 *//* 쿼리문 *//* 쿼리문 *//* 쿼리문 *//* 쿼리문 *//* 쿼리문 *//* 쿼리문 *//* 쿼리문 */
/* 쿼리문 *//* 쿼리문 *//* 쿼리문 *//* 쿼리문 *//* 쿼리문 *//* 쿼리문 *//* 쿼리문 *//* 쿼리문 */






/* helper 테이블에 값 입력 & 산모아이디도 같이 생성*/
insert into helper(helper_id, helper_password, helper_name, helper_email, helper_tel, helper_address, helper_address_detail, helper_birth, helper_alaram, helper_location, helper_info, helper_status)
values
    ('test1', '1234', '테스터1', '1@1', '00000000001', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('test2', '1234', '테스터2', '1@2', '00000000002', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('test3', '1234', '테스터3', '1@3', '00000000003', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('test4', '1234', '테스터4', '1@4', '00000000004', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('test5', '1234', '테스터5', '1@5', '00000000005', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('test6', '1234', '테스터6', '1@6', '00000000006', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('test7', '1234', '테스터7', '1@7', '00000000007', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('test8', '1234', '테스터8', '1@8', '00000000008', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('test9', '1234', '테스터9', '1@9', '00000000009', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('helper1', '1234', '헬퍼1', '1111@1111', '01000001111', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('helper2', '1234', '헬퍼2', '2222@2222', '01000002222', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('helper3', '1234', '헬퍼3', '3333@3333', '01000003333', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('helper4', '1234', '헬퍼4', '4444@4444', '01000004444', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('helper5', '1234', '헬퍼5', '5555@5555', '01000005555', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('helper6', '1234', '헬퍼6', '6666@6666', '01000006666', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('helper7', '1234', '헬퍼7', '7777@7777', '01000007777', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('helper8', '1234', '헬퍼8', '8888@8888', '01000008888', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('helper9', '1234', '헬퍼9', '9999@9999', '01000009999', '서울시', '205호', '950616', 1, 1, 1, 0),
    ('mother1', '1234', '산모1', '11111@11111', '01011111111', '서울시', '205호', '950616', 1, 1, 1, 1),
    ('mother2', '1234', '산모2', '22222@22222', '01011112222', '서울시', '205호', '950616', 1, 1, 1, 1),
    ('mother3', '1234', '산모3', '33333@33333', '01011113333', '서울시', '205호', '950616', 1, 1, 1, 1),
    ('mother4', '1234', '산모4', '44444@44444', '01011114444', '서울시', '205호', '950616', 1, 1, 1, 1),
    ('mother5', '1234', '산모5', '55555@55555', '01011115555', '서울시', '205호', '950616', 1, 1, 1, 1),
    ('mother6', '1234', '산모6', '66666@66666', '01011116666', '서울시', '205호', '950616', 1, 1, 1, 1),
    ('mother7', '1234', '산모7', '77777@77777', '01011117777', '서울시', '205호', '950616', 1, 1, 1, 1),
    ('mother8', '1234', '산모8', '88888@88888', '01011118888', '서울시', '205호', '950616', 1, 1, 1, 1),
    ('mother9', '1234', '산모9', '99999@99999', '01011119999', '서울시', '205호', '950616', 1, 1, 1, 1),
    ('jaewon', '1234', '장재원', 'jaewon@jaewon.com', '01099999999', '구로구', '205호', '950616', '1', '1', '1', '1'),
    ('jinyoung', '1234', '김진영', 'jinyoung@jinyoung.com', '01099999998', '구로구', '205호', '950616', '1', '1', '1', '1'),
    ('youngnam', '1234', '최영남', 'youngnum33@naver.com', '01099283732', '구로구', '205호', '950616', '1', '1', '1', '1'),
    ('seungyeon', '1234', '김승연', 'seungyeon@seungyeon.com', '01099999996', '구로구', '205호', '950616', '1', '1', '1', '1'),
    ('hyerin', '1234', '김혜린', 'hyerin@hyerin.com', '01099999995', '구로구', '205호', '950616', '1', '1', '1', '1'),
    ('jueon', '1234', '김주언', 'jueon@jueon.com', '01099999994', '구로구', '205호', '950616', '1', '1', '1', '1'),
    ('gowoon', '1234', '유고운', 'gowoon@gowoon.com', '01099999993', '구로구', '205호', '950616', '1', '1', '1', '1'),
    ('moonju', '1234', '강문주', 'moonju@moonju.com', '01099999992', '구로구', '205호', '950616', '1', '1', '1', '1'),
    ('hyunwoo', '1234', '최현우', 'hyunwoo@hyunwoo.com', '01099999991', '구로구', '205호', '950616', '1', '1', '1', '1'),
    ('minho', '1234', '윤민호', 'minho@minho.com', '01051188412', '구로구', '205호', '950616', '1', '1', '1', '1'),
    ('minji', '1234', '김민지', 'minji@minji.com', '01099999989', '구로구', '205호', '950616', '1', '1', '1', '1'),
    ('sejin', '1234', '정세진', 'sejin@sejin.com', '01099999988', '구로구', '205호', '950616', '1', '1', '1', '1'),
    ('heeseon', '1234', '왕희선', 'heeseon@heeseon.com', '01099999987', '구로구', '205호', '950616', '1', '1', '1', '1'),
    ('youngwoong', '1234', '조영웅', 'youngwoong@youngwoong.com', '01099999986', '구로구', '205호', '950616', '1', '1', '1', '1'),
    ('jaejun', '1234', '강재준', 'jaejun@jaejun.com', '01099999985', '구로구', '205호', '950616', '1', '1', '1', '1'),
    ('yumi', '1234', '이유미', 'yumi@yumi.com', '01099999984', '구로구', '205호', '950616', '1', '1', '1', '1'),
    ('huieun', '1234', '남희은', 'huieun@huieun.com', '01099999983', '구로구', '205호', '950616', '1', '1', '1', '1'),
    ('sjpark', '1234', '박성진', 'sjpark@sjpark.com', '01099999982', '구로구', '205호', '950616', '1', '1', '1', '1'),
    ('seungwan', '1234', '서승완', 'seungwan@seungwan.com', '01099999981', '구로구', '205호', '950616', '1', '1', '1', '1'),
    ('admin', 'admin', '관리자', 'admin@admin', '99999999999', '관리실', '205호', '950616', 1, 1, 1, 9),
    ('dnjfemwlffjt', '1234', '장재원', 'dnjfemwlffjt@naver.com', '01090611355', '서울시 관악구 신림동', '행복한빌 205호', '950616', 1, 1, 1, 1),
    ('dnjfemwlffjt2', '1234', '김혜린', 'fls9277@naver.com', '01086062967', '서울시 관악구 신림동', '행복한빌 206호', '930415', 1, 1, 1, 1),
    ('dnjfemwlffjt3', '1234', '김진영', 'dsr_shine@naver.com', '01079399276', '서울시 관악구 신림동', '행복한빌 207호', '920510', 1, 1, 1, 1);



/* mother 테이블에 값 추가 // 자바에서 넣을 때의 쿼리문 = update mother set mother_babyName = '하늘이', mother_due_date = '2024-10-01' where mother_id = 'mother1'; */
update mother set mother_babyName = case mother_id
                                        when 'mother1' then '하늘이'
                                        when 'mother2' then '사랑이'
                                        when 'mother3' then '튼튼이'
                                        when 'mother4' then '꼬물이'
                                        when 'mother5' then '별'
                                        when 'mother6' then '초롱이'
                                        when 'mother7' then '혜성이'
                                        when 'mother8' then '대한이'
                                        when 'mother9' then '민국이'
                                        when 'jaewon' then 'baby'
                                        when 'jinyoung' then 'baby'
                                        when 'youngnam' then 'baby'
                                        when 'seungyeon' then 'baby'
                                        when 'hyerin' then 'baby'
                                        when 'jueon' then 'baby'
                                        when 'gowoon' then 'baby'
                                        when 'moonju' then 'baby'
                                        when 'hyunwoo' then 'baby'
                                        when 'minho' then 'baby'
                                        when 'minji' then 'baby'
                                        when 'sejin' then 'baby'
                                        when 'heeseon' then 'baby'
                                        when 'youngwoong' then 'baby'
                                        when 'jaejun' then 'baby'
                                        when 'yumi' then 'baby'
                                        when 'huieun' then 'baby'
                                        when 'sjpark' then 'baby'
                                        when 'seungwan' then 'baby'
                                        when 'dnjfemwlffjt' then '재원2세'
    end,
                  mother_due_date = case mother_id
                                        when 'mother1' then '2024-10-01'
                                        when 'mother2' then '2024-10-21'
                                        when 'mother3' then '2024-11-11'
                                        when 'mother4' then '2024-10-11'
                                        when 'mother5' then '2025-01-03'
                                        when 'mother6' then '2024-09-12'
                                        when 'mother7' then '2024-12-24'
                                        when 'mother8' then '2025-02-17'
                                        when 'mother9' then '2025-03-01'
                                        when 'jaewon' then '2024-03-21'
                                        when 'jinyoung' then '2024-03-21'
                                        when 'youngnam' then '2024-03-21'
                                        when 'seungyeon' then '2024-03-21'
                                        when 'hyerin' then '2024-03-21'
                                        when 'jueon' then '2024-03-21'
                                        when 'gowoon' then '2024-03-21'
                                        when 'moonju' then '2024-03-21'
                                        when 'hyunwoo' then '2024-03-21'
                                        when 'minho' then '2024-03-21'
                                        when 'minji' then '2024-03-21'
                                        when 'sejin' then '2024-03-21'
                                        when 'heeseon' then '2024-03-21'
                                        when 'youngwoong' then '2024-03-21'
                                        when 'jaejun' then '2024-03-21'
                                        when 'yumi' then '2024-03-21'
                                        when 'huieun' then '2024-03-21'
                                        when 'sjpark' then '2024-03-21'
                                        when 'seungwan' then '2024-03-21'
                                        when 'dnjfemwlffjt' then '2024-05-05'
                      end
where mother_id in ('mother1', 'mother2', 'mother3', 'mother4', 'mother5', 'mother6', 'mother7', 'mother8', 'mother9',
                    'jaewon', 'jinyoung', 'youngnam', 'seungyeon', 'hyerin', 'jueon', 'gowoon', 'moonju', 'hyunwoo', 'minho', 'minji',
                    'sejin', 'heeseon', 'youngwoong', 'jaejun', 'yumi', 'huieun', 'sjpark', 'seungwan', 'dnjfemwlffjt');








/* mother_daily_report 테이블 값 추가 */
insert into mother_daily_report (mother_id, report_date, general_status, status_detail)
values
    ('mother1', '2024-01-01', '그냥그럼', '특별한 이상이 없음'),
    ('mother1', '2024-01-11', '문제없음', '특별한 이상이 없음'),
    ('mother1', '2024-01-21', '아랫배가 땡김', '아프긴 하지만 참을만 한정도임'),
    ('mother1', '2024-02-05', '괜찮음', '특별한 이상이 없음'),
    ('mother1', '2024-02-15', '좋음', '기분이 좋음'),
    ('mother2', '2024-01-23', '그냥그럼', '특별한 이상이 없음'),
    ('mother2', '2024-01-25', '문제없음', '특별한 이상이 없음'),
    ('mother2', '2024-01-30', '아랫배가 땡김', '통증이 있지만 가벼워서 병원에 갈 필요는 없어보임'),
    ('mother2', '2024-02-01', '좋음', '아랫배 통증이 사라지고 편안함'),
    ('mother2', '2024-02-15', '문제없음', '특별한 이상이 없음'),
    ('mother2', '2024-02-20', '문제없음', '특별한 이상이 없음'),
    ('mother3', '2024-01-19', '문제없음', '특별한 이상이 없음'),
    ('mother3', '2024-02-19', '문제없음', '특별한 이상이 없음'),
    ('mother4', '2024-01-19', '문제없음', '특별한 이상이 없음'),
    ('mother4', '2024-01-20', '문제없음', '특별한 이상이 없음'),
    ('dnjfemwlffjt', '2024-02-15', '문제없음', '특별한 이상이 없음'),
    ('dnjfemwlffjt', '2024-02-20', '문제없음', '특별한 이상이 없음'),
    ('dnjfemwlffjt', '2024-01-19', '문제없음', '특별한 이상이 없음'),
    ('dnjfemwlffjt', '2024-02-19', '문제없음', '특별한 이상이 없음'),
    ('dnjfemwlffjt', '2024-01-19', '문제없음', '특별한 이상이 없음'),
    ('dnjfemwlffjt', '2024-01-20', '문제없음', '특별한 이상이 없음');

INSERT INTO mother_daily_report (mother_id, report_date, general_status, status_detail)
VALUES
    ('dnjfemwlffjt', '2024-01-01', '별다르게 느낄 것 없음', '몸에 이상한 것을 찾아본다면 없음'),
    ('dnjfemwlffjt', '2024-01-02', '아무 이상 없음', '특이사항 없음'),
    ('dnjfemwlffjt', '2024-01-03', '평범한 하루', '별다를 게 없음'),
    ('dnjfemwlffjt', '2024-01-04', '그저 그래', '뭔가 다른 것을 기대한다면 없음'),
    ('dnjfemwlffjt', '2024-01-05', '문제 없는 날', '특별히 불편한 점 없음'),

    ('jaewon', '2024-01-01', '별다르게 느낄 것 없음', '몸에 이상한 것을 찾아본다면 없음'),
    ('jaewon', '2024-01-02', '아무 이상 없음', '특이사항 없음'),
    ('jaewon', '2024-01-03', '평범한 하루', '별다를 게 없음'),
    ('jaewon', '2024-01-04', '그저 그래', '뭔가 다른 것을 기대한다면 없음'),
    ('jaewon', '2024-01-05', '문제 없는 날', '특별히 불편한 점 없음'),

    ('jaewon', '2024-02-01', '별다르게 느낄 것 없음', '몸에 이상한 것을 찾아본다면 없음'),
    ('jaewon', '2024-02-02', '아무 이상 없음', '특이사항 없음'),
    ('jaewon', '2024-02-03', '평범한 하루', '별다를 게 없음'),
    ('jaewon', '2024-02-04', '그저 그래', '뭔가 다른 것을 기대한다면 없음'),
    ('jaewon', '2024-02-05', '문제 없는 날', '특별히 불편한 점 없음'),

    ('jaewon', '2024-03-01', '별다르게 느낄 것 없음', '몸에 이상한 것을 찾아본다면 없음'),
    ('jaewon', '2024-04-02', '아무 이상 없음', '특이사항 없음'),
    ('jaewon', '2024-05-03', '평범한 하루', '별다를 게 없음'),
    ('jaewon', '2024-05-04', '그저 그래', '뭔가 다른 것을 기대한다면 없음'),
    ('jaewon', '2024-06-05', '문제 없는 날', '특별히 불편한 점 없음'),

    ('jaewon', '2025-02-01', '별다르게 느낄 것 없음', '몸에 이상한 것을 찾아본다면 없음'),
    ('jaewon', '2025-02-02', '아무 이상 없음', '특이사항 없음'),
    ('jaewon', '2025-02-03', '평범한 하루', '별다를 게 없음'),
    ('jaewon', '2025-02-04', '그저 그래', '뭔가 다른 것을 기대한다면 없음'),
    ('jaewon', '2025-02-05', '문제 없는 날', '특별히 불편한 점 없음'),

    ('jinyoung', '2024-01-11', '안정적인 상태', '특별히 불편함을 느끼지 않음'),
    ('jinyoung', '2024-01-12', '평온함', '몸에 이상한 점 없음'),
    ('jinyoung', '2024-01-13', '아무 문제 없음', '몸에 느껴지는 이상한 점 없음'),
    ('jinyoung', '2024-01-14', '무난한 상태', '몸에 느껴지는 불편함 없음'),
    ('jinyoung', '2024-01-15', '평범하게 잘 지내고 있음', '특별한 건강 문제 없음'),

    ('youngnam', '2024-01-21', '배가 조금 아픔', '아프지만 참을만함'),
    ('youngnam', '2024-01-22', '배 부분에 불편함', '아프지만 크게 문제될 정도는 아님'),
    ('youngnam', '2024-01-23', '아랫배가 땡김', '통증이 있지만 견딜 수 있음'),
    ('youngnam', '2024-01-24', '배가 조금 아프지만 괜찮음', '참을 수 있는 통증'),
    ('youngnam', '2024-01-25', '배가 아파도 괜찮음', '통증이 있지만 크게 문제가 되지 않음'),

    ('seungyeon', '2024-01-11', '안정적인 상태', '특별히 불편함을 느끼지 않음'),
    ('seungyeon', '2024-01-12', '평온함', '몸에 이상한 점 없음'),
    ('seungyeon', '2024-01-13', '아무 문제 없음', '몸에 느껴지는 이상한 점 없음'),
    ('seungyeon', '2024-01-14', '무난한 상태', '몸에 느껴지는 불편함 없음'),
    ('seungyeon', '2024-01-15', '평범하게 잘 지내고 있음', '특별한 건강 문제 없음'),

    ('hyerin', '2024-01-21', '배가 조금 아픔', '아프지만 참을만함'),
    ('hyerin', '2024-01-22', '배 부분에 불편함', '아프지만 크게 문제될 정도는 아님'),
    ('hyerin', '2024-01-23', '아랫배가 땡김', '통증이 있지만 견딜 수 있음'),
    ('hyerin', '2024-01-24', '배가 조금 아프지만 괜찮음', '참을 수 있는 통증'),
    ('hyerin', '2024-01-25', '배가 아파도 괜찮음', '통증이 있지만 크게 문제가 되지 않음');



/* mother_health_report 테이블에 값 추가 */
insert into mother_health_report (mother_id, hospital_name, medicine_name, visited_date, result, result_detail)
values
    ('mother1', '아이조아산부인과', '', '2024-01-01', 'good', '혹시나 해서 산부인과에 다녀왔는데 임신 사실을 알게 되었다. 상태는 아이와 나 모두 건강하다고 했다.'),
    ('mother1', '아이조아산부인과', '', '2024-01-08', 'good', '정기점검차 산부인과에 방문함'),
    ('mother1', '아이조아산부인과', '', '2024-01-15', 'good', '정기점검차 산부인과에 방문함'),
    ('mother1', '아이조아산부인과', '', '2024-01-20', 'good', '정기점검차 산부인과에 방문함'),
    ('mother1', '아이조아산부인과', '약1', '2024-01-21', 'not bad', '아랫배에 근육통이 있어 병원을 방문했지만 가벼운 증상이라 태아에는 무해한 간단한 약을 처방받음'),
    ('mother1', '아이조아산부인과', '', '2024-01-29', 'good', '기존의 통증은 완전히 사라졌으며 정기점검차 산부인과에 방문함'),
    ('mother1', '아이조아산부인과', '', '2024-02-08', 'good', '정기점검차 산부인과에 방문함'),
    ('mother2', '순풍산부인과', '', '2024-01-23', 'good', '정기점검차 산부인과에 방문함'),
    ('mother2', '순풍산부인과', '진통제', '2024-01-27', 'bad', '아랫배 통증이 심하여 산부인과에 방문했고 통증 완화를 위해 태아에는 영향이 없는 가벼운 진통제를 처방받음'),
    ('mother2', '순풍산부인과', '진통제', '2024-02-01', 'caution', '며칠이 지나도 통증이 사라지지 않아 산부인과에 재 방문을 하였고 초음파 및 각종 검사를 받았지만 이상이 없어서 가벼운 진통제를 다시 처방받음'),
    ('mother2', '순풍산부인과', '', '2024-02-15', 'good', '정기점검차 산부인과에 방문함'),
    ('mother2', '순풍산부인과', '', '2024-03-01', 'good', '정기점검차 산부인과에 방문함'),
    ('mother2', '순풍산부인과', '', '2024-03-23', 'good', '정기점검차 산부인과에 방문함'),
    ('mother3', '산인부과', '', '2024-01-19', 'good', '정기점검차 산부인과에 방문함'),
    ('mother3', '산인부과', '', '2024-02-05', 'good', '정기점검차 산부인과에 방문함'),
    ('mother3', '산인부과', '', '2024-02-15', 'good', '정기점검차 산부인과에 방문함'),
    ('mother3', '산인부과', '', '2024-02-25', 'good', '정기점검차 산부인과에 방문함'),
    ('mother3', '산인부과', '', '2024-03-05', 'good', '정기점검차 산부인과에 방문함'),
    ('mother3', '산인부과', '', '2024-03-15', 'good', '정기점검차 산부인과에 방문함'),
    ('dnjfemwlffjt', '산인부과', '', '2024-01-19', 'good', '정기점검차 산부인과에 방문함'),
    ('dnjfemwlffjt', '산인부과', '', '2024-02-05', 'good', '정기점검차 산부인과에 방문함'),
    ('dnjfemwlffjt', '산인부과', '', '2024-02-15', 'good', '정기점검차 산부인과에 방문함'),
    ('dnjfemwlffjt', '산인부과', '', '2024-02-25', 'good', '정기점검차 산부인과에 방문함'),
    ('dnjfemwlffjt', '산인부과', '', '2024-03-05', 'good', '정기점검차 산부인과에 방문함'),
    ('dnjfemwlffjt', '산인부과', '', '2024-03-15', 'good', '정기점검차 산부인과에 방문함');







/* 헬퍼가 산모를 추가(친구등록 요청)할 때 사용 (디비용)*/
INSERT INTO invite_list_HTM (helper_id, mother_id)
VALUES
    ('helper1', (SELECT mother.mother_id FROM mother, helper WHERE mother.mother_id = helper.helper_id
                                                               AND helper.helper_tel = '01011111111')),
    ('helper1', (SELECT mother.mother_id FROM mother, helper WHERE mother.mother_id = helper.helper_id
                                                               AND helper.helper_tel = '01011112222')),
    ('helper1', (SELECT mother.mother_id FROM mother, helper WHERE mother.mother_id = helper.helper_id
                                                               AND helper.helper_tel = '01011113333')),
    ('helper2', (SELECT mother.mother_id FROM mother, helper WHERE mother.mother_id = helper.helper_id
                                                               AND helper.helper_tel = '01011113333')),
    ('helper3', (SELECT mother.mother_id FROM mother, helper WHERE mother.mother_id = helper.helper_id
                                                               AND helper.helper_tel = '01011113333')),
    ('helper4', (SELECT mother.mother_id FROM mother, helper WHERE mother.mother_id = helper.helper_id
                                                               AND helper.helper_tel = '01011113333')),
    ('helper5', (SELECT mother.mother_id FROM mother, helper WHERE mother.mother_id = helper.helper_id
                                                               AND helper.helper_tel = '01011113333')),
    ('helper6', (SELECT mother.mother_id FROM mother, helper WHERE mother.mother_id = helper.helper_id
                                                               AND helper.helper_tel = '01011113333')),

    ('helper1', (SELECT mother.mother_id FROM mother, helper WHERE mother.mother_id = helper.helper_id
                                                               AND helper.helper_tel = '01099999999')),
    ('helper2', (SELECT mother.mother_id FROM mother, helper WHERE mother.mother_id = helper.helper_id
                                                               AND helper.helper_tel = '01099999999')),
    ('helper3', (SELECT mother.mother_id FROM mother, helper WHERE mother.mother_id = helper.helper_id
                                                               AND helper.helper_tel = '01099999999')),
    ('helper4', (SELECT mother.mother_id FROM mother, helper WHERE mother.mother_id = helper.helper_id
                                                               AND helper.helper_tel = '01099999999')),
    ('helper5', (SELECT mother.mother_id FROM mother, helper WHERE mother.mother_id = helper.helper_id
                                                               AND helper.helper_tel = '01099999999')),
    ('helper6', (SELECT mother.mother_id FROM mother, helper WHERE mother.mother_id = helper.helper_id
                                                               AND helper.helper_tel = '01099999999')),
    ('helper7', (SELECT mother.mother_id FROM mother, helper WHERE mother.mother_id = helper.helper_id
                                                               AND helper.helper_tel = '01099999999'));




/* 산모가 헬퍼를 추가(친구등록 요청)할 때 사용 (디비용)*/
INSERT INTO invite_list_MTH (mother_id, helper_id)
VALUES
    ('mother1', (select helper_id from helper where helper_tel = '01000006666')),
    ('mother1', (select helper_id from helper where helper_tel = '01000007777')),
    ('mother1', (select helper_id from helper where helper_tel = '01000008888')),
    ('mother1', (select helper_id from helper where helper_tel = '01000009999')),
    ('mother2', (select helper_id from helper where helper_tel = '01000009999')),
    ('mother3', (select helper_id from helper where helper_tel = '01000009999')),
    ('mother4', (select helper_id from helper where helper_tel = '01000009999')),
    ('jaewon', (select helper_id from helper where helper_tel = '01099999998')),
    ('jaewon', (select helper_id from helper where helper_tel = '01099283732')),
    ('jaewon', (select helper_id from helper where helper_tel = '01099999996')),
    ('jaewon', (select helper_id from helper where helper_tel = '01099999995')),
    ('jaewon', (select helper_id from helper where helper_tel = '01099999994')),
    ('jaewon', (select helper_id from helper where helper_tel = '01099999993')),
    ('jaewon', (select helper_id from helper where helper_tel = '01099999992')),
    ('jaewon', (select helper_id from helper where helper_tel = '01099999991')),
    ('jaewon', (select helper_id from helper where helper_tel = '01051188412')),
    ('jaewon', (select helper_id from helper where helper_tel = '01099999989')),
    ('jaewon', (select helper_id from helper where helper_tel = '01099999988')),
    ('jaewon', (select helper_id from helper where helper_tel = '01099999987')),
    ('jaewon', (select helper_id from helper where helper_tel = '01099999986')),
    ('jaewon', (select helper_id from helper where helper_tel = '01099999985')),
    ('jaewon', (select helper_id from helper where helper_tel = '01099999984')),
    ('jaewon', (select helper_id from helper where helper_tel = '01099999983')),
    ('jaewon', (select helper_id from helper where helper_tel = '01099999982')),
    ('jaewon', (select helper_id from helper where helper_tel = '01099999981')),

    ('jinyoung', (select helper_id from helper where helper_tel = '01099999999')),
    ('jinyoung', (select helper_id from helper where helper_tel = '01099283732')),
    ('jinyoung', (select helper_id from helper where helper_tel = '01099999996')),
    ('jinyoung', (select helper_id from helper where helper_tel = '01099999995')),
    ('jinyoung', (select helper_id from helper where helper_tel = '01099999994')),
    ('jinyoung', (select helper_id from helper where helper_tel = '01099999993')),
    ('jinyoung', (select helper_id from helper where helper_tel = '01099999981')),
    ('jinyoung', (select helper_id from helper where helper_tel = '01099999992')),
    ('jinyoung', (select helper_id from helper where helper_tel = '01099999991')),
    ('jinyoung', (select helper_id from helper where helper_tel = '01051188412')),
    ('jinyoung', (select helper_id from helper where helper_tel = '01099999989')),
    ('jinyoung', (select helper_id from helper where helper_tel = '01099999988')),
    ('jinyoung', (select helper_id from helper where helper_tel = '01099999987')),
    ('jinyoung', (select helper_id from helper where helper_tel = '01099999986')),
    ('jinyoung', (select helper_id from helper where helper_tel = '01099999985')),
    ('jinyoung', (select helper_id from helper where helper_tel = '01099999984')),
    ('jinyoung', (select helper_id from helper where helper_tel = '01099999983')),
    ('jinyoung', (select helper_id from helper where helper_tel = '01099999982')),

    ('youngnam', (select helper_id from helper where helper_tel = '01099999999')),
    ('youngnam', (select helper_id from helper where helper_tel = '01099999998')),
    ('youngnam', (select helper_id from helper where helper_tel = '01099999996')),
    ('youngnam', (select helper_id from helper where helper_tel = '01099999995')),
    ('youngnam', (select helper_id from helper where helper_tel = '01099999994')),
    ('youngnam', (select helper_id from helper where helper_tel = '01099999993')),
    ('youngnam', (select helper_id from helper where helper_tel = '01099999992')),
    ('youngnam', (select helper_id from helper where helper_tel = '01099999991')),
    ('youngnam', (select helper_id from helper where helper_tel = '01051188412')),
    ('youngnam', (select helper_id from helper where helper_tel = '01099999989')),
    ('youngnam', (select helper_id from helper where helper_tel = '01099999988')),
    ('youngnam', (select helper_id from helper where helper_tel = '01099999986')),
    ('youngnam', (select helper_id from helper where helper_tel = '01099999985')),
    ('youngnam', (select helper_id from helper where helper_tel = '01099999984')),
    ('youngnam', (select helper_id from helper where helper_tel = '01099999983')),
    ('youngnam', (select helper_id from helper where helper_tel = '01099999982')),
    ('youngnam', (select helper_id from helper where helper_tel = '01099999981')),
    ('youngnam', (select helper_id from helper where helper_tel = '01099999987')),

    ('seungyeon', (select helper_id from helper where helper_tel = '01099999999')),
    ('seungyeon', (select helper_id from helper where helper_tel = '01099999998')),
    ('seungyeon', (select helper_id from helper where helper_tel = '01099283732')),
    ('seungyeon', (select helper_id from helper where helper_tel = '01099999995')),
    ('seungyeon', (select helper_id from helper where helper_tel = '01099999994')),
    ('seungyeon', (select helper_id from helper where helper_tel = '01099999993')),
    ('seungyeon', (select helper_id from helper where helper_tel = '01099999992')),
    ('seungyeon', (select helper_id from helper where helper_tel = '01099999991')),
    ('seungyeon', (select helper_id from helper where helper_tel = '01051188412')),
    ('seungyeon', (select helper_id from helper where helper_tel = '01099999989')),
    ('seungyeon', (select helper_id from helper where helper_tel = '01099999988')),
    ('seungyeon', (select helper_id from helper where helper_tel = '01099999986')),
    ('seungyeon', (select helper_id from helper where helper_tel = '01099999985')),
    ('seungyeon', (select helper_id from helper where helper_tel = '01099999984')),
    ('seungyeon', (select helper_id from helper where helper_tel = '01099999983')),
    ('seungyeon', (select helper_id from helper where helper_tel = '01099999982')),
    ('seungyeon', (select helper_id from helper where helper_tel = '01099999981')),
    ('seungyeon', (select helper_id from helper where helper_tel = '01099999987')),

    ('hyerin', (select helper_id from helper where helper_tel = '01099999999')),
    ('hyerin', (select helper_id from helper where helper_tel = '01099999998')),
    ('hyerin', (select helper_id from helper where helper_tel = '01099283732')),
    ('hyerin', (select helper_id from helper where helper_tel = '01099999996')),
    ('hyerin', (select helper_id from helper where helper_tel = '01099999994')),
    ('hyerin', (select helper_id from helper where helper_tel = '01099999993')),
    ('hyerin', (select helper_id from helper where helper_tel = '01099999992')),
    ('hyerin', (select helper_id from helper where helper_tel = '01099999991')),
    ('hyerin', (select helper_id from helper where helper_tel = '01051188412')),
    ('hyerin', (select helper_id from helper where helper_tel = '01099999989')),
    ('hyerin', (select helper_id from helper where helper_tel = '01099999988')),
    ('hyerin', (select helper_id from helper where helper_tel = '01099999987')),
    ('hyerin', (select helper_id from helper where helper_tel = '01099999986')),
    ('hyerin', (select helper_id from helper where helper_tel = '01099999985')),
    ('hyerin', (select helper_id from helper where helper_tel = '01099999984')),
    ('hyerin', (select helper_id from helper where helper_tel = '01099999983')),
    ('hyerin', (select helper_id from helper where helper_tel = '01099999982')),
    ('hyerin', (select helper_id from helper where helper_tel = '01099999981')),


    ('jueon', (select helper_id from helper where helper_tel = '01099999999')),
    ('jueon', (select helper_id from helper where helper_tel = '01099999998')),
    ('jueon', (select helper_id from helper where helper_tel = '01099283732')),
    ('jueon', (select helper_id from helper where helper_tel = '01099999996')),
    ('jueon', (select helper_id from helper where helper_tel = '01099999995')),
    ('jueon', (select helper_id from helper where helper_tel = '01099999993')),
    ('jueon', (select helper_id from helper where helper_tel = '01099999992')),
    ('jueon', (select helper_id from helper where helper_tel = '01099999991')),
    ('jueon', (select helper_id from helper where helper_tel = '01051188412')),
    ('jueon', (select helper_id from helper where helper_tel = '01099999989')),
    ('jueon', (select helper_id from helper where helper_tel = '01099999988')),
    ('jueon', (select helper_id from helper where helper_tel = '01099999987')),
    ('jueon', (select helper_id from helper where helper_tel = '01099999986')),
    ('jueon', (select helper_id from helper where helper_tel = '01099999985')),
    ('jueon', (select helper_id from helper where helper_tel = '01099999984')),
    ('jueon', (select helper_id from helper where helper_tel = '01099999983')),
    ('jueon', (select helper_id from helper where helper_tel = '01099999982')),
    ('jueon', (select helper_id from helper where helper_tel = '01099999981')),

    ('gowoon', (select helper_id from helper where helper_tel = '01099999999')),
    ('gowoon', (select helper_id from helper where helper_tel = '01099999998')),
    ('gowoon', (select helper_id from helper where helper_tel = '01099283732')),
    ('gowoon', (select helper_id from helper where helper_tel = '01099999996')),
    ('gowoon', (select helper_id from helper where helper_tel = '01099999995')),
    ('gowoon', (select helper_id from helper where helper_tel = '01099999994')),
    ('gowoon', (select helper_id from helper where helper_tel = '01099999992')),
    ('gowoon', (select helper_id from helper where helper_tel = '01099999991')),
    ('gowoon', (select helper_id from helper where helper_tel = '01051188412')),
    ('gowoon', (select helper_id from helper where helper_tel = '01099999989')),
    ('gowoon', (select helper_id from helper where helper_tel = '01099999988')),
    ('gowoon', (select helper_id from helper where helper_tel = '01099999987')),
    ('gowoon', (select helper_id from helper where helper_tel = '01099999986')),
    ('gowoon', (select helper_id from helper where helper_tel = '01099999985')),
    ('gowoon', (select helper_id from helper where helper_tel = '01099999984')),
    ('gowoon', (select helper_id from helper where helper_tel = '01099999983')),
    ('gowoon', (select helper_id from helper where helper_tel = '01099999982')),
    ('gowoon', (select helper_id from helper where helper_tel = '01099999981')),

    ('moonju', (select helper_id from helper where helper_tel = '01099999999')),
    ('moonju', (select helper_id from helper where helper_tel = '01099999998')),
    ('moonju', (select helper_id from helper where helper_tel = '01099283732')),
    ('moonju', (select helper_id from helper where helper_tel = '01099999996')),
    ('moonju', (select helper_id from helper where helper_tel = '01099999995')),
    ('moonju', (select helper_id from helper where helper_tel = '01099999994')),
    ('moonju', (select helper_id from helper where helper_tel = '01099999993')),
    ('moonju', (select helper_id from helper where helper_tel = '01099999981')),
    ('moonju', (select helper_id from helper where helper_tel = '01099999991')),
    ('moonju', (select helper_id from helper where helper_tel = '01051188412')),
    ('moonju', (select helper_id from helper where helper_tel = '01099999989')),
    ('moonju', (select helper_id from helper where helper_tel = '01099999988')),
    ('moonju', (select helper_id from helper where helper_tel = '01099999987')),
    ('moonju', (select helper_id from helper where helper_tel = '01099999986')),
    ('moonju', (select helper_id from helper where helper_tel = '01099999985')),
    ('moonju', (select helper_id from helper where helper_tel = '01099999984')),
    ('moonju', (select helper_id from helper where helper_tel = '01099999983')),
    ('moonju', (select helper_id from helper where helper_tel = '01099999982')),

    ('hyunwoo', (select helper_id from helper where helper_tel = '01099999999')),
    ('hyunwoo', (select helper_id from helper where helper_tel = '01099999998')),
    ('hyunwoo', (select helper_id from helper where helper_tel = '01099283732')),
    ('hyunwoo', (select helper_id from helper where helper_tel = '01099999996')),
    ('hyunwoo', (select helper_id from helper where helper_tel = '01099999995')),
    ('hyunwoo', (select helper_id from helper where helper_tel = '01099999994')),
    ('hyunwoo', (select helper_id from helper where helper_tel = '01099999993')),
    ('hyunwoo', (select helper_id from helper where helper_tel = '01099999992')),
    ('hyunwoo', (select helper_id from helper where helper_tel = '01099999981')),
    ('hyunwoo', (select helper_id from helper where helper_tel = '01051188412')),
    ('hyunwoo', (select helper_id from helper where helper_tel = '01099999989')),
    ('hyunwoo', (select helper_id from helper where helper_tel = '01099999988')),
    ('hyunwoo', (select helper_id from helper where helper_tel = '01099999987')),
    ('hyunwoo', (select helper_id from helper where helper_tel = '01099999986')),
    ('hyunwoo', (select helper_id from helper where helper_tel = '01099999985')),
    ('hyunwoo', (select helper_id from helper where helper_tel = '01099999984')),
    ('hyunwoo', (select helper_id from helper where helper_tel = '01099999983')),
    ('hyunwoo', (select helper_id from helper where helper_tel = '01099999982')),

    ('minho', (select helper_id from helper where helper_tel = '01099999999')),
    ('minho', (select helper_id from helper where helper_tel = '01099999998')),
    ('minho', (select helper_id from helper where helper_tel = '01099283732')),
    ('minho', (select helper_id from helper where helper_tel = '01099999996')),
    ('minho', (select helper_id from helper where helper_tel = '01099999995')),
    ('minho', (select helper_id from helper where helper_tel = '01099999994')),
    ('minho', (select helper_id from helper where helper_tel = '01099999993')),
    ('minho', (select helper_id from helper where helper_tel = '01099999992')),
    ('minho', (select helper_id from helper where helper_tel = '01099999991')),
    ('minho', (select helper_id from helper where helper_tel = '01099999981')),
    ('minho', (select helper_id from helper where helper_tel = '01099999989')),
    ('minho', (select helper_id from helper where helper_tel = '01099999988')),
    ('minho', (select helper_id from helper where helper_tel = '01099999987')),
    ('minho', (select helper_id from helper where helper_tel = '01099999986')),
    ('minho', (select helper_id from helper where helper_tel = '01099999985')),
    ('minho', (select helper_id from helper where helper_tel = '01099999984')),
    ('minho', (select helper_id from helper where helper_tel = '01099999983')),
    ('minho', (select helper_id from helper where helper_tel = '01099999982')),

    ('minji', (select helper_id from helper where helper_tel = '01099999999')),
    ('minji', (select helper_id from helper where helper_tel = '01099999998')),
    ('minji', (select helper_id from helper where helper_tel = '01099283732')),
    ('minji', (select helper_id from helper where helper_tel = '01099999996')),
    ('minji', (select helper_id from helper where helper_tel = '01099999995')),
    ('minji', (select helper_id from helper where helper_tel = '01099999994')),
    ('minji', (select helper_id from helper where helper_tel = '01099999993')),
    ('minji', (select helper_id from helper where helper_tel = '01099999992')),
    ('minji', (select helper_id from helper where helper_tel = '01099999991')),
    ('minji', (select helper_id from helper where helper_tel = '01051188412')),
    ('minji', (select helper_id from helper where helper_tel = '01099999981')),
    ('minji', (select helper_id from helper where helper_tel = '01099999988')),
    ('minji', (select helper_id from helper where helper_tel = '01099999987')),
    ('minji', (select helper_id from helper where helper_tel = '01099999986')),
    ('minji', (select helper_id from helper where helper_tel = '01099999985')),
    ('minji', (select helper_id from helper where helper_tel = '01099999984')),
    ('minji', (select helper_id from helper where helper_tel = '01099999983')),
    ('minji', (select helper_id from helper where helper_tel = '01099999982')),

    ('sejin', (select helper_id from helper where helper_tel = '01099999999')),
    ('sejin', (select helper_id from helper where helper_tel = '01099999998')),
    ('sejin', (select helper_id from helper where helper_tel = '01099283732')),
    ('sejin', (select helper_id from helper where helper_tel = '01099999996')),
    ('sejin', (select helper_id from helper where helper_tel = '01099999995')),
    ('sejin', (select helper_id from helper where helper_tel = '01099999994')),
    ('sejin', (select helper_id from helper where helper_tel = '01099999993')),
    ('sejin', (select helper_id from helper where helper_tel = '01099999992')),
    ('sejin', (select helper_id from helper where helper_tel = '01099999991')),
    ('sejin', (select helper_id from helper where helper_tel = '01051188412')),
    ('sejin', (select helper_id from helper where helper_tel = '01099999989')),
    ('sejin', (select helper_id from helper where helper_tel = '01099999981')),
    ('sejin', (select helper_id from helper where helper_tel = '01099999987')),
    ('sejin', (select helper_id from helper where helper_tel = '01099999986')),
    ('sejin', (select helper_id from helper where helper_tel = '01099999985')),
    ('sejin', (select helper_id from helper where helper_tel = '01099999984')),
    ('sejin', (select helper_id from helper where helper_tel = '01099999983')),
    ('sejin', (select helper_id from helper where helper_tel = '01099999982')),

    ('heeseon', (select helper_id from helper where helper_tel = '01099999999')),
    ('heeseon', (select helper_id from helper where helper_tel = '01099999998')),
    ('heeseon', (select helper_id from helper where helper_tel = '01099283732')),
    ('heeseon', (select helper_id from helper where helper_tel = '01099999996')),
    ('heeseon', (select helper_id from helper where helper_tel = '01099999995')),
    ('heeseon', (select helper_id from helper where helper_tel = '01099999994')),
    ('heeseon', (select helper_id from helper where helper_tel = '01099999993')),
    ('heeseon', (select helper_id from helper where helper_tel = '01099999992')),
    ('heeseon', (select helper_id from helper where helper_tel = '01099999991')),
    ('heeseon', (select helper_id from helper where helper_tel = '01051188412')),
    ('heeseon', (select helper_id from helper where helper_tel = '01099999989')),
    ('heeseon', (select helper_id from helper where helper_tel = '01099999988')),
    ('heeseon', (select helper_id from helper where helper_tel = '01099999981')),
    ('heeseon', (select helper_id from helper where helper_tel = '01099999986')),
    ('heeseon', (select helper_id from helper where helper_tel = '01099999985')),
    ('heeseon', (select helper_id from helper where helper_tel = '01099999984')),
    ('heeseon', (select helper_id from helper where helper_tel = '01099999983')),
    ('heeseon', (select helper_id from helper where helper_tel = '01099999982')),

    ('youngwoong', (select helper_id from helper where helper_tel = '01099999999')),
    ('youngwoong', (select helper_id from helper where helper_tel = '01099999998')),
    ('youngwoong', (select helper_id from helper where helper_tel = '01099283732')),
    ('youngwoong', (select helper_id from helper where helper_tel = '01099999996')),
    ('youngwoong', (select helper_id from helper where helper_tel = '01099999995')),
    ('youngwoong', (select helper_id from helper where helper_tel = '01099999994')),
    ('youngwoong', (select helper_id from helper where helper_tel = '01099999993')),
    ('youngwoong', (select helper_id from helper where helper_tel = '01099999992')),
    ('youngwoong', (select helper_id from helper where helper_tel = '01099999991')),
    ('youngwoong', (select helper_id from helper where helper_tel = '01051188412')),
    ('youngwoong', (select helper_id from helper where helper_tel = '01099999989')),
    ('youngwoong', (select helper_id from helper where helper_tel = '01099999988')),
    ('youngwoong', (select helper_id from helper where helper_tel = '01099999987')),
    ('youngwoong', (select helper_id from helper where helper_tel = '01099999981')),
    ('youngwoong', (select helper_id from helper where helper_tel = '01099999985')),
    ('youngwoong', (select helper_id from helper where helper_tel = '01099999984')),
    ('youngwoong', (select helper_id from helper where helper_tel = '01099999983')),
    ('youngwoong', (select helper_id from helper where helper_tel = '01099999982')),

    ('jaejun', (select helper_id from helper where helper_tel = '01099999999')),
    ('jaejun', (select helper_id from helper where helper_tel = '01099999998')),
    ('jaejun', (select helper_id from helper where helper_tel = '01099283732')),
    ('jaejun', (select helper_id from helper where helper_tel = '01099999996')),
    ('jaejun', (select helper_id from helper where helper_tel = '01099999995')),
    ('jaejun', (select helper_id from helper where helper_tel = '01099999994')),
    ('jaejun', (select helper_id from helper where helper_tel = '01099999993')),
    ('jaejun', (select helper_id from helper where helper_tel = '01099999992')),
    ('jaejun', (select helper_id from helper where helper_tel = '01099999991')),
    ('jaejun', (select helper_id from helper where helper_tel = '01051188412')),
    ('jaejun', (select helper_id from helper where helper_tel = '01099999989')),
    ('jaejun', (select helper_id from helper where helper_tel = '01099999988')),
    ('jaejun', (select helper_id from helper where helper_tel = '01099999987')),
    ('jaejun', (select helper_id from helper where helper_tel = '01099999986')),
    ('jaejun', (select helper_id from helper where helper_tel = '01099999981')),
    ('jaejun', (select helper_id from helper where helper_tel = '01099999984')),
    ('jaejun', (select helper_id from helper where helper_tel = '01099999983')),
    ('jaejun', (select helper_id from helper where helper_tel = '01099999982')),

    ('yumi', (select helper_id from helper where helper_tel = '01099999999')),
    ('yumi', (select helper_id from helper where helper_tel = '01099999998')),
    ('yumi', (select helper_id from helper where helper_tel = '01099283732')),
    ('yumi', (select helper_id from helper where helper_tel = '01099999996')),
    ('yumi', (select helper_id from helper where helper_tel = '01099999995')),
    ('yumi', (select helper_id from helper where helper_tel = '01099999994')),
    ('yumi', (select helper_id from helper where helper_tel = '01099999993')),
    ('yumi', (select helper_id from helper where helper_tel = '01099999992')),
    ('yumi', (select helper_id from helper where helper_tel = '01099999991')),
    ('yumi', (select helper_id from helper where helper_tel = '01051188412')),
    ('yumi', (select helper_id from helper where helper_tel = '01099999989')),
    ('yumi', (select helper_id from helper where helper_tel = '01099999988')),
    ('yumi', (select helper_id from helper where helper_tel = '01099999987')),
    ('yumi', (select helper_id from helper where helper_tel = '01099999986')),
    ('yumi', (select helper_id from helper where helper_tel = '01099999985')),
    ('yumi', (select helper_id from helper where helper_tel = '01099999981')),
    ('yumi', (select helper_id from helper where helper_tel = '01099999983')),
    ('yumi', (select helper_id from helper where helper_tel = '01099999982')),

    ('huieun', (select helper_id from helper where helper_tel = '01099999999')),
    ('huieun', (select helper_id from helper where helper_tel = '01099999998')),
    ('huieun', (select helper_id from helper where helper_tel = '01099283732')),
    ('huieun', (select helper_id from helper where helper_tel = '01099999996')),
    ('huieun', (select helper_id from helper where helper_tel = '01099999995')),
    ('huieun', (select helper_id from helper where helper_tel = '01099999994')),
    ('huieun', (select helper_id from helper where helper_tel = '01099999993')),
    ('huieun', (select helper_id from helper where helper_tel = '01099999992')),
    ('huieun', (select helper_id from helper where helper_tel = '01099999991')),
    ('huieun', (select helper_id from helper where helper_tel = '01051188412')),
    ('huieun', (select helper_id from helper where helper_tel = '01099999989')),
    ('huieun', (select helper_id from helper where helper_tel = '01099999988')),
    ('huieun', (select helper_id from helper where helper_tel = '01099999987')),
    ('huieun', (select helper_id from helper where helper_tel = '01099999986')),
    ('huieun', (select helper_id from helper where helper_tel = '01099999985')),
    ('huieun', (select helper_id from helper where helper_tel = '01099999984')),
    ('huieun', (select helper_id from helper where helper_tel = '01099999981')),
    ('huieun', (select helper_id from helper where helper_tel = '01099999982')),

    ('sjpark', (select helper_id from helper where helper_tel = '01099999999')),
    ('sjpark', (select helper_id from helper where helper_tel = '01099999998')),
    ('sjpark', (select helper_id from helper where helper_tel = '01099283732')),
    ('sjpark', (select helper_id from helper where helper_tel = '01099999996')),
    ('sjpark', (select helper_id from helper where helper_tel = '01099999995')),
    ('sjpark', (select helper_id from helper where helper_tel = '01099999994')),
    ('sjpark', (select helper_id from helper where helper_tel = '01099999993')),
    ('sjpark', (select helper_id from helper where helper_tel = '01099999992')),
    ('sjpark', (select helper_id from helper where helper_tel = '01099999991')),
    ('sjpark', (select helper_id from helper where helper_tel = '01051188412')),
    ('sjpark', (select helper_id from helper where helper_tel = '01099999989')),
    ('sjpark', (select helper_id from helper where helper_tel = '01099999988')),
    ('sjpark', (select helper_id from helper where helper_tel = '01099999987')),
    ('sjpark', (select helper_id from helper where helper_tel = '01099999986')),
    ('sjpark', (select helper_id from helper where helper_tel = '01099999985')),
    ('sjpark', (select helper_id from helper where helper_tel = '01099999984')),
    ('sjpark', (select helper_id from helper where helper_tel = '01099999983')),
    ('sjpark', (select helper_id from helper where helper_tel = '01099999981')),

    ('seungwan', (select helper_id from helper where helper_tel = '01099999999')),
    ('seungwan', (select helper_id from helper where helper_tel = '01099999998')),
    ('seungwan', (select helper_id from helper where helper_tel = '01099283732')),
    ('seungwan', (select helper_id from helper where helper_tel = '01099999996')),
    ('seungwan', (select helper_id from helper where helper_tel = '01099999995')),
    ('seungwan', (select helper_id from helper where helper_tel = '01099999994')),
    ('seungwan', (select helper_id from helper where helper_tel = '01099999993')),
    ('seungwan', (select helper_id from helper where helper_tel = '01099999992')),
    ('seungwan', (select helper_id from helper where helper_tel = '01099999991')),
    ('seungwan', (select helper_id from helper where helper_tel = '01051188412')),
    ('seungwan', (select helper_id from helper where helper_tel = '01099999989')),
    ('seungwan', (select helper_id from helper where helper_tel = '01099999988')),
    ('seungwan', (select helper_id from helper where helper_tel = '01099999987')),
    ('seungwan', (select helper_id from helper where helper_tel = '01099999986')),
    ('seungwan', (select helper_id from helper where helper_tel = '01099999985')),
    ('seungwan', (select helper_id from helper where helper_tel = '01099999984')),
    ('seungwan', (select helper_id from helper where helper_tel = '01099999983')),
    ('seungwan', (select helper_id from helper where helper_tel = '01099999982')),


    ('dnjfemwlffjt', (select helper_id from helper where helper_tel = '01086062967')),
    ('dnjfemwlffjt', (select helper_id from helper where helper_tel = '01079399276'));


update mother set mother_obHospital_name = '더조은 아카데미', mother_obHospital_tel = '028381680' where mother_id = 'dnjfemwlffjt';


/* invite_list_HTM(헬퍼가 산모에게 보낸 친구등록 대기목록 테이블)에서 친구 수락하기 */
UPDATE invite_list_HTM
SET accept = CASE
                 WHEN helper_id = 'helper1' AND mother_id = 'mother1' THEN '1'
                 WHEN helper_id = 'helper1' AND mother_id = 'mother2' THEN '1'
                 WHEN helper_id = 'helper1' AND mother_id = 'mother3' THEN '1'
                 WHEN helper_id = 'helper2' AND mother_id = 'mother3' THEN '1'
                 WHEN helper_id = 'helper3' AND mother_id = 'mother3' THEN '1'
                 WHEN helper_id = 'helper4' AND mother_id = 'mother3' THEN '1'
                 WHEN helper_id = 'helper5' AND mother_id = 'mother3' THEN '1'
                 ELSE accept
    END
WHERE (helper_id, mother_id) IN (
                                 ('helper1', 'mother1'),
                                 ('helper1', 'mother2'),
                                 ('helper1', 'mother3'),
                                 ('helper2', 'mother3'),
                                 ('helper3', 'mother3'),
                                 ('helper4', 'mother3'),
                                 ('helper5', 'mother3')
    );
/* invite_list_MTH(산모가 헬퍼에게 보낸 친구등록 대기목록 테이블)에서 친구 수락하기 */
UPDATE invite_list_MTH
SET accept = CASE
                 WHEN mother_id = 'mother1' AND helper_id = 'helper6' THEN '1'
                 WHEN mother_id = 'mother1' AND helper_id = 'helper7' THEN '1'
                 WHEN mother_id = 'mother1' AND helper_id = 'helper8' THEN '1'
                 WHEN mother_id = 'mother1' AND helper_id = 'helper9' THEN '1'
                 WHEN mother_id = 'mother2' AND helper_id = 'helper9' THEN '1'
                 WHEN mother_id = 'mother3' AND helper_id = 'helper9' THEN '1'
                 WHEN mother_id = 'mother4' AND helper_id = 'helper9' THEN '1'
                 WHEN mother_id = 'dnjfemwlffjt' AND helper_id = 'dnjfemwlffjt2' THEN '1'
                 WHEN mother_id = 'dnjfemwlffjt' AND helper_id = 'dnjfemwlffjt3' THEN '1'

                 ELSE accept
    END
WHERE (mother_id, helper_id) IN (
                                 ('mother1', 'helper6'),
                                 ('mother1', 'helper7'),
                                 ('mother1', 'helper8'),
                                 ('mother1', 'helper9'),
                                 ('mother2', 'helper9'),
                                 ('dnjfemwlffjt', 'dnjfemwlffjt2'),
                                 ('dnjfemwlffjt', 'dnjfemwlffjt3')
    );

UPDATE invite_list_MTH
SET accept = CASE
                 WHEN mother_id = 'jaewon' AND helper_id = 'jinyoung' THEN '1'
                 WHEN mother_id = 'jaewon' AND helper_id = 'youngnam' THEN '1'
                 WHEN mother_id = 'jaewon' AND helper_id = 'seungyeon' THEN '1'
                 WHEN mother_id = 'jaewon' AND helper_id = 'hyerin' THEN '1'
                 WHEN mother_id = 'jaewon' AND helper_id = 'jueon' THEN '1'
                 WHEN mother_id = 'jaewon' AND helper_id = 'gowoon' THEN '1'
                 WHEN mother_id = 'jaewon' AND helper_id = 'moonju' THEN '1'
                 WHEN mother_id = 'jaewon' AND helper_id = 'hyunwoo' THEN '1'
                 WHEN mother_id = 'jaewon' AND helper_id = 'minho' THEN '1'
                 WHEN mother_id = 'jaewon' AND helper_id = 'minji' THEN '1'
                 WHEN mother_id = 'jaewon' AND helper_id = 'sejin' THEN '1'
                 WHEN mother_id = 'jaewon' AND helper_id = 'heeseon' THEN '1'
                 WHEN mother_id = 'jaewon' AND helper_id = 'youngwoong' THEN '1'
                 WHEN mother_id = 'jaewon' AND helper_id = 'jaejun' THEN '1'
                 WHEN mother_id = 'jaewon' AND helper_id = 'yumi' THEN '1'
                 WHEN mother_id = 'jaewon' AND helper_id = 'huieun' THEN '1'
                 WHEN mother_id = 'jaewon' AND helper_id = 'sjpark' THEN '1'
                 WHEN mother_id = 'jaewon' AND helper_id = 'seungwan' THEN '1'

                 WHEN mother_id = 'jinyoung' AND helper_id = 'jaewon' THEN '1'
                 WHEN mother_id = 'jinyoung' AND helper_id = 'youngnam' THEN '1'
                 WHEN mother_id = 'jinyoung' AND helper_id = 'seungyeon' THEN '1'
                 WHEN mother_id = 'jinyoung' AND helper_id = 'hyerin' THEN '1'
                 WHEN mother_id = 'jinyoung' AND helper_id = 'jueon' THEN '1'
                 WHEN mother_id = 'jinyoung' AND helper_id = 'gowoon' THEN '1'
                 WHEN mother_id = 'jinyoung' AND helper_id = 'moonju' THEN '1'
                 WHEN mother_id = 'jinyoung' AND helper_id = 'hyunwoo' THEN '1'
                 WHEN mother_id = 'jinyoung' AND helper_id = 'minho' THEN '1'
                 WHEN mother_id = 'jinyoung' AND helper_id = 'minji' THEN '1'
                 WHEN mother_id = 'jinyoung' AND helper_id = 'sejin' THEN '1'
                 WHEN mother_id = 'jinyoung' AND helper_id = 'heeseon' THEN '1'
                 WHEN mother_id = 'jinyoung' AND helper_id = 'youngwoong' THEN '1'
                 WHEN mother_id = 'jinyoung' AND helper_id = 'jaejun' THEN '1'
                 WHEN mother_id = 'jinyoung' AND helper_id = 'yumi' THEN '1'
                 WHEN mother_id = 'jinyoung' AND helper_id = 'huieun' THEN '1'
                 WHEN mother_id = 'jinyoung' AND helper_id = 'sjpark' THEN '1'
                 WHEN mother_id = 'jinyoung' AND helper_id = 'seungwan' THEN '1'

                 WHEN mother_id = 'youngnam' AND helper_id = 'jinyoung' THEN '1'
                 WHEN mother_id = 'youngnam' AND helper_id = 'jaewon' THEN '1'
                 WHEN mother_id = 'youngnam' AND helper_id = 'seungyeon' THEN '1'
                 WHEN mother_id = 'youngnam' AND helper_id = 'hyerin' THEN '1'
                 WHEN mother_id = 'youngnam' AND helper_id = 'jueon' THEN '1'
                 WHEN mother_id = 'youngnam' AND helper_id = 'gowoon' THEN '1'
                 WHEN mother_id = 'youngnam' AND helper_id = 'moonju' THEN '1'
                 WHEN mother_id = 'youngnam' AND helper_id = 'hyunwoo' THEN '1'
                 WHEN mother_id = 'youngnam' AND helper_id = 'minho' THEN '1'
                 WHEN mother_id = 'youngnam' AND helper_id = 'minji' THEN '1'
                 WHEN mother_id = 'youngnam' AND helper_id = 'sejin' THEN '1'
                 WHEN mother_id = 'youngnam' AND helper_id = 'heeseon' THEN '1'
                 WHEN mother_id = 'youngnam' AND helper_id = 'youngwoong' THEN '1'
                 WHEN mother_id = 'youngnam' AND helper_id = 'jaejun' THEN '1'
                 WHEN mother_id = 'youngnam' AND helper_id = 'yumi' THEN '1'
                 WHEN mother_id = 'youngnam' AND helper_id = 'huieun' THEN '1'
                 WHEN mother_id = 'youngnam' AND helper_id = 'sjpark' THEN '1'
                 WHEN mother_id = 'youngnam' AND helper_id = 'seungwan' THEN '1'

                 WHEN mother_id = 'seungyeon' AND helper_id = 'jinyoung' THEN '1'
                 WHEN mother_id = 'seungyeon' AND helper_id = 'youngnam' THEN '1'
                 WHEN mother_id = 'seungyeon' AND helper_id = 'jaewon' THEN '1'
                 WHEN mother_id = 'seungyeon' AND helper_id = 'hyerin' THEN '1'
                 WHEN mother_id = 'seungyeon' AND helper_id = 'jueon' THEN '1'
                 WHEN mother_id = 'seungyeon' AND helper_id = 'gowoon' THEN '1'
                 WHEN mother_id = 'seungyeon' AND helper_id = 'moonju' THEN '1'
                 WHEN mother_id = 'seungyeon' AND helper_id = 'hyunwoo' THEN '1'
                 WHEN mother_id = 'seungyeon' AND helper_id = 'minho' THEN '1'
                 WHEN mother_id = 'seungyeon' AND helper_id = 'minji' THEN '1'
                 WHEN mother_id = 'seungyeon' AND helper_id = 'sejin' THEN '1'
                 WHEN mother_id = 'seungyeon' AND helper_id = 'heeseon' THEN '1'
                 WHEN mother_id = 'seungyeon' AND helper_id = 'youngwoong' THEN '1'
                 WHEN mother_id = 'seungyeon' AND helper_id = 'jaejun' THEN '1'
                 WHEN mother_id = 'seungyeon' AND helper_id = 'yumi' THEN '1'
                 WHEN mother_id = 'seungyeon' AND helper_id = 'huieun' THEN '1'
                 WHEN mother_id = 'seungyeon' AND helper_id = 'sjpark' THEN '1'
                 WHEN mother_id = 'seungyeon' AND helper_id = 'seungwan' THEN '1'

                 WHEN mother_id = 'hyerin' AND helper_id = 'jinyoung' THEN '1'
                 WHEN mother_id = 'hyerin' AND helper_id = 'youngnam' THEN '1'
                 WHEN mother_id = 'hyerin' AND helper_id = 'seungyeon' THEN '1'
                 WHEN mother_id = 'hyerin' AND helper_id = 'jaewon' THEN '1'
                 WHEN mother_id = 'hyerin' AND helper_id = 'jueon' THEN '1'
                 WHEN mother_id = 'hyerin' AND helper_id = 'gowoon' THEN '1'
                 WHEN mother_id = 'hyerin' AND helper_id = 'moonju' THEN '1'
                 WHEN mother_id = 'hyerin' AND helper_id = 'hyunwoo' THEN '1'
                 WHEN mother_id = 'hyerin' AND helper_id = 'minho' THEN '1'
                 WHEN mother_id = 'hyerin' AND helper_id = 'minji' THEN '1'
                 WHEN mother_id = 'hyerin' AND helper_id = 'sejin' THEN '1'
                 WHEN mother_id = 'hyerin' AND helper_id = 'heeseon' THEN '1'
                 WHEN mother_id = 'hyerin' AND helper_id = 'youngwoong' THEN '1'
                 WHEN mother_id = 'hyerin' AND helper_id = 'jaejun' THEN '1'
                 WHEN mother_id = 'hyerin' AND helper_id = 'yumi' THEN '1'
                 WHEN mother_id = 'hyerin' AND helper_id = 'huieun' THEN '1'
                 WHEN mother_id = 'hyerin' AND helper_id = 'sjpark' THEN '1'
                 WHEN mother_id = 'hyerin' AND helper_id = 'seungwan' THEN '1'

                 WHEN mother_id = 'jueon' AND helper_id = 'jinyoung' THEN '1'
                 WHEN mother_id = 'jueon' AND helper_id = 'youngnam' THEN '1'
                 WHEN mother_id = 'jueon' AND helper_id = 'seungyeon' THEN '1'
                 WHEN mother_id = 'jueon' AND helper_id = 'hyerin' THEN '1'
                 WHEN mother_id = 'jueon' AND helper_id = 'jaewon' THEN '1'
                 WHEN mother_id = 'jueon' AND helper_id = 'gowoon' THEN '1'
                 WHEN mother_id = 'jueon' AND helper_id = 'moonju' THEN '1'
                 WHEN mother_id = 'jueon' AND helper_id = 'hyunwoo' THEN '1'
                 WHEN mother_id = 'jueon' AND helper_id = 'minho' THEN '1'
                 WHEN mother_id = 'jueon' AND helper_id = 'minji' THEN '1'
                 WHEN mother_id = 'jueon' AND helper_id = 'sejin' THEN '1'
                 WHEN mother_id = 'jueon' AND helper_id = 'heeseon' THEN '1'
                 WHEN mother_id = 'jueon' AND helper_id = 'youngwoong' THEN '1'
                 WHEN mother_id = 'jueon' AND helper_id = 'jaejun' THEN '1'
                 WHEN mother_id = 'jueon' AND helper_id = 'yumi' THEN '1'
                 WHEN mother_id = 'jueon' AND helper_id = 'huieun' THEN '1'
                 WHEN mother_id = 'jueon' AND helper_id = 'sjpark' THEN '1'
                 WHEN mother_id = 'jueon' AND helper_id = 'seungwan' THEN '1'

                 WHEN mother_id = 'gowoon' AND helper_id = 'jinyoung' THEN '1'
                 WHEN mother_id = 'gowoon' AND helper_id = 'youngnam' THEN '1'
                 WHEN mother_id = 'gowoon' AND helper_id = 'seungyeon' THEN '1'
                 WHEN mother_id = 'gowoon' AND helper_id = 'hyerin' THEN '1'
                 WHEN mother_id = 'gowoon' AND helper_id = 'jueon' THEN '1'
                 WHEN mother_id = 'gowoon' AND helper_id = 'jaewon' THEN '1'
                 WHEN mother_id = 'gowoon' AND helper_id = 'moonju' THEN '1'
                 WHEN mother_id = 'gowoon' AND helper_id = 'hyunwoo' THEN '1'
                 WHEN mother_id = 'gowoon' AND helper_id = 'minho' THEN '1'
                 WHEN mother_id = 'gowoon' AND helper_id = 'minji' THEN '1'
                 WHEN mother_id = 'gowoon' AND helper_id = 'sejin' THEN '1'
                 WHEN mother_id = 'gowoon' AND helper_id = 'heeseon' THEN '1'
                 WHEN mother_id = 'gowoon' AND helper_id = 'youngwoong' THEN '1'
                 WHEN mother_id = 'gowoon' AND helper_id = 'jaejun' THEN '1'
                 WHEN mother_id = 'gowoon' AND helper_id = 'yumi' THEN '1'
                 WHEN mother_id = 'gowoon' AND helper_id = 'huieun' THEN '1'
                 WHEN mother_id = 'gowoon' AND helper_id = 'sjpark' THEN '1'
                 WHEN mother_id = 'gowoon' AND helper_id = 'seungwan' THEN '1'

                 WHEN mother_id = 'moonju' AND helper_id = 'jinyoung' THEN '1'
                 WHEN mother_id = 'moonju' AND helper_id = 'youngnam' THEN '1'
                 WHEN mother_id = 'moonju' AND helper_id = 'seungyeon' THEN '1'
                 WHEN mother_id = 'moonju' AND helper_id = 'hyerin' THEN '1'
                 WHEN mother_id = 'moonju' AND helper_id = 'jueon' THEN '1'
                 WHEN mother_id = 'moonju' AND helper_id = 'gowoon' THEN '1'
                 WHEN mother_id = 'moonju' AND helper_id = 'jaewon' THEN '1'
                 WHEN mother_id = 'moonju' AND helper_id = 'hyunwoo' THEN '1'
                 WHEN mother_id = 'moonju' AND helper_id = 'minho' THEN '1'
                 WHEN mother_id = 'moonju' AND helper_id = 'minji' THEN '1'
                 WHEN mother_id = 'moonju' AND helper_id = 'sejin' THEN '1'
                 WHEN mother_id = 'moonju' AND helper_id = 'heeseon' THEN '1'
                 WHEN mother_id = 'moonju' AND helper_id = 'youngwoong' THEN '1'
                 WHEN mother_id = 'moonju' AND helper_id = 'jaejun' THEN '1'
                 WHEN mother_id = 'moonju' AND helper_id = 'yumi' THEN '1'
                 WHEN mother_id = 'moonju' AND helper_id = 'huieun' THEN '1'
                 WHEN mother_id = 'moonju' AND helper_id = 'sjpark' THEN '1'
                 WHEN mother_id = 'moonju' AND helper_id = 'seungwan' THEN '1'

                 WHEN mother_id = 'hyunwoo' AND helper_id = 'jinyoung' THEN '1'
                 WHEN mother_id = 'hyunwoo' AND helper_id = 'youngnam' THEN '1'
                 WHEN mother_id = 'hyunwoo' AND helper_id = 'seungyeon' THEN '1'
                 WHEN mother_id = 'hyunwoo' AND helper_id = 'hyerin' THEN '1'
                 WHEN mother_id = 'hyunwoo' AND helper_id = 'jueon' THEN '1'
                 WHEN mother_id = 'hyunwoo' AND helper_id = 'gowoon' THEN '1'
                 WHEN mother_id = 'hyunwoo' AND helper_id = 'moonju' THEN '1'
                 WHEN mother_id = 'hyunwoo' AND helper_id = 'jaewon' THEN '1'
                 WHEN mother_id = 'hyunwoo' AND helper_id = 'minho' THEN '1'
                 WHEN mother_id = 'hyunwoo' AND helper_id = 'minji' THEN '1'
                 WHEN mother_id = 'hyunwoo' AND helper_id = 'sejin' THEN '1'
                 WHEN mother_id = 'hyunwoo' AND helper_id = 'heeseon' THEN '1'
                 WHEN mother_id = 'hyunwoo' AND helper_id = 'youngwoong' THEN '1'
                 WHEN mother_id = 'hyunwoo' AND helper_id = 'jaejun' THEN '1'
                 WHEN mother_id = 'hyunwoo' AND helper_id = 'yumi' THEN '1'
                 WHEN mother_id = 'hyunwoo' AND helper_id = 'huieun' THEN '1'
                 WHEN mother_id = 'hyunwoo' AND helper_id = 'sjpark' THEN '1'
                 WHEN mother_id = 'hyunwoo' AND helper_id = 'seungwan' THEN '1'

                 WHEN mother_id = 'minho' AND helper_id = 'jinyoung' THEN '1'
                 WHEN mother_id = 'minho' AND helper_id = 'youngnam' THEN '1'
                 WHEN mother_id = 'minho' AND helper_id = 'seungyeon' THEN '1'
                 WHEN mother_id = 'minho' AND helper_id = 'hyerin' THEN '1'
                 WHEN mother_id = 'minho' AND helper_id = 'jueon' THEN '1'
                 WHEN mother_id = 'minho' AND helper_id = 'gowoon' THEN '1'
                 WHEN mother_id = 'minho' AND helper_id = 'moonju' THEN '1'
                 WHEN mother_id = 'minho' AND helper_id = 'hyunwoo' THEN '1'
                 WHEN mother_id = 'minho' AND helper_id = 'jaewon' THEN '1'
                 WHEN mother_id = 'minho' AND helper_id = 'minji' THEN '1'
                 WHEN mother_id = 'minho' AND helper_id = 'sejin' THEN '1'
                 WHEN mother_id = 'minho' AND helper_id = 'heeseon' THEN '1'
                 WHEN mother_id = 'minho' AND helper_id = 'youngwoong' THEN '1'
                 WHEN mother_id = 'minho' AND helper_id = 'jaejun' THEN '1'
                 WHEN mother_id = 'minho' AND helper_id = 'yumi' THEN '1'
                 WHEN mother_id = 'minho' AND helper_id = 'huieun' THEN '1'
                 WHEN mother_id = 'minho' AND helper_id = 'sjpark' THEN '1'
                 WHEN mother_id = 'minho' AND helper_id = 'seungwan' THEN '1'

                 WHEN mother_id = 'minji' AND helper_id = 'jinyoung' THEN '1'
                 WHEN mother_id = 'minji' AND helper_id = 'youngnam' THEN '1'
                 WHEN mother_id = 'minji' AND helper_id = 'seungyeon' THEN '1'
                 WHEN mother_id = 'minji' AND helper_id = 'hyerin' THEN '1'
                 WHEN mother_id = 'minji' AND helper_id = 'jueon' THEN '1'
                 WHEN mother_id = 'minji' AND helper_id = 'gowoon' THEN '1'
                 WHEN mother_id = 'minji' AND helper_id = 'moonju' THEN '1'
                 WHEN mother_id = 'minji' AND helper_id = 'hyunwoo' THEN '1'
                 WHEN mother_id = 'minji' AND helper_id = 'minho' THEN '1'
                 WHEN mother_id = 'minji' AND helper_id = 'jaewon' THEN '1'
                 WHEN mother_id = 'minji' AND helper_id = 'sejin' THEN '1'
                 WHEN mother_id = 'minji' AND helper_id = 'heeseon' THEN '1'
                 WHEN mother_id = 'minji' AND helper_id = 'youngwoong' THEN '1'
                 WHEN mother_id = 'minji' AND helper_id = 'jaejun' THEN '1'
                 WHEN mother_id = 'minji' AND helper_id = 'yumi' THEN '1'
                 WHEN mother_id = 'minji' AND helper_id = 'huieun' THEN '1'
                 WHEN mother_id = 'minji' AND helper_id = 'sjpark' THEN '1'
                 WHEN mother_id = 'minji' AND helper_id = 'seungwan' THEN '1'

                 WHEN mother_id = 'sejin' AND helper_id = 'jinyoung' THEN '1'
                 WHEN mother_id = 'sejin' AND helper_id = 'youngnam' THEN '1'
                 WHEN mother_id = 'sejin' AND helper_id = 'seungyeon' THEN '1'
                 WHEN mother_id = 'sejin' AND helper_id = 'hyerin' THEN '1'
                 WHEN mother_id = 'sejin' AND helper_id = 'jueon' THEN '1'
                 WHEN mother_id = 'sejin' AND helper_id = 'gowoon' THEN '1'
                 WHEN mother_id = 'sejin' AND helper_id = 'moonju' THEN '1'
                 WHEN mother_id = 'sejin' AND helper_id = 'hyunwoo' THEN '1'
                 WHEN mother_id = 'sejin' AND helper_id = 'minho' THEN '1'
                 WHEN mother_id = 'sejin' AND helper_id = 'minji' THEN '1'
                 WHEN mother_id = 'sejin' AND helper_id = 'jaewon' THEN '1'
                 WHEN mother_id = 'sejin' AND helper_id = 'heeseon' THEN '1'
                 WHEN mother_id = 'sejin' AND helper_id = 'youngwoong' THEN '1'
                 WHEN mother_id = 'sejin' AND helper_id = 'jaejun' THEN '1'
                 WHEN mother_id = 'sejin' AND helper_id = 'yumi' THEN '1'
                 WHEN mother_id = 'sejin' AND helper_id = 'huieun' THEN '1'
                 WHEN mother_id = 'sejin' AND helper_id = 'sjpark' THEN '1'
                 WHEN mother_id = 'sejin' AND helper_id = 'seungwan' THEN '1'

                 WHEN mother_id = 'heeseon' AND helper_id = 'jinyoung' THEN '1'
                 WHEN mother_id = 'heeseon' AND helper_id = 'youngnam' THEN '1'
                 WHEN mother_id = 'heeseon' AND helper_id = 'seungyeon' THEN '1'
                 WHEN mother_id = 'heeseon' AND helper_id = 'hyerin' THEN '1'
                 WHEN mother_id = 'heeseon' AND helper_id = 'jueon' THEN '1'
                 WHEN mother_id = 'heeseon' AND helper_id = 'gowoon' THEN '1'
                 WHEN mother_id = 'heeseon' AND helper_id = 'moonju' THEN '1'
                 WHEN mother_id = 'heeseon' AND helper_id = 'hyunwoo' THEN '1'
                 WHEN mother_id = 'heeseon' AND helper_id = 'minho' THEN '1'
                 WHEN mother_id = 'heeseon' AND helper_id = 'minji' THEN '1'
                 WHEN mother_id = 'heeseon' AND helper_id = 'sejin' THEN '1'
                 WHEN mother_id = 'heeseon' AND helper_id = 'jaewon' THEN '1'
                 WHEN mother_id = 'heeseon' AND helper_id = 'youngwoong' THEN '1'
                 WHEN mother_id = 'heeseon' AND helper_id = 'jaejun' THEN '1'
                 WHEN mother_id = 'heeseon' AND helper_id = 'yumi' THEN '1'
                 WHEN mother_id = 'heeseon' AND helper_id = 'huieun' THEN '1'
                 WHEN mother_id = 'heeseon' AND helper_id = 'sjpark' THEN '1'
                 WHEN mother_id = 'heeseon' AND helper_id = 'seungwan' THEN '1'

                 WHEN mother_id = 'youngwoong' AND helper_id = 'jinyoung' THEN '1'
                 WHEN mother_id = 'youngwoong' AND helper_id = 'youngnam' THEN '1'
                 WHEN mother_id = 'youngwoong' AND helper_id = 'seungyeon' THEN '1'
                 WHEN mother_id = 'youngwoong' AND helper_id = 'hyerin' THEN '1'
                 WHEN mother_id = 'youngwoong' AND helper_id = 'jueon' THEN '1'
                 WHEN mother_id = 'youngwoong' AND helper_id = 'gowoon' THEN '1'
                 WHEN mother_id = 'youngwoong' AND helper_id = 'moonju' THEN '1'
                 WHEN mother_id = 'youngwoong' AND helper_id = 'hyunwoo' THEN '1'
                 WHEN mother_id = 'youngwoong' AND helper_id = 'minho' THEN '1'
                 WHEN mother_id = 'youngwoong' AND helper_id = 'minji' THEN '1'
                 WHEN mother_id = 'youngwoong' AND helper_id = 'sejin' THEN '1'
                 WHEN mother_id = 'youngwoong' AND helper_id = 'heeseon' THEN '1'
                 WHEN mother_id = 'youngwoong' AND helper_id = 'jaewon' THEN '1'
                 WHEN mother_id = 'youngwoong' AND helper_id = 'jaejun' THEN '1'
                 WHEN mother_id = 'youngwoong' AND helper_id = 'yumi' THEN '1'
                 WHEN mother_id = 'youngwoong' AND helper_id = 'huieun' THEN '1'
                 WHEN mother_id = 'youngwoong' AND helper_id = 'sjpark' THEN '1'
                 WHEN mother_id = 'youngwoong' AND helper_id = 'seungwan' THEN '1'

                 WHEN mother_id = 'jaejun' AND helper_id = 'jinyoung' THEN '1'
                 WHEN mother_id = 'jaejun' AND helper_id = 'youngnam' THEN '1'
                 WHEN mother_id = 'jaejun' AND helper_id = 'seungyeon' THEN '1'
                 WHEN mother_id = 'jaejun' AND helper_id = 'hyerin' THEN '1'
                 WHEN mother_id = 'jaejun' AND helper_id = 'jueon' THEN '1'
                 WHEN mother_id = 'jaejun' AND helper_id = 'gowoon' THEN '1'
                 WHEN mother_id = 'jaejun' AND helper_id = 'moonju' THEN '1'
                 WHEN mother_id = 'jaejun' AND helper_id = 'hyunwoo' THEN '1'
                 WHEN mother_id = 'jaejun' AND helper_id = 'minho' THEN '1'
                 WHEN mother_id = 'jaejun' AND helper_id = 'minji' THEN '1'
                 WHEN mother_id = 'jaejun' AND helper_id = 'sejin' THEN '1'
                 WHEN mother_id = 'jaejun' AND helper_id = 'heeseon' THEN '1'
                 WHEN mother_id = 'jaejun' AND helper_id = 'youngwoong' THEN '1'
                 WHEN mother_id = 'jaejun' AND helper_id = 'jaewon' THEN '1'
                 WHEN mother_id = 'jaejun' AND helper_id = 'yumi' THEN '1'
                 WHEN mother_id = 'jaejun' AND helper_id = 'huieun' THEN '1'
                 WHEN mother_id = 'jaejun' AND helper_id = 'sjpark' THEN '1'
                 WHEN mother_id = 'jaejun' AND helper_id = 'seungwan' THEN '1'

                 WHEN mother_id = 'yumi' AND helper_id = 'jinyoung' THEN '1'
                 WHEN mother_id = 'yumi' AND helper_id = 'youngnam' THEN '1'
                 WHEN mother_id = 'yumi' AND helper_id = 'seungyeon' THEN '1'
                 WHEN mother_id = 'yumi' AND helper_id = 'hyerin' THEN '1'
                 WHEN mother_id = 'yumi' AND helper_id = 'jueon' THEN '1'
                 WHEN mother_id = 'yumi' AND helper_id = 'gowoon' THEN '1'
                 WHEN mother_id = 'yumi' AND helper_id = 'moonju' THEN '1'
                 WHEN mother_id = 'yumi' AND helper_id = 'hyunwoo' THEN '1'
                 WHEN mother_id = 'yumi' AND helper_id = 'minho' THEN '1'
                 WHEN mother_id = 'yumi' AND helper_id = 'minji' THEN '1'
                 WHEN mother_id = 'yumi' AND helper_id = 'sejin' THEN '1'
                 WHEN mother_id = 'yumi' AND helper_id = 'heeseon' THEN '1'
                 WHEN mother_id = 'yumi' AND helper_id = 'youngwoong' THEN '1'
                 WHEN mother_id = 'yumi' AND helper_id = 'jaejun' THEN '1'
                 WHEN mother_id = 'yumi' AND helper_id = 'jaewon' THEN '1'
                 WHEN mother_id = 'yumi' AND helper_id = 'huieun' THEN '1'
                 WHEN mother_id = 'yumi' AND helper_id = 'sjpark' THEN '1'
                 WHEN mother_id = 'yumi' AND helper_id = 'seungwan' THEN '1'

                 WHEN mother_id = 'huieun' AND helper_id = 'jinyoung' THEN '1'
                 WHEN mother_id = 'huieun' AND helper_id = 'youngnam' THEN '1'
                 WHEN mother_id = 'huieun' AND helper_id = 'seungyeon' THEN '1'
                 WHEN mother_id = 'huieun' AND helper_id = 'hyerin' THEN '1'
                 WHEN mother_id = 'huieun' AND helper_id = 'jueon' THEN '1'
                 WHEN mother_id = 'huieun' AND helper_id = 'gowoon' THEN '1'
                 WHEN mother_id = 'huieun' AND helper_id = 'moonju' THEN '1'
                 WHEN mother_id = 'huieun' AND helper_id = 'hyunwoo' THEN '1'
                 WHEN mother_id = 'huieun' AND helper_id = 'minho' THEN '1'
                 WHEN mother_id = 'huieun' AND helper_id = 'minji' THEN '1'
                 WHEN mother_id = 'huieun' AND helper_id = 'sejin' THEN '1'
                 WHEN mother_id = 'huieun' AND helper_id = 'heeseon' THEN '1'
                 WHEN mother_id = 'huieun' AND helper_id = 'youngwoong' THEN '1'
                 WHEN mother_id = 'huieun' AND helper_id = 'jaejun' THEN '1'
                 WHEN mother_id = 'huieun' AND helper_id = 'yumi' THEN '1'
                 WHEN mother_id = 'huieun' AND helper_id = 'jaewon' THEN '1'
                 WHEN mother_id = 'huieun' AND helper_id = 'sjpark' THEN '1'
                 WHEN mother_id = 'huieun' AND helper_id = 'seungwan' THEN '1'

                 WHEN mother_id = 'sjpark' AND helper_id = 'jinyoung' THEN '1'
                 WHEN mother_id = 'sjpark' AND helper_id = 'youngnam' THEN '1'
                 WHEN mother_id = 'sjpark' AND helper_id = 'seungyeon' THEN '1'
                 WHEN mother_id = 'sjpark' AND helper_id = 'hyerin' THEN '1'
                 WHEN mother_id = 'sjpark' AND helper_id = 'jueon' THEN '1'
                 WHEN mother_id = 'sjpark' AND helper_id = 'gowoon' THEN '1'
                 WHEN mother_id = 'sjpark' AND helper_id = 'moonju' THEN '1'
                 WHEN mother_id = 'sjpark' AND helper_id = 'hyunwoo' THEN '1'
                 WHEN mother_id = 'sjpark' AND helper_id = 'minho' THEN '1'
                 WHEN mother_id = 'sjpark' AND helper_id = 'minji' THEN '1'
                 WHEN mother_id = 'sjpark' AND helper_id = 'sejin' THEN '1'
                 WHEN mother_id = 'sjpark' AND helper_id = 'heeseon' THEN '1'
                 WHEN mother_id = 'sjpark' AND helper_id = 'youngwoong' THEN '1'
                 WHEN mother_id = 'sjpark' AND helper_id = 'jaejun' THEN '1'
                 WHEN mother_id = 'sjpark' AND helper_id = 'yumi' THEN '1'
                 WHEN mother_id = 'sjpark' AND helper_id = 'huieun' THEN '1'
                 WHEN mother_id = 'sjpark' AND helper_id = 'jaewon' THEN '1'
                 WHEN mother_id = 'sjpark' AND helper_id = 'seungwan' THEN '1'

                 WHEN mother_id = 'seungwan' AND helper_id = 'jinyoung' THEN '1'
                 WHEN mother_id = 'seungwan' AND helper_id = 'youngnam' THEN '1'
                 WHEN mother_id = 'seungwan' AND helper_id = 'seungyeon' THEN '1'
                 WHEN mother_id = 'seungwan' AND helper_id = 'hyerin' THEN '1'
                 WHEN mother_id = 'seungwan' AND helper_id = 'jueon' THEN '1'
                 WHEN mother_id = 'seungwan' AND helper_id = 'gowoon' THEN '1'
                 WHEN mother_id = 'seungwan' AND helper_id = 'moonju' THEN '1'
                 WHEN mother_id = 'seungwan' AND helper_id = 'hyunwoo' THEN '1'
                 WHEN mother_id = 'seungwan' AND helper_id = 'minho' THEN '1'
                 WHEN mother_id = 'seungwan' AND helper_id = 'minji' THEN '1'
                 WHEN mother_id = 'seungwan' AND helper_id = 'sejin' THEN '1'
                 WHEN mother_id = 'seungwan' AND helper_id = 'heeseon' THEN '1'
                 WHEN mother_id = 'seungwan' AND helper_id = 'youngwoong' THEN '1'
                 WHEN mother_id = 'seungwan' AND helper_id = 'jaejun' THEN '1'
                 WHEN mother_id = 'seungwan' AND helper_id = 'yumi' THEN '1'
                 WHEN mother_id = 'seungwan' AND helper_id = 'huieun' THEN '1'
                 WHEN mother_id = 'seungwan' AND helper_id = 'sjpark' THEN '1'
                 WHEN mother_id = 'seungwan' AND helper_id = 'jaewon' THEN '1'









                 ELSE accept
    END
WHERE (mother_id, helper_id) IN (
                                 ('jaewon', 'jinyoung'),
                                 ('jaewon', 'youngnam'),
                                 ('jaewon', 'seungyeon'),
                                 ('jaewon', 'hyerin'),
                                 ('jaewon', 'jueon'),
                                 ('jaewon', 'gowoon'),
                                 ('jaewon', 'moonju'),
                                 ('jaewon', 'hyunwoo'),
                                 ('jaewon', 'minho'),
                                 ('jaewon', 'minji'),
                                 ('jaewon', 'sejin'),
                                 ('jaewon', 'heeseon'),
                                 ('jaewon', 'youngwoong'),
                                 ('jaewon', 'jaejun'),
                                 ('jaewon', 'yumi'),
                                 ('jaewon', 'huieun'),
                                 ('jaewon', 'sjpark'),
                                 ('jaewon', 'seungwan'),

                                 ('jinyoung', 'jaewon'),
                                 ('jinyoung', 'youngnam'),
                                 ('jinyoung', 'seungyeon'),
                                 ('jinyoung', 'hyerin'),
                                 ('jinyoung', 'jueon'),
                                 ('jinyoung', 'gowoon'),
                                 ('jinyoung', 'moonju'),
                                 ('jinyoung', 'hyunwoo'),
                                 ('jinyoung', 'minho'),
                                 ('jinyoung', 'minji'),
                                 ('jinyoung', 'sejin'),
                                 ('jinyoung', 'heeseon'),
                                 ('jinyoung', 'youngwoong'),
                                 ('jinyoung', 'jaejun'),
                                 ('jinyoung', 'yumi'),
                                 ('jinyoung', 'huieun'),
                                 ('jinyoung', 'sjpark'),
                                 ('jinyoung', 'seungwan'),

                                 ('youngnam', 'jinyoung'),
                                 ('youngnam', 'jaewon'),
                                 ('youngnam', 'seungyeon'),
                                 ('youngnam', 'hyerin'),
                                 ('youngnam', 'jueon'),
                                 ('youngnam', 'gowoon'),
                                 ('youngnam', 'moonju'),
                                 ('youngnam', 'hyunwoo'),
                                 ('youngnam', 'minho'),
                                 ('youngnam', 'minji'),
                                 ('youngnam', 'sejin'),
                                 ('youngnam', 'heeseon'),
                                 ('youngnam', 'youngwoong'),
                                 ('youngnam', 'jaejun'),
                                 ('youngnam', 'yumi'),
                                 ('youngnam', 'huieun'),
                                 ('youngnam', 'sjpark'),
                                 ('youngnam', 'seungwan'),

                                 ('seungyeon', 'jinyoung'),
                                 ('seungyeon', 'youngnam'),
                                 ('seungyeon', 'jaewon'),
                                 ('seungyeon', 'hyerin'),
                                 ('seungyeon', 'jueon'),
                                 ('seungyeon', 'gowoon'),
                                 ('seungyeon', 'moonju'),
                                 ('seungyeon', 'hyunwoo'),
                                 ('seungyeon', 'minho'),
                                 ('seungyeon', 'minji'),
                                 ('seungyeon', 'sejin'),
                                 ('seungyeon', 'heeseon'),
                                 ('seungyeon', 'youngwoong'),
                                 ('seungyeon', 'jaejun'),
                                 ('seungyeon', 'yumi'),
                                 ('seungyeon', 'huieun'),
                                 ('seungyeon', 'sjpark'),
                                 ('seungyeon', 'seungwan'),

                                 ('hyerin', 'jinyoung'),
                                 ('hyerin', 'youngnam'),
                                 ('hyerin', 'seungyeon'),
                                 ('hyerin', 'jaewon'),
                                 ('hyerin', 'jueon'),
                                 ('hyerin', 'gowoon'),
                                 ('hyerin', 'moonju'),
                                 ('hyerin', 'hyunwoo'),
                                 ('hyerin', 'minho'),
                                 ('hyerin', 'minji'),
                                 ('hyerin', 'sejin'),
                                 ('hyerin', 'heeseon'),
                                 ('hyerin', 'youngwoong'),
                                 ('hyerin', 'jaejun'),
                                 ('hyerin', 'yumi'),
                                 ('hyerin', 'huieun'),
                                 ('hyerin', 'sjpark'),
                                 ('hyerin', 'seungwan'),

                                 ('jueon', 'jinyoung'),
                                 ('jueon', 'youngnam'),
                                 ('jueon', 'seungyeon'),
                                 ('jueon', 'hyerin'),
                                 ('jueon', 'jaewon'),
                                 ('jueon', 'gowoon'),
                                 ('jueon', 'moonju'),
                                 ('jueon', 'hyunwoo'),
                                 ('jueon', 'minho'),
                                 ('jueon', 'minji'),
                                 ('jueon', 'sejin'),
                                 ('jueon', 'heeseon'),
                                 ('jueon', 'youngwoong'),
                                 ('jueon', 'jaejun'),
                                 ('jueon', 'yumi'),
                                 ('jueon', 'huieun'),
                                 ('jueon', 'sjpark'),
                                 ('jueon', 'seungwan'),

                                 ('gowoon', 'jinyoung'),
                                 ('gowoon', 'youngnam'),
                                 ('gowoon', 'seungyeon'),
                                 ('gowoon', 'hyerin'),
                                 ('gowoon', 'jueon'),
                                 ('gowoon', 'jaewon'),
                                 ('gowoon', 'moonju'),
                                 ('gowoon', 'hyunwoo'),
                                 ('gowoon', 'minho'),
                                 ('gowoon', 'minji'),
                                 ('gowoon', 'sejin'),
                                 ('gowoon', 'heeseon'),
                                 ('gowoon', 'youngwoong'),
                                 ('gowoon', 'jaejun'),
                                 ('gowoon', 'yumi'),
                                 ('gowoon', 'huieun'),
                                 ('gowoon', 'sjpark'),
                                 ('gowoon', 'seungwan'),

                                 ('moonju', 'jinyoung'),
                                 ('moonju', 'youngnam'),
                                 ('moonju', 'seungyeon'),
                                 ('moonju', 'hyerin'),
                                 ('moonju', 'jueon'),
                                 ('moonju', 'gowoon'),
                                 ('moonju', 'jaewon'),
                                 ('moonju', 'hyunwoo'),
                                 ('moonju', 'minho'),
                                 ('moonju', 'minji'),
                                 ('moonju', 'sejin'),
                                 ('moonju', 'heeseon'),
                                 ('moonju', 'youngwoong'),
                                 ('moonju', 'jaejun'),
                                 ('moonju', 'yumi'),
                                 ('moonju', 'huieun'),
                                 ('moonju', 'sjpark'),
                                 ('moonju', 'seungwan'),

                                 ('hyunwoo', 'jinyoung'),
                                 ('hyunwoo', 'youngnam'),
                                 ('hyunwoo', 'seungyeon'),
                                 ('hyunwoo', 'hyerin'),
                                 ('hyunwoo', 'jueon'),
                                 ('hyunwoo', 'gowoon'),
                                 ('hyunwoo', 'moonju'),
                                 ('hyunwoo', 'jaewon'),
                                 ('hyunwoo', 'minho'),
                                 ('hyunwoo', 'minji'),
                                 ('hyunwoo', 'sejin'),
                                 ('hyunwoo', 'heeseon'),
                                 ('hyunwoo', 'youngwoong'),
                                 ('hyunwoo', 'jaejun'),
                                 ('hyunwoo', 'yumi'),
                                 ('hyunwoo', 'huieun'),
                                 ('hyunwoo', 'sjpark'),
                                 ('hyunwoo', 'seungwan'),

                                 ('minho', 'jinyoung'),
                                 ('minho', 'youngnam'),
                                 ('minho', 'seungyeon'),
                                 ('minho', 'hyerin'),
                                 ('minho', 'jueon'),
                                 ('minho', 'gowoon'),
                                 ('minho', 'moonju'),
                                 ('minho', 'hyunwoo'),
                                 ('minho', 'jaewon'),
                                 ('minho', 'minji'),
                                 ('minho', 'sejin'),
                                 ('minho', 'heeseon'),
                                 ('minho', 'youngwoong'),
                                 ('minho', 'jaejun'),
                                 ('minho', 'yumi'),
                                 ('minho', 'huieun'),
                                 ('minho', 'sjpark'),
                                 ('minho', 'seungwan'),

                                 ('minji', 'jinyoung'),
                                 ('minji', 'youngnam'),
                                 ('minji', 'seungyeon'),
                                 ('minji', 'hyerin'),
                                 ('minji', 'jueon'),
                                 ('minji', 'gowoon'),
                                 ('minji', 'moonju'),
                                 ('minji', 'hyunwoo'),
                                 ('minji', 'minho'),
                                 ('minji', 'jaewon'),
                                 ('minji', 'sejin'),
                                 ('minji', 'heeseon'),
                                 ('minji', 'youngwoong'),
                                 ('minji', 'jaejun'),
                                 ('minji', 'yumi'),
                                 ('minji', 'huieun'),
                                 ('minji', 'sjpark'),
                                 ('minji', 'seungwan'),

                                 ('sejin', 'jinyoung'),
                                 ('sejin', 'youngnam'),
                                 ('sejin', 'seungyeon'),
                                 ('sejin', 'hyerin'),
                                 ('sejin', 'jueon'),
                                 ('sejin', 'gowoon'),
                                 ('sejin', 'moonju'),
                                 ('sejin', 'hyunwoo'),
                                 ('sejin', 'minho'),
                                 ('sejin', 'minji'),
                                 ('sejin', 'jaewon'),
                                 ('sejin', 'heeseon'),
                                 ('sejin', 'youngwoong'),
                                 ('sejin', 'jaejun'),
                                 ('sejin', 'yumi'),
                                 ('sejin', 'huieun'),
                                 ('sejin', 'sjpark'),
                                 ('sejin', 'seungwan'),

                                 ('heeseon', 'jinyoung'),
                                 ('heeseon', 'youngnam'),
                                 ('heeseon', 'seungyeon'),
                                 ('heeseon', 'hyerin'),
                                 ('heeseon', 'jueon'),
                                 ('heeseon', 'gowoon'),
                                 ('heeseon', 'moonju'),
                                 ('heeseon', 'hyunwoo'),
                                 ('heeseon', 'minho'),
                                 ('heeseon', 'minji'),
                                 ('heeseon', 'sejin'),
                                 ('heeseon', 'jaewon'),
                                 ('heeseon', 'youngwoong'),
                                 ('heeseon', 'jaejun'),
                                 ('heeseon', 'yumi'),
                                 ('heeseon', 'huieun'),
                                 ('heeseon', 'sjpark'),
                                 ('heeseon', 'seungwan'),

                                 ('youngwoong', 'jinyoung'),
                                 ('youngwoong', 'youngnam'),
                                 ('youngwoong', 'seungyeon'),
                                 ('youngwoong', 'hyerin'),
                                 ('youngwoong', 'jueon'),
                                 ('youngwoong', 'gowoon'),
                                 ('youngwoong', 'moonju'),
                                 ('youngwoong', 'hyunwoo'),
                                 ('youngwoong', 'minho'),
                                 ('youngwoong', 'minji'),
                                 ('youngwoong', 'sejin'),
                                 ('youngwoong', 'heeseon'),
                                 ('youngwoong', 'jaewon'),
                                 ('youngwoong', 'jaejun'),
                                 ('youngwoong', 'yumi'),
                                 ('youngwoong', 'huieun'),
                                 ('youngwoong', 'sjpark'),
                                 ('youngwoong', 'seungwan'),

                                 ('jaejun', 'jinyoung'),
                                 ('jaejun', 'youngnam'),
                                 ('jaejun', 'seungyeon'),
                                 ('jaejun', 'hyerin'),
                                 ('jaejun', 'jueon'),
                                 ('jaejun', 'gowoon'),
                                 ('jaejun', 'moonju'),
                                 ('jaejun', 'hyunwoo'),
                                 ('jaejun', 'minho'),
                                 ('jaejun', 'minji'),
                                 ('jaejun', 'sejin'),
                                 ('jaejun', 'heeseon'),
                                 ('jaejun', 'youngwoong'),
                                 ('jaejun', 'jaewon'),
                                 ('jaejun', 'yumi'),
                                 ('jaejun', 'huieun'),
                                 ('jaejun', 'sjpark'),
                                 ('jaejun', 'seungwan'),

                                 ('yumi', 'jinyoung'),
                                 ('yumi', 'youngnam'),
                                 ('yumi', 'seungyeon'),
                                 ('yumi', 'hyerin'),
                                 ('yumi', 'jueon'),
                                 ('yumi', 'gowoon'),
                                 ('yumi', 'moonju'),
                                 ('yumi', 'hyunwoo'),
                                 ('yumi', 'minho'),
                                 ('yumi', 'minji'),
                                 ('yumi', 'sejin'),
                                 ('yumi', 'heeseon'),
                                 ('yumi', 'youngwoong'),
                                 ('yumi', 'jaejun'),
                                 ('yumi', 'jaewon'),
                                 ('yumi', 'huieun'),
                                 ('yumi', 'sjpark'),
                                 ('yumi', 'seungwan'),

                                 ('huieun', 'jinyoung'),
                                 ('huieun', 'youngnam'),
                                 ('huieun', 'seungyeon'),
                                 ('huieun', 'hyerin'),
                                 ('huieun', 'jueon'),
                                 ('huieun', 'gowoon'),
                                 ('huieun', 'moonju'),
                                 ('huieun', 'hyunwoo'),
                                 ('huieun', 'minho'),
                                 ('huieun', 'minji'),
                                 ('huieun', 'sejin'),
                                 ('huieun', 'heeseon'),
                                 ('huieun', 'youngwoong'),
                                 ('huieun', 'jaejun'),
                                 ('huieun', 'yumi'),
                                 ('huieun', 'jaewon'),
                                 ('huieun', 'sjpark'),
                                 ('huieun', 'seungwan'),

                                 ('sjpark', 'jinyoung'),
                                 ('sjpark', 'youngnam'),
                                 ('sjpark', 'seungyeon'),
                                 ('sjpark', 'hyerin'),
                                 ('sjpark', 'jueon'),
                                 ('sjpark', 'gowoon'),
                                 ('sjpark', 'moonju'),
                                 ('sjpark', 'hyunwoo'),
                                 ('sjpark', 'minho'),
                                 ('sjpark', 'minji'),
                                 ('sjpark', 'sejin'),
                                 ('sjpark', 'heeseon'),
                                 ('sjpark', 'youngwoong'),
                                 ('sjpark', 'jaejun'),
                                 ('sjpark', 'yumi'),
                                 ('sjpark', 'huieun'),
                                 ('sjpark', 'jaewon'),
                                 ('sjpark', 'seungwan'),

                                 ('seungwan', 'jinyoung'),
                                 ('seungwan', 'youngnam'),
                                 ('seungwan', 'seungyeon'),
                                 ('seungwan', 'hyerin'),
                                 ('seungwan', 'jueon'),
                                 ('seungwan', 'gowoon'),
                                 ('seungwan', 'moonju'),
                                 ('seungwan', 'hyunwoo'),
                                 ('seungwan', 'minho'),
                                 ('seungwan', 'minji'),
                                 ('seungwan', 'sejin'),
                                 ('seungwan', 'heeseon'),
                                 ('seungwan', 'youngwoong'),
                                 ('seungwan', 'jaejun'),
                                 ('seungwan', 'yumi'),
                                 ('seungwan', 'huieun'),
                                 ('seungwan', 'sjpark'),
                                 ('seungwan', 'jaewon')
    );


insert into mother_health_report (mother_id, hospital_name, medicine_name, visited_date, result, result_detail)
values
    ('jaewon', '서울산부인과', '', '2024-01-01', 'very good', '임신 초기, 본인과 아기의 건강을 위해 정기 검진을 시작했습니다.'),
    ('jaewon', '서울산부인과', '비타민제', '2024-01-08', 'good', '비타민제를 처방받아 복용 중입니다.'),
    ('jaewon', '서울산부인과', '', '2024-01-15', 'caution', '아랫배 통증이 있어 점검을 받았습니다. 특별한 문제는 없었지만 주의가 필요합니다.'),
    ('jaewon', '서울산부인과', '', '2024-01-20', 'good', '통증이 사라져 정상적인 상태를 유지하고 있습니다.'),
    ('jaewon', '서울산부인과', '철분제', '2024-01-29', 'good', '철분 수치가 조금 낮아 철분제를 복용하게 되었습니다.'),
    ('jaewon', '서울산부인과', '', '2024-02-01', 'very good', '임신 초기, 본인과 아기의 건강을 위해 정기 검진을 시작했습니다.'),
    ('jaewon', '서울산부인과', '비타민제', '2024-01-08', 'good', '비타민제를 처방받아 복용 중입니다.'),
    ('jaewon', '서울산부인과', '', '2024-02-15', 'caution', '아랫배 통증이 있어 점검을 받았습니다. 특별한 문제는 없었지만 주의가 필요합니다.'),
    ('jaewon', '서울산부인과', '', '2024-02-20', 'good', '통증이 사라져 정상적인 상태를 유지하고 있습니다.'),
    ('jaewon', '서울산부인과', '철분제', '2024-02-29', 'good', '철분 수치가 조금 낮아 철분제를 복용하게 되었습니다.'),
    ('jaewon', '서울산부인과', '', '2024-03-01', 'very good', '임신 초기, 본인과 아기의 건강을 위해 정기 검진을 시작했습니다.'),
    ('jaewon', '서울산부인과', '비타민제', '2024-03-08', 'good', '비타민제를 처방받아 복용 중입니다.'),
    ('jaewon', '서울산부인과', '', '2024-03-15', 'caution', '아랫배 통증이 있어 점검을 받았습니다. 특별한 문제는 없었지만 주의가 필요합니다.'),
    ('jaewon', '서울산부인과', '', '2024-03-20', 'good', '통증이 사라져 정상적인 상태를 유지하고 있습니다.'),
    ('jaewon', '서울산부인과', '철분제', '2024-03-29', 'good', '철분 수치가 조금 낮아 철분제를 복용하게 되었습니다.'),
    ('jaewon', '서울산부인과', '', '2024-04-01', 'very good', '임신 초기, 본인과 아기의 건강을 위해 정기 검진을 시작했습니다.'),
    ('jaewon', '서울산부인과', '비타민제', '2024-04-08', 'good', '비타민제를 처방받아 복용 중입니다.'),
    ('jaewon', '서울산부인과', '', '2024-04-15', 'caution', '아랫배 통증이 있어 점검을 받았습니다. 특별한 문제는 없었지만 주의가 필요합니다.'),
    ('jaewon', '서울산부인과', '', '2024-04-20', 'good', '통증이 사라져 정상적인 상태를 유지하고 있습니다.'),
    ('jaewon', '서울산부인과', '철분제', '2024-04-29', 'good', '철분 수치가 조금 낮아 철분제를 복용하게 되었습니다.'),
    ('jaewon', '서울산부인과', '', '2025-02-01', 'very good', '임신 초기, 본인과 아기의 건강을 위해 정기 검진을 시작했습니다.'),
    ('jaewon', '서울산부인과', '비타민제', '2025-02-08', 'good', '비타민제를 처방받아 복용 중입니다.'),
    ('jaewon', '서울산부인과', '', '2025-02-15', 'caution', '아랫배 통증이 있어 점검을 받았습니다. 특별한 문제는 없었지만 주의가 필요합니다.'),
    ('jaewon', '서울산부인과', '', '2025-02-20', 'good', '통증이 사라져 정상적인 상태를 유지하고 있습니다.'),
    ('jaewon', '서울산부인과', '철분제', '2025-02-27', 'good', '철분 수치가 조금 낮아 철분제를 복용하게 되었습니다.'),

    ('dnjfemwlffjt', '서울산부인과', '', '2024-01-01', 'very good', '임신 초기, 본인과 아기의 건강을 위해 정기 검진을 시작했습니다.'),
    ('dnjfemwlffjt', '서울산부인과', '비타민제', '2024-01-08', 'good', '비타민제를 처방받아 복용 중입니다.'),
    ('dnjfemwlffjt', '서울산부인과', '', '2024-01-15', 'caution', '아랫배 통증이 있어 점검을 받았습니다. 특별한 문제는 없었지만 주의가 필요합니다.'),
    ('dnjfemwlffjt', '서울산부인과', '', '2024-01-20', 'good', '통증이 사라져 정상적인 상태를 유지하고 있습니다.'),
    ('dnjfemwlffjt', '서울산부인과', '철분제', '2024-01-29', 'good', '철분 수치가 조금 낮아 철분제를 복용하게 되었습니다.'),
    ('dnjfemwlffjt', '서울산부인과', '', '2024-02-01', 'very good', '임신 초기, 본인과 아기의 건강을 위해 정기 검진을 시작했습니다.'),
    ('dnjfemwlffjt', '서울산부인과', '비타민제', '2024-01-08', 'good', '비타민제를 처방받아 복용 중입니다.'),
    ('dnjfemwlffjt', '서울산부인과', '', '2024-02-15', 'caution', '아랫배 통증이 있어 점검을 받았습니다. 특별한 문제는 없었지만 주의가 필요합니다.'),
    ('dnjfemwlffjt', '서울산부인과', '', '2024-02-20', 'good', '통증이 사라져 정상적인 상태를 유지하고 있습니다.'),
    ('dnjfemwlffjt', '서울산부인과', '철분제', '2024-02-29', 'good', '철분 수치가 조금 낮아 철분제를 복용하게 되었습니다.'),
    ('dnjfemwlffjt', '서울산부인과', '', '2024-03-01', 'very good', '임신 초기, 본인과 아기의 건강을 위해 정기 검진을 시작했습니다.'),
    ('dnjfemwlffjt', '서울산부인과', '비타민제', '2024-03-08', 'good', '비타민제를 처방받아 복용 중입니다.'),
    ('dnjfemwlffjt', '서울산부인과', '', '2024-03-15', 'caution', '아랫배 통증이 있어 점검을 받았습니다. 특별한 문제는 없었지만 주의가 필요합니다.'),
    ('dnjfemwlffjt', '서울산부인과', '', '2024-03-20', 'good', '통증이 사라져 정상적인 상태를 유지하고 있습니다.'),
    ('dnjfemwlffjt', '서울산부인과', '철분제', '2024-03-29', 'good', '철분 수치가 조금 낮아 철분제를 복용하게 되었습니다.'),
    ('dnjfemwlffjt', '서울산부인과', '', '2024-04-01', 'very good', '임신 초기, 본인과 아기의 건강을 위해 정기 검진을 시작했습니다.'),
    ('dnjfemwlffjt', '서울산부인과', '비타민제', '2024-04-08', 'good', '비타민제를 처방받아 복용 중입니다.'),
    ('dnjfemwlffjt', '서울산부인과', '', '2024-04-15', 'caution', '아랫배 통증이 있어 점검을 받았습니다. 특별한 문제는 없었지만 주의가 필요합니다.'),
    ('dnjfemwlffjt', '서울산부인과', '', '2024-04-20', 'good', '통증이 사라져 정상적인 상태를 유지하고 있습니다.'),
    ('dnjfemwlffjt', '서울산부인과', '철분제', '2024-04-29', 'good', '철분 수치가 조금 낮아 철분제를 복용하게 되었습니다.'),
    ('dnjfemwlffjt', '서울산부인과', '', '2025-02-01', 'very good', '임신 초기, 본인과 아기의 건강을 위해 정기 검진을 시작했습니다.'),
    ('dnjfemwlffjt', '서울산부인과', '비타민제', '2025-02-08', 'good', '비타민제를 처방받아 복용 중입니다.'),
    ('dnjfemwlffjt', '서울산부인과', '', '2025-02-15', 'caution', '아랫배 통증이 있어 점검을 받았습니다. 특별한 문제는 없었지만 주의가 필요합니다.'),
    ('dnjfemwlffjt', '서울산부인과', '', '2025-02-20', 'good', '통증이 사라져 정상적인 상태를 유지하고 있습니다.'),
    ('dnjfemwlffjt', '서울산부인과', '철분제', '2025-02-27', 'good', '철분 수치가 조금 낮아 철분제를 복용하게 되었습니다.'),


    ('jinyoung', '아산병원', '', '2024-01-05', 'very good', '임신 초기, 본인과 아기의 건강을 위해 정기 검진을 시작했습니다.'),
    ('jinyoung', '아산병원', '칼슘제', '2024-01-12', 'good', '칼슘 수치가 조금 낮아 칼슘제를 복용하게 되었습니다.'),
    ('jinyoung', '아산병원', '', '2024-01-19', 'caution', '아랫배 통증이 있어 점검을 받았습니다. 특별한 문제는 없었지만 주의가 필요합니다.'),
    ('jinyoung', '아산병원', '', '2024-01-26', 'good', '통증이 사라져 정상적인 상태를 유지하고 있습니다.'),
    ('jinyoung', '아산병원', '비타민제', '2024-02-02', 'good', '비타민제를 처방받아 복용 중입니다.'),

    ('hyerin', '서울산부인과', '', '2024-01-01', 'very good', '임신 초기, 본인과 아기의 건강을 위해 정기 검진을 시작했습니다.'),
    ('hyerin', '서울산부인과', '비타민제', '2024-01-08', 'good', '비타민제를 처방받아 복용 중입니다.'),
    ('hyerin', '서울산부인과', '', '2024-01-15', 'caution', '아랫배 통증이 있어 점검을 받았습니다. 특별한 문제는 없었지만 주의가 필요합니다.'),
    ('hyerin', '서울산부인과', '', '2024-01-20', 'good', '통증이 사라져 정상적인 상태를 유지하고 있습니다.'),
    ('hyerin', '서울산부인과', '철분제', '2024-01-29', 'good', '철분 수치가 조금 낮아 철분제를 복용하게 되었습니다.'),

    ('youngnam', '아산병원', '', '2024-01-05', 'very good', '임신 초기, 본인과 아기의 건강을 위해 정기 검진을 시작했습니다.'),
    ('youngnam', '아산병원', '칼슘제', '2024-01-12', 'good', '칼슘 수치가 조금 낮아 칼슘제를 복용하게 되었습니다.'),
    ('youngnam', '아산병원', '', '2024-01-19', 'caution', '아랫배 통증이 있어 점검을 받았습니다. 특별한 문제는 없었지만 주의가 필요합니다.'),
    ('youngnam', '아산병원', '', '2024-01-26', 'good', '통증이 사라져 정상적인 상태를 유지하고 있습니다.'),
    ('youngnam', '아산병원', '비타민제', '2024-02-02', 'good', '비타민제를 처방받아 복용 중입니다.'),

    ('seungyeon', '서울산부인과', '', '2024-01-01', 'very good', '임신 초기, 본인과 아기의 건강을 위해 정기 검진을 시작했습니다.'),
    ('seungyeon', '서울산부인과', '비타민제', '2024-01-08', 'good', '비타민제를 처방받아 복용 중입니다.'),
    ('seungyeon', '서울산부인과', '', '2024-01-15', 'caution', '아랫배 통증이 있어 점검을 받았습니다. 특별한 문제는 없었지만 주의가 필요합니다.'),
    ('seungyeon', '서울산부인과', '', '2024-01-20', 'good', '통증이 사라져 정상적인 상태를 유지하고 있습니다.'),
    ('seungyeon', '서울산부인과', '철분제', '2024-01-29', 'good', '철분 수치가 조금 낮아 철분제를 복용하게 되었습니다.');










UPDATE connection_list_MTH
SET relation = '지인'
WHERE mother_id = 'jaewon'
  AND helper_id IN ('jinyoung', 'youngnam',
                    'seungyeon', 'hyerin', 'jueon', 'gowoon', 'moonju', 'hyunwoo', 'minho', 'minji', 'sejin', 'heeseon',
                    'youngwoong', 'jaejun', 'yumi', 'huieun', 'sjpark', 'seungwan');

UPDATE connection_list_MTH
SET relation = '풀스택 7회차'
WHERE mother_id = 'dnjfemwlffjt'
  AND helper_id IN ('dnjfemwlffjt2','dnjfemwlffjt3');



/* 산모가 A 버튼을 누르는 쿼리문 // 자바에서 넣을 때의 쿼리문 = update mother set mother_emergency_alaram = '1' where mother_id = 'mother1'; */
UPDATE mother
SET mother_emergency_alaram = CASE
                                  WHEN mother_id IN ('mother1', 'mother2', 'mother3', 'mother4', 'jaewon', 'jinyoung', 'youngnam', 'seungyeon', 'hyerin', 'jueon', 'gowoon', 'moonju', 'hyunwoo', 'minho') THEN '1'
                                  ELSE mother_emergency_alaram
    END
WHERE mother_id IN ('mother1', 'mother2', 'mother3', 'mother4', 'jaewon', 'jinyoung', 'youngnam', 'seungyeon', 'hyerin', 'jueon', 'gowoon', 'moonju', 'hyunwoo', 'minho');




/* 산모가 B 버튼을 누르는 쿼리문 // 자바에서 넣을 때의 쿼리문 = update mother set mother_emergency_alaram = '2' where mother_id = 'mother5'; */
UPDATE mother
SET mother_emergency_alaram = CASE
                                  WHEN mother_id IN ('mother5', 'mother6', 'mother7', 'mother8', 'minji', 'sejin', 'heeseon', 'youngwoong', 'jaejun', 'yumi', 'huieun', 'sjpark', 'seungwan') THEN '2'
                                  ELSE mother_emergency_alaram
    END
WHERE mother_id IN ('mother5', 'mother6', 'mother7', 'mother8', 'minji', 'sejin', 'heeseon', 'youngwoong', 'jaejun', 'yumi', 'huieun', 'sjpark', 'seungwan');



alter table connection_list_mth add column locationallowhtm boolean DEFAULT FALSE;
alter table connection_list_mth add column locationallowmth boolean DEFAULT FALSE;
alter table connection_list_htm add column locationallowhtm boolean DEFAULT FALSE;
alter table connection_list_htm add column locationallowmth boolean DEFAULT FALSE;


/* 시연용 */
insert into connection_list_HTM (helper_id, mother_id) values ('dnjfemwlffjt', 'dnjfemwlffjt2');
insert into connection_list_HTM (helper_id, mother_id) values ('dnjfemwlffjt', 'dnjfemwlffjt3');

insert into invite_list_MTH(mother_id, helper_id) values ('minho', 'dnjfemwlffjt');
insert into invite_list_MTH(mother_id, helper_id) values ('youngnam', 'dnjfemwlffjt');

update mother set mother_emergency_alaram = 1 where mother_id = 'dnjfemwlffjt2';
update mother set mother_emergency_alaram = 2 where mother_id = 'dnjfemwlffjt3';









/* -------------------------- 쿼리문 -------------------------------------------------------------------------------------*/
/* -------------------------- 쿼리문 -------------------------------------------------------------------------------------*/
/* -------------------------- 쿼리문 -------------------------------------------------------------------------------------*/
/* -------------------------- 쿼리문 -------------------------------------------------------------------------------------*/
/* -------------------------- 쿼리문 -------------------------------------------------------------------------------------*/




select * from helper;
select * from mother where mother_id = 'dnjfemwlffjt3';
select * from mother_daily_report;
select * from mother_health_report;
select * from hospital;

/* 약을 처방 받은 산모만 출력하기 위해 not을 붙임 */
select * from medicine where not medicine_name = "";

select * from invite_list_HTM where helper_id = 'dnjfemwlffjt';
select * from invite_list_MTH;
select distinct * from connection_list_HTM where helper_id = 'dnjfemwlffjt';
select distinct * from connection_list_MTH;
select * from A_button_list;
select * from B_button_list;


select * from helper where helper_name = '김진영';
select * from mother where mother_id = 'dnjfemwlffjt2';
desc helper;