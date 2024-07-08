<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.Period" %>
<%@ page import="com.example.sanpa.biz.mother.MotherVO" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%
	Object mother = request.getAttribute("mother");
	LocalDate birthdate = ((MotherVO)mother).getHelper_birth();
	LocalDate mother_due_date = ((MotherVO)mother).getMother_due_date();

	Period birth = Period.between(birthdate, LocalDate.now());
	int age = birth.getYears();

	int month = 0;
	if(mother_due_date != null) {
		long daysBetween = ChronoUnit.DAYS.between(LocalDate.now(), mother_due_date);
		month = 9 - (int) daysBetween / 30;
	}


	int leftDay = 0;
	if(mother_due_date != null) {
		leftDay = (int) ChronoUnit.DAYS.between(LocalDate.now(), mother_due_date);
	}

%>
<!DOCTYPE html>
<html>
<head>
	<script src="/js/jquery-3.7.1.min.js"></script>
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
</style>
</head>
<body align="center" style="margin:0; height:1030px; overflow: hidden;">

<script>

	$(document).ready(function () {

		$('#AButtonClick').on('click', function () {
			$('#AButtonPage').css({"display":"inline-block"});
		});

		var countdown; // 카운트다운 인터벌 핸들을 저장할 전역 변수

		$('#BButtonClick').on('click', function () {
			$('#BButtonPage').css({"display":"inline-block"});
			var count = 4;
			countdown = setInterval(function(){
				$('p#countdownText').text(count + "초 후 자동으로 실행됩니다.");
				count--;
				if (count < 0) {
					clearInterval(countdown);
					$('#BBtnYes').trigger('click');
				}
			}, 1000); // 1000ms = 1s
		});

		$('.closeButton').on('click', function () {
			$('#AButtonPage').css({"display":"none"});
			$('#BButtonPage').css({"display":"none"});
		})

		$('#ABtnYes').on('click', function () {
			location.href="/AButtonClick";
		});
		$('#ABtnNo').on('click', function () {
			$('#AButtonPage').css({"display":"none"});
		});

		$('#BBtnYes').on('click', function () {
			location.href="BButtonClick";
		});
		$('#BBtnNo').on('click', function () {
			$('#BButtonPage').css({"display":"none"});
			clearInterval(countdown); // 카운트다운 인터벌을 취소
		});

	});

</script>

<%-- A Button Page --%>
<div id="AButtonPage" style="display: none; position:absolute; width: 480px; height: 1030px; background:rgba(10,10,10,0.3);box-shadow: 0 0px 4px 4px lightgrey; z-index: 1000">
	<div style="width: 84%; margin: 170px auto; background: white; border: 5px solid #FFB3B3;
				border-radius: 20px;z-index: 2000; padding: 0;">
		<p class="closeButton" style="margin: 0;padding:0; margin-left: 74%; position: absolute;">
			<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-x" viewBox="0 0 16 16">
				<path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708"/>
			</svg>
		</p>

		<p style="font-weight: 400; font-size: 100px; font-family: -apple-system; color: #FFB3B3; margin: 0 auto;">A</p>

		<p style="font-size: 25px; font-weight: 600; color: #FFB3B3;text-align: center; margin: 5px auto;">${mother.helper_name}님의 헬퍼즈</p>
		<p style="font-size: 28px; font-weight: 800; color: #FF578B;text-align: center; margin: 3px auto;">헬퍼즈 출동</p>

		<div style="width: 88%; border-radius: 20px; border: 3px solid rgba(0, 0, 0, 0.4); margin: 30px auto; box-shadow: 0px 2px 4px; background: #FFEDED;">
			<p style="font-weight: 500; font-size: 20px;">호출 List</p>
			<div style="padding: 10px; background: white; border-radius: 20px; font-weight: 600; margin: 0 auto; height: 200px; overflow: scroll;">
				<c:forEach var="mother2" items="${mother2}">
					<c:choose>
						<c:when test="${mother2.nicknameOfMother != null}">
							<p>${mother2.nicknameOfMother}</p>
						</c:when>
						<c:when test="${mother2.nicknameOfHelper != null}">
							<p>${mother2.nicknameOfHelper}</p>
						</c:when>
						<c:otherwise>
							<p>${mother2.helper_name}</p>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
			<p>출동 메세지는 총 ${mother3}명에게 전달됩니다.</p>
		</div>

		<p style="font-weight: 600; font-size: 25px; color: #FFB3B3">호출을 원하십니까?</p>

		<div style="display: flex; justify-content: space-around">
			<button id="ABtnYes" style="border-radius: 20px; border: 3px solid #FFB3B3; text-align: center; font-size: 25px; font-weight: 600; width: 46%; height: 80px; background: #FF578B; color: white; margin-bottom: 20px;">예</button>
			<button id="ABtnNo" style="border-radius: 20px; border: 3px solid #FFB3B3; text-align: center; font-size: 25px; font-weight: 600; width: 46%; height: 80px; color: #FF578B; margin-bottom: 20px;">아니오</button>
		</div>
	</div>
