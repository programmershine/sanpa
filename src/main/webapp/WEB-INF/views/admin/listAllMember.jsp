<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="kr">
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
            min-width: 800px;
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

        main {
            display: inline-block;
            padding: 20px;
            box-sizing: border-box;
            min-width: 500px;

        }
        .contentcontainer{
            display: inline-block;
            justify-content: space-evenly;
            min-width: 500px;
            color: #FF578B;
            margin-right: 10px;

        }
        .contentTitle{
            font-size: 28px;
            display: flex;
            justify-content: center;
            margin-top: -5px;
            margin-bottom: 20px;
            min-width: 146px;

        }
        .content{
            height: 90vh;
            margin-top: -10px;
            margin-bottom: 15px;
            -ms-overflow-style: none; /* 인터넷 익스플로러 */
            overflow-y: scroll;
            border: 1px solid #FF578B;
            width: 79vw;
            min-width: 500px;

        }
        .content::-webkit-scrollbar {
            display: none;
        }
        table {
            table-layout: fixed; /* 테이블 레이아웃 고정 */
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
        .category {
            border-collapse: collapse;
            border-spacing: 0;
            width: 100%;
            text-align: center;

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
        .dropdown {
            display: inline-block;
        }

        .dropbtn {
            font-size: 15px;
            border: 1px solid #FF578B;
            max-width: 100px;
            border-radius: 5px;
            background-color: #2E2E36;
            color: white;
            padding: 10px;
            cursor: pointer;
        }

        .dropbtn2 {
            font-size: 15px;
            border: 1px solid #FF578B;
            max-width: 130px;
            border-radius: 5px;
            background-color: #2E2E36;
            color: white;
            padding: 10px;
            cursor: pointer;
            margin-left: 15px;
        }

        .dropbtn:hover, .dropbtn:focus {
            background-color: #FF578B;
        }

        .dropbtn2:hover, .dropbtn2:focus {
            font-size: 15px;
            background-color: #FF578B;
            max-width: 130px;
            border-radius: 5px;
            color: white;
            padding: 10px;
            cursor: pointer;
            margin-left: 15px;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #2E2E36;
            box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
            z-index: 1;
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
        @media screen and (max-width: 768px) {
            .contentTitle {
                font-size: 24px; /* 글자 크기를 줄임 */
            }
        }
    </style>

    <%--    <script src="/js/jquery-3.7.1.min.js"></script>--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>

<aside>
    <nav>
        <div style="margin-top: 20px; margin-bottom: 50px">
            <%=sanpalogo%>
        </div>

        <a href="login_move">산모대시보드</a>
        <a href="admin_buttonStatus" >버튼상황목록</a>
        <a href="admin_listAllMember" style="color: #FF578B;">회원목록</a>
        <a href="/" style="font-size: 25px; position: relative ; margin-top: 600px">로그아웃</a>
    </nav>
</aside>



<main>

    <div class="contentcontainer">
        <div style="display: flex; justify-content: space-between; align-items: center;">
            <div style="width: 650px"></div>  <p class="contentTitle" style="display: inline-block;"> 전체회원목록</p><div style="width: 350px"></div>
            <div style="display: inline-block;  margin-bottom: 10px;">
                <form style="display: inline-block;">
                    <table>
                        <tr>

                            <td>
                                <div id="searchBtn" style="display: inline; margin-right: 20px;"><%=searchIcon%></div>
                            </td>

                            <td>
                                <input id="searchKeyword" type="text" name="searchKeyword"  STYLE="font-size: 20px; border: 1px solid #FF578B; max-width: 150px; border-radius: 5px; margin-right: 10px;">
                            </td>

                            <td>
                                <div class="dropdown">
                                    <label>
                                        <select name="searchCondition" class="dropbtn dropbtn2">
                                            <c:forEach var="option" items="${conditionMap}">
                                                <option value="${option.value}">${option.key}</option>
                                            </c:forEach>
                                        </select>
                                    </label>
                                </div>
                            </td>
                            <!-- 드롭다운 메뉴 끝 -->
                        </tr>

                    </table>
                </form>
            </div>
        </div>


        <div class="content">
            <table class="category tableBody">
                <thead>
                <tr>
                    <th>아이디</th>
                    <th>성 함</th>
                    <th>회원구분</th>
                    <th>연락처</th>
                    <th>주소</th>
                    <th>더 보기</th>
                </tr>
                </thead>
                <tbody class="category tableBody">

                <c:forEach var="helper" items="${helperVO}">
                    <tr class="member">
                        <td>${helper.helper_id}</td>
                        <td>${helper.helper_name}</td>
                        <td>
                            <c:choose>
                                <c:when test="${helper.helper_status==9}">관리자</c:when>
                                <c:when test="${helper.helper_status==1}">산모</c:when>
                                <c:when test="${helper.helper_status==0}">헬퍼</c:when>
                            </c:choose>
                        </td>
                        <td>${helper.helper_tel.substring(0,3)}-${helper.helper_tel.substring(3,7)}-${helper.helper_tel.substring(7,11)}</td>
                        <td>${helper.helper_address} - ${helper.helper_address_detail}</td>
                        <td>
                            <div class="dropdown" onclick="toggleDropdown('more')">
                                <button class="dropbtn">...</button>
                                <div class="dropdown-content" id="more">
                                    <a href="#" onclick="confirmDelete()">회원삭제</a>
                                </div>
                            </div>
                        </td>
                    </tr>
                </c:forEach>

                </tbody>
            </table>
        </div>
    </div>


</main>
</body>
<script>
    function toggleDropdown(dropdownId) {
        var dropdown = document.getElementById(dropdownId);
        dropdown.classList.toggle("show");
    }

    window.onclick = function(event) {
        if (!event.target.matches('.dropbtn')) {
            var dropdowns = document.getElementsByClassName("dropdown-content");
            for (var i = 0; i < dropdowns.length; i++) {
                var openDropdown = dropdowns[i];
                if (openDropdown.classList.contains('show')) {
                    openDropdown.classList.remove('show');
                }
            }
        }
    }

    function confirmDelete() {
        var result = confirm("정말로 이 회원을 삭제하시겠습니까?");
        if (result) {
            alert("회원이 삭제되었습니다.");
            location.reload();// 그냥 새로고침으로 삭제한 회원 안 뜨게하기
        }
    }

    $(document).ready(function() {
        $('.dropbtn2').change(function() {
            var searchCondition = $(this).val();
            $.ajax({
                url: 'admin_changeListMember',
                type: 'post',
                data: { 'searchCondition': searchCondition },
                success: function(response) {
                    // 사용자 목록을 표시할 테이블의 tbody를 선택합니다.
                    var tbody = $('.category .tableBody');

                    // tbody의 내용을 비웁니다.
                    tbody.empty();

                    // 서버로부터 받은 사용자 목록 데이터를 순회하면서 화면에 표시합니다.
                    $.each(response, function(i, helper) {
                        var helperRow = '<tr class="member">' +
                            '<td>' + helper.helper_id + '</td>' +
                            '<td>' + helper.helper_name + '</td>' +
                            '<td>' + getStatusText(helper.helper_status) + '</td>' +
                            '<td>' + helper.helper_tel.substring(0,3) + '-' + helper.helper_tel.substring(3,7) + '-' + helper.helper_tel.substring(7,11) + '</td>' +
                            '<td>' + helper.helper_address + ' - ' + helper.helper_address_detail + '</td>' +
                            '<td>' +
                            '<div class="dropdown" onclick="toggleDropdown(\'more\')">' +
                            '<button class="dropbtn">...</button>' +
                            '<div class="dropdown-content" id="more">' +
                            '<a href="#" onclick="confirmDelete()">회원삭제</a>' +
                            '</div>' +
                            '</div>' +
                            '</td>' +
                            '</tr>';

                        // 생성한 행을 tbody에 추가합니다.
                        tbody.append(helperRow);
                    });
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.log("외않됌?");
                }
            });
        });

        $('#searchKeyword').keyup(function () {
            var searchKeyword = $(this).val();
            $.ajax({
                url: 'admin_searchListMember',
                type: 'POST',
                data: { 'searchKeyword' : searchKeyword},
                success: function (response) {
                    // 사용자 목록을 표시할 테이블의 tbody를 선택합니다.
                    var tbody = $('.category .tableBody');

                    // tbody의 내용을 비웁니다.
                    tbody.empty();
                    // 서버로부터 받은 사용자 목록 데이터를 순회하면서 화면에 표시합니다.
                    $.each(response, function(i, helper) {
                        var helperRow = '<tr class="member">' +
                            '<td>' + helper.helper_id + '</td>' +
                            '<td>' + helper.helper_name + '</td>' +
                            '<td>' + getStatusText(helper.helper_status) + '</td>' +
                            '<td>' + helper.helper_tel.substring(0,3) + '-' + helper.helper_tel.substring(3,7) + '-' + helper.helper_tel.substring(7,11) + '</td>' +
                            '<td>' + helper.helper_address + ' - ' + helper.helper_address_detail + '</td>' +
                            '<td>' +
                            '<div class="dropdown" onclick="toggleDropdown(\'more\')">' +
                            '<button class="dropbtn">...</button>' +
                            '<div class="dropdown-content" id="more">' +
                            '<a href="#" onclick="confirmDelete()">회원삭제</a>' +
                            '</div>' +
                            '</div>' +
                            '</td>' +
                            '</tr>';
                        // 생성한 행을 tbody에 추가합니다.
                        tbody.append(helperRow);
                    });
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.log("외않됌?");
                }
            });
        });

    });

    function getStatusText(status) {
        switch (status) {
            case 9: return '관리자';
            case 1: return '산모';
            case 0: return '헬퍼';
            default: return '';
        }
    }

</script>
</html>







