<%-- 
    Document   : adminSendNotificationToClass
    Created on : Jul 10, 2025, 6:15:05 PM
    Author     : wrx_Chur04
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String ID_LopHoc = request.getParameter("idLop");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gửi thông báo lớp học</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f8fb;
            padding: 30px;
            color: #1F4E79;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        form {
            max-width: 600px;
            margin: auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        label {
            display: block;
            margin-top: 20px;
            font-weight: bold;
        }

        textarea {
            width: 100%;
            padding: 10px;
            margin-top: 8px;
            font-size: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            resize: vertical;
        }

        button {
            margin-top: 30px;
            background-color: #1F4E79;
            color: white;
            padding: 12px 25px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
        }

        button:hover {
            background-color: #163b5c;
        }
    </style>
</head>
<body>

<h2>Gửi thông báo đến lớp học</h2>

<form action="${pageContext.request.contextPath}/adminActionWithNotification" method="post">
    <input type="hidden" name="type" value="sendToClass">
    <input type="hidden" name="ID_LopHoc" value="<%= ID_LopHoc %>">
  
    <label for="noidungGV">Nội dung gửi cho giáo viên:</label>
    <textarea id="noidungGV" name="noidungGV" rows="5" required></textarea>

    <label for="noidungHS">Nội dung gửi cho học sinh:</label>
    <textarea id="noidungHS" name="noidungHS" rows="5" required></textarea>

    <button type="submit">Gửi thông báo</button>
</form>

</body>
</html>
