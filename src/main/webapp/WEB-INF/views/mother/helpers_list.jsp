<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="/js/jquery-3.7.1.min.js"></script>
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

        .toggle-slide {
            display: none;
        }
        .toggle-container {
            position: relative;
            font-size: 16px;
            display: inline-block;
            /*align-items: center;*/
            /*justify-content: flex-end;*/
        }
        .toggle-text {
            margin: 0 5px;
        }
        .refuse {
            position: relative;
            left: 10px;
            top: 3px;
        }
        .agree {
            position: relative;
            left: 93px;
            top: 2px;
        }
        label {
            width: 120px !important;
            height: 60px !important;
            background: #FE78A1;
            opacity: 0.5;
            text-indent: -9999px;
            border-radius: 60px;
            position: relative;
            cursor: pointer;
            transition: 0.5s;
        }
        label::before {
            content: '';
            position: absolute;
            top: 0;
            left: 10px;
            width: 80px;
            height: 31px;
            background: #FE78A1;
            border-radius: 40px;
            transition: 0.5s;
        }
        label::after {
            content: '';
            position: absolute;
            width: 24px;
            height: 24px;
            background: #e5e5e5;
            border-radius: 25px;
            transition: 0.5s;
            top:4px;
            left:16px;
        }
        .toggle-slide:checked + label {
            opacity: 1;
        }
        .toggle-slide:checked + label::after {
            top: 4px;
            left: 61px;
        }

    </style>
</head>
<body align="center" style="margin:0; height:1030px; overflow: hidden;">

