<%@ page import="java.util.Random" %>
<%@ page import="com.example.sanpa.biz.mother.MotherVO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="kr">
<head>
    <title>회원상세정보</title>
    <script src="https://www.gstatic.com/firebasejs/9.6.10/firebase-app-compat.js"></script>
    <script src="https://www.gstatic.com/firebasejs/9.6.10/firebase-auth-compat.js"></script>
    <script src="https://www.gstatic.com/firebasejs/9.6.10/firebase-database-compat.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>


<%
    // 여기서 mother_id를 가져옴
    MotherVO motherBox1 = (MotherVO) request.getAttribute("motherBox1");
    String motherId = motherBox1.getMother_id();
    System.out.println("Mother ID: " + motherId);
    int motherAlaram = motherBox1.getMother_emergency_alaram();
    System.out.println(motherAlaram);

    // motherBox3은 List<MotherVO> 객체
    List<MotherVO> motherBox3List = (List<MotherVO>) request.getAttribute("motherBox3");

    // 모든 MotherVO 객체를 처리
    String[] helperIds = new String[motherBox3List.size()];
    int index = 0;

    if (motherBox3List != null && !motherBox3List.isEmpty()) {
        for (MotherVO motherVO : motherBox3List) {
            String helperId = motherVO.getHelper_id();
            System.out.println("Helper ID:" + helperId);

            helperIds[index++] = helperId;
        }
    }

    // 배열을 JSON 문자열로 변환
    String helperIdsJson = new Gson().toJson(helperIds);

