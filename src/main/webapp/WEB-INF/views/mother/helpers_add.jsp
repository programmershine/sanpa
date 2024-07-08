<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
    <%
        String mother_id = (String)session.getAttribute("helper_id");
    %>
</head>
<body align="center" style="margin:0; height:1030px; overflow: hidden;">

<div class="mainFrame" style="position:relative; width: 480px; height: 1030px; background:white; display: inline-block; box-shadow: 0 0px 4px 4px lightgrey;">
    <jsp:include page="header.jsp"/>
    <div style="width:480px; height: 830px; position: absolute; background: white; top:100px; overflow: scroll;">

        <div id="mainDiv" style="width: 480px; text-align: center; position: relative; top: 0px;">
            <div id="innerDiv" style="width: 420px; height: 60px; background: white; display: flex; justify-content: space-between; align-items: center; font-size: 20px; margin: 0 auto; color: #999; font-weight: bold;">
                <div id="listBtn" onclick="location.href='/helpers_list'">헬퍼즈 List</div>
                <span style="margin: 0 10px;">|</span>
                <div id="addBtn" style="color: black" onclick="location.href='/helpers_add'">헬퍼즈 추가</div>
                <span style="margin: 0 10px;">|</span>
                <div id="locationBtn" onclick="location.href='/#/helpers'">헬퍼즈 위치</div>
            </div>
        </div>

        <form action="helpers_add_searchKeyword" method="post">
            <div style="background: #FE78A1; width: 95%; height: 100px; border-radius: 15px; text-align: center; margin: 5px auto;">
                <p style="font-weight: bold; color: white; font-size: 18px; margin: 5px auto; padding: 5px;">전화번호로 검색</p>
                <input id="searchInput" name="searchKeyword" type="text" style="outline: none; border: 1px solid rgba(0, 0, 0, 0.3); width: 77%; height: 38px; font-size: 20px; border-radius: 10px; padding: 5px 10px; font-weight: bold; margin: 0px 5px">
                <div id="searchButton" style="margin: 1px; display: inline-block; position: relative; top: 1px;"><input type="hidden" value="${sessionScope.helper_id}" name="mother_id">
                    <button type="submit" style="height: 38px; position: relative; background: #FE78A1; border: none; top: 3px">
                        <svg xmlns="http://www.w3.org/2000/svg" width="36" height="32" fill="currentColor" class="bi bi-search-heart" viewBox="0 0 16 16">
                            <path d="M6.5 4.482c1.664-1.673 5.825 1.254 0 5.018-5.825-3.764-1.664-6.69 0-5.018"/>
                            <path d="M13 6.5a6.47 6.47 0 0 1-1.258 3.844q.06.044.115.098l3.85 3.85a1 1 0 0 1-1.414 1.415l-3.85-3.85a1 1 0 0 1-.1-.115h.002A6.5 6.5 0 1 1 13 6.5M6.5 12a5.5 5.5 0 1 0 0-11 5.5 5.5 0 0 0 0 11"/>
                        </svg>
                    </button>
                </div>
            </div>
        </form>

        <%-- 검색하여 나온 항목 --%>
        <c:if test="${helperInfo != null}">
        <div style="border-bottom: 2px solid rgba(0, 0, 0, 0.3); margin: 5px auto">
            <p style="color: rgba(0, 0, 0, 0.4); font-size: 21px; font-weight: 500; text-align: center; padding: 2px; margin-bottom: 8px">검색 결과</p>
        </div>
        </c:if>

        <div style="width: 95%; margin: 5px auto; margin-top: 25px;">

                    <c:if test="${added != null}">
                    <c:forEach var="addedHelper" items="${helperInfo_addedId}">
                    <div id="helperBox" style="display: flex; align-items: center; border: 3px solid #FE78A1; max-width: 100%; border-radius: 15px; margin: 10px auto; padding: 10px;">
                        <div style="display: flex; flex-direction: row; justify-content: center; align-items: center; margin-right: 10px;">
                            <div style="background: deeppink;border-radius: 50%; width: 70px; height: 70px; margin: 5px; padding: 2px; margin-left: 15px;"></div>
                        </div>

                        <div style="display: inline-block">
                            <p style="color:rgba(0, 0, 0, 0.5); font-size: 20px; font-weight: bolder; text-align: left; margin: 7px 10px;">${added.helper_name}</p><input id="helper_idInput2" type="hidden" name="helper_id" value="${added.helper_id}">
                            <p style="color:rgba(0, 0, 0, 0.5); font-size: 20px; font-weight: bolder; text-align: left; margin: 7px 10px;">${added.helper_tel}</p><input id="mother_idInput2" type="hidden" name="mother_id" value="<%=mother_id%>">
                        </div>

                        <div style="display: inline-block; position: relative; left: 25px;">
                            <button disabled style="background: #FE78A1; padding: 7px 12px; color: white; font-size: 18px; font-weight: 500; border: none; border-radius: 20px;
        margin: 10px; width: 120px;">요청중...</button><Br>
                            <button id="addedIdBtn2" type="button" style="background: rgba(0, 0, 0, 0.3); padding: 7px 12px; color: rgba(0, 0, 0, 0.5); font-size: 18px; font-weight: 600; border: none;
        border-radius: 20px; margin: 10px; width: 120px;">취소</button>
                        </div>
                    </div>
                    </c:forEach>
                    </c:if>

                    <c:if test="${helperInfo_duplicatedId != null}">
                    <c:forEach var="duplicatedHelper" items="${helperInfo_duplicatedId}">
                    <div id="helperBox" style="display: flex; align-items: center; border: 3px solid #FE78A1; max-width: 100%; border-radius: 15px; margin: 10px auto; padding: 10px;">
                        <div style="display: flex; flex-direction: row; justify-content: center; align-items: center; margin-right: 10px;">
                            <div style="background: deeppink;border-radius: 50%; width: 70px; height: 70px; margin: 5px; padding: 2px; margin-left: 15px;"></div>
                        </div>

                        <div style="display: inline-block">
                            <p style="color:rgba(0, 0, 0, 0.5); font-size: 20px; font-weight: bolder; text-align: left; margin: 7px 10px;">${duplicatedHelper.helper_name}</p><input id="helper_idInput3" type="hidden" name="helper_id" value="${duplicatedHelper.helper_id}">
                            <p style="color:rgba(0, 0, 0, 0.5); font-size: 20px; font-weight: bolder; text-align: left; margin: 7px 10px;">${duplicatedHelper.helper_tel}</p><input id="mother_idInput3" type="hidden" name="mother_id" value="<%=mother_id%>">
                        </div>

                        <div style="display: inline-block; position: relative; left: 25px;">
                            <button disabled style="background: #FE78A1; padding: 7px 12px; color: white; font-size: 18px; font-weight: 500; border: none; border-radius: 20px;
            margin: 10px; width: 120px;">친구예요</button><Br>
                        </div>
                    </div>
                    </c:forEach>
                    </c:if>




            <c:if test="${dupped == null && added == null}">
            <c:forEach var="helper" items="${helperInfo}" varStatus="status">

                <form action="helpers_add_helper" method="post">
                    <div id="helperBox-${status.index}" style="display: flex; align-items: center; border: 3px solid #FE78A1; max-width: 100%; border-radius: 15px; margin: 10px auto; padding: 10px;">

                        <div style="display: flex; flex-direction: row; justify-content: center; align-items: center; margin-right: 10px;">
                            <div style="background: deeppink;border-radius: 50%; width: 70px; height: 70px; margin: 5px; padding: 2px; margin-left: 15px;"></div>
                        </div>

                        <div style="display: inline-block">
                            <p style="color:rgba(0, 0, 0, 0.5); font-size: 20px; font-weight: bolder; text-align: left; margin: 7px 10px;">${helper.helper_name}</p><input id="helper_idInput" type="hidden" name="helper_id" value="${helper.helper_id}">
                            <p style="color:rgba(0, 0, 0, 0.5); font-size: 20px; font-weight: bolder; text-align: left; margin: 7px 10px;">${helper.helper_tel}</p><input id="mother_idInput" type="hidden" name="mother_id" value="<%=mother_id%>">
                        </div>


                            <div style="display: inline-block; position: relative; left: 25px;">
                                <button type="submit" style="background: #FE78A1; padding: 7px 12px; color: white; font-size: 18px; font-weight: 500; border: none; border-radius: 20px;
            margin: 10px; width: 120px;">헬퍼 추가</button><Br>
                            </div>

                    </div>

                </form>

            </c:forEach>
            </c:if>
