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
        ::-webkit-scrollbar {
            opacity: 0;
        }

        .toggle-slide {
            display: none;
        }
        .toggle-container {
            position: relative;
            font-size: 16px;
            display: inline-block;
            /*align-items: center;*/
            /*justify-content: flex-end;*/
        }
        .toggle-text {
            margin: 0 5px;
        }
        .refuse {
            position: relative;
            left: 10px;
            top: 3px;
        }
        .agree {
            position: relative;
            left: 93px;
            top: 2px;
        }
        label {
            width: 120px !important;
            height: 60px !important;
            background: #a9e5ff;
            opacity: 0.5;
            text-indent: -9999px;
            border-radius: 60px;
            position: relative;
            cursor: pointer;
            transition: 0.5s;
        }
        label::before {
            content: '';
            position: absolute;
            top: 0;
            left: 10px;
            width: 80px;
            height: 31px;
            background: #a9e5ff;
            border-radius: 40px;
            transition: 0.5s;
        }
        label::after {
            content: '';
            position: absolute;
            width: 24px;
            height: 24px;
            background: #e5e5e5;
            border-radius: 25px;
            transition: 0.5s;
            top:4px;
            left:16px;
        }
        .toggle-slide:checked + label {
            opacity: 1;
        }
        .toggle-slide:checked + label::after {
            top: 4px;
            left: 61px;
        }

    </style>
</head>
<body align="center" style="margin:0;">

