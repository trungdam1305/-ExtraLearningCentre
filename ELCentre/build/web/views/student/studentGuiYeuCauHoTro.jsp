<%-- 
    Document   : studentGuiYeuCauHoTro
    Created on : Jul 17, 2025, 3:28:13 PM
    Author     : wrx_Chur04
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/views/student/sidebar.jsp" %>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="${pageContext.request.contextPath}/views/login.jsp" />
</c:if>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gửi yêu cầu hỗ trợ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-style.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            background-color: #f4f6f9;
        }
        .main-content {
            flex: 1;
            padding: 30px;
        }
        .form-box {
            background-color: white;
            border-radius: 10px;
            padding: 30px;
            max-width: 600px;
            margin: 0 auto;
        }
        .form-box h2 {
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            font-weight: bold;
            display: block;
            margin-bottom: 6px;
        }
        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 14px;
        }
        textarea {
            height: 120px;
            resize: vertical;
        }
        .submit-btn {
            margin-top: 15px;
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .submit-btn:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<!-- Main Content -->
<div class="main-content">
    <div class="form-box">
        <h2>Gửi yêu cầu hỗ trợ</h2>
        <form action="${pageContext.request.contextPath}/StudentSupportServlet" method="post">
            <div class="form-group">
                <label for="tenHoTro">Tiêu đề hỗ trợ:</label>
                <input type="text" id="tenHoTro" name="tenHoTro" required>
            </div>

            <div class="form-group">
                <label for="moTa">Mô tả chi tiết:</label>
                <textarea id="moTa" name="moTa" required></textarea>
            </div>

            <input type="hidden" name="idTaiKhoan" value="${sessionScope.user.ID_TaiKhoan}">

            <button type="submit" class="submit-btn">Gửi yêu cầu</button>
        </form>
    </div>
</div>

</body>
</html>
