
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        @keyframes slide {
            0% {
                background-position: 0% 0%;
            }
            100% {
                background-position: 100% 0%;
            }
        }
        @keyframes slideLeft {
            0% {
                transform: translateX(-100%);
            }
            100% {
                transform: translateX(0%);
            }
        }

        @keyframes slideRight {
            0% {
                transform: translateX(0%);
                opacity: 0; /* 초기에 숨기기 위해 투명도를 0으로 설정 */
            }

            100% {
                transform: translateX(0%);
                opacity: 1;
            }
        }
        @keyframes colorChange {
            0% {
                color: white;
            }
            50% {
                color: #ff9595; /* 변경할 색상 지정 */
            }
            100% {
                color: white;
            }
        }
        @keyframes showButton{
            0%{
                opacity: 0;
            }
            100%{
                opacity: 1;
            }
        }


    </style>
</head>
<body align="center" style="margin:0; overflow-y: auto;">
<div class="mainFrame" style="position: relative;
            width: 480px;
            height: 1030px;
            border: 1px solid black;
            display: inline-block;
            overflow: hidden;">
    <div class="bgImg" style="
            animation: slide 20s linear infinite; /* 20초 동안 좌에서 우로 이동, 시간은 조절 가능 */
            background-image: url('/img/family.jpg');
            background-size: cover;
            height: 1030px;">
        <div class="container" style="position: absolute; top: 10px; width: 460px; padding: 10px; margin: 10px auto; display: flex;
            flex-direction: column; ">
            <div  class="hidden-element" style="text-align: right; color: white; font-size: 15px; cursor: pointer;
            animation: showButton 3s ease-in-out"
                 onclick="window.location.href='/getButtonList'">닫기</div>
            <div class="pageName" style="margin: 30px auto;">
                <h3 style="font-size: 50px; text-align: center; color: white;">Premium</h3>
            </div>
            <div class="slideLeft" style="text-align: left;margin-top: 50px;margin-left: 20px;
            animation: slideLeft 2s ease-in-out; /* 2초 동안 왼쪽에서 등장 */
            color: white; font-size: 18px">
                <p style="font-size: 22px; font-weight: bolder"><span style=" font-size: 27px;">도움</span>이 필요한 상황,</p>
                <p>내가 등록한 헬퍼를 호출합 수 있어요!</p>
                <p>산모와 헬퍼가 <span style="font-size: 25px; animation: colorChange 2s infinite;">위치</span>를 공유하고</p>
                <p><span style="font-size: 25px;animation: colorChange 2s infinite;">채팅</span>으로 상황을 알릴 수 있어요. </p>

            </div>
            <div class="slideRight" style="text-align: right;margin-top: 80px;margin-right: 20px;
            animation: slideRight 2s ease-in-out; /* 2초 동안 오른쪽에서 등장 */
           color: white;font-size: 18px">
                <p><span style="font-size: 22px; font-weight: bolder; color: gold">검진 기록</span>과
                    <span style="font-size: 22px; font-weight: bolder; color:#61dafb;">복용약</span>을 기록하여</p>
                <p>위급한 상황에 바로 확인할 수 있어요</p>
                <p><span style="font-size: 22px; font-weight: bolder; color: #ff9595;">오늘의 상태</span>를 등록하면</p>
                <p>모니터링을 통해 빠른 서비스를 제공합니다.</p>

            </div>
            <div style="text-align: right;margin-top: 80px; ">
                <p class="pointer" style="color: white;font-size: 25px; font-weight: bolder;cursor: pointer">
                    <span class="premiumButton"  onclick="window.location.href='/helper_subscribe'"
                     style="color: white;font-size: 15px; font-weight: normal; animation: colorChange 2s infinite; ">프리미엄 서비스 가입하기</span>&nbsp;&gt;</p>
            </div>
        </div>
    </div>

</div>


</body>
</html>