</div>

<%-- B Button Page --%>
<div id="BButtonPage" style="display: none; position:absolute; width: 480px; height: 1030px; background:rgba(10,10,10,0.3);box-shadow: 0 0px 4px 4px lightgrey; z-index: 1000">
	<div style="width: 84%; margin: 170px auto; background: white; border: 5px solid #FFB3B3;
				border-radius: 20px;z-index: 2000; padding: 0;">
		<p class="closeButton" style="margin: 0;padding:0; margin-left: 74%; position: absolute;">
			<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-x" viewBox="0 0 16 16">
				<path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708"/>
			</svg>
		</p>

		<p style="font-weight: 400; font-size: 100px; font-family: -apple-system; color: #FFB3B3; margin: 0 auto;">B</p>

		<p style="font-size: 25px; font-weight: 600; color: #FFB3B3;text-align: center; margin: 5px auto;">${mother.helper_name}님의 헬퍼즈</p>
		<p style="font-size: 28px; font-weight: 800; color: #FF578B;text-align: center; margin: 3px auto;">헬퍼즈 출동</p>

		<div style="width: 88%; border-radius: 20px; border: 3px solid rgba(0, 0, 0, 0.4); margin: 30px auto; box-shadow: 0px 2px 4px; background: #FFEDED;">
			<p style="font-weight: 500; font-size: 20px;">호출 List</p>
			<div style="padding: 10px; background: white; border-radius: 20px; font-weight: 600; margin: 0 auto; height: 200px; overflow: scroll;">
				<p style="color: red; font-weight: 600; font-size: 20px">119 구급차</p>
				<c:forEach var="mother2" items="${mother2}">
					<c:choose>
						<c:when test="${mother2.nicknameOfMother != null}">
							<p>${mother2.nicknameOfMother}</p>
						</c:when>
						<c:when test="${mother2.nicknameOfHelper != null}">
							<p>${mother2.nicknameOfHelper}</p>
						</c:when>
						<c:otherwise>
							<p>${mother2.helper_name}</p>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
			<p>출동 메세지는 총 ${mother3}명 + <span style="color: red;font-weight: 600">구급대원 </span>에게 <br/>전달됩니다.</p>
		</div>

		<p style="font-weight: 600; font-size: 25px; color: #FFB3B3; margin: 0px auto;">호출을 원하십니까?</p>
		<p id="countdownText" style="font-weight: 600; font-size: 21px; opacity: 0.5; margin: 0px auto;">5초 후 자동으로 실행됩니다.</p>

		<div style="display: flex; justify-content: space-around">
			<button id="BBtnYes" style="border-radius: 20px; border: 3px solid #FFB3B3; text-align: center; font-size: 25px; font-weight: 600; width: 46%; height: 80px; background: #FF578B; color: white; margin-bottom: 20px;">예</button>
			<button id="BBtnNo" style="border-radius: 20px; border: 3px solid #FFB3B3; text-align: center; font-size: 25px; font-weight: 600; width: 46%; height: 80px; color: #FF578B; margin-bottom: 20px;">아니오</button>
		</div>
	</div>
</div>

