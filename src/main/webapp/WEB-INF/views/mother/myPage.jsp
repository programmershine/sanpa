<%@ page import="com.example.sanpa.biz.mother.MotherVO" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.Period" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    Object mother = request.getAttribute("mother");
    LocalDate birthdate = ((MotherVO)mother).getHelper_birth();
    LocalDate mother_due_date = ((MotherVO)mother).getMother_due_date();

    Period birth = Period.between(birthdate, LocalDate.now());
    int age = birth.getYears();

    int month = 0;
    if(mother_due_date != null) {
        long daysBetween = ChronoUnit.DAYS.between(LocalDate.now(), mother_due_date);
        month = 9 - (int) daysBetween / 30;
    }


    int leftDay = 0;
    if(mother_due_date != null) {
        leftDay = (int) ChronoUnit.DAYS.between(LocalDate.now(), mother_due_date);
    }

%>


<!DOCTYPE html>
<html>
<head>
    <script src="/js/jquery-3.7.1.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        .container::-webkit-scrollbar {
            display: none;
        }
    </style>

</head>
<body align="center" style="margin:0;">

<%-- mainPage --%>
<div class="mainFrame" style="position:relative; width: 480px; height: 1030px; background:white; display: inline-block; box-shadow: 0 0px 4px 4px lightgrey;">
    <jsp:include page="header.jsp"/>
    <div class="container" style="width:480px; height: 830px; position: absolute; background: white; top:100px; overflow: auto">
        <br>

        <%--마이페이지 타이틀 & 뒤로가기 버튼--%>
        <div style="text-align: left; margin: 20px 10px; text-align: center;">
            <button onclick="location.href='login_move'" style="background: white; border:none; position: absolute; top:42px; left: 20px;">
                <svg width="15" height="26" viewBox="0 0 15 26" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M13 2L2 13L13 24" stroke="#333333" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </button>
            <span style=" font-size: 28px; font-weight: bolder; ">마이페이지</span>
        </div>

        <!-- 산모,태명 -->
        <div style="position:relative; width: 420px; height: 120px; border-radius: 16px; box-shadow: 0 0 2px 2px lightgrey; margin: auto;">
            <div style="position:absolute; top:16px; left:16px; width: 88px; height: 88px; border-radius: 44px; background: black;"></div>
            <div style="position:absolute; top:24px; left:120px; width: 260px; height: 72px; background: white; text-align: left;">
                <div style=" font-size: 24px;"><span style="color: #777">산모 : </span><span style="color: #FF8F8F"><strong>${mother.helper_name}</strong>님 <%=age%>살</span></div>
                <div style=" font-size: 24px;"><span style="color: #777">태명 : </span><span style="color: #FF8F8F"><strong>${mother.mother_babyName}</strong> <%=month%>개월</span></div>
            </div>
        </div>
        <br>
        <!-- D-day -->
        <div style="position:relative; width: 420px; height: 80px; margin: auto; text-align: left;">
            <div style="position: absolute; right: -10px; top:-40px;">
                <svg width="108" height="68" viewBox="0 0 108 68" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M0 12C0 5.37258 5.37258 0 12 0H96C102.627 0 108 5.37258 108 12V41C108 47.6274 102.627 53 96 53H87.5L82.5 67.5L66.5 53H12C5.37258 53 0 47.6274 0 41V12Z" fill="#FF578B"/>
                </svg>
                <div style="position: absolute; top:6px; left: 4px; width: 100px; height: 44px; text-align: center;">
                    <div style="font-weight: lighter; color: white">출산예정일</div>
                    <div style="font-weight: bold; color: white">${mother.mother_due_date}</div>
                </div>
            </div>

            <span style="color: #FF8F8F">${mother.mother_babyName}를 만나기까지 <strong><%=leftDay%>일</strong>남았습니다.</span>
            <div id="progress-bar" style="margin-top: 4px; width: 420px; height: 32px; background: white; border-radius: 16px; border: 3px solid #FF567b; overflow: hidden">
                <div style="position:absolute; text-align: center; margin-top: 6px; width: 420px; height: 32px; z-index: 251; color: #FF567b;"> D-<%=leftDay%>일 </div>
                <i class="bi bi-heart-fill" style="z-index: 252; position: absolute; right:8px; top:34px; color:#ff567b;"></i>
                <div id="progress-div" style="width: 0%; height: 32px; background: #FFC2C2;"></div>
            </div>
        </div>

        <%
            int chkParam = (int)request.getAttribute("chk");
            int chk = (chkParam > 0) ? 1 : 0;
            System.out.println("skdjfnkfjskdjfhsdf "+chk+" sdkfjshdkfjshdkfjdh");
        %>
        <script>
            var totalDays = 280;
            var leftDays = <%=leftDay%>;
            var progress = ((totalDays - leftDays) / totalDays) * 100;

            document.getElementById('progress-div').style.width = progress + '%';

            function updateBtn(e) {
                var chk = <%=chk%>;
                var helper_id = $("#helper_idInput").val();
                if(chk > 0) { // 산모의 버튼이 울린 상황이라면
                    console.log(chk + "111");
                    e.preventDefault();
                    alert("\n응급상황에는 \n\n회원정보 수정을 할 수 없습니다...");
                }
            }

        </script>
        <br>

        <%--회원정보 수정--%>
        <form action="mother_setUpdateForm" method="post">
            <input id="helper_idInput" type="hidden" name="helper_id" value="${helper.helper_id}">
            <div style="width: 480px; display: flex; justify-content: center;" >
                <button onclick="updateBtn(event)" id="submitBtn" type="submit" style="width: 448px; height: 60px; background: #ccc; border-radius: 20px; margin: 6px auto; border: none; cursor: pointer;">
                    <div style="margin-top: 6px; font-size: 28px; color: #333;">회원정보 수정</div>
                </button>
            </div>
        </form>








        <%--헬퍼 계정으로 전환--%>
        <div onclick="location.href='changeMotherToHelper'" style=" width: 480px; display: flex; justify-content: center;">
            <div style="cursor: pointer; width: 448px; height: 60px; background: #ccc; border-radius: 20px; margin: 6px auto;">
                <div style="margin-top: 12px; font-size: 28px; color: #333">헬퍼 계정으로 전환</div>
            </div>
        </div>
        <%--구독 및 결제--%>
        <div onclick="location.href='mother_subscribe'" style="width: 480px; display: flex; justify-content: center;">
            <div style="cursor: pointer; width: 448px; height: 60px; background: #ccc; border-radius: 20px; margin: 6px auto;">
                <div style="margin-top: 12px; font-size: 28px; color: #333">구독 및 결제</div>
            </div>
        </div>
        <%--문의--%>
        <div onclick="location.href='mother_ask'" style="width: 480px; display: flex; justify-content: center;">
            <div style="cursor: pointer; width: 448px; height: 60px; background: #ccc; border-radius: 20px; margin: 6px auto;">
                <div style="margin-top: 12px; font-size: 28px; color: #333">문의</div>
            </div>
        </div>
        <%--회원탈퇴--%>
        <div onclick="confirmDismissSanpa()" style="width: 480px; display: flex; justify-content: center;">
            <div style="cursor: pointer; width: 448px; height: 60px; background: #ccc; border-radius: 20px; margin: 6px auto;">
                <div style="margin-top: 12px; font-size: 28px; color: #333">회원탈퇴</div>
            </div>
        </div>
        <br>
        <%--로그아웃--%>
        <div style="width: 480px; display: flex; justify-content: center;">
            <div style="cursor: pointer; width: 448px; height: 60px; margin: 6px auto;">
                <!-- 로그아웃 버튼 클릭 시 경고창이 나타나도록 설정 -->
                <div onclick="confirmLogout()" style="margin-top: 12px; font-size: 28px; color: #FF578B; cursor: pointer;">로그아웃</div>
            </div>
        </div>

        <script>
            // 로그아웃 함수
            function confirmLogout() {
                // 경고창을 띄워 사용자에게 로그아웃 여부를 확인
                if (confirm("정말 로그아웃 하시겠습니까?")) {
                    // 예를 선택한 경우 로그아웃 페이지로 이동
                    location.href = 'logout';
                } else {
                    // 아니오를 선택한 경우 아무 작업도 수행하지 않음
                    return false;
                }
            }
            function confirmDismissSanpa() {
                // 경고창을 띄워 사용자에게 로그아웃 여부를 확인
                if (confirm("정말 회원 탈퇴를 하시겠습니까?")) {
                    // 예를 선택한 경우 로그아웃 페이지로 이동
                    location.href = 'dismissSanpa';
                } else {
                    // 아니오를 선택한 경우 아무 작업도 수행하지 않음
                    return false;
                }
            }
        </script>


    </div>
    <jsp:include page="footer.jsp"/>
</div>
</body>
</html>












