<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"   %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Title</title>
</head>
<body align="center" style="margin:0;">
<div class=”mainFrame”  style="position: relative; width: 480px; height: 1030px; border:1px solid black; display: inline-block;">

    <jsp:include page="header.jsp"></jsp:include>
    <div class="container" style="position: absolute; top: 200px; width: 460px; padding: 10px; margin: 10px auto; display: flex;
      flex-direction: column;">
        <div>
            <!-- 폭죽 아이콘 -->
            <div style="margin-top: 80px">
                <img src="img/sucessImg.png" alt="폭죽아이콘" width="250px" height="250px">
            </div>
            <h3>친구등록 요청이 완료되었습니다.</h3>
            <p>산모가 요청을 수락하면 산모즈에서 확인할 수 있습니다.</p>
        </div>
        <a href="sanmoz" style="margin-top:50px; font-weight: bold; text-decoration: none; color:#ff9595; font-size: 18px;">등록된 산모 확인하기 ></a>
    </div>

    <jsp:include page="footer.jsp"/>

</div>
</body>
</html>

