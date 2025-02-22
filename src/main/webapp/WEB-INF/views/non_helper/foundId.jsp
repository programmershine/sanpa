<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<style type="text/css">
	input::placeholder {
		color: rgba(0, 0, 0, 0.4);
	}
	.btn2:hover {
		background: rgba(0, 0, 0, 0.1) !important;
		border-radius: 15px;
	}
</style>
<%
	String logo = "<svg width='180' height='56' viewBox='0 0 180 56' fill='none' xmlns='http://www.w3.org/2000/svg'><path d='M52.1368 13.7176C55.9554 13.7176 59.0509 10.6468 59.0509 6.85878C59.0509 3.07078 55.9554 0 52.1368 0C48.3182 0 45.2227 3.07078 45.2227 6.85878C45.2227 10.6468 48.3182 13.7176 52.1368 13.7176Z' fill='#FF578B' fill-opacity='0.8'/><path d='M15.66 23.8194C11.9497 23.8194 10.0664 25.4213 10.0101 27.6074C9.95812 30.0082 12.322 31.1849 15.8202 31.9322L19.2102 32.7311C26.6871 34.3846 31.0469 38.0695 31.0988 44.2583C31.0469 51.568 25.3407 56.0002 15.66 56.0002C7.64186 56.0002 1.94863 52.9982 0.134595 46.9382C-0.488846 44.851 1.1347 42.7637 3.32973 42.7637H5.76288C7.118 42.7637 8.28695 43.6184 8.80215 44.8596C9.78494 47.2131 12.2311 48.4199 15.5518 48.4199C19.4266 48.4199 21.7386 46.7106 21.7905 44.2583C21.7386 42.0164 19.747 40.8439 15.4435 39.8819L11.3565 38.9199C4.63289 37.3737 0.541563 34.0625 0.541563 28.2473C0.48961 21.0965 6.88854 16.2949 15.712 16.2949C22.5871 16.2949 27.5747 19.1381 29.5835 23.682C30.5447 25.8594 28.9428 28.3031 26.5486 28.3031H24.202C22.9205 28.3031 21.8122 27.5387 21.2277 26.4091C20.3704 24.7514 18.4828 23.8194 15.66 23.8194Z' fill='#FF578B' fill-opacity='0.8'/><path d='M105.28 55.4673H102.535C101.448 55.4673 100.427 54.9391 99.8074 54.0501L84.9791 32.7866H84.7106V52.1775C84.7106 53.9942 83.2256 55.4673 81.3943 55.4673H78.8789C77.0475 55.4673 75.5625 53.9942 75.5625 52.1775V20.117C75.5625 18.3003 77.0475 16.8271 78.8789 16.8271H81.7233C82.8187 16.8271 83.8404 17.364 84.4595 18.2573L99.1277 39.5079H99.4524V20.117C99.4524 18.3003 100.937 16.8271 102.769 16.8271H105.284C107.116 16.8271 108.601 18.3003 108.601 20.117V52.1775C108.601 53.9942 107.116 55.4673 105.284 55.4673H105.28Z' fill='#FF578B' fill-opacity='0.8'/><path d='M114.516 20.117C114.516 18.3003 116.001 16.8271 117.832 16.8271H130.44C139.207 16.8271 144.588 22.2686 144.588 30.1152C144.588 37.9618 139.103 43.3518 130.171 43.3518H126.976C125.145 43.3518 123.66 44.8249 123.66 46.6416V52.1775C123.66 53.9942 122.175 55.4673 120.343 55.4673H117.828C115.997 55.4673 114.512 53.9942 114.512 52.1775V20.117H114.516ZM128.505 36.1451C132.808 36.1451 135.12 33.7443 135.12 30.1152C135.12 26.4861 132.808 24.1927 128.505 24.1927H126.981C125.149 24.1927 123.664 25.6658 123.664 27.4825V32.8596C123.664 34.6763 125.149 36.1494 126.981 36.1494H128.505V36.1451Z' fill='#FF578B' fill-opacity='0.8'/><path d='M144.226 51.1206L155.206 19.0601C155.665 17.7244 156.925 16.8311 158.345 16.8311H165.748C167.168 16.8311 168.432 17.7287 168.887 19.0643L179.823 51.1249C180.55 53.2594 178.953 55.467 176.684 55.467H173.892C172.446 55.467 171.164 54.535 170.731 53.1693L169.558 49.4929C169.121 48.1229 167.843 47.1952 166.397 47.1952H157.7C156.253 47.1952 154.972 48.1272 154.539 49.4929L153.366 53.1693C152.928 54.5393 151.651 55.467 150.205 55.467H147.365C145.092 55.467 143.495 53.2509 144.226 51.1206ZM166.038 38.4124L163.531 30.5271C163.116 29.2172 161.254 29.2 160.808 30.4971L158.119 38.3823C157.803 39.3014 158.496 40.2591 159.475 40.2591H164.67C165.635 40.2591 166.328 39.3272 166.034 38.4124H166.038Z' fill='#FF578B' fill-opacity='0.8'/><path d='M67.208 43.1241C70.914 40.5902 72.6804 35.8616 71.2301 31.3908C69.7451 26.8211 65.3723 23.9823 60.7571 24.2056L59.0037 19.0604C58.5491 17.7248 57.2849 16.8271 55.8648 16.8271H48.4615C47.0414 16.8271 45.7772 17.7248 45.3226 19.0604L34.3432 51.121C33.6115 53.2555 35.2134 55.4673 37.482 55.4673H40.3221C41.7682 55.4673 43.0497 54.5354 43.4826 53.1696L44.6559 49.4933C45.0932 48.1233 46.3704 47.1956 47.8164 47.1956H56.5143C57.9603 47.1956 59.2418 48.1276 59.6748 49.4933L60.848 53.1696C61.2853 54.5397 62.5625 55.4673 64.0085 55.4673H66.801C69.0697 55.4673 70.6716 53.2555 69.9399 51.1253L67.2123 43.1241H67.208ZM62.2681 37.0857C55.2457 37.0857 49.5352 31.4208 49.5352 24.4547C49.5352 23.0331 50.6998 21.8778 52.1329 21.8778C53.5659 21.8778 54.7305 23.0331 54.7305 24.4547C54.7305 28.5777 58.1118 31.9319 62.2681 31.9319C63.7012 31.9319 64.8658 33.0872 64.8658 34.5088C64.8658 35.9304 63.7012 37.0857 62.2681 37.0857Z' fill='#FF578B' fill-opacity='0.8'/></svg>";
