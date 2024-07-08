<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <style>
        /* Pretendard 폰트 패밀리 적용 */
        body {
            font-family: 'Pretendard', sans-serif;
        }
    </style>
</head>
<body>
<div style="text-align: center; z-index:251; position:absolute; bottom:0px; width:480px; height:100px; background: white; box-shadow: 0 0 2px 2px #ccc; font-size: 0px; ">
    <div  onclick ="window.location.href='/tip'"
          style="width: 80px; height: 90px;  display: inline-block; margin: 0 14px;">
        <i class="bi bi-clipboard2-check" style=" font-size: 50px; color:#999;"></i>
        <div style=" color:#999;font-size: 16px; font-weight: bold;">TIP♡</div>
    </div>
    <div style="width: 80px; height: 90px; display: inline-block; margin: 0 14px;" onclick ="window.location.href='/premium'">
        <i class="bi bi-people" style="font-size: 50px; color:#999;" ></i>
        <div style="color:#999;font-size: 16px; font-weight: bold;">프리미엄</div>
    </div>
    <div style="width: 80px; height: 90px; display: inline-block; margin: 0 14px;  cursor: pointer;" onclick="window.location.href ='/sanmoz'">
        <i class="bi bi-pencil" style="font-size: 50px; color:#999;"></i>
        <div style="color:#999;font-size: 16px; font-weight: bold;">산모즈</div>
    </div>
    <div style="width: 80px; height: 90px; display: inline-block; margin: 0 14px;" onclick="redirectToMyPage()">
        <i class="bi bi-person-circle" onclick="window.location.href = '/helper_myPage'" style="font-size: 50px; color:#999;"></i>
        <div style="color:#999;font-size: 16px; font-weight: bold;">마이페이지</div>
    </div>
</div>
</body>
</html>