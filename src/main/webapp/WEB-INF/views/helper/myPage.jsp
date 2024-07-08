<%@ page import="com.example.sanpa.biz.mother.MotherVO" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.Period" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
            <button onclick="location.href='getButtonList'" style="background: white; border:none; position: absolute; top:42px; left: 20px;">
                <svg width="15" height="26" viewBox="0 0 15 26" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M13 2L2 13L13 24" stroke="#333333" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </button>
            <span style=" font-size: 28px; font-weight: bolder; ">마이페이지</span>
        </div>


        <%--회원정보 수정--%>
        <form action="helper_setUpdateForm" method="post">
            <input type="hidden" name="helper_id" value="${helper.helper_id}">
            <div style="width: 480px; display: flex; justify-content: center;">
                <button type="submit" style="width: 448px; height: 60px; background: #ccc; border-radius: 20px; margin: 6px auto; border: none; cursor: pointer;">
                    <div style="margin-top: 6px; font-size: 28px; color: #333;">회원정보 수정</div>
                </button>
            </div>
        </form>


        <%--산모 계정으로 전환--%>
        <div onclick="changeHelperToMother()" style=" width: 480px; display: flex; justify-content: center;">
            <div style="cursor: pointer; width: 448px; height: 60px; background: #ccc; border-radius: 20px; margin: 6px auto;">
                <div style="margin-top: 12px; font-size: 28px; color: #333">산모 계정으로 전환</div>
            </div>
        </div>

        <%-- 산모 계정으로 바꾸는 함수 --%>
        <script>
            function changeHelperToMother() {
                var helper_status = ${helper.helper_status};
                if(helper_status === 0) {
                    alert("산모가입 이후 이용하실 수 있습니다.\n\n가입을 원하시면 하단 탭에서\n진행하실 수 있습니다.");
                } else if(helper_status === 1) {
                    location.href="changeHelperToMother?helper_status=1";
                }
            }
        </script>

        <c:if test="${helper.helper_status == 0}">
        <%--구독 및 결제--%>
        <div onclick="location.href='helper_subscribe'" style="width: 480px; display: flex; justify-content: center;">
            <div style="cursor: pointer; width: 448px; height: 60px; background: #ccc; border-radius: 20px; margin: 6px auto;">
                <div style="margin-top: 12px; font-size: 28px; color: #333">산모 서비스 구독 및 결제</div>
            </div>
        </div>
        </c:if>
        <%--문의--%>
        <div onclick="location.href='helper_ask'" style="width: 480px; display: flex; justify-content: center;">
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












