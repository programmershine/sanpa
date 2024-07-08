<%@ page import="java.time.LocalDate" %>
<%@ page import="com.example.sanpa.biz.mother.MotherVO" %>
<%@ page import="java.time.Period" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    Object mother = request.getAttribute("mother");
    LocalDate birthdate = ((MotherVO)mother).getHelper_birth();

    Period birth = Period.between(birthdate, LocalDate.now());
    int age = birth.getYears();
    LocalDate today = LocalDate.now();
%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="/js/jquery-3.7.1.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <title>Insert title here</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            font-family: Pretendard,sans-serif;
        }

        ::-webkit-scrollbar {
            width: 10px;
            height: 5px;
            display: none;
        }

        ::-webkit-scrollbar-track {
            background: white;
        }

        ::-webkit-scrollbar-thumb {
            background: #FF578B;
        }

        .container {
            display: flex;
            text-align: left;
            padding-left: 20px;
            padding-right: 20px;
            margin-bottom: 5px;
        }

        textarea {
            resize: none;
        }




        input[type="checkbox"] {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            width: 16px;
            height: 16px;
            border-radius: 50%;
            border: 1px solid rgba(0, 0, 0, 0.4);
            outline: none;
            transition: background-color 0.3s;
        }

        input[type="checkbox"]:checked {
            background-color: #FF578B;
        }

        .category {
            border-collapse: collapse;
            border-spacing: 0;
            width: 100%;
            text-align: center;
            margin-top: 5px;
        }

        .category th {
            position: sticky;
            top: 0;
            background-color: #2E2E36;
            color: #fff;
        }
        tr:nth-child(even) {
            background-color: #FFD4D4;
        }
        tr:nth-child(odd) {
            background-color: #ffffff;
        }
        .category th{
            padding: 5px;
        }
        .category td {

            padding: 5px;
            border-bottom: 1px solid #ddd;

        }

        .category tr:hover th {
            background-color: #2E2E36;
            color: #fff;
        }

        .category tr:hover {
            background-color: rgba(255, 87, 139, 0.8);
            color: #fff;
        }

        .recordsgroupedbymonth {
            display: none;
        }

        .month {
            border-radius: 15px;
            background-color: #FF578B;
            margin-top: 10px;
            cursor: pointer;
            display: flex;
            font-size: 20px;
            color: whitesmoke;
            padding: 5px;
            justify-content: space-between;
        }

        .month.clicked + .recordsgroupedbymonth {
            display: block;
        }

        .edit-input {
            display: none;
        }

        .edit-input.show {
            display: inline-block;
        }
        .custom-modal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            padding: 20px;
            background-color: #282c34;
            border: none;
            border-radius: 15px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            z-index: 1000;
            color: white;
        }

        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }
        .monthlyrecordscroll {
            display: flex;
            flex-direction: column;
            height: 494px;
            overflow-y: scroll;
            border-radius: 15px;
            width: auto;

        }
        .month {
            flex-shrink: 0;
        }

    </style>
</head>
<body align="center" style="margin:0; height:1030px;">

<!-- 모달 -->
<div class="overlay"></div>
<div class="custom-modal">
    <p style="font-size: 25px; margin-bottom: 15px">정말로 삭제하시겠습니까?</p>
    <button id="confirmDelete" style="font-size: 20px; color: white; width: 75px;border: none ;border-radius: 10px; background-color: #FF578B;  box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5); padding: 1px">예</button>
    <button id="cancelDelete" style="font-size: 20px; color: white; width: 75px;border: none ;border-radius: 10px; background-color: #FF578B;  box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5); padding: 1px">아니오</button>
</div>



