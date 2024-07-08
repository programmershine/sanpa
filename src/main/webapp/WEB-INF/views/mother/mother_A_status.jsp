<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.Period" %>
<%@ page import="com.example.sanpa.biz.mother.MotherVO" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
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

    <title>Insert title here</title>
    <style>
        ::-webkit-scrollbar {
            width: 10px;
            height: 10px;
        }

        ::-webkit-scrollbar-track {
            background: white;
        }

        ::-webkit-scrollbar-thumb {
            background: #FF578B;
        }

        #moving-text-container {
            position: relative;
            overflow: hidden;
            width: 100%;
            background: #FF578B;
            font-weight: 500;
            color: white;
            font-size: 20px;
        }



        #moving-text {
            position: relative;
            left: 100%;
            top: 0;
            white-space: nowrap;
            animation: moveLeft 7s linear infinite, changeColor 1s linear infinite;
            padding-right: 50px;
            width: fit-content;
        }

        @keyframes changeColor {
            0% { color: white; }
            50% { color: red;font-weight: bolder}
            100% { color: white; }
        }

        @keyframes moveLeft {
            0% { left: 100%; }
            100% { left: -100%; }
        }
    </style>
</head>
<body align="center" style="margin:0; height:1030px; overflow: hidden;">

<script>

    $(document).ready(function () {

        $('#AButtonClick').on('click', function () {
            $('#AButtonPage').css({"display":"inline-block"});
        });

        var countdown; // 카운트다운 인터벌 핸들을 저장할 전역 변수

        $('#BButtonClick').on('click', function () {
            $('#BButtonPage').css({"display":"inline-block"});
            var count = 4;
            countdown = setInterval(function(){
                $('p#countdownText').text(count + "초 후 자동으로 실행됩니다.");
                count--;
                if (count < 0) {
                    clearInterval(countdown);
                    $('#BBtnYes').trigger('click');
                }
            }, 1000); // 1000ms = 1s
        });

        $('.closeButton').on('click', function () {
            $('#AButtonPage').css({"display":"none"});
            $('#BButtonPage').css({"display":"none"});
        })

        $('#ABtnYes').on('click', function () {
            location.href="/AButtonClick";
        });
        $('#ABtnNo').on('click', function () {
            $('#AButtonPage').css({"display":"none"});
        });

        $('#BBtnYes').on('click', function () {
            location.href="BButtonClick";
        });
        $('#BBtnNo').on('click', function () {
            $('#BButtonPage').css({"display":"none"});
            clearInterval(countdown); // 카운트다운 인터벌을 취소
        });

    });

</script>



