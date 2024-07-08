<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>



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
            <button onclick="location.href='mother_myPage'" style="background: white; border:none; position: absolute; top:42px; left: 20px;">
                <svg width="15" height="26" viewBox="0 0 15 26" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M13 2L2 13L13 24" stroke="#333333" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </button>
            <span style=" font-size: 28px; font-weight: bolder; ">구독 및 결제</span>
        </div>

        <%--구독현황--%>
        <div style="width: 360px; margin: auto;">
            <div style="text-align: left; font-size: 24px; color: #FF9595">
                <strong>김산모</strong> 님(38) 의 구독현황
            </div>
            <br>
            <div style="width: 360px; height: 200px; border-radius: 20px; background: #ff9595; color:white;">
                <br>
                <div>산모서비스: 29,800원 / 월</div>
                <br>
                <div>2024-01-02 시작</div>
                <br>
                <div style="width: 240px; height: 80px; border: 2px solid white; border-radius: 10px; margin: auto;">

                    <div style="margin-top: 8px; font-weight: lighter;">매월 자동 갱신</div>
                    <div style="margin-top: 12px;">현재 서비스 기간</div>
                    <div>2024-03-02 ~ 2024-04-02</div>
                </div>
            </div>
            <br><br>
            <div style="width: 360px; height: 40px; border: 2px solid #ff9595; border-radius: 20px; color: #ff9595">
                <div style="font-size: 20px; margin-top: 8px;">결제수단 변경</div>
            </div>
            <br>
            <div id="dismissBtn" style="width: 360px; height: 40px; border: 2px solid #ff9595; border-radius: 20px; color: #ff9595">
                <div style="font-size: 20px; margin-top: 8px;">해지하기</div>
            </div>
            <script>

                $('#dismissBtn').click(function () {
                    if(confirm("산모 서비스 이용을 해지하시겠습니까?\n\n해지를 진행해도\n기존 산모 데이터는 유지할 수 있습니다.")) {
                        alert("이용 해지가 완료됐습니다.");
                        location.href='dismissMother';
                    } else {
                        return false;
                    }
                })

            </script>


            <div style="font-size: 14px; margin-top: 4px; color: #ff9595; font-weight: bold;">
                헬퍼즈 상태로 변경되어 서비스를 계속 이용하실 수 있습니다.
            </div>
        </div>



    </div>
    <jsp:include page="footer.jsp"/>
</div>
</body>
</html>