<div class="mainFrame" style="position:relative; width: 480px; height: 1030px; background:white; display: inline-block; box-shadow: 0 0px 4px 4px lightgrey;">
    <jsp:include page="header.jsp"/>
    <div style="width:480px; height: 830px; position: absolute; background: white; top:100px; overflow: scroll;">

        <div id="mainDiv" style="width: 480px; text-align: center; position: relative; top: 0px;">
            <div id="innerDiv" style="width: 420px; height: 60px; background: white; display: flex; justify-content: space-between; align-items: center; font-size: 20px; margin: 0 auto; color: #999; font-weight: bold;">
                <div id="listBtn" style="color: black" onclick="location.href='/helpers_list'">헬퍼즈 List</div>
                <span style="margin: 0 10px;">|</span>
                <div id="addBtn" onclick="location.href='/helpers_add'">헬퍼즈 추가</div>
                <span style="margin: 0 10px;">|</span>
                <div id="locationBtn" onclick="location.href='/#/helpers'">헬퍼즈 위치</div>
            </div>
        </div>

        <form action="helperListSearchKeyword" method="post">
            <div style="background: #FE78A1; width: 95%; height: 100px; border-radius: 15px; text-align: center; margin: 5px auto;">
                <p style="font-weight: bold; color: white; font-size: 18px; margin: 5px auto; padding: 5px;">헬퍼 이름 or 별칭 검색</p>
                <input id="searchInput" name="searchKeyword" type="text" style="outline: none; border: 1px solid rgba(0, 0, 0, 0.3); width: 77%; height: 38px; font-size: 20px; border-radius: 10px; padding: 5px 10px; font-weight: bold; margin: 0px 5px">
                <div id="searchButton" style="margin: 1px; display: inline-block; position: relative; top: 1px;">
                    <button type="submit" style="height: 38px; position: relative; background: #FE78A1; border: none; top: 3px">
                        <svg xmlns="http://www.w3.org/2000/svg" width="36" height="32" fill="currentColor" class="bi bi-search-heart" viewBox="0 0 16 16">
                            <path d="M6.5 4.482c1.664-1.673 5.825 1.254 0 5.018-5.825-3.764-1.664-6.69 0-5.018"/>
                            <path d="M13 6.5a6.47 6.47 0 0 1-1.258 3.844q.06.044.115.098l3.85 3.85a1 1 0 0 1-1.414 1.415l-3.85-3.85a1 1 0 0 1-.1-.115h.002A6.5 6.5 0 1 1 13 6.5M6.5 12a5.5 5.5 0 1 0 0-11 5.5 5.5 0 0 0 0 11"/>
                        </svg>
                    </button>
                </div>
            </div>
        </form>

        <div style="width: 95%; margin: 5px auto; ">
            <p style="display: flex; justify-content: space-between; font-weight: bold; color: rgba(0, 0, 0, 0.5); font-size: 21px; margin: 20px 10px;"><span onclick="location.href='helpers_list_edit'">수정</span>
                <span id="helpers_request_list" onclick="location.href='mother_helpers_invite_list'">

                        <c:choose>
                            <c:when test="${numOfInHTM == 0}">&nbsp;</c:when>
                            <c:otherwise><span style="font-size: 17px; font-weight: 400; color: white; background: #FE78A1;
                            position: relative;border: 1px solid red; border-radius: 50%; margin-right: 5px;padding:1px 3px;text-align: center">${numOfInHTM}</span></c:otherwise>
                        </c:choose>

                   헬퍼즈 요청 리스트</span></p>

            <script>// 페이지 로드시 실행


            $(document).ready(function () {
                var num = ${numOfInHTM};
                if(num !== 0) {
                    $('#helpers_request_list').css({"color":"red"});
                } else if (num === 0) {
                    $('#helpers_request_list').css({"color":"rgba(0, 0, 0, 0.4)"});
                }
            });
            // 위치동의 토글 버튼 클릭 이벤트 처리
            function handleLocationToggle(helperId, checked) {
                // AJAX를 통해 서버에 데이터베이스 수정 요청
                $.ajax({
                    type: "POST", // 또는 "GET"
                    url: "/api/data/updateLocationAllowmth.do", // 수정을 처리할 서버의 URL
                    contentType: "application/json",
                    data: JSON.stringify({ helperId: helperId, locationallowmth: checked ? 1 : 0 }), // 요청 본문 데이터
                    success: function(response) {
                        // 서버에서 성공적으로 응답을 받았을 때 수행할 동작
                        console.log("데이터베이스 수정 완료:", response);
                    },
                    error: function(xhr, status, error) {
                        // 요청이 실패했을 때 수행할 동작
                        console.error("데이터베이스 수정 실패:", error);
                    }
                });
            }
            </script>

            <c:forEach var="helper" items="${helperInfo}" varStatus="status">
                <div id="helperBox-${status.index}" style="display: flex; align-items: center; border: 3px solid #FE78A1; max-width: 100%; border-radius: 15px; margin: 10px auto; padding: 10px;">
                    <div style="display: flex; flex-direction: row; justify-content: center; align-items: center; margin-right: 10px;">
                        <span style="font-weight: bold; font-size: 40px; color: rgba(0, 0, 0, 0.75); margin: auto 3px; padding: 2px;">${String.format("%02d", status.index + 1)}</span>
                        <div style="background: deeppink;border-radius: 50%; width: 70px; height: 70px; margin: 5px; padding: 2px;"></div>
                    </div>
                    <div>
                        <c:set var="nicknameOfHelper" value="${helper.nicknameOfHelper != null ? helper.nicknameOfHelper : helper.helper_name}" />
                        <c:set var="relation" value="${helper.relation != null ? helper.relation : ''}" />
                        <p style="color:rgba(0, 0, 0, 0.5); font-size: 20px; font-weight: bolder; text-align: left; margin: 7px 10px;">${nicknameOfHelper}
                            <c:if test="${relation != null}">
                                <span style="font-size: 17px; font-weight: bold; color: rgba(0, 0, 0, 0.35); margin-left: 5px">${relation}</span>
                            </c:if>
                        </p>
                        <p style="color:rgba(0, 0, 0, 0.5); font-size: 20px; font-weight: bolder; text-align: left; margin: 7px 10px;">${helper.formattedHelper_tel}</p>
                        <p style="color:rgba(0, 0, 0, 0.5); font-size: 18px; font-weight: 400; text-align: left; margin: 7px 10px; ">위치 공유
                            <span class="toggle-container">
                                <span class="toggle-text refuse">거절</span>
                                <input type="checkbox" id="toggle-slide-${status.index}" class="toggle-slide" ${helper.locationallowmth == 1 ? 'checked' : ''}
                                       onchange="handleLocationToggle('${helper.helper_id}', this.checked)">
                                <label for="toggle-slide-${status.index}"></label>
                                <span class="toggle-text agree">동의</span>
                            </span>
                        </p>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <jsp:include page="footer.jsp"/>
</div>






</body>
</html>