<%-- mainPage --%>
<div class="mainFrame" style="position:relative; width: 480px; height: 1030px; background:white; display: inline-block; box-shadow: 0 0px 4px 4px lightgrey;">
	<jsp:include page="header.jsp"/>
	<div style="width:480px; height: 830px; position: absolute; background: white; top:100px;">
		<br>
		<p style="color:#555; font-size: 16px; font-weight: bold;">${mother.helper_name}님의 정보</p>
		<!-- 산모,태명 -->
		<div style="position:relative; width: 420px; height: 120px; border-radius: 16px; box-shadow: 0 0 2px 2px lightgrey; margin: auto;">
			<div style="position:absolute; top:16px; left:16px; width: 88px; height: 88px; border-radius: 44px; background: black;"></div>
			<div style="position:absolute; top:24px; left:120px; width: 260px; height: 72px; background: white; text-align: left;">
				<div style=" font-size: 24px;"><span style="color: #777">산모 : </span><span style="color: #FF8F8F"><strong>${mother.helper_name}</strong>님 <%=age%>살</span></div>
				<div style=" font-size: 24px;"><span style="color: #777">태명 : </span><span style="color: #FF8F8F"><strong>${mother.mother_babyName}</strong> <%=month%>개월</span></div>
			</div>
		</div>
		<br>



		<!-- D-day -->
		<div style="position:relative; width: 420px; height: 80px; margin: auto; text-align: left;">
			<div style="position: absolute; right: -10px; top:-40px;">
				<svg width="108" height="68" viewBox="0 0 108 68" fill="none" xmlns="http://www.w3.org/2000/svg">
					<path d="M0 12C0 5.37258 5.37258 0 12 0H96C102.627 0 108 5.37258 108 12V41C108 47.6274 102.627 53 96 53H87.5L82.5 67.5L66.5 53H12C5.37258 53 0 47.6274 0 41V12Z" fill="#FF578B"/>
				</svg>
				<div style="position: absolute; top:6px; left: 4px; width: 100px; height: 44px; text-align: center;">
					<div style="font-weight: lighter; color: white">출산예정일</div>
					<div style="font-weight: bold; color: white">${mother.mother_due_date}</div>
				</div>
			</div>
			<c:set var="babyName" value="${mother.mother_babyName != null ? mother.mother_babyName : '애기'}"></c:set>
			<span style="color: #FF8F8F">${babyName} 만나기까지 <strong><%=leftDay%>일</strong>남았습니다.</span>
			<div id="progress-bar" style="margin-top: 4px; width: 420px; height: 32px; background: white; border-radius: 16px; border: 3px solid #FF567b; overflow: hidden">
				<div style="position:absolute; text-align: center; margin-top: 6px; width: 420px; height: 32px; z-index: 251; color: #FF567b;"> D-<%=leftDay%>일 </div>
				<i class="bi bi-heart-fill" style="z-index: 252; position: absolute; right:8px; top:34px; color:#ff567b;"></i>
				<div id="progress-div" style="width: 0%; height: 32px; background: #FFC2C2;"></div>
			</div>
		</div>

		<script>
			var totalDays = 280;
			var leftDays = <%=leftDay%>;
			var progress = ((totalDays - leftDays) / totalDays) * 100;

			document.getElementById('progress-div').style.width = progress + '%';
		</script>

		<!-- 출산예정일 -->
		<div style="position:relative; width: 360px; height: 30px; margin: auto; text-align: left; border-bottom: 2px solid #FFC2C2;">
			<div style="position:absolute; width: 128px; height: 30px; text-align: center; color: #999; font-size: 18px;">출산예정일:</div>
			<div style="position:absolute; width: 220px; height: 30px; right: 0; color: #FF8F8F; font-size: 20px;">
				<c:choose>
					<c:when test="${mother.mother_due_date != null}">${mother.mother_due_date}</c:when>
					<c:otherwise>기록한 결과가 없음</c:otherwise>
				</c:choose>
			</div>
		</div>
		<br/>
		<!-- 등록산부인과 -->
		<div style="position:relative; width: 360px; height: 30px; margin: auto; text-align: left; border-bottom: 2px solid #FFC2C2;">
			<div style="position:absolute; width: 128px; height: 30px; text-align: center; color: #999; font-size: 18px;">등록 산부인과:</div>
			<div style="position:absolute; width: 220px; height: 30px; right: 0; color: #FF8F8F; font-size: 20px;">
				<c:choose>
					<c:when test="${mother.mother_obHospital_name != null}">${mother.mother_obHospital_name}</c:when>
					<c:otherwise>등록한 산부인과가 없음</c:otherwise>
				</c:choose>

			</div>
		</div>
		<br/>
		<br/>
		<!-- 버튼 안내문 -->
		<div style="position:relative; width: 420px; height: 80px; margin: auto; text-align: center; font-size: 20px; opacity: 0.5;">
			<div>도움이 필요한 경우</div> <div>헬퍼즈 출동 버튼을 눌러주세요</div>
		</div>
		<br>
		<!-- A,B 버튼 -->
		<div style="position:relative; width: 420px; height: 300px; margin: auto;">
			<div style="width: 180px; height: 300px; position: absolute; left:10px;">
				<!--A버튼-->
				<div id="AButtonClick" style="position:relative; width: 180px; height: 180px; background: linear-gradient(135deg, #FFDBE6, #FF729E); border-radius: 90px;">
					<div style="position:absolute; width: 160px; height: 160px; border-radius: 80px; margin: 10px 10px; background: #FFE2EB">
						<div style=" font-size: 100px; margin-bottom: -10px; color: #FF578B">A</div>
						<div style=" font-size: 24px; color: #FF578B">LEVEL</div>
					</div>
				</div>
				<%--A버튼 설명--%>
				<br>
				<div style="font-size: 20px; color: #ff578b;">헬퍼즈 출동</div>
				<br>
			</div>
			<div style="width: 180px; height: 300px; position: absolute; right:10px;">
				<!--B버튼-->
				<div id="BButtonClick" style="position:relative; width: 180px; height: 180px; background: linear-gradient(135deg, #FFDBE6, #FF729E); border-radius: 90px;">
					<div style="position:absolute; width: 160px; height: 160px; border-radius: 80px; margin: 10px 10px; background: #FF578B">
						<div style=" font-size: 100px; margin-bottom: -10px; color: white">B</div>
						<div style=" font-size: 24px; color: white">LEVEL</div>
					</div>
				</div>
				<%--B버튼 설명--%>
				<br>
				<div style="font-size: 20px; color: #ff578b;">헬퍼즈 + <span style="color: red;font-weight: bold">119</span> 출동</div>
				<br>
			</div>
		</div>

	</div>
	<form action="mother_myPage" method="get">
		<button type="submit">myPage로</button>
		<jsp:include page="footer.jsp"/>
</div>
</body>
</html>