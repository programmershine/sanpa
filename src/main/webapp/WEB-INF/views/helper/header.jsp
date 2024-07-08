<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <%
        String logo = "<svg width='131' height='41' viewBox='0 0 131 41' fill='none' xmlns='http://www.w3.org/2000/svg'><path d='M38.1025 9.97058C40.8558 9.97058 43.0878 7.73859 43.0878 4.98529C43.0878 2.23199 40.8558 0 38.1025 0C35.3492 0 33.1172 2.23199 33.1172 4.98529C33.1172 7.73859 35.3492 9.97058 38.1025 9.97058Z' fill='#FF578B'/><path d='M11.7991 17.3129C9.12387 17.3129 7.76595 18.4773 7.72537 20.0662C7.68791 21.8112 9.39233 22.6665 11.9146 23.2097L14.3589 23.7903C19.75 24.9922 22.8935 27.6706 22.931 32.1689C22.8935 37.4819 18.7792 40.7035 11.7991 40.7035C6.01782 40.7035 1.91284 38.5215 0.604859 34.1168C0.15534 32.5997 1.32596 31.0825 2.90864 31.0825H4.66302C5.6401 31.0825 6.48295 31.7038 6.85442 32.6059C7.56304 34.3166 9.32678 35.1938 11.7211 35.1938C14.515 35.1938 16.1819 33.9514 16.2194 32.1689C16.1819 30.5394 14.746 29.6872 11.6431 28.9879L8.6962 28.2887C3.84826 27.1649 0.898295 24.7581 0.898295 20.5313C0.860835 15.3338 5.47465 11.8438 11.8366 11.8438C16.7938 11.8438 20.3899 13.9103 21.8384 17.213C22.5314 18.7957 21.3764 20.5719 19.6501 20.5719H17.9582C17.0342 20.5719 16.235 20.0163 15.8136 19.1953C15.1955 17.9903 13.8345 17.3129 11.7991 17.3129Z' fill='#FF578B'/><path d='M76.4173 40.316H74.4382C73.6546 40.316 72.9179 39.9321 72.4715 39.2859L61.7798 23.8306H61.5863V37.9249C61.5863 39.2453 60.5156 40.316 59.1951 40.316H57.3814C56.061 40.316 54.9902 39.2453 54.9902 37.9249V14.6217C54.9902 13.3012 56.061 12.2305 57.3814 12.2305H59.4324C60.2221 12.2305 60.9589 12.6207 61.4052 13.27L71.9814 28.716H72.2156V14.6217C72.2156 13.3012 73.2863 12.2305 74.6068 12.2305H76.4204C77.7409 12.2305 78.8116 13.3012 78.8116 14.6217V37.9249C78.8116 39.2453 77.7409 40.316 76.4204 40.316H76.4173Z' fill='#FF578B'/><path d='M83.0754 14.6217C83.0754 13.3012 84.1461 12.2305 85.4666 12.2305H94.5569C100.878 12.2305 104.758 16.1856 104.758 21.8889C104.758 27.5922 100.803 31.5098 94.3633 31.5098H92.0595C90.7391 31.5098 89.6683 32.5806 89.6683 33.901V37.9249C89.6683 39.2453 88.5976 40.316 87.2771 40.316H85.4635C84.143 40.316 83.0723 39.2453 83.0723 37.9249V14.6217H83.0754ZM93.1615 26.2717C96.2644 26.2717 97.9314 24.5267 97.9314 21.8889C97.9314 19.2511 96.2644 17.5841 93.1615 17.5841H92.0627C90.7422 17.5841 89.6715 18.6548 89.6715 19.9753V23.8836C89.6715 25.2041 90.7422 26.2748 92.0627 26.2748H93.1615V26.2717Z' fill='#FF578B'/><path d='M104.497 37.1577L112.413 13.8545C112.744 12.8837 113.652 12.2344 114.676 12.2344H120.014C121.038 12.2344 121.95 12.8868 122.278 13.8576L130.163 37.1608C130.687 38.7123 129.535 40.3168 127.9 40.3168H125.886C124.844 40.3168 123.92 39.6394 123.607 38.6467L122.761 35.9746C122.446 34.9788 121.525 34.3045 120.483 34.3045H114.211C113.169 34.3045 112.244 34.9819 111.932 35.9746L111.086 38.6467C110.771 39.6426 109.85 40.3168 108.808 40.3168H106.76C105.121 40.3168 103.969 38.7061 104.497 37.1577ZM120.223 27.9207L118.416 22.1894C118.116 21.2372 116.774 21.2248 116.453 22.1675L114.514 27.8989C114.286 28.5669 114.786 29.263 115.491 29.263H119.237C119.933 29.263 120.433 28.5856 120.22 27.9207H120.223Z' fill='#FF578B'/><path d='M48.9682 31.3444C51.6404 29.5026 52.914 26.0657 51.8683 22.816C50.7975 19.4946 47.6446 17.4312 44.317 17.5935L43.0527 13.8537C42.7249 12.8829 41.8134 12.2305 40.7895 12.2305H35.4514C34.4275 12.2305 33.516 12.8829 33.1882 13.8537L25.2717 37.1569C24.7441 38.7084 25.8992 40.316 27.5349 40.316H29.5827C30.6254 40.316 31.5494 39.6387 31.8615 38.646L32.7075 35.9738C33.0228 34.978 33.9437 34.3037 34.9863 34.3037H41.2577C42.3004 34.3037 43.2244 34.9811 43.5365 35.9738L44.3825 38.646C44.6978 39.6418 45.6187 40.316 46.6613 40.316H48.6748C50.3105 40.316 51.4656 38.7084 50.938 37.1601L48.9714 31.3444H48.9682ZM45.4064 26.9553C40.3431 26.9553 36.2256 22.8379 36.2256 17.7745C36.2256 16.7413 37.0653 15.9015 38.0986 15.9015C39.1319 15.9015 39.9716 16.7413 39.9716 17.7745C39.9716 20.7713 42.4096 23.2093 45.4064 23.2093C46.4397 23.2093 47.2794 24.0491 47.2794 25.0823C47.2794 26.1156 46.4397 26.9553 45.4064 26.9553Z' fill='#FF578B'/></svg>";
    %>


    <title>Insert title here</title>
</head>
<body>
<div style="z-index:251; position:absolute; top:0px; width:480px; height:100px; background: white; box-shadow: 0 0 2px 2px #ccc;">

    <!-- 로고 -->
    <div style="display: flex; justify-content: center; margin-top:48px;" onclick="location.href='getButtonList'"><%= logo %></div>
    <!-- 프로필 -->
    <%--<div style="position:absolute; top:30px; right:20px; width:60px; height:60px; background: black; border-radius: 30px;"></div>--%>

</div>

</body>
</html>
