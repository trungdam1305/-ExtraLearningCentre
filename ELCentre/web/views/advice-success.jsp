<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gửi yêu cầu thành công</title>
    <meta http-equiv="refresh" content="5; URL=${pageContext.request.contextPath}/HomePage">
    <!--    Tự động chuyển sau 5 giây -->
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f0f8ff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .message-box {
            background-color: #ffffff;
            border: 2px solid #1f4e79;
            padding: 30px 50px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .message-box h2 {
            color: #1f4e79;
            margin-bottom: 12px;
        }
        .message-box p {
            color: #555;
            font-size: 16px;
        }
        .message-box a {
            margin-top: 15px;
            display: inline-block;
            text-decoration: none;
            background-color: #1f4e79;
            color: white;
            padding: 10px 18px;
            border-radius: 6px;
            font-weight: bold;
        }
        .message-box a:hover {
            background-color: #218838;
        }
        .small-text {
            margin-top: 12px;
            color: #888;
            font-size: 13px;
        }
    </style>
</head>
<body>
    <div class="message-box">
        <h2>✅ Cảm ơn bạn đã gửi yêu cầu tư vấn!</h2>
        <p>Chúng tôi sẽ liên hệ với bạn sớm nhất có thể.</p>
        <a href="${pageContext.request.contextPath}/HomePage">Quay lại trang chủ</a>
        <div class="small-text">(Bạn sẽ được chuyển hướng về trang chủ sau vài giây...)</div>
    </div>
</body>
</html>