<div class="mainFrame"
     style="position:relative; width: 480px; height: 1030px; background:white; display: inline-block; box-shadow: 0 0px 4px 4px lightgrey;">
    <jsp:include page="header.jsp"/>
    <div style="width:480px; height: 830px; position: absolute; background: white; top:100px;">

        <div
                style="margin: 25px auto; font-weight: bold; font-size: 24px"><span
                style="color: #FF578B; font-size: 28px; ">&nbsp;&nbsp;${mother.helper_name}님 (<%=age%>)</span><span
                style="color: rgba(0, 0, 0, 0.6)">&nbsp;오늘의 상태</span></div>
        <div
                style="display: flex; justify-content: left; font-size: 18px"
                class="container">
            <form action="mother_daily_report_insert" method="post" style="font-size: 20px">
                <div>
                    <label> <span style="margin-right: 15px">날짜</span>
                        <input required id="dateInput" type="date" name="report_date" style="border:  1px solid lightgrey; border-radius: 15px; height: 25px; width: 355px; padding-left: 5px; padding-right: 5px; font-size: 18px " placeholder="<%=today%>">
                    </label>
                </div><br>

                <div style="width: 430px;"> <span style="margin-right: 15px">상태</span>
                    <label style="width: 372.2px"> <input required id="generalStatusInput"
                                                          type="text" name="general_status" placeholder="컨디션을 입력해주세요." style="border-radius: 10px; font-size: 18px">
                    </label>
                </div><br>

                <div
                        style="display: flex;flex-direction: row"> <p
                        style="margin-right: 15px">비고</p> <label>
                    <textarea required id="statusDetailInput"
                              name="status_detail"  rows="5"
                              placeholder="오늘의 상태를 간단히 적어주세요."
                              style="border-radius: 15px; width: 355px; padding-left: 10px; padding-right: 10px; padding-top: 5px; border:  1px solid lightgrey; font-size: 18px"></textarea>
                </label><br>
                </div>
                <div
                        style="float: right; font-weight: bolder; margin-right: 10px">
                    <input
                            type="submit" value="등록"
                            style="font-size: 20px; color: white; width: 55px;border: none ;border-radius: 10px; background-color: #FF578B; cursor: pointer; box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5); padding: 1px">
                    <input
                            type="reset" value="취소"
                            style="font-size: 20px; color: white ;width: 55px;border-radius: 10px; border: none ; background-color: #FF578B; cursor: pointer; box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5); padding: 1px">
                </div>
            </form>
        </div>


        <div class="monthlyrecordscroll">
            <%--여기부터 --%>

            <c:if test="${motherInfo_month != null}">
                <c:forEach var="monthCount" items="${motherInfo_month}">
                    <div class="month" style="border-radius: 15px; background-color: #FF578B ;margin-top: 10px; margin-right: 5px; margin-left: 5px; cursor: pointer; display: flex;  font-size: 20px; color: whitesmoke; padding: 5px; justify-content: space-between; box-shadow: 4px 4px 4px rgba(0, 0, 0, 0.5)">
                        <span>&nbsp;&nbsp;&nbsp;${monthCount.month}&nbsp;&nbsp;(${monthCount.month_count})</span> <span>∨</span>
                    </div>



                    <div class="recordsgroupedbymonth">
                        <table class="category">
                            <tr>
                                <th>날짜</th>
                                <th>상태</th>
                                <th>비고</th>
                            </tr>


                            <c:forEach var="motherInfos" items="${motherInfo}" varStatus="status">
                            <c:if test="${fn:contains(motherInfos.report_date, monthCount.month) }">

                            <form id="form_${motherInfos.report_date}" action="mother_daily_report_update?pre_report_date=${motherInfos.report_date}&pre_general_status=${motherInfos.general_status}&pre_status_detail=${motherInfos.status_detail}" method="post">
                                <tr class="dailyinfo">
                                    <td style="min-width: 108px">
                                        <div id="pre_report_date">${motherInfos.report_date}</div>
                                    </td>

                                    <td style="min-width: 120px">
                                        <div id="pre_general_status">${motherInfos.general_status}</div>
                                    </td>

                                    <td>
                                        <div id="pre_status_detail">${motherInfos.status_detail}</div>
                                    </td>
                                </tr>
                                </c:if>
                                </c:forEach>
                        </table>
                        <div class="edit-input" style="font-family: Pretendard, serif">

                            <div style="display: flex; flex-direction: row; justify-content:center;">
                                <label for="report_date_input">날짜
                                    <input required id="report_date_input" type="date" name="report_date" class="editDate" style="border: 2px solid #FF578B; border-radius: 15px; width:150px; padding: 5px; font-size: 13px"></label>
                                <label for="general_status_input" >상태
                                    <input required id="general_status_input" class="editStatus" name="general_status" style="border: 2px solid #FF578B; border-radius: 15px; width:100px; padding: 5px; font-size: 13px" autofocus>
                                </label>
                                <label for="status_detail_input">비고
                                    <textarea required id="status_detail_input" class="editNotes" name="status_detail" rows="5" style="border: 2px solid #FF578B; border-radius: 15px; width:150px; padding: 5px; font-size: 13px"></textarea></label>
                            </div>
                            <div style=" display:flex; justify-content: space-evenly; margin-top: 5px ">
                                <button class="updateBtn" type="submit" style="font-size: 20px; color: white; width: 30%;border: none ;border-radius: 10px; background-color: #FF578B;  box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5); padding: 1px">수정</button>
                                <button class="deleteBtn" id="report_delete_btn" style="font-size: 20px; color: white; width: 30%;border: none ;border-radius: 10px; background-color: #FF578B; box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5); padding: 1px">삭제</button>
                                <button class="cancelEdit" type="reset" style="font-size: 20px; color: white; width: 30%;border: none ;border-radius: 10px; background-color: #FF578B; box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.5); padding: 1px">취소</button>
                            </div>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
        </div>
    </div>
    <jsp:include page="footer.jsp"/>
