<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MainPageHB</title>
    <style>
        .box {
            text-align: center;
            width: 420px;
            height: 450px;
            margin: 10px 7px;
            padding: 10px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background-color: rgba(255, 194, 194, 0.7);
        }
        .textbox {
            height: 100px;
            width: 300px;
            border: none;
            border-radius: 20px;
            background-color: snow;
            box-shadow: -3px -1px -2px darkgray;
            font-family: Gothic/고딕체;
            font-size: 30px;
        }
        .textbox1 {
            height: 40px;
            width: 300px;
            border: none;
            border-radius: 15px;
            background-color: snow;
            box-shadow: -3px -1px -2px darkgray;
            font-family: Gothic/고딕체;
            font-size: 20px;
        }
        .button {
            margin-top: 10px;
            width: 100px;
            height: 40px;
            background-color: #ffffff;
            color: gray;
            border: none;
            border-radius: 15px;
            cursor: pointer;
        }
        .modal {
            height: 300px;
            width: 300px;
            background-color: #ffffff;
            top: 100px;
        }
    </style>
</head>
<body>
<div class="box">
    <h3>병원 등록</h3>
    <form id="hospitalForm" method="post" action="submitHospital">
        <label>
            <input type="text" name="hospitalName" placeholder="병원 이름" class="textbox"/>
        </label>
        <br/><br/>
        <label>
            <input type="text" name="phoneNumber" placeholder="전화번호" class="textbox1"/>
        </label>
        <br/><br/>
        <button type="submit" class="button">등록</button>&nbsp;
        <button type="button" class="button" onclick="closeModal()">취소</button>
    </form>
    <div id="modal" class="modal" style="display: none;">
        <h2>등록 완료!</h2>
        <p>병원 이름: <span id="hospitalName"></span></p>
        <p>전화번호: <span id="phoneNumber"></span></p>
        <button onclick="closeModal()">닫기</button>
    </div>
</div>
<script>
    function closeModal() {
        document.getElementById("modal").style.display = "none";
    }

    // 페이지 로드 후 실행되는 함수
    document.addEventListener("DOMContentLoaded", function() {
        // 폼 제출 후 실행되는 함수
        document.getElementById("hospitalForm").addEventListener("submit", function(event) {
            event.preventDefault(); // 폼 제출 기본 동작 방지
            // 폼 데이터를 FormData 객체로 가져오기
            const formData = new FormData(event.target);
            // 등록 완료 모달 보이기
            document.getElementById("modal").style.display = "block";
            // 입력된 병원 이름과 전화번호를 모달에 표시하기
            document.getElementById("hospitalName").textContent = formData.get("hospitalName");
            document.getElementById("phoneNumber").textContent = formData.get("phoneNumber");
        });
    });
</script>
</body>
</html>