%>
<%
    String sanpalogo = "<svg width='180' height='56' viewBox='0 0 180 56' fill='none' xmlns='http://www.w3.org/2000/svg'>" +
            "<path d='M52.1368 13.7176C55.9554 13.7176 59.0509 10.6468 59.0509 6.85878C59.0509 3.07078 55.9554 0 52.1368 " +
            "0C48.3182 0 45.2227 3.07078 45.2227 6.85878C45.2227 10.6468 48.3182 13.7176 52.1368 13.7176Z' fill='#FF578B'" +
            " fill-opacity='0.8'/><path d='M15.66 23.8194C11.9497 23.8194 10.0664 25.4213 10.0101 27.6074C9.95812 30.0082" +
            " 12.322 31.1849 15.8202 31.9322L19.2102 32.7311C26.6871 34.3846 31.0469 38.0695 31.0988 44.2583C31.0469 51.5" +
            "68 25.3407 56.0002 15.66 56.0002C7.64186 56.0002 1.94863 52.9982 0.134595 46.9382C-0.488846 44.851 1.1347 42" +
            ".7637 3.32973 42.7637H5.76288C7.118 42.7637 8.28695 43.6184 8.80215 44.8596C9.78494 47.2131 12.2311 48.4199 " +
            "15.5518 48.4199C19.4266 48.4199 21.7386 46.7106 21.7905 44.2583C21.7386 42.0164 19.747 40.8439 15.4435 39.88" +
            "19L11.3565 38.9199C4.63289 37.3737 0.541563 34.0625 0.541563 28.2473C0.48961 21.0965 6.88854 16.2949 15.712 " +
            "16.2949C22.5871 16.2949 27.5747 19.1381 29.5835 23.682C30.5447 25.8594 28.9428 28.3031 26.5486 28.3031H24.20" +
            "2C22.9205 28.3031 21.8122 27.5387 21.2277 26.4091C20.3704 24.7514 18.4828 23.8194 15.66 23.8194Z' fill='#FF5" +
            "78B' fill-opacity='0.8'/><path d='M105.28 55.4673H102.535C101.448 55.4673 100.427 54.9391 99.8074 54.0501L84" +
            ".9791 32.7866H84.7106V52.1775C84.7106 53.9942 83.2256 55.4673 81.3943 55.4673H78.8789C77.0475 55.4673 75.562" +
            "5 53.9942 75.5625 52.1775V20.117C75.5625 18.3003 77.0475 16.8271 78.8789 16.8271H81.7233C82.8187 16.8271 83." +
            "8404 17.364 84.4595 18.2573L99.1277 39.5079H99.4524V20.117C99.4524 18.3003 100.937 16.8271 102.769 16.8271H1" +
            "05.284C107.116 16.8271 108.601 18.3003 108.601 20.117V52.1775C108.601 53.9942 107.116 55.4673 105.284 55.467" +
            "3H105.28Z' fill='#FF578B' fill-opacity='0.8'/><path d='M114.516 20.117C114.516 18.3003 116.001 16.8271 117.8" +
            "32 16.8271H130.44C139.207 16.8271 144.588 22.2686 144.588 30.1152C144.588 37.9618 139.103 43.3518 130.171 43" +
            ".3518H126.976C125.145 43.3518 123.66 44.8249 123.66 46.6416V52.1775C123.66 53.9942 122.175 55.4673 120.343 5" +
            "5.4673H117.828C115.997 55.4673 114.512 53.9942 114.512 52.1775V20.117H114.516ZM128.505 36.1451C132.808 36.14" +
            "51 135.12 33.7443 135.12 30.1152C135.12 26.4861 132.808 24.1927 128.505 24.1927H126.981C125.149 24.1927 123." +
            "664 25.6658 123.664 27.4825V32.8596C123.664 34.6763 125.149 36.1494 126.981 36.1494H128.505V36.1451Z' fill='" +
            "#FF578B' fill-opacity='0.8'/><path d='M144.226 51.1206L155.206 19.0601C155.665 17.7244 156.925 16.8311 158.3" +
            "45 16.8311H165.748C167.168 16.8311 168.432 17.7287 168.887 19.0643L179.823 51.1249C180.55 53.2594 178.953 55" +
            ".467 176.684 55.467H173.892C172.446 55.467 171.164 54.535 170.731 53.1693L169.558 49.4929C169.121 48.1229 16" +
            "7.843 47.1952 166.397 47.1952H157.7C156.253 47.1952 154.972 48.1272 154.539 49.4929L153.366 53.1693C152.928 " +
            "54.5393 151.651 55.467 150.205 55.467H147.365C145.092 55.467 143.495 53.2509 144.226 51.1206ZM166.038 38.412" +
            "4L163.531 30.5271C163.116 29.2172 161.254 29.2 160.808 30.4971L158.119 38.3823C157.803 39.3014 158.496 40.25" +
            "91 159.475 40.2591H164.67C165.635 40.2591 166.328 39.3272 166.034 38.4124H166.038Z' fill='#FF578B' fill-opac" +
            "ity='0.8'/><path d='M67.208 43.1241C70.914 40.5902 72.6804 35.8616 71.2301 31.3908C69.7451 26.8211 65.3723 2" +
            "3.9823 60.7571 24.2056L59.0037 19.0604C58.5491 17.7248 57.2849 16.8271 55.8648 16.8271H48.4615C47.0414 16.82" +
            "71 45.7772 17.7248 45.3226 19.0604L34.3432 51.121C33.6115 53.2555 35.2134 55.4673 37.482 55.4673H40.3221C41." +
            "7682 55.4673 43.0497 54.5354 43.4826 53.1696L44.6559 49.4933C45.0932 48.1233 46.3704 47.1956 47.8164 47.1956" +
            "H56.5143C57.9603 47.1956 59.2418 48.1276 59.6748 49.4933L60.848 53.1696C61.2853 54.5397 62.5625 55.4673 64.0" +
            "085 55.4673H66.801C69.0697 55.4673 70.6716 53.2555 69.9399 51.1253L67.2123 43.1241H67.208ZM62.2681 37.0857C5" +
            "5.2457 37.0857 49.5352 31.4208 49.5352 24.4547C49.5352 23.0331 50.6998 21.8778 52.1329 21.8778C53.5659 21.87" +
            "78 54.7305 23.0331 54.7305 24.4547C54.7305 28.5777 58.1118 31.9319 62.2681 31.9319C63.7012 31.9319 64.8658 3" +
            "3.0872 64.8658 34.5088C64.8658 35.9304 63.7012 37.0857 62.2681 37.0857Z' fill='#FF578B' fill-opacity='0.8'/></svg>";
    String searchIcon ="<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"20\" height=\"20\" fill=\"none\"><path fill=\"#000\" " +
            "d=\"m19.671 18.094-3.776-3.765a8.797 8.797 0 0 0 1.877-5.443 8.886 8.886 0 1 0-8.886 8.886 " +
            "8.797 8.797 0 0 0 5.443-1.877l3.765 3.776a1.11 1.11 0 0 0 1.577 0 1.11 1.11 0 0 0 0-1.577ZM2.221 " +
            "8.886a6.665 6.665 0 1 1 13.33 0 6.665 6.665 0 0 1-13.33 0Z\"/></svg>";

    String moveBack ="<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"30\" height=\"30\" fill=\"none\">\n" +
            "  <path fill=\"#FF578B\" d=\"M29.1 24.9 19.2 15l9.9-9.9c1.2-1.2 1.2-3 0-4.2-1.2-1.2-3-1.2-4.2 0l-12 12c-1.2 1.2-1.2" +
            " 3 0 4.2l12 12c.6.6 1.2.9 2.1.9.9 0 1.5-.3 2.1-.9 1.2-1.2 1.2-3 0-4.2ZM3 0C1.2 0 0 1.2 0 3v24c0 1.8 1.2 3 3 3s3-1.2 " +
            "3-3V3c0-1.8-1.2-3-3-3Z\"/>\n</svg>";
    String moveToRight="<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"20\" height=\"20\" fill=\"none\">\n" +
            "  <path fill=\"#FF578B\" d=\"M.6 3.4 7.2 10 .6 16.6c-.8.8-.8 2 0 2.8.8.8 2 .8 2.8 0l8-8c.8-.8.8-2 0-2.8l-8-8C3 " +
            ".2 2.6 0 2 0 1.4 0 1 .2.6.6c-.8.8-.8 2 0 2.8ZM18 20c1.2 0 2-.8 2-2V2c0-1.2-.8-2-2-2s-2 .8-2 2v16c0 1.2.8 2 2 2Z\"/>\n" +
            "</svg>";
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원목록</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            width: 100vw;
            height: 98vh;
            position: relative;
            display: flex;
            line-height: normal;
            font-family: "Pretendard Variable", Pretendard,
            -apple-system, BlinkMacSystemFont, system-ui, Roboto,
            "Helvetica Neue", "Segoe UI", "Apple SD Gothic Neo", "Noto Sans KR",
            "Malgun Gothic", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", sans-serif;
            min-width: 1100px;

        }
        .leftsecondblock:hover {
            transform: scale(1.05); /* 확대 비율 조절 가능 */
        }
        aside {
            display: flex;
            justify-content: center;
            width: 285px;
            background-color: #2E2E36;
            color: #fff;
            padding: 20px;
            box-sizing: border-box;
            height: 100vh;
            margin-right: 10px;
        }

        #gotoMotherLocation:hover {
            background-color: #D84578;
        }
        main {
            display: inline-block;
            padding:0;
            box-sizing: border-box;
            width: 83vw;
            min-width: 500px;

        }
        .contentcontainer{
            display: inline-block;
            justify-content: space-evenly;
            width: 80vw;
            color: #FF578B;
            margin-left: 2vw;
        }
        .contentTitle{
            font-size: 30px;
            display: flex;
            justify-content: center;
            margin-top: -5px;
            margin-bottom: 10px;
            width: 60vw;
        }


        .leftthirdblock::-webkit-scrollbar{
            display: none;
        }

        aside a {
            color: #fff;
            text-decoration: none;
            display: block;
            margin-bottom: 10px;
            font-size: 30px;
            transition: color 0.3s;
            text-shadow: 4px 4px 4px rgba(0, 0, 0, 0.5);
        }
        aside a:hover {
            color: #FF578B;
        }

        .category th {
            position: sticky;
            top: 0;
            background-color: #2E2E36;
            color: #fff;
        }

        .category th, .category td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        .category tr:hover th {
            background-color: #2E2E36;
            color: #fff;
        }

        .category tr:hover {
            background-color: rgba(255, 87, 139, 0.8);
            color: #fff;
        }

        .dropdown-content a {
            color: white;
            padding: 12px 16px;
            display: block;
            text-decoration: none;
        }

        .dropdown-content a:hover {
            background-color: #FF578B;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }
        .inforeversetable tr { display: block; float: left; }
        .inforeversetable th, td { display: block; }

        .helperlistblock::-webkit-scrollbar {
            display: none;
        }

        /* 모달 스타일 */
        .modal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            padding: 20px;
            background-color: #282c34;
            color: white;
            border: 1px solid #ccc;
            border-radius: 15px;
            font-size: 0.8em;
            width: 200px;
            z-index: 1000;
            opacity: 0; /* 초기 투명도 설정 */
            visibility: hidden; /* 초기 상태에서 숨김 */
            transition: opacity 0.4s ease, visibility 0.4s ease;
        }

        /* 모달 창이 열릴 때의 스타일 */
        .modal.active {
            opacity: 1;
            visibility: visible;
        }

        /* 모달 닫기 버튼 스타일 */
        .modal-close {
            cursor: pointer;
            float: right;
            font-size: 18px;
        }

    </style>
    <%--클라이언트 아이디= t0tc6s6192 <-- 이거 넣어야함 근데 일단 빼둠--%>
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=v3ze7pkpo4"></script>