</div>


<script>
    $(document).ready(function () {
        var clickedRowData = {}; // 클릭된 행의 데이터를 저장할 전역 변수

        $('.GSInput1').click(function () {
            if ($(this).prop('checked')) {
                $('.GSInput1').prop('checked', false);
                $(this).prop('checked', true);
            }
        });

        $(document).on('click', '.month', function () {
            $(this).toggleClass("clicked");
        });

        $('.dailyinfo').click(function () {
            // 클릭된 행에서 각 열의 값을 가져와서 전역 변수에 저장
            clickedRowData.date = $(this).find('td:eq(0) div').text();
            clickedRowData.status = $(this).find('td:eq(1) div').text();
            clickedRowData.notes = $(this).find('td:eq(2) div').text();

            // 가져온 값을 입력 폼에 넣기
            $('.editDate').val(clickedRowData.date);
            $('.editStatus').val(clickedRowData.status);
            $('.editNotes').val(clickedRowData.notes);

            // 현재 클릭된 행의 부모 .recordsgroupedbymonth를 찾아 그 안에서만 .edit-input을 찾아 보여줌
            var editInput = $(this).closest('.recordsgroupedbymonth').find('.edit-input');
            editInput.addClass('show');

            // 만약 다른 현재 클릭된 행의 부모가 아닌 .recordsgroupedbymonth안에 .edit-input이 보여지고 있다면 닫기
            $('.recordsgroupedbymonth').not($(this).closest('.recordsgroupedbymonth')).find('.edit-input').removeClass('show');

            // 보여진 .edit-input 중에서 input 요소를 찾아서 두 번째 요소에 포커스를 설정
            editInput.find('input:eq(1)').focus();
        });

        // 삭제 버튼 클릭 시 모달
        $('.deleteBtn').click(function (e) {
            e.preventDefault();
            setTimeout(function () {
                $('.custom-modal, .overlay').show();
            }, 100);
        });

        // 예를 선택할 때
        $('#confirmDelete').click(function () {
            $('.custom-modal, .overlay').hide();
            deleteBtn();
        });

        // 아니오를 선택할 때
        $('#cancelDelete').click(function () {
            // 모달 창 닫기
            $('.custom-modal, .overlay').hide();
        });

        // 수정 취소
        $('.cancelEdit').click(function () {
            // 수정 폼 닫기
            $('.edit-input').removeClass('show');
        });

        /* 날짜 값을 입력하지 않으면 오늘의 날짜를 기입하도록 하는 함수 */
        var dateInput = $('#dateInput');

        function formatDate(date) {
            var d = new Date(date),
                month = '' + (d.getMonth() + 1),
                day = '' + d.getDate(),
                year = d.getFullYear();
            if (month.length < 2) month = '0' + month;
            if (day.length < 2) day = '0' + day;
            return [year, month, day].join('-');
        }
        if (dateInput.val() === '') {
            dateInput.val(formatDate(new Date()));
        }

        /* report 삭제 함수 */
        function deleteBtn() {
            // 클릭된 행의 데이터를 사용하여 AJAX 요청 보내기
            var pre_report_date = clickedRowData.date;
            var pre_general_status = clickedRowData.status;
            var pre_status_detail = clickedRowData.notes;

            $.ajax({
                type: "POST",
                url: "/mother_daily_report_delete",
                data: {
                    pre_report_date: pre_report_date,
                    pre_general_status: pre_general_status,
                    pre_status_detail: pre_status_detail
                },
                success: function (response) {
                    window.location.href = "/mother_daily_report";
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("요청 처리 중 문제가 발생했습니다: " + textStatus);
                }
            });
        }
    });

</script>


</body>

</html>
