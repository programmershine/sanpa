<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"   %>

<!DOCTYPE html>
<!--

우측상단 산모추가 클릭 시  본인 아이디가지고 search.do > get방식이면 jsp로 보내고 > post방식이면 로직수행 > 완료후 invite_list.jsp
받은 요청목록 : invitationList
요청보내기 : invite.do
산모 검색 : searchPage(페이지이동), 검색서밋 : search.do
-->
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>산모즈에서 산모추가 클릭시 검색창</title>
    <style>
        input:hover {
            border-color: blue;
            box-shadow: 0 0 5px 0 #a9e5ff; /* Add blue shadow on hover */
        }
        #goSanmobtn:hover{
            color: darkgrey;
            font-weight: bold;
        }

    </style>
</head>
<body align="center" style="margin:0;">

<div class=”mainFrame”  style="position: relative; width: 480px; height: 1030px; border:1px solid black; display: inline-block;">
    <jsp:include page="header.jsp"></jsp:include>
    <div class="container" style="position: absolute; top: 100px; width: 460px; padding: 10px; margin: 10px auto; display: flex;
  flex-direction: column;">

        <div id="mainDiv" style="width: 480px; text-align: center; position: relative; top: 0px;">
            <div id="innerDiv" style="width: 420px; height: 60px; background: white; display: flex; justify-content: space-between; align-items: center; font-size: 20px; margin: 0 auto; color: #999; font-weight: bold;">
                <div id="listBtn"  onclick="window.location.href ='/sanmoz'">산모즈 List</div>
                <span style="margin: 0 10px;">|</span>
                <div id="addBtn" style="color: #00ACF6" onclick="location.href='/searchPage'">산모즈 추가</div>
                <span style="margin: 0 10px;">|</span>
                <div id="locationBtn" onclick="location.href='/#/mothers'">산모즈 위치</div>
            </div>
        </div>
        <div style="width: 95%; margin: 5px auto;">
            <p style=" text-align: right; font-weight: bold; color: #00ACF6; font-size: 21px;"
               onclick="location.href='/invitationList'">받은 요청 리스트 &gt;</p>
        </div>

        <div class="search" style="background:#a9e5ff; border-radius: 15px; width: 95%; height: 100px;  margin: 20px auto; align-items: center; justify-content: center; margin-bottom: 20px; display: flex; flex-direction: column;">
            <!-- helper테이블 전화번호로 검색한 결과의 helper 테이블의 이름, 전화번호 띄워줌 -->

            <form action="search.do" method="POST">
                <input type="text" name="phoneNumber" placeholder="  -없이 전화번호로 검색"
                       style="font-size: 15px; width: 320px; height: 40px; border: 1px solid lightgrey; border-radius: 5px;">
                <button type="submit" style="width: 60px; padding:12px; background: white; border: 1px solid lightgrey; border-radius: 5px; cursor: pointer">검색</button>
            </form>
        </div>

        <!-- 검색 결과 출력 -->
        <div class="searchList" style="overflow-y: auto; max-height: 500px; margin: 5px auto; ">
            <c:choose>
                <c:when test="${not empty searchResult}">
                    <div class="listItem"
                         style="border: 1px solid #d9d9d9; display: flex; justify-content: center; flex-direction: row; margin: 30px auto;
                 border-radius: 10px; align-items: center; width: 400px; padding: 10px; ">
                        <div style="text-align: left; width: 300px; ">
                            <p>이름 : <span style="font-weight: bolder; font-size: 17px">${searchResult.helper_name}</span>  </p>
                            <p>연락처 : <span style="font-weight: bolder; font-size: 17px">${searchResult.formattedHelper_tel} </span>  </p>
                            <p>출산 예정일 : <span  style="font-weight: bolder; font-size: 17px">${searchResult.mother_due_date}</span> </p>
                        </div>
                        <div style="float: right;">
                            <div style="width: 90px; padding:6px; background-color: #a9e5ff; border-radius: 5px; text-align: center; ">
                                <a href="invite.do?id=${searchResult.mother_id }" style="text-decoration: none; color:black; font-size: 15px;">요청 보내기</a></div>
                        </div>
                    </div>

                </c:when>
                <c:otherwise>
                    <c:if test="${empty searchResult and empty errorMessage}">
                        <p style="margin-top: 150px; text-align: center; color: #00ACF6; font-size: 18px;font-weight: bold;">
                            추가하고 싶은 산모의 전화번호를 입력하세요.
                        </p>
                    </c:if>
                </c:otherwise>
            </c:choose>

            <!-- errorMessage가 비어 있지 않은 경우에만 출력 -->
            <c:if test="${not empty errorMessage and empty searchResult}">
                <p style="margin-top: 150px; text-align: center; color: #ff0000; font-size: 18px; font-weight: bold;">
                        ${errorMessage}
                </p><br/><br/><br/>
                <a id="goSanmobtn" href="sanmoz" style=" font-weight: bold; text-decoration: none; color:darkgrey; font-size: 18px;">등록된 산모 확인하기 ></a><br/><br/><br/>
                <a id="goSanmobtn" href="invitationList" style=" font-weight: bold; text-decoration: none; color:darkgrey; font-size: 18px;">내가 받은 요청 확인하기 ></a>
            </c:if>
        </div>
    </div>
    <jsp:include page="footer.jsp"/>
</div>

</body>
</html>