</head>
<body>


<aside>
    <nav>
        <div style="margin-top: 20px; margin-bottom: 50px">
            <%=sanpalogo%>
        </div>

        <a href="login_move?status=9">산모대시보드</a>
        <a href="admin_buttonStatus" style="color: #FF578B;">버튼상황목록</a>
        <a href="admin_listAllMember" >회원목록</a>
        <a href="/" style="font-size: 25px; position: relative ; margin-top: 600px">로그아웃</a>
    </nav>
</aside>

<main>

    <%--페이지 상단 제목--%>
    <div class="header" style="height: 50px; margin-top: 15px; display: flex; justify-content: space-evenly;"> <div style="width: 70px; margin-top: 10px"><a href="javascript:history.back();" style="float: left; position: relative; margin-top: -10px; margin-left: -80px ">
        <%=moveBack%>
    </a></div>
        <div class="contentTitle"><STRONG style=" color: #FF578B; margin-left: -250px"> 상세정보 </STRONG></div></div>
    <div class="contentcontainer" >
        <div style="display: flex; flex-direction: row;">


            <div class="firstblock" style="display:flex; flex-direction: column; width: 25%; height: 87.5vh; margin-right: 20px; min-width: 290px" >
                <div style="font-size: 25px">&nbsp;</div>

                <div class="leftfirstblock" style="
                min-width: 244px;
                background-color: #2E2E36;
                color: #fff;
                padding: 20px;
                box-sizing: border-box;
                border-radius: 15px;
                margin-bottom: 10px;
                max-height: 192px;
                min-height: 184px;
                height: 21vh">
                    <table style="width: 100%" class="inforeversetable">
                        <tr class="infotr1" style="color: #8D8888 ;">
                            <th>아이디</th>
                            <th>이름</th>
                            <th>연락처</th>
                            <th>버튼상태</th>
                            <th>최근 컨디션</th>
                            <th>컨디션 기록일</th>
                            <th>출산예정일</th>
                        </tr>
                        <tr class="infotr2" style="float: right">
                            <td>
                                ${motherBox1.mother_id}
                            </td>
                            <td>
                                ${motherBox1.helper_name}
                            </td>
                            <td>
                                ${motherBox1.helper_tel.substring(0,3)}-${motherBox1.helper_tel.substring(3,7)}-${motherBox1.helper_tel.substring(7,11)}
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${motherBox1.mother_emergency_alaram == 2}"><span style="font-weight: bold; color: red">B</span></c:when>
                                    <c:when test="${motherBox1.mother_emergency_alaram == 1}"><span style="font-weight: bold; color: red">A</span></c:when>
                                    <c:otherwise>&nbsp;-&nbsp;</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty motherBox1.general_status}">
                                        ${motherBox1.general_status}
                                    </c:when>
                                    <c:otherwise>
                                        기록 없음
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty motherBox1.report_date}">
                                        ${motherBox1.report_date}
                                    </c:when>
                                    <c:otherwise>
                                        기록 없음
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty motherBox1.mother_d_day}">
                                        ${motherBox1.mother_d_day}
                                    </c:when>
                                    <c:otherwise>
                                        예정 없음
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </table>

                </div>
                <%--왼쪽 두번째 박스--%>
                <div style="display: flex; flex-direction: row; min-width: 244px; justify-content: space-evenly">
                    <div class="leftsecondblock" style="display: flex; flex-direction: column;  margin-right: 10px;align-items: center; min-height: 56px; background-color: #2E2E36; padding: 20px 10px 20px 20px; margin-bottom: 10px; border-radius: 15px; box-sizing: border-box; width: 50%; color: #FF578B; font-size: 1.2em; height: 6vh; cursor: pointer" onclick="location.href='admin_motherHealthReport?mother_id=${motherBox1.mother_id}'">
                        <div style="font-weight: bold;">검진기록열람</div>
                    </div>

                    <div class="leftsecondblock" style="display: flex; flex-direction: column; align-items: center; min-height: 56px; background-color: #2E2E36; padding: 20px 10px 20px 20px; margin-bottom: 10px; border-radius: 15px; box-sizing: border-box; color: #FF578B; width: 50%; font-size: 1.2em; height: 6vh; cursor: pointer" onclick="location.href='admin_motherHealthReport?mother_id=${motherBox1.mother_id}'">
                        <div style="font-weight: bold;">처방기록열람</div>
                    </div>
                </div>

                <span style="font-size: 1.2em;"> <strong> 복용 중인 약품 </strong></span>
                <%--왼쪽 세번째 박스--%>
                <div class="leftthirdblock" style="
                min-width: 244px;
                justify-content: center;
                background-color: #2E2E36;
                color: #FF578B;
                padding: 20px;
                box-sizing: border-box;
                border-radius: 15px;
                font-size: 1.2em;
                height: 95%;
                -ms-overflow-style: none; /* 인터넷 익스플로러 */
                overflow-y: scroll;">
                    <c:forEach var="motherMedicineInfo" items="${motherBox2}">
                        <table style="width: auto; margin-bottom: 10px" class="inforeversetable">
                            <tr class="" style="color: #8D8888; justify-content: center ">
                                <th>처방일 :</th>
                                <th>약 이름:</th>
                            </tr>

                            <tr>
                                <td>${motherMedicineInfo.visited_date}</td>
                                <td>${motherMedicineInfo.medicine_name}</td>
                            </tr>
                        </table>
                    </c:forEach>
                </div>

            </div>

            <div class="secondblock" style="display: inline-block; flex-direction: column; width: 300px; height: 90vh; margin-right: 20px;  min-width: fit-content" >
                <div style="font-size: 25px"><strong>${motherBox1.helper_name}님의 헬퍼목록</strong></div>
                <%--가운데 헬퍼목록--%>
                <div class="helperlistblock" style="display: flex;
            justify-content: center;
            padding: 10px;
            background-color: #2E2E36;
            box-sizing: border-box;
            border-radius: 15px;
            height: 84.5vh;
            border: #FF578B 1px solid;
            margin-bottom: 30px;
            overflow-y: scroll;
            min-width: 230px">
                    <div class="helper-list;" style="margin-bottom: 5px; ">
                        <c:forEach var="connectedHelperInfo" items="${motherBox3}">
                            <div class="helper" style="display: flex; align-items: center; justify-content: center; margin-bottom: 15px">
                                <div style="border: 2px solid white; width: 25px; height: 25px; border-radius: 50%; display: inline-block; margin-right: 5px;">
                                    <div style="width: 25px; height: 25px; border-radius: 50%; display: inline-block" class="helperColor" id="helperColor_${connectedHelperInfo.helper_id}"></div>
                                </div>
                                <table class="inforeversetable">
                                    <tr>
                                        <th style="text-align: left;">헬퍼ID</th>
                                        <th style="text-align: left;">이름</th>
                                        <th style="text-align: left;">전화번호</th>
                                        <th style="text-align: left;">산모와관계</th>
                                        <th style="text-align: left;">수락여부</th>
                                    </tr>
                                    <tr style="color: white">
                                        <td style="text-align: right;">${connectedHelperInfo.helper_id}</td>
                                        <td style="text-align: right;">${connectedHelperInfo.helper_name}</td>
                                        <td style="text-align: right;">${connectedHelperInfo.helper_tel.substring(0,3)}-${connectedHelperInfo.helper_tel.substring(3,7)}-${connectedHelperInfo.helper_tel.substring(7,11)}</td>
                                        <td style="text-align: right;" class="relation"></td>
                                        <td style="text-align: right;" class="gostop"></td>
                                    </tr>
                                </table>
                            </div>
                        </c:forEach>
                    </div>
                    <script>
                        const firebaseConfig = {
                            apiKey: "AIzaSyB18vZPqKnceElo5oIftGaU45xRaoho8Uw",
                            authDomain: "sanpa-c6a82.firebaseapp.com",
                            databaseURL: "https://sanpa-c6a82-default-rtdb.firebaseio.com",
                            projectId: "sanpa-c6a82",
                            storageBucket: "sanpa-c6a82.appspot.com",
                            messagingSenderId: "495243475176",
                            appId: "1:495243475176:web:8eb86c02b740e0b50b315d",
                            measurementId: "G-NV822LHWG3"
                        };

                        firebase.initializeApp(firebaseConfig);


                        const locDataRef2 = firebase.database().ref(`userLocations/${motherBox1.mother_id}/nicknrel/`);
                        const dataObjectArray = []; // 키와 값 배열

                        locDataRef2.once('value')
                            .then(snapshot => {
                                const data = snapshot.val();

                                if (data) {
                                    // nickrel 아래에 있는 helper 키, 값 저장
                                    Object.keys(data).forEach(helperKey => {
                                        const helperData = data[helperKey];
                                        dataObjectArray.push({ key: helperKey, relation: helperData.relation, gostop: helperData.gostop });
                                    });


                                    console.log("키, 값:", dataObjectArray);
                                    generateHelperHTML();
                                } else {
                                    console.log("데이터 못 찾음");
                                }
                            })
                            .catch(error => {
                                console.error("에러임:", error);
                            });

                        function generateHelperHTML() {
                            const helperDivs = document.querySelectorAll('.helper');

                            helperDivs.forEach((helperDiv) => {
                                const helperId = helperDiv.querySelector('td:first-child').textContent.trim();
                                console.log(helperId + "하이하이하이");
                                if (dataObjectArray.some(item => item.key === helperId)) {
                                    const { relation, gostop } = dataObjectArray.find(item => item.key === helperId);

                                    // 관계
                                    const relationCell = helperDiv.querySelector('.relation');
                                    if (relation) {
                                        relationCell.innerText = relation;
                                    } else {
                                        relationCell.innerText = "관계 미설정";
                                    }

                                    // 수락 여부
                                    const gostopCell = helperDiv.querySelector('.gostop');
                                    if (gostop !== undefined) {
                                        if (gostop == "0") {
                                            gostopCell.textContent = "선택 중";
                                            gostopCell.classList.add('selected');
                                        } else if (gostop == "1") {
                                            gostopCell.textContent = "가는 중";
                                            gostopCell.classList.add('going');
                                        } else {
                                            gostopCell.textContent = "못 가요";
                                            gostopCell.classList.add('not-going');
                                        }
                                    } else {
                                        gostopCell.textContent = "수락 여부 미설정";
                                    }
                                }
                            });
                        }
                    </script>
                </div>
            </div>




            <div class="mapblock" style="display:flex; flex-direction: column; width: 53%; height: 90vh" >
                <div style="font-size: 25px"><strong>현재위치</strong></div>
                <%--오른쪽 지도 박스--%>
                <div class="rightfirstblock" id="map" style="display: flex;
                justify-content: left;
                padding: 20px;
                box-sizing: border-box;
                border-radius: 15px;
                height: 100%;
                border: #FF578B 1px solid;
                margin-bottom: 30px;">
                    <button id="gotoMotherLocation" style="width: 75px; height: 30px; z-index: 1; background-color: #FF578B; color: #fff; border: none; border-radius: 5px; cursor: pointer; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);">
                        산모 위치
                    </button>
                </div>
            </div>
        </div>
    </div>


    <!-- 모달 창 -->
    <div id="myModal" class="modal">
        <span class="modal-close" onclick="closeModal()">&times;</span>
        <p id="modalText"></p>
    </div>