%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
</head>
<body align="center" style="margin:0;">
	
		
<div class=”mainFrame”  style="position: relative; width: 480px; height: 1030px; border:1px solid black; display: inline-block;">

	<div style="margin-top: 200px">
		<%= logo %>
	</div>
	<h1 style="color: rgba(0, 0, 0, 0.5); margin: 40px auto;">아이디 찾기</h1>
		<p style="color: rgba(0, 0, 0, 0.4);font-size: 17px; font-weight: bold; text-align: center;margin-left: -80px">입력하신 고객님의 아이디는</p>
		<!-- id값이 없을 때의 경우를 jstl로 만들어야함 -->
		<input type="text"  name="helper_id" style="background:#fffcfc; color: rgba(0, 0, 0, 0.5); padding: 10px;
					 margin: 10px; font-size: 20px; font-weight: bold; border-radius: 15px;
					 border: 1px solid rgba(0, 0, 0, 0.5)" readonly>
		<span style="color: rgba(0, 0, 0, 0.4);font-size: 17px; font-weight: bold; text-align: center; position:absolute; top:450px">입니다.</span>
					 
		<input onclick="location.href='/'" type="button" class="btn2" value="로그인 하러가기" style="width: 287px; height:44px; color: white;
					 background: #FF578B; text-align: center; font-size: 20px; padding: 25px auto;
					 border-radius: 15px; box-shadow: 2px 4px 4px 0px rgba(0,0,0,0.4); border: none;
					 margin-top: 60px;">
	<br>
		<input onclick="location.href='findId'" type="button" class="btn2" value="아이디 찾기" style="width: 287px; height:44px; color: white;
					 background: #FF578B; text-align: center; font-size: 20px; padding: 25px auto;
					 border-radius: 15px; box-shadow: 2px 4px 4px 0px rgba(0,0,0,0.4); border: none;
					 margin-top: 60px;">
		<input onclick="location.href='findPassword'" type="button" class="btn2" value="비밀번호 찾기" style="width: 287px; height:44px; color: white;
					 background: #FF578B; text-align: center; font-size: 20px; padding: 25px auto;
					 border-radius: 15px; box-shadow: 2px 4px 4px 0px rgba(0,0,0,0.4); border: none;
					 margin-top: 20px;">
		<input onclick="location.href='insertHelper'" type="button" class="btn2" value="회원가입" style="width: 287px; height:44px; color: white;
				background: #FF578B; text-align: center; font-size: 20px; padding: 25px auto;
				border-radius: 15px; box-shadow: 2px 4px 4px 0px rgba(0,0,0,0.4); border: none;
				margin-top: 20px;">
	
	
</div>


<script>
	window.onload = function() {
		var helperId = "${info.helper_id}";
		var input = document.querySelector("input[name='helper_id']");
		input.value = helperId || "없는 아이디 입니다.";
	};
</script>



</body>
</html>