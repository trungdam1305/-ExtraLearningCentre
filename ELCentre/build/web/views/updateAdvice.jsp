<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cập nhật nội dung tư vấn</title>
    <style>
        body {
            background-color: #f4f8fb;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            margin: 50px auto;
            background-color: white;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0,0,0,0.15);
            border-radius: 8px;
        }

        h2 {
            text-align: center;
            color: #1F4E79;
            margin-bottom: 30px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
            color: #333;
        }

        input[type="text"],
        input[type="email"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 18px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }

        textarea {
            resize: vertical;
        }

        .btn-submit {
            display: block;
            width: 100%;
            padding: 12px;
            background-color: #1F4E79;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 15px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-submit:hover {
            background-color: #163E5C;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
        }

        .back-link a {
            color: #1F4E79;
            text-decoration: none;
        }

        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Cập nhật nội dung tư vấn</h2>

        <form action="${pageContext.request.contextPath}/adminActionWithAdvice" method="post">
            <input type="hidden" name="action" value="saveUpdate"/>
            <input type="hidden" name="id" value="${tuvan.ID_ThongBao}"/>

            <label>Họ tên:</label>
            <input type="text" name="hoTen" value="${tuvan.hoTen}" />

            <label>Email:</label>
            <input type="text" name="email" value="${tuvan.email}" />

            <label>SĐT:</label>
            <input type="text" name="sdt" value="${tuvan.soDienThoai}" />

            <label>Nội dung:</label>
            <textarea name="noiDung">${tuvan.noiDungTuVan}</textarea>

            <button type="submit" class="btn-submit">Lưu</button>
        </form>


    <div class="back-link">
        <a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=yeucautuvan">← Quay lại danh sách</a>
    </div>
</div>

</body>
</html>