</main>



<script>
    const firebaseConfig2 = {
        apiKey: "AIzaSyB18vZPqKnceElo5oIftGaU45xRaoho8Uw",
        authDomain: "sanpa-c6a82.firebaseapp.com",
        databaseURL: "https://sanpa-c6a82-default-rtdb.firebaseio.com",
        projectId: "sanpa-c6a82",
        storageBucket: "sanpa-c6a82.appspot.com",
        messagingSenderId: "495243475176",
        appId: "1:495243475176:web:8eb86c02b740e0b50b315d",
        measurementId: "G-NV822LHWG3"
    };

    firebase.initializeApp(firebaseConfig2);


    const locDatabase = firebase.database();
    const locDataRef = locDatabase.ref('userLocations/');

    //firebase realtimedb를 이용하여 네이버 지도 시작위치 지정하기
    locDataRef.once('value', (snapshot) => {
        const locData = snapshot.val();
        Object.entries(locData).forEach(([key, value]) => {
            const latlng = new naver.maps.LatLng(value.latitude, value.longitude);
            if ('<%=motherId%>' === key) {
                // 해당 motherId와 key가 일치하는 경우에 지도의 중심을 해당 위치로 변경
                map.setCenter(latlng);
                map.setZoom(15); //
            }
        });
    });

    //산모 위치로 이동하는 버튼
    document.addEventListener('DOMContentLoaded', function () {
        document.getElementById('gotoMotherLocation').addEventListener('click', function () {
            locDataRef.once('value', (snapshot) => {
                const locData = snapshot.val();
                Object.entries(locData).forEach(([key, value]) => {
                    const latlng = new naver.maps.LatLng(value.latitude, value.longitude);
                    if ('<%=motherId%>' === key) {
                        // 해당 motherId와 key가 일치하는 경우에 지도의 중심을 해당 위치로 변경
                        map.setCenter(latlng);
                        map.setZoom(15); //
                    }
                });
            });

        });
    });
    var map = new naver.maps.Map('map',{
        zoomControl: true, //줌 컨트롤
        zoomControlOptions: { //줌 컨트롤 옵션
            position: naver.maps.Position.TOP_RIGHT
        }
    });
    // 마커 정보를 담은 배열
    var markers = [];

    const helperIds = JSON.parse('<%= helperIdsJson %>');
    var currentInfowindow = null;
    //  이벤트 핸들러
    locDataRef.on('value', (snapshot) => {
        //  마커 삭제
        deleteMarkers();

        markers = [];

        // 마커 생성
        const locData = snapshot.val();
        Object.entries(locData).forEach(([key, value]) => {
            const latlng = new naver.maps.LatLng(value.latitude, value.longitude);
            const color = value.color;

            markers.push({
                key: key,
                latlng: latlng,
                helperId: key,
                color: color,
            });

            //  motherId와 key가 같으면 마커를 찍기
            if ('<%=motherId%>' === key) {
                const infowindowContent = '<div style="padding:10px;"> 산모 ID:'+ key + '</div>';
                addMarkerAndInfowindow(map, key, latlng, infowindowContent, markers);


            }
            //배열로 가져온 연결된 헬퍼 id들을 뿌리기
            const helperIdsArray = Array.from(helperIds);
            if (helperIdsArray.includes(key)) {


                const infowindowContent = '<div style="padding:10px; ">헬퍼 ID: ' + key + '</div>';
                addMarkerAndInfowindow(map, key, latlng, infowindowContent, markers);
            }
        });
    });




    function addMarkerAndInfowindow(map, key, latlng, infowindowContent, markers) {
        const color = markers.find(marker => marker.key === key).color;


        const newMarker = new naver.maps.Marker({
            position: latlng,
            map: map,
            color: color,
            icon: {
                content: [
                    '<div style="border: 3px solid white; width: 25px; height: 25px; border-radius: 50%; display: inline-block; margin-right: 5px; color: #282c34; font-weight: bold;">',
                    '    <div style="width: 25px; height: 25px;  color: #282c34 ;background-color:  '+color+' ; border-radius: 50%; "><div style="z-index: 2; margin-left: -17px; color: #FF578B; font-weight: bold "></div></div>',
                    '</div>'
                ].join(''),
                size: new naver.maps.Size(50, 50),
                anchor: new naver.maps.Point(12, 12) // 마커 이미지의 중심점
            }
        });

        // 마커를 클릭했을 때 인포윈도우 생성
        naver.maps.Event.addListener(newMarker, 'click', function() {
            // 현재 열려있는 인포윈도우가 있다면 닫기
            if (currentInfowindow) {
                currentInfowindow.close();
            }

            const infowindow = new naver.maps.InfoWindow({
                content: infowindowContent,
                borderWidth: 2,
                disableAnchor: true,
                pixelOffset: new naver.maps.Point(0,-20)
            });
            infowindow.open(map, newMarker);



            currentInfowindow = infowindow;
        });

        markers.push(newMarker);
    }


    // 기존 마커 삭제
    function deleteMarkers() {
        for (var i = 0; i < markers.length; i++) {
            if (markers[i] instanceof naver.maps.Marker) {
                markers[i].setMap(null);
            }
        }
        markers = [];
    }

    naver.maps.Event.once(map, 'init', function () {
        // 초기화가 완료된 후에 실행되는 코드
        console.log('네이버 지도가 초기화되었습니다.');
    });

    // 클릭 이벤트 리스너
    function onHelperClick(helperId) {
        // helperId key 찾기
        locDataRef.once('value', (snapshot) => {
            const locData = snapshot.val();
            let locationExists = false;

            Object.entries(locData).forEach(([key, value]) => {
                if (key === helperId) {
                    // 해당 key에 대한 위치 정보 가져오기
                    const latlng = new naver.maps.LatLng(value.latitude, value.longitude);

                    // 해당 위치로 지도 이동
                    map.setCenter(latlng);
                    map.setZoom(19); // 적절한 줌 레벨로 조정 (원하는 값으로 변경 가능)

                    locationExists = true;
                }
            });

            if (!locationExists) {
                // 모달에 알림 텍스트 설정
                const modalText = document.getElementById('modalText');
                modalText.textContent = '해당 헬퍼의 위치를 찾을 수 없습니다.\n 또는 위치 추적 허용 거부 중입니다.';

                // 모달 열기
                openModal();
            }
        });
    }

    // 모달 열기 함수
    function openModal() {
        const modal = document.getElementById('myModal');
        modal.style.display = 'block'; // 모달을 보이게

        setTimeout(() => {
            modal.classList.add('active');
        }, 10);
    }

    // 모달 닫기 함수
    function closeModal() {
        const modal = document.getElementById('myModal');
        modal.classList.remove('active');

        //  모달을 감춤
        modal.addEventListener('transitionend', function handleTransitionEnd() {
            modal.style.display = 'none';
            modal.removeEventListener('transitionend', handleTransitionEnd);
        });
    }

    // "helper" div 클릭 이벤트 리스너를 각 "helper" div에 추가하자
    document.addEventListener('DOMContentLoaded', function () {
        const helperDivs = document.querySelectorAll('.helper');
        helperDivs.forEach((helperDiv) => {
            helperDiv.addEventListener('click', function () {
                const helperId = this.querySelector('td').textContent.trim();
                onHelperClick(helperId);
            });
        });
    });

    const helperColors = {};

    locDataRef.once('value', (snapshot) => {
        const locData = snapshot.val();
        Object.entries(locData).forEach(([key, value]) => {
            // Helper의 key와 color 정보를 객체에 저장
            helperColors[key] = value.color;
        });
    });

    naver.maps.Event.addListener(map, 'click', function() {

        if (currentInfowindow) {
            currentInfowindow.close();
            currentInfowindow = null;
        }
    });

    document.addEventListener('DOMContentLoaded', function () {
        const helperIds = JSON.parse('<%= helperIdsJson %>');
        console.log('실행'+helperIds);
        const locDataRef = firebase.database().ref('userLocations/');

        if (helperIds) {

            locDataRef.once('value', (snapshot) => {
                const locData = snapshot.val();


                helperIds.forEach(helperId => {
                    const helperColorDiv = document.getElementById(`helperColor_`+helperId);

                    if (helperColorDiv) {
                        const color = locData[helperId]?.color || 'black';
                        helperColorDiv.style.backgroundColor = color;
                    }
                });
            });


        }
    });


    document.addEventListener('DOMContentLoaded', generateHelperHTML);



</script>

</body>
</html>


