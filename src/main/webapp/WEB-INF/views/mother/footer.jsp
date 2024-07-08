<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

<div style="z-index:251; position:absolute; bottom:0px; width:480px; height:100px; background: white; box-shadow: 0 0 4px 4px #ccc; font-size: 0px; ">
	<div style="width: 80px; height: 90px;  display: inline-block; margin: 0 14px;" onclick ="window.location.href='mother_health_report'">
		<i class="bi bi-clipboard2-check" style="font-size: 50px; color:#999;"></i>
		<div style="color:#999; font-size: 16px; font-weight: bold;">검진일지</div>
	</div>
	<div style="width: 80px; height: 90px; display: inline-block; margin: 0 14px;"
		onclick ="window.location.href='/helpers_list'">
		<i class="bi bi-people" style="font-size: 50px; color:#999;"></i>
		<div style="color:#999; font-size: 16px; font-weight: bold;">헬퍼즈</div>
	</div>
	<div style="width: 80px; height: 90px; display: inline-block; margin: 0 14px;"  onclick="location.href='mother_daily_report'">
		<i class="bi bi-pencil" style="font-size: 50px; color:#999;"></i>
		<div style="color:#999; font-size: 16px; font-weight: bold;">오늘의상태</div>
	</div>
	<div style="width: 80px; height: 90px; display: inline-block; margin: 0 14px;" onclick="location.href='mother_myPage'">
		<i class="bi bi-person-circle" style="font-size: 50px; color:#999;"></i>
		<div style="color:#999; font-size: 16px; font-weight: bold;">마이페이지</div>
	</div>
</div>
</body>
</html>