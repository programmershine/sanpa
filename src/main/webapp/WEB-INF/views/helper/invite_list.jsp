<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"   %>
<!DOCTYPE html>
<!--
UI맘에 안듬

우측상단 받은 요청 클릭 시  본인 아이디가지고 invitationList페이지로 이동

invite_list 테이블에서 내 아이디와 헬퍼아이디가 같은 마더아이디 조회해서 invite_list에 뿌려주면 마더 이름, 연락처 뿌려줘

수락 누르면 accept.do로 가서 invite_list에 accept컬럼 1로 업데이트하면 connection_list은 자동으로 추가 됨 > 완료 후 다시 invitList.do

거절 누르면 refuse.do로 가서 invite_list에서 그 헬퍼아이디, 마더아이디 조건에 맞는 데이터 삭제 > 삭제 완료 후 다시 invitList.do

-->
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>받은요청목록 </title>

</head>
<body align="center" style="overflow-y: auto; margin:0;">

<div class=”mainFrame”  style="position: relative; width: 480px; height: 1030px; border:1px solid black; display: inline-block;">

    <jsp:include page="header.jsp"></jsp:include>

    <div class="container" style="position: absolute; top: 100px; width: 460px; padding: 10px; margin: 10px auto; display: flex;
  flex-direction: column;">

        <div id="mainDiv" style="width: 480px; text-align: center; position: relative; top: 0px;">
            <div id="innerDiv" style="width: 420px; height: 60px; background: white; display: flex; justify-content: space-between; align-items: center; font-size: 20px; margin: 0 auto; color: #999; font-weight: bold;">
                <div id="listBtn"  onclick="window.location.href ='/sanmoz'">산모즈 List</div>
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
        <!-- jstl로 검색결과-->

        <div class="searchList" style=" margin-top:50px; ">
            <c:if test="${empty inviteList}">
                <p style="color:#ff9595; text-align: center; font-weight: bold; font-size: 20px;margin-top: 40px;">등록요청을 받은 내역이 없습니다.</p>
            </c:if>
            <c:forEach var="invitation" items="${inviteList}">

                <div class="listItem"
                     style="border: 1px solid #d9d9d9; display: flex; justify-content: center; flex-direction: row; margin: 10px auto; border-radius: 10px; align-items: center; width: 400px; padding: 10px; position: relative;">

                    <div style="text-align: left; width: 300px; ">
                        <p>산모이름 : <span style="font-weight: bolder; font-size: 17px">${invitation.helper_name} </span>  </p>
                        <p>연락처 : <span style="font-weight: bolder; font-size: 17px">${invitation.formattedHelper_tel}</span>   </p>
                    </div>

                    <div style="float: right;">
                        <div style="width:80px; padding: 5px; background-color: #a9e5ff; border-radius: 5px; text-align: center; margin-bottom: 5px; "><a href="accept.do?id=${invitation.mother_id}" style=" text-decoration: none; color:black; font-size: 15px;">수  락</a></div>

                        <div style="width:80px; padding: 5px; border: 1px solid #a9e5ff; border-radius: 5px; text-align: center; "><a href="refuse.do?id=${invitation.mother_id}" style=" text-decoration: none; color:black; font-size: 15px;">거  절</a></div>

                    </div>
                </div>
            </c:forEach>

        </div>

    </div>
    <jsp:include page="footer.jsp"/>
</div>
</body>
</html>