<script>

    $("#addedIdBtn2").click(function (e) {
       var helper_id =  $("#helper_idInput2").val();
       var mother_id =  $("#mother_idInput2").val();
       $.ajax({
          type: "POST",
          url: "helpers_add_cancel",
           data: {helper_id:helper_id, mother_id:mother_id},
           success: function(response) {
               window.location.href = "/helpers_add";
           },
           error: function(jqXHR, textStatus, errorThrown){
               alert("요청 처리 중 문제가 발생했습니다: " + textStatus);
           }
       });
    });

</script>

            <%-- 친구 요청을 보내고 헬퍼쪽에서 수락 대기중인 항목 --%>
            <c:if test="${helperAddList != null}">
                <div style="border-bottom: 2px solid rgba(0, 0, 0, 0.3); margin: 5px auto">
                    <p style="color: rgba(0, 0, 0, 0.4); font-size: 21px; font-weight: 500; text-align: center; padding: 2px; margin-bottom: 8px">요청 수락 중인 목록</p>
                </div>
            </c:if>

            <c:forEach var="helper" items="${helperAddList}" varStatus="status">
                <form action="helpers_add_cancel" method="post">
                    <div id="helperBox-${status.index}" style="display: flex; align-items: center; border: 3px solid #FE78A1; max-width: 100%; border-radius: 15px; margin: 10px auto; padding: 10px;">

                        <div style="display: flex; flex-direction: row; justify-content: center; align-items: center; margin-right: 10px;">
                            <div style="background: deeppink;border-radius: 50%; width: 70px; height: 70px; margin: 5px; padding: 2px; margin-left: 15px;"></div>
                        </div>

                        <div style="display: inline-block">
                            <p style="color:rgba(0, 0, 0, 0.5); font-size: 20px; font-weight: bolder; text-align: left; margin: 7px 10px;">${helper.helper_name}</p><input type="hidden" name="helper_id" value="${helper.helper_id}">
                            <p style="color:rgba(0, 0, 0, 0.5); font-size: 20px; font-weight: bolder; text-align: left; margin: 7px 10px;">${helper.helper_tel.substring(0,3)}-${helper.helper_tel.substring(3,7)}-${helper.helper_tel.substring(7,11)}</p><input type="hidden" name="mother_id" value="<%=mother_id%>">
                        </div>

                        <div style="display: inline-block; position: relative; left: 25px;">
                            <button disabled style="background: #FE78A1; padding: 7px 12px; color: white; font-size: 18px; font-weight: 500; border: none; border-radius: 20px;
                            margin: 10px; width: 120px;">요청중...</button><Br>
                            <button type="submit" style="background: rgba(0, 0, 0, 0.3); padding: 7px 12px; color: rgba(0, 0, 0, 0.5); font-size: 18px; font-weight: 600; border: none;
                            border-radius: 20px; margin: 10px; width: 120px;">취소</button>
                        </div>

                    </div>
                </form>
            </c:forEach>





        </div>

    </div>
    <jsp:include page="footer.jsp"/>
</div>





</body>
</html>