<div id=”mainFrame”  style="position: relative; width: 480px; height: 1030px; border:1px solid black; display: inline-block; ">
    <jsp:include page="header.jsp" />
    <div class="container" style="position: absolute; top: 100px; width: 460px; padding: 10px; margin: 10px auto; display: flex;
  flex-direction: column; margin-bottom: 150px">

        <div id="mainDiv" style="width: 480px; text-align: center; position: relative; top: 0px;">
            <div id="innerDiv" style="width: 420px; height: 60px; background: white; display: flex; justify-content: space-between; align-items: center; font-size: 20px; margin: 0 auto; color: #999; font-weight: bold;">
                <div id="listBtn" style="color: #00ACF6" onclick="window.location.href ='/sanmoz'">산모즈 List</div>
                <span style="margin: 0 10px;">|</span>
                <div id="addBtn" onclick="location.href='/searchPage'">산모즈 추가</div>
                <span style="margin: 0 10px;">|</span>
                <div id="locationBtn" onclick="location.href='/#/mothers'">산모즈 위치</div>
            </div>
        </div>
        <div style="width: 95%; margin: 5px auto;">
            <p style=" text-align: right; font-weight: bold; color: #00ACF6; font-size: 21px;"
               onclick="location.href='/invitationList'">받은 요청 리스트 &gt;</p>
        </div>
        <!-- jstl로 목록출력 UI 안보여서 임시로 막아놓음-->
        <!--  connection_list 테이블에 helper_id가 내 아이디인 mother_id들의 helper_name, helper_tel 조회 -->
        <div class="sanmozList" style="  max-height: 500px; margin-top:10px;">
            <c:if test="${empty motherList}">
                <p style="color:#ff9595; text-align: center; font-weight: bold; font-size: 18px;">등록된 산모가 없습니다.</p>
            </c:if>
            <c:forEach var="mother" items="${motherList}" varStatus="loop" >

                <div class="listItem"
                     style="border: 3px solid #d9d9d9; margin: 10px auto; border-radius: 15px; width: 400px; padding: 10px; position: relative;">
                    <div style="display: flex; flex-direction: row;">

                        <div style="text-align: left; width: 300px; ">
                            <p >산모이름 :<span style="font-weight: bolder; font-size: 18px"> ${motherNameList[loop.index] != null ? motherNameList[loop.index].helper_name : '뗴잉'} </span></p>
                            <p >오늘의 상태 :  <span style="font-weight: bolder; font-size: 18px">${not empty mother.general_status ? mother.general_status : '등록된 정보 없음'}</span></p>
                            <p style="text-decoration: underline;cursor: pointer;" onclick="toggleModal('${mother.mother_id}', '${mother.visited_date}', '${mother.hospital_name}', '${mother.medicine_name}')">최근 검진기록 보기▽
                            </p>

                        </div>


                        <div style="width: 100px; padding-top: 30px">
                            <div style="width:80px; padding: 5px; background-color: #a9e5ff; border-radius: 5px; text-align: center; margin-bottom: 5px; "><a onClick="handleButtonClick('${mother.mother_id}')"<%--href="/#/mothers"--%> style="text-decoration: none; color:black; font-size: 15px;">위치보기</a></div>
                            <!-- 삭제하기 버튼을 누르면 산모 아이디 가져가서 connection_list랑, invite_list에서 삭제누른 헬퍼와 해당 산모의 데이터 삭제  -->
                            <div style="width: 80px; padding:5px; border: 1px solid #a9e5ff; border-radius: 5px; text-align: center;">
                                <a href="javascript:void(0);" onclick="confirmDelete('${mother.mother_id}')" style="text-decoration: none; color:black; font-size: 15px;">삭제하기</a>
                            </div>
                        </div>
                    </div>
                    <div id="motherBox-${loop.index}" style="display: flex; align-items: center; max-width: 100%; ">
                        <p style="color:rgba(0, 0, 0, 0.5); font-size: 18px; font-weight: 400; text-align: left; margin: 7px 10px; ">위치 공유 </p>
                        <span class="toggle-container" style="margin-left: 100px;">
                                <span class="toggle-text refuse">거절</span>
                                <input type="checkbox" id="toggle-slide-${loop.index}" class="toggle-slide" ${mother.locationallowhtm == 1 ? 'checked' : ''}
                                       onchange="handleLocationToggle('${mother.mother_id}', this.checked)">

                            <!--  {helper.locationAllow == 1 ? 'checked' : ''  -->

                                <label for="toggle-slide-${loop.index}"></label>
                                <span class="toggle-text agree">동의</span>
                            </span>

                    </div>
                    <!-- 모달창  -->
                    <div id="myModal_${mother.mother_id}" class="modal"  style="display: none;  width: 90%; background: #FFD4D4; box-shadow:2px 2px 2px darkgrey; border-radius: 10px; padding: 10px; text-align: left; position: absolute; left: 10px; bottom: -90px; z-index: 1; font-size: 17px">
                        <c:choose>
                            <c:when test="${not empty mother.visited_date}">
                                <p>검진 날짜: <span id="examDate_${mother.mother_id}">${mother.visited_date}</span></p>
                            </c:when>
                            <c:otherwise>
                                <p>검진 날짜: 등록된 정보 없음</p>
                            </c:otherwise>
                        </c:choose>

                        <c:choose>
                            <c:when test="${not empty mother.hospital_name}">
                                <p>내원 병원: <span id="hospital_${mother.mother_id}">${mother.hospital_name}</span></p>
                            </c:when>
                            <c:otherwise>
                                <p>내원 병원: 등록된 정보 없음</p>
                            </c:otherwise>
                        </c:choose>

                        <c:choose>
                            <c:when test="${not empty mother.medicine_name}">
                                <p>복용 약: <span id="medication_${mother.mother_id}">${mother.medicine_name}</span></p>
                            </c:when>
                            <c:otherwise>
                                <p>복용 약: 등록된 정보 없음</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>


                <script>
                    //삭제하기 전 확인
                    function confirmDelete(motherId) {
                        var confirmDelete = confirm("정말 삭제하시겠습니까?");

                        if (confirmDelete) {
                            // 확인을 선택한 경우, 삭제 작업 수행
                            window.location.href = "delete.do?id=" + motherId;
                        } else {
                            // 취소를 선택한 경우, 아무 작업도 수행하지 않음
                        }
                    }

                    function toggleModal(motherId, visitedDate, hospitalName, medicineName) {
                        var modalId = 'myModal_' + motherId;
                        var modal = document.getElementById(modalId);

                        if (modal.style.display === 'none' || modal.style.display === '') {
                            // 모달이 닫혀있을 때 열기
                            modal.style.display = 'block';

                            // 모달 내용 설정 (산모아이디로 병원, 약 테이블 데이터 조회)
                            document.getElementById('examDate_' + motherId).innerText = visitedDate;
                            document.getElementById('hospital_' + motherId).innerText = hospitalName;
                            document.getElementById('medication_' + motherId).innerText = medicineName;

                            var rect = element.getBoundingClientRect();
                            modal.style.bottom = rect.height + 'px';

                        } else {
                            // 모달이 열려있을 때 닫기
                            modal.style.display = 'none';
                        }
                    }
                    // 위치동의 토글 버튼 클릭 이벤트 처리
                    function handleLocationToggle(motherId, checked) {
                        // AJAX를 통해 서버에 데이터베이스 수정 요청
                        $.ajax({
                            type: "POST", // 또는 "GET"
                            url: "/api/data/updateLocationAllowhtm.do", // 수정을 처리할 서버의 URL
                            contentType: "application/json",
                            data: JSON.stringify({ motherId: motherId, locationallowhtm: checked ? 1 : 0 }), // 요청 본문 데이터
                            success: function(response) {
                                // 서버에서 성공적으로 응답을 받았을 때 수행할 동작
                                console.log("데이터베이스 수정 완료:", response);
                            },
                            error: function(xhr, status, error) {
                                // 요청이 실패했을 때 수행할 동작
                                console.error("데이터베이스 수정 실패:", error);
                            }
                        });
                    }
                    function handleButtonClick(element) {
                        console.log("클릭했어");

                        var motherId = element; /*.closest('.item').getAttribute('data-mother-id');*/
                        sessionStorage.setItem('mother_id', motherId);
                        console.log('mother_id',motherId);
                        console.log("보낼거야 마더스로");
                        window.location.href = '/#/mothers';
                    }

                </script>
            </c:forEach>

        </div>

    </div>

    <jsp:include page="footer.jsp"/>
</div>

</body>
</html>