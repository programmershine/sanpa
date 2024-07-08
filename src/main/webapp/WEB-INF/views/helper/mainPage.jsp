<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <title>Insert title here</title>
    <style>

        h3 span {
            position: relative;
            top: 20px;
            display: inline-block;
            animation: bounce .4s ease infinite alternate;
            font-family: 'Titan One', cursive;
            font-size: 35px;
            color: #ff9595;
            text-shadow: 0 1px 0 #ccc,
            0 2px 0 #ccc,
            0 3px 0 #ccc,
            0 4px 0 #ccc,
            0 5px 0 #ccc,
            0 6px 0 transparent,
            0 7px 0 transparent,
            0 8px 0 transparent,
            0 9px 0 transparent,
            0 10px 10px rgba(0, 0, 0, .4);
        }

        h3 span:nth-child(2) { animation-delay: .1s; }
        h3 span:nth-child(3) { animation-delay: .2s; }
        h3 span:nth-child(4) { animation-delay: .3s; }
        h3 span:nth-child(5) { animation-delay: .4s; }
        h3 span:nth-child(6) { animation-delay: .5s; }
        h3 span:nth-child(7) { animation-delay: .6s; }
        h3 span:nth-child(8) { animation-delay: .7s; }

        @keyframes bounce {
            100% {
                top: -2px;
                text-shadow: 0 1px 0 #CCC,
                0 2px 0 #CCC,
                0 3px 0 #CCC,
                0 4px 0 #CCC,
                0 5px 0 #CCC,
                0 6px 0 #CCC,
                0 7px 0 #CCC,
                0 8px 0 #CCC,
                0 9px 0 #CCC,
                0 50px 25px rgba(0, 0, 0, .2);
            }
        }
        @keyframes bounce_m {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-10px);
            }
            60% {
                transform: translateY(-10px);
            }
        }

        /* 게이지 바 스타일 수정 */
        .progress-container {
            width: 250px;
            height: 30px;
            border: 1px solid #ff9595;
            border-radius: 10px;
            margin-right: 50px;
        }

        .progress-bar {
            height: 100%;
            width: 60%;
            background-color: #ff9595;
            border-radius: 10px;
            transition: width 0.5s ease-in-out;
        }
    </style>
    <!-- 페이지 로드 시 실행될 스크립트 -->
    <script>
        window.onload = function () {
            var items = document.querySelectorAll('.item');

            items.forEach(function (item) {
                var motherDDay = item.getAttribute('data-mother-d-day');

                var nonNegativeMotherDDay = Math.abs(motherDDay);

                var adjustedMotherDDay = Math.max(0, nonNegativeMotherDDay);

                var percentage = Math.min(100, Math.max(0,100- (adjustedMotherDDay / 280) * 100));

                var progressBar = item.querySelector('.progress-bar');

                console.log(percentage);
                progressBar.style.width = percentage + '%';
            });
        };

        function handleButtonClick(element) {
            var motherId = element.closest('.item').getAttribute('data-mother-id');
            sessionStorage.setItem('mother_id', motherId);
            window.location.href = '/#/mothers';
        }

        document.addEventListener('DOMContentLoaded', function() {
            const imageContainer = document.querySelector('.image-container-container');
            const textOverlay = document.querySelector('.text-overlay');


            // 추가: 클릭 이벤트 리스너
            const link = document.querySelector('.text-overlay a');
            link.addEventListener('click', () => {
                // 클릭 시 수행할 동작 추가
                console.log('링크가 클릭되었습니다.');
            });
        });

    </script>
</head>
<body align="center" style=" margin: 0; justify-content: center;  height:1030px; overflow: hidden;
 display: flex; flex-direction: column; align-items: center;" >

<div id=”mainFrame”  style="position:relative; width: 480px; height: 1030px; background:white; display: inline-block; box-shadow: 0 0px 4px 4px lightgrey;">
    <jsp:include page="header.jsp" />
    <div class="container" style="width:480px; height: 830px; position: absolute; background: white; top:120px;">
        <div style="width: 100%; text-align: center;  padding-top: 20px">
            <img sizes="animation: bounce_m 5s ease-in-out infinite;"
                 alt="메인로고이미지" src="/img/sanpaIcon.png" width="170px" height="180px">
        </div> <br/>
        <div style="width: 100%; display: flex; justify-content: center; align-items: center">
            <h3 style="height: 50px">
                <span>E</span>
                <span>M</span>
                <span>E</span>
                <span>R</span>
                <span>G</span>
                <span>E</span>
                <span>N</span>
                <span>C</span>
                <span>Y</span>
            </h3>
        </div><br/>
        <div style="overflow-y: scroll; height: 550px;  ">
            <div class="list" style="margin-top:30px; position:relative;">
                <c:if test="${not empty buttonList}">
                    <c:forEach var="button" items="${buttonList}" varStatus="loop">
                        <div class="item" data-mother-id="${button.mother_id}" data-mother-d-day="${button.mother_d_day}"
                             style="border: 1px solid #d9d9d9; display: flex; justify-content: center; flex-direction: column; margin: 10px auto; border-radius: 10px;
                         width: 400px; height: 200px; padding: 10px;">
                            <h4 style="text-align: center;  ">LEVEL
                                <span style="color: #ff9595; font-size: 25px; font-weight: bolder">${button.buttonType}</span></h4>
                            <p style="text-align: left">산모이름 : <span style="font-weight: bold">${motherNameList[loop.index] != null ? motherNameList[loop.index].helper_name : ''}</span><br/>
                                출산예정일 : <span style="font-weight: bold">${button.mother_due_date}</span></p>
                            <div style="display: flex; justify-content: center; flex-direction: row; align-items: center">
                                <div class="progress-container" >
                                    <div class="progress-bar" ></div>
                                </div><br/>
                                <div style="width: 90px; padding:6px; border: 3px solid #a9e5ff; border-radius: 5px; text-align: center; ">
                                    <a onclick="handleButtonClick(this)" style="cursor: pointer ;text-decoration: none; color:black;
                                    font-size: 15px;">요청확인</a>
                                </div>
                            </div>
                            <span style="font-weight: bold; font-size: 20px" >D<i>${button.mother_d_day}</i></span>


                        </div><%--item--%>

                    </c:forEach>
                </c:if>
                <c:if test="${empty buttonList}">
                    <div style="text-align: center; font-size: 20px; font-weight: bold; color: #ff9595; margin-top: 80px;">
                        현재 도움을 요청한 산모가 없습니다.
                    </div>
                    <div style="position: relative; margin-top: 50px;" class="image-container-container">
                        <img class="image-container" src="/img/mainImg1.png" alt="Main Image" style="width: 400px; height: 250px; border-radius: 15px; opacity: 0.6;">
                        <div class="text-overlay" style="width: 100%; height: 100%; position: absolute; top: 0; left: 0;   transition: opacity 0.3s; display: flex; justify-content: center; align-items: center;">
                            <p style="background-color: lightgray; padding: 10px; border-radius: 5px; opacity: 0.8; text-align: center;width: 300px; ">
                                <a href="/tip" style="font-weight: bolder; text-decoration: none; color: white; cursor: pointer; font-size: 20px; display: block;">헬퍼와 산모를 위한<br/> 꿀팁 보러가기 &gt;</a>
                            </p>
                        </div>
                    </div>
                </c:if>
            </div>
            <br/>
        </div>

    </div>

    <jsp:include page="footer.jsp"/>
</div>

</body>
</html>