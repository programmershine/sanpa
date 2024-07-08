<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
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
                <div id="listBtn" style="color: black" onclick="location.href='/helpers_list'">헬퍼즈 List</div>
                <span style="margin: 0 10px;">|</span>
                <div id="addBtn"  onclick="location.href='/helpers_add'">헬퍼즈 추가</div>
                <span style="margin: 0 10px;">|</span>
                <div id="locationBtn" onclick="location.href='/#/helpers'">헬퍼즈 위치</div>
            </div>
        </div>

        <div style="margin: 10px auto; padding: 10px; height: 50px; display: inline-block; bottom: 72px;" onclick="location.href='helpers_list'">
            <p style="display: inline-block; font-weight: bolder; font-size: 30px; opacity: 0.5; padding: 0px 15px;"> < </p>
            <p style="display: inline-block; font-weight: bold; font-size: 23px; opacity: 0.5; padding: 0px 15px;">헬퍼즈 요청 리스트</p>
        </div>

        <div style="width: 95%; margin: 5px auto; ">

            <c:forEach var="helper" items="${helperInfo}" varStatus="status">
                <form action="helpers_invite_list_accept_invitation" method="post">
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
                            <button id="refuseButton" type="button" style="background: rgba(0, 0, 0, 0.3); padding: 7px 12px; color: rgba(0, 0, 0, 0.5); font-size: 18px; font-weight: 600; border: none;
                            border-radius: 20px; margin: 10px; width: 120px;">거절</button>
                        </div>

                    </div>
                </form>
            </c:forEach>
        </div>


    </div>
    <jsp:include page="footer.jsp"/>
</div>


<script>

    $(document).on('click', "[id^='refuseButton']", function () {
        var helper_id = $(this).closest('form').find("[id^='helper_idInput']").val();
        var mother_id = $(this).closest('form').find("[id^='mother_idInput']").val();
        $.ajax({
            type:"POST",
            url:"helpers_invite_HTM_refuse",
            data:{helper_id:helper_id, mother_id:mother_id},
            success: function(response) {
                window.location.href='mother_helpers_invite_list';
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("요청 처리 중 문제가 발생했습니다: " + textStatus);
            }
        });
    });

</script>



</body>
</html>