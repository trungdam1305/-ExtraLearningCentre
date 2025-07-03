<%-- 
    Document   : sendAdviceMail
    Created on : 6 thg 6, 2025, 02:19:20
    Author     : vkhan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Soạn nội dung gửi email tư vấn</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6fa;
            margin: 30px;
        }

        h2 {
            text-align: center;
            color: #1F4E79;
        }

        form {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
            color: #333;
        }

        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        textarea {
            resize: vertical;
        }

        .btn-send {
            margin-top: 20px;
            background-color: #1F4E79;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .btn-send:hover {
            background-color: #163d5f;
        }

        .back {
            margin-top: 20px;
            text-align: center;
        }

        .back a {
            color: #1F4E79;
            text-decoration: none;
        }
    </style>
</head>
    <body>

        <h2>Gửi nội dung email đăng ký</h2>

        <form action="${pageContext.request.contextPath}/SendAdviceMailServlet" method="post">
            <input type="hidden" name="id" value="${param.id}" />

            <label for="subject">Tiêu đề email:</label>
            <input type="text" name="subject" id="subject" value="Mời bạn đăng ký tài khoản học viên tại Extra Learning Centre" required>

            <label for="content">Nội dung email:</label>
            <textarea name="content" id="content" rows="8" required>
    Chào bạn,

    Cảm ơn bạn đã quan tâm tới chương trình học tại Extra Learning Centre.

    ABC

    Bạn đã sẵn sàng học rồi chứ,hãy click ngay vào đường dẫn dưới đây để đăng ký tài khoản học viên nhé:

    http://localhost:9105/ELCentre1/views/register.jsp

    Trân trọng,
    Quản trị viên ELCentre
            </textarea>

            <button type="submit" class="btn-send">Gửi Email</button>
        </form>

        <div class="back">
            <p><a href="${pageContext.request.contextPath}/views/admin/adminApproveRegisterUser.jsp">← Quay lại danh sách yêu cầu</a></p>
        </div>

    </body>
</html>
