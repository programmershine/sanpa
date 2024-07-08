<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservation Page</title>
    <style>
        .box {
            text-align: left;
            width: 550px;
            margin: 10px;
            padding: 10px;
        }
        .input {
            text-align: left;
            height: 30px;
            width: 100%;
            background-color: snow;
            font-size: 16px;
            margin-bottom: 10px;
            box-sizing: border-box;
        }
        .description {
            width: 568px;
            height: 223px;
            font-size: 16px;
            text-align: center;
            background-color: aliceblue;
            box-shadow: 1px 1px 1px gray;
        }
        .button {
            padding: 10px 20px;
            margin-right: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="box">
    <form id="reservationForm" method="post">
        <label for="dayOfGuest">검진 날짜</label>
        <input type="text" id="dayOfGuest" name="dayOfGuest" class="input" placeholder="yyyy-MM-dd" required>
        <br /><br />
        <label>검진 결과</label>
        <label><input type="radio" name="hr" value="위험"> 위험</label>
        <label><input type="radio" name="hr" value="조금위험"> 조금위험</label>
        <label><input type="radio" name="hr" value="주의"> 주의</label>
        <label><input type="radio" name="hr" value="양호" checked> 양호</label>
        <label><input type="radio" name="hr" value="매우양호"> 매우양호</label>
        <br /><br />
        <label for="cont">비고</label>
        <input type="text" id="cont" name="cont" class="input">
        <br /><br />
        <button type="submit" class="button">등록</button>
        <button type="button" class="button">취소</button>
    </form>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const reservationForm = document.getElementById("reservationForm");

        // Form submission handling
        reservationForm.addEventListener("submit", function(event) {
            event.preventDefault();
            const form = event.target;
            const formData = new FormData(form);
            // You can now submit formData via AJAX or fetch
        });
    });
</script>
</body>
</html>