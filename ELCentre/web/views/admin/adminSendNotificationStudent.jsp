<%-- 
    Document   : adminSendNotificationStudentAndTeacher
    Created on : Jul 10, 2025, 9:07:42 AM
    Author     : wrx_Chur04
--%>



<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String idtaikhoan = request.getParameter("idtaikhoan");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gửi thông báo</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #f0f4f8;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #1F4E79;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .notification-container {
            background-color: #ffffff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 550px;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #1F4E79;
            font-size: 24px;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: 600;
            font-size: 15px;
        }

        textarea {
            width: 100%;
            padding: 12px;
            font-size: 15px;
            margin-top: 8px;
            border: 1px solid #ccc;
            border-radius: 8px;
            resize: vertical;
            min-height: 130px;
        }

        button {
            margin-top: 25px;
            width: 100%;
            padding: 12px;
            background-color: #1F4E79;
            color: #ffffff;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-weight: bold;
            letter-spacing: 0.5px;
        }

        button:hover {
            background-color: #163b5c;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            text-decoration: none;
            color: #1F4E79;
            font-size: 14px;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="notification-container">
    <h2>Gửi thông báo đến học sinh</h2>

    <form action="${pageContext.request.contextPath}/adminActionWithStudent" method="post">
        <input type="hidden" name="idtaikhoan" value="<%= idtaikhoan %>">
        <input type="hidden" name="type" value="sendNotification">

        <label for="noidung">Nội dung thông báo:</label>
        <textarea id="noidung" name="noidung" required></textarea>

        <button type="submit">Gửi thông báo</button>
    </form>

    <a href="${pageContext.request.contextPath}/views/admin/adminReceiveHocSinh.jsp" class="back-link">← Quay lại danh sách học sinh</a>
</div>

</body>
</html>