<%-- mainPage --%>
<div class="mainFrame" style="position:relative; width: 480px; height: 1030px; background:white; display: inline-block; box-shadow: 0 0px 4px 4px lightgrey;">
    <jsp:include page="header.jsp"/>
    <div style="width:480px; height: 830px; position: absolute; background: white; top:100px;">
        <br>
        <p style="color:#555; font-size: 16px; font-weight: bold;">${mother.helper_name}님의 정보</p>
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
            <span style="color: #FF8F8F">또또 만나기까지 <strong><%=leftDay%>일</strong>남았습니다.</span>
            <div id="progress-bar" style="margin-top: 4px; width: 420px; height: 32px; background: white; border-radius: 16px; border: 3px solid #FF567b; overflow: hidden">
                <div style="position:absolute; text-align: center; margin-top: 6px; width: 420px; height: 32px; z-index: 251; color: #FF567b;"> D-<%=leftDay%>일 </div>
                <i class="bi bi-heart-fill" style="z-index: 252; position: absolute; right:8px; top:34px; color:#ff567b;"></i>
                <div id="progress-div" style="width: 0%; height: 32px; background: #FFC2C2;"></div>
            </div>
        </div>

        <script>
            var totalDays = 280;
            var leftDays = <%=leftDay%>;
            var progress = ((totalDays - leftDays) / totalDays) * 100;

            document.getElementById('progress-div').style.width = progress + '%';
        </script>

        <!-- 출산예정일 -->
        <div style="position:relative; width: 360px; height: 30px; margin: auto; text-align: left; border-bottom: 2px solid #FFC2C2;">
            <div style="position:absolute; width: 128px; height: 30px; text-align: center; color: #999; font-size: 18px;">출산예정일:</div>
            <div style="position:absolute; width: 220px; height: 30px; right: 0; color: #FF8F8F; font-size: 20px;">
                <c:choose>
                    <c:when test="${mother.mother_due_date != null}">${mother.mother_due_date}</c:when>
                    <c:otherwise>기록한 결과가 없음</c:otherwise>
                </c:choose>
            </div>
        </div>
        <br/>
        <!-- 등록산부인과 -->
        <div style="position:relative; width: 360px; height: 30px; margin: auto; text-align: left; border-bottom: 2px solid #FFC2C2;">
            <div style="position:absolute; width: 128px; height: 30px; text-align: center; color: #999; font-size: 18px;">등록 산부인과:</div>
            <div style="position:absolute; width: 220px; height: 30px; right: 0; color: #FF8F8F; font-size: 20px;">
                <c:choose>
                    <c:when test="${mother.mother_obHospital_name != null}">${mother.mother_obHospital_name}</c:when>
                    <c:otherwise>등록한 산부인과가 없음</c:otherwise>
                </c:choose>

            </div>
        </div>
        <br/>
        <br/>

        <!-- A status ~ing -->
        <div id="moving-text-container">
            <div id="moving-text">헬퍼즈 출동 중!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;헬퍼즈 출동 중!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;헬퍼즈 출동 중!</div>
        </div>

        <div style="width: 84%; border: 5px solid #FFB3B3; margin: 35px auto; background: #FF578B; border-radius: 25px;">

            <p STYLE="color: white;"><span style="font-weight: bold; font-size: 45px;margin-right: 10px;">A</span><span style="font-size: 25px; font-weight: bold">LEVEL</span></p>
            <div style="display: flex; justify-content: space-evenly; ">
                <div onclick="location.href='/#/helpers'"  style="width: 37%; border-radius: 20px; background: white; padding: 13px; display: inline-block; margin-bottom: 15px;">
                    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="#FF578B" class="bi bi-map" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M15.817.113A.5.5 0 0 1 16 .5v14a.5.5 0 0 1-.402.49l-5 1a.5.5 0 0 1-.196 0L5.5 15.01l-4.902.98A.5.5 0 0 1 0 15.5v-14a.5.5 0 0 1 .402-.49l5-1a.5.5 0 0 1 .196 0L10.5.99l4.902-.98a.5.5 0 0 1 .415.103M10 1.91l-4-.8v12.98l4 .8zm1 12.98 4-.8V1.11l-4 .8zm-6-.8V1.11l-4 .8v12.98z"/>
                    </svg>
                    <p style="margin-bottom: 5px; color: rgba(0, 0, 0, 0.4); font-size: 17px; font-weight: 500">헬퍼즈<br>지도보기</p>
                </div>
                <div onclick="location.href='release_A_status'" style="width: 37%; border-radius: 20px; background: white; padding: 13px; display: inline-block; margin-bottom: 15px;">
                    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="#FF578B" class="bi bi-door-open" viewBox="0 0 16 16">
                        <path d="M8.5 10c-.276 0-.5-.448-.5-1s.224-1 .5-1 .5.448.5 1-.224 1-.5 1"/>
                        <path d="M10.828.122A.5.5 0 0 1 11 .5V1h.5A1.5 1.5 0 0 1 13 2.5V15h1.5a.5.5 0 0 1 0 1h-13a.5.5 0 0 1 0-1H3V1.5a.5.5 0 0 1 .43-.495l7-1a.5.5 0 0 1 .398.117M11.5 2H11v13h1V2.5a.5.5 0 0 0-.5-.5M4 1.934V15h6V1.077z"/>
                    </svg>
                    <p style="margin-bottom: 5px; color: rgba(0, 0, 0, 0.4); font-size: 20px; font-weight: 500">상황 해제</p>
                </div>

            </div>

        </div>

        <div>
            <p style="color: #FF578B; font-weight: 600; font-size: 27px;">헬퍼즈 ${mother2}명 출동</p>
        </div>

    </div>
    <form action="mother_myPage" method="get">
        <button type="submit">myPage로</button>
        <jsp:include page="footer.jsp"/>
</div>
</body>
</html>