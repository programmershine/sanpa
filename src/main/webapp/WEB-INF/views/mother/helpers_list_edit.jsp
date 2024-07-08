<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
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

        .toggle-slide {
            display: none;
        }
        .toggle-container {
            position: relative;
            font-size: 16px;
            display: inline-block;
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
    <script>
        $(document).ready(function(){
            $("[id^='deleteButton']").click(function () {
                var helper_id = $(this).siblings('input[name="helper_id"]').val();
                var mother_id = $(this).siblings('input[name="mother_id"]').val();
                var useConfirm = confirm("친구 삭제를 하시겠습니까?");
                if(useConfirm) {
                    $.ajax({
                        type:"POST",
                        url: "helpers_list_delete",
                        data: {helper_id:helper_id, mother_id:mother_id},
                        error: function(jqXHR, textStatus, errorThrown){
                            alert("요청 처리 중 문제가 발생했습니다: " + textStatus);
                        }
                    });
                }

            });
        });
        $(document).ready(function () {
            // 각 헬퍼의 토글 버튼을 선택하고 수정합니다.
            <c:forEach var="helper" items="${helperInfo}" varStatus="status">
            var toggleButtonId = "toggle-slide-${status.index}";
            // 각 토글 버튼을 비활성화합니다.
            $("#" + toggleButtonId).prop("disabled", true);
            </c:forEach>
        });
    </script>
    <%
        String mother_id = (String)session.getAttribute("helper_id");
    %>
</head>
<body align="center" style="margin:0; height:1030px; overflow: hidden;">

<div class="mainFrame" style="position:relative; width: 480px; height: 1030px; background:white; display: inline-block; box-shadow: 0 0px 4px 4px lightgrey;">
    <jsp:include page="header.jsp"/>
    <div style="width:480px; height: 830px; position: absolute; background: white; top:100px; overflow: scroll;">

        <div id="mainDiv" style="width: 480px; text-align: center; position: relative; top: 0px;">
            <div id="innerDiv" style="width: 420px; height: 60px; background: white; display: flex; justify-content: space-between; align-items: center; font-size: 20px; margin: 0 auto; color: #999; font-weight: bold;">
                <div id="listBtn" style="color: black" onclick="location.href='/helpers_list'">헬퍼즈 List</div>
                <span style="margin: 0 10px;">|</span>
                <div id="addBtn"  onclick="location.href='/helpers_add'">헬퍼즈 추가</div>
                <span style="margin: 0 10px;">|</span>
                <div id="locationBtn" onclick="location.href='/#/helpers'">헬퍼즈 위치</div>
            </div>
        </div>


        <form action="helperListEditSearchKeyword" method="post">
            <div style="background: #FE78A1; width: 95%; height: 100px; border-radius: 15px; text-align: center; margin: 5px auto;">
                <p style="font-weight: bold; color: white; font-size: 18px; margin: 5px auto; padding: 5px;">헬퍼 이름 검색</p>
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

        <form action="helpers_list_edit" method="post">
            <div style="width: 95%; margin: 5px auto; ">

                <p style="display: flex; justify-content: right; font-weight: bold; color: rgba(0, 0, 0, 0.5); font-size: 21px; margin: 20px 10px;">
                    <button type="submit" style="border: none; border-radius: 20px; background: #FE78A1; font-size: 23px; padding: 4px 15px; margin: 2px 10px; color: rgba(0, 0, 0, 0.5); font-weight: 600">수정</button>
                    <button onclick="location.href='helpers_list'" style="border: none; border-radius: 20px; background: rgba(0, 0, 0, 0.3); font-size: 23px; padding: 4px 15px; margin: 2px 10px; margin-right: 0; color: rgba(0, 0, 0, 0.5); font-weight: 600">취소</button></p>
                <c:set var="itemCount" value="${fn:length(helperInfo)}" />
                <input type="hidden" name="itemCount" value="${itemCount}">


                <c:forEach var="helper" items="${helperInfo}" varStatus="status">
                    <%-- status 변수에서 현재 인덱스 가져오기 --%>

                    <div style="display: flex; align-items: center; border: 3px solid #FE78A1; max-width: 100%; border-radius: 15px; margin: 10px auto; padding: 10px;">
                        <div style="display: flex; flex-direction: row; justify-content: center; align-items: center; margin-right: 10px;">
                            <span style="font-weight: bold; font-size: 40px; color: rgba(0, 0, 0, 0.75); margin: auto 3px; padding: 2px;">${String.format("%02d", status.index + 1)}</span>
                            <div style="background: deeppink;border-radius: 50%; width: 70px; height: 70px; margin: 5px; padding: 2px;"></div>
                        </div>
                        <div>
                            <input type="hidden" name="helper_id${status.index}" value="${helper.helper_id}">
                            <input type="hidden" name="mother_id${status.index}" value="<%=mother_id%>">
                            <c:set var="nicknameOfHelper" value="${helper.nicknameOfHelper != null ? helper.nicknameOfHelper : helper.helper_name}" />
                            <c:set var="relation" value="${helper.relation != null ? helper.relation : ''}" />
                            <p style="margin: 7px 10px; position: relative; left: -13px; display: inline-block">

                                <input class="editInput_name" type="text" name="nicknameOfHelper${status.index}" value="${nicknameOfHelper}"
                                       style="color:rgba(0, 0, 0, 0.5); font-size: 20px; font-weight: bolder; text-align: left; border-radius: 20px; width: 85px; padding: 5px 10px;
                                            border: 2px solid rgba(0, 0, 0, 0.3);">

                                <span style="margin-left: 5px">

                                            <input class="editInput_relation" type="text" name="relation${status.index}" value="${relation}"
                                                   style="color:rgba(0, 0, 0, 0.35); font-size: 17px; font-weight: bold; border-radius: 20px; width: 70px; padding: 5px 10px;
                                                   border: 2px solid rgba(0, 0, 0, 0.3);">
                                    </span>
                            </p>
                            <button id="deleteButton${status.index}" style="border-radius: 20px; color: white; background: red; font-weight: bold; font-size: 23px;padding: 4px 15px; border: none;">삭제</button>
                            <p style="color:rgba(0, 0, 0, 0.5); font-size: 20px; font-weight: bolder; text-align: left; margin: 7px 10px;">${helper.formattedHelper_tel}</p>
                            <p style="color:rgba(0, 0, 0, 0.5); font-size: 18px; font-weight: 400; text-align: left; margin: 7px 10px; ">위치 공유
                                <span class="toggle-container">
                                    <span class="toggle-text refuse">거절</span>
                                    <input type="checkbox" id="toggle-slide-${status.index}" class="toggle-slide" ${helper.locationallowmth== 1 ? 'checked' : ''}
                                    >
                                    <label for="toggle-slide-${status.index}"></label>
                                    <span class="toggle-text agree">동의</span>
                                </span>
                            </p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </form>
    </div>
    <jsp:include page="footer.jsp"/>
</div>






</body>
</html>