<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"   %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<!--
1.맨 위 산모즈 누르면 어디로 갈지
2.위치보기 버튼 아직 미정
3.삭제하기 버튼 delete.do?산모아이디 가져가기
4.산모추가 : search.do
5.받은 요청: inviteList.do

-->
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="/js/jquery-3.7.1.min.js"></script>
    <title>등록된 산모목록</title>
    <style>

        .card-container {
            position: absolute;
            left: 50%;
            top: 95%;
            transform: translate(-50%, -50%);
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 40px;
            overflow: inherit;
        }

        .card {
            height: 500px;
            width: 400px;
            transform-style: preserve-3d;
            margin-bottom: 20px;
            transition: all 1s;
            box-shadow: 1px 2px 4px grey;
            border-radius: 10px;
        }

        .card > div {
            height: 100%;
            width: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: flex-start;
            border-radius: 10px;
            position: absolute;
            left: 0;
            top: 0;
            backface-visibility: hidden;
            z-index: 9999;
        }

        .card .front {
            z-index: 9999;
        }

        .card .back {
            transform: rotateY(180deg);
        }
        .card.flipped {
            transform: rotateY(180deg);
        }

    </style>
</head>
<body align="center" style="margin:0;">

<div id=”mainFrame”  style="overflow: auto; position: relative; width: 480px; height: 1030px; border:1px solid black; display: inline-block; ">
    <jsp:include page="header.jsp" />
    <div style="position: absolute;
            margin: 0 auto;
            left: 25%;
            top: 120px">
        <p style="font-size: 30px; font-weight: bold;  color: #00ACF6; text-align: center;">헬퍼들을 위한 꿀팁</p>
    </div>
    <div class="card-container">
        <div class="card" onclick="rotateCard(this)">
            <div class="front" style="background-image: url('/img/pregnant.jpg');
            background-size: cover;"><h3 style="font-size: 30px; font-weight: bold;  color: white; text-shadow: 1px 2px 2px rgba(80, 115, 102, 0.7); padding-top: 350px">
                <img src="/img/heart.png" width="30px" height="30px">임산부 응급상황 알아두기</h3></div>
            <div class="back" style="text-align: left">
                <div style="width: 95%; height: 100%; padding-left: 10px" >
                    <h2 style="color:#80baa5;">내원이 필요한 상황</h2><br/>
                    <h3>임신 초기</h3>
                    <p style="margin: 0; font-size: 18px">출혈과 함께 <span style="font-weight: bold; color: #80baa5; text-shadow: 0 0 10px #ffcc00, 0 0 20px #ffcc00, 0 0 30px #ffcc00;">심한 통증</span>이 발생한다면 자궁외임신 증상일 수 있습니다.</p>
                    <h3>중기 이후</h3>
                    <p style="margin: 0; font-size: 18px">통증 없이 <span style="font-weight: bold; color: #80baa5; text-shadow: 0 0 10px #ffcc00, 0 0 20px #ffcc00, 0 0 30px #ffcc00;">양수</span>가 흐르는 경우 양막파열 여부를 확인해야합니다.</p>
                    <h3>임신 후기</h3>
                    <p style="margin: 0 ; font-size: 18px">20분동안 4회이상 규칙적인</span> 출혈이 발생할 경우 조기진통이 의심됩니다.<br/>
                        뒷목이 뻣뻣하고 <span style="font-weight: bold; color: #80baa5; text-shadow: 0 0 10px #ffcc00, 0 0 20px #ffcc00, 0 0 30px #ffcc00;">두통</span>과
                        <span style="font-weight: bold; color: #80baa5; text-shadow: 0 0 10px #ffcc00, 0 0 20px #ffcc00, 0 0 30px #ffcc00;">부종</span>이 생긴다면 임신중독증일 수 있습니다.</p>
                </div>
            </div>
        </div>
        <div class="card" onclick="rotateCard(this)">
            <div class="front" style="background-image: url('/img/gifts.png');
            background-size: cover;"><h3 style="font-size: 30px; font-weight: bold; color: white; text-shadow: 1px 2px 2px rgba(0, 0, 0, 0.5); padding-top: 350px">&nbsp;<img src="/img/present.png" width="30px" height="30px">&nbsp;출산 선물 추천</h3></div>
            <div class="back" style="background: rgba(255, 178, 178,0.3)">
                <div style="width: 95%; height: 100%; padding-left: 10px;"  >
                    <div style="display: flex; flex-direction: row; align-items: center; justify-content: center">
                        <img src="/img/cardImg1.png" width="150px" height="150px">
                        <div style="text-align: left;width: 100%; display: flex; flex-direction: column; align-items: center; justify-content: center">
                            <h2>젖병소독기</h2>
                            <span style="font-size: 15px">스펙트라/컬러에디션 젖병 소독기</span>
                        </div>
                    </div>
                    <div style="display: flex; flex-direction: row; align-items: center; justify-content: center">
                        <div style="text-align: left;width: 100%; display: flex; flex-direction: column; align-items: center; justify-content: center">
                            <h2>자동분유제조기</h2>
                            <span style="font-size: 15px">베이비브레짜/분유포트</span>
                        </div>
                        <img src="/img/cardImg3.png" width="150px" height="150px">
                    </div>
                    <div style="display: flex; flex-direction: row; align-items: center; justify-content: center">
                        <img src="/img/cardImg4.png" width="150px" height="150px">
                        <div style="text-align: left;width: 100%; display: flex; flex-direction: column; align-items: center; justify-content: center">
                            <h2>기저귀,물티슈</h2>
                            <span style="font-size: 15px">하기스 네이처메이드/맥스트라이</span>
                        </div>
                    </div>

                </div>

            </div>
        </div>
        <div class="card" onclick="rotateCard(this)">
            <div class="front" style="background-image: url('/img/happy-boy.jpg');
            background-size: cover;"><h3 style="font-size: 30px; color: white; font-weight: bold; text-shadow: 1px 2px 2px rgba(0, 0, 0, 0.5); padding-top: 350px">&nbsp;<img src="/img/party.png" width="50px" height="40px">꿀팁! 예비 엄빠라면?</h3></div>
            <div class="back">
                <div style="width: 90%; height: 100%; padding: 10px;text-align: center;
                display: flex; flex-direction: row; align-items: center; justify-content: center">
                    <img src="/img/sanpaIcon.png" style="padding-top: 20px" width="60px" height="70px">&nbsp;&nbsp;
                    `        <h2 >신생아 특례 대출 총정리!</h2>
                </div>
                <div style="width: 95%">
                    <p style="text-align: left;margin: 0; padding: 0; padding-left: 10px; font-size: 18px">
                        임신 중인 맘! 또는 초보 엄빠라면<br/>
                        반드시 살펴봐야 할 꿀팁!!<br/><br/>
                        <span style="font-size: 18px; font-weight: bold">신생아 특례대출</span><br/>
                        2년 이내 출산한 무주택가구를 대상으로<br/>
                        저금리 대출을 받을 수 있는 정책<br/><br/>

                        <span style="font-size: 18px; font-weight: bold">구입 자금 대출</span><br/>
                        출산한 가구에게 저금리와 우대조건으로<br/>
                        주택구입자금 지원하는 정책<br/><br/>

                        <span style="font-size: 18px; font-weight: bold">전세 자금 대출</span><br/>
                        대출 신청일 기준 2년 이내의<br/>
                        출산 이력이 있는 무주택가구 대상<br/>
                        <span style="color: #ff9595; float:right; cursor: pointer;font-size: 13px">자세히 보기 &gt;</span>
                    </p>

                </div>
            </div>
        </div>
    </div>


</div>
<script>
    // 클릭 시 카드를 회전시키는 함수
    function rotateCard(card) {
        // 클릭된 카드의 클래스에 'flipped' 클래스를 토글하여 회전 애니메이션을 적용
        card.classList.toggle('flipped');
    }
</script>
</body>
</html>