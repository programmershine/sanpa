<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html>
<head>
    <script src="/js/jquery-3.7.1.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        .container::-webkit-scrollbar {
            display: none;
        }
    </style>

</head>
<body align="center" style="margin:0;">

<%-- mainPage --%>
<div class="mainFrame" style="position:relative; width: 480px; height: 1030px; background:white; display: inline-block; box-shadow: 0 0px 4px 4px lightgrey;">
    <jsp:include page="header.jsp"/>
    <div class="container" style="width:480px; height: 830px; position: absolute; background: white; top:100px; overflow: auto">
        <br>




        <%--문의--%>
        <div style="text-align: left; margin: 20px 10px; text-align: center;">
            <button onclick="location.href='mother_myPage'" style="background: white; border:none; position: absolute; top:42px; left: 20px;">
                <svg width="15" height="26" viewBox="0 0 15 26" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M13 2L2 13L13 24" stroke="#333333" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </button>
            <span style=" font-size: 28px; font-weight: bolder; ">문의</span>
        </div>
        <br>

        <%--문의하기 카테고리--%>
        <div style="width: 440px; height: 40px; margin: auto; text-align: center;">
            <div onclick="location.href='mother_ask'" style="width: 220px; height: 40px; display: inline-block; margin-right: 0; font-size: 20px; border-bottom: 2px solid #999; color: #999;">문의하기</div><div onclick="location.href='mother_myask'" style="width: 220px; height: 40px; display: inline-block; margin-left: 0; font-size: 20px; border-bottom: 4px solid black; color:black;">나의문의</div>
        </div>

        <br>

        <form>
            <div style="position: relative; width: 440px; height: 40px; margin: auto; text-align: left;">
                <div style="position:absolute; top:8px; width: 80px; font-size: 16px;  margin-bottom: 8px; color: #999;">작성날짜</div>
                <div style="position:absolute; top:8px; left: 80px; width: 350px;">
                    날짜데이터입니다. 2024-03-12
                </div>
            </div>
            <br>
            <div style="position: relative; width: 440px; height: 40px; margin: auto; text-align: left;">
                <div style="position:absolute; top:8px; width: 80px; font-size: 16px; margin-bottom: 8px; color: #999;">문의종류</div>
                <div style="position:absolute; left: 80px; width: 350px;">
                    <select name="dropdown" style="width: 350px; height: 40px; border-radius: 12px; border: 2px solid #999">
                        <option value="option1">옵션 1</option>
                        <option value="option2">옵션 2</option>
                        <option value="option3">옵션 3</option>
                    </select>
                </div>
            </div>
            <br>

            <div style="position: relative; width: 440px; height: 40px; margin: auto; text-align: left;">
                <div style="position:absolute; top:8px; width: 80px; font-size: 16px;  margin-bottom: 8px; color: #999;">제목</div>
                <div style="position:absolute; left: 80px; width: 350px;">
                    <input style="padding: 0; width: 346px; height: 36px; border-radius: 12px; border: 2px solid #999" type="text" placeholder=" 문의 제목을 입력해주세요">
                </div>
            </div>
            <br>

            <div style="position: relative; width: 440px; height: 200px; margin: auto; text-align: left;">
                <div style="position:absolute; top:8px; width: 80px; font-size: 16px; display: inline-block; margin-bottom: 8px; color: #999;">내용</div>
                <div style="position:absolute; left: 80px; width: 350px; display: inline-block;">
                    <textarea style="padding: 4px; width: 338px; height: 200px; border-radius: 12px; border: 2px solid #999; resize: none;" placeholder=" 문의 내용을 입력해주세요"></textarea>
                </div>
            </div>
            <br>
            <div style=" position: relative; width: 440px; height: 48px; margin: auto;">
                <button type="button" style=" position:absolute; top: 8px; right: 120px; width:100px; height: 48px; border-radius: 24px; background: #FF578B; color: white; font-size: 20px; border: none;">수정</button>
                <button type="button" onclick="location.href='mother_myask'" style=" position:absolute; top: 8px; right: 10px; width:100px; height: 48px; border-radius: 24px; background: #ccc; color: #999; font-size: 20px; border: none;">취소</button>
            </div>
        </form>
        <br><br>
        <div style="width: 480px; height: 180px; background: #f0f0f0; position: absolute; bottom: 0;">
            <br>
            <div style="width: 440px; color: #999; margin: auto; font-size: 14px;">문의사항이 많아 상담원이 문의를 늦게 확인할 수 있습니다.<br>
                문의전화 070-1111-1111로 전화주시면 보다 신속하고 <br> 친절하게 상담드리겠습니다.</div>
        </div>

    </div>
    <jsp:include page="footer.jsp"/>
</div>
</body>
</html>












