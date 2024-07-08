<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FileUploaderImg JSP</title>
    <script src="/js/jquery-3.7.1.min.js"></script>
</head>


<body align="center" style="margin:0; height:1030px; overflow: hidden;">
<div class="mainFrame" style="position:relative; width: 480px; height: 1030px; background:white; display: inline-block; box-shadow: 0 0px 4px 4px lightgrey;">
    <jsp:include page="header.jsp"/>

<div id="root"></div>

<div style="text-align: center; width: 420px; height: 450px; margin: 10px 7px; padding: 10px; display: flex; flex-direction: column; align-items: center; justify-content: center; background: #FFC2C2; background-color: rgba(255, 194, 194, 0.7); box-shadow: -3px -1px -2px darkgray; font-family: Gothic/고딕체; font-size: 16px; border-radius: 16px;">

    <form action="s3/file" method="post" enctype="multipart/form-data">

        <h3>복용약 등록</h3>
        <input placeholder="파일을 첨부해주세요(약봉투 사진,처방전 등)" style="width: 300px; height: 30px; background-color: #ffffff; margin-top: 10px;" type="file" name="multipartFile"/>
        <br/>
        <img src="${pageContext.request.contextPath}/${imgsrc}" width="300px" alt="Uploaded file"/>
        <br/>
<%--        비고: <input type="text" name="inputValue"/>--%>
        <br/>
        <button style="margin-top: 10px;" type="submit">등록</button>
        <button style="margin-top: 10px;" type="button">취소</button>

    </form>

</div>
    <jsp:include page="footer.jsp"/>
</div>
<script>
    $("form").submit(function(e) {
            alert("이미지가 업로드 됐습니다.");
    });
</script>
</body>
</html>