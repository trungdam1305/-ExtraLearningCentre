<%-- 
    Document   : addClass
    Created on : June 21, 2025
    Author     : [Your Name]
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm lớp học</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        
        
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 20px;
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
        form {
            max-width: 600px;
            margin: 0 auto;
            background-color: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }
        input[type="text"],
        input[type="number"],
        input[type="date"],
        select,
        textarea,
        input[type="file"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
            box-sizing: border-box;
        }
        textarea {
            resize: vertical;
            min-height: 80px;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            margin-right: 10px;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .alert-danger {
            color: red;
            font-weight: bold;
            font-size: 14px;
            text-align: center;
            margin-bottom: 20px;
        }
        .alert-success {
            color: green;
            font-weight: bold;
            font-size: 14px;
            text-align: center;
            margin-bottom: 20px;
        }
        .back-button {
            display: block;
            text-align: center;
            margin-top: 20px;
        }
        .back-button a {
            color: white;
            text-decoration: none;
        }
        .debug-info {
            background-color: #f8f9fa;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #dee2e6;
        }
        p.info {
            color: #333;
            font-size: 14px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <h2>Thêm lớp học</h2>

    <%
        String idKhoaHoc = request.getParameter("ID_KhoaHoc");
        if (idKhoaHoc == null) {
            idKhoaHoc = (String) request.getAttribute("ID_KhoaHoc");
        }
        String idKhoi = request.getParameter("ID_Khoi");
        if (idKhoi == null) {
            idKhoi = (String) request.getAttribute("ID_Khoi");
        }
        String tenLop = "Không xác định";
        if (idKhoi != null) {
            try {
                int idKhoi2 = Integer.parseInt(idKhoi);
                if (idKhoi2 >= 1 && idKhoi2 <= 7) {
                    tenLop = "Lớp " + (idKhoi2 + 5);
                } else {
                    tenLop = "Tổng ôn";
                }
            } catch (NumberFormatException e) {
                tenLop = "Dữ liệu không hợp lệ";
            }
        }
    %>

    <!-- Debug slotHocList -->
    <div class="debug-info">
        <p>slotHocList: ${slotHocList != null ? slotHocList.size() : 'null'}</p>
        <c:forEach var="slot" items="${slotHocList}">
            <p>ID: ${slot.idSlotHoc}, Time: ${slot.slotThoiGian}</p>
        </c:forEach>
    </div>

    <!-- Thông báo -->
    <c:if test="${not empty err}">
        <div class="alert alert-danger">${err}</div>
    </c:if>
    <c:if test="${not empty suc}">
        <div class="alert alert-success">${suc}</div>
    </c:if>

    <!-- Form thêm lớp học -->
    <form action="${pageContext.request.contextPath}/ManageClass" method="post" enctype="multipart/form-data">
        <input type="hidden" name="ID_KhoaHoc" value="<%= idKhoaHoc != null ? idKhoaHoc : "" %>">
        <input type="hidden" name="ID_Khoi" value="<%= idKhoi != null ? idKhoi : "" %>">
        <input type="hidden" name="action" value="addClass">

        <label>Tên lớp học (bắt buộc):</label>
        <input type="text" name="TenLopHoc" class="form-control" value="${tenLopHoc != null ? tenLopHoc : ''}" >

        <label>Khóa học:</label>
        <p class="info">Bạn đang thêm lớp học cho khóa có ID: <%= idKhoaHoc != null ? idKhoaHoc : "Không xác định" %></p>

        <label>Khối học:</label>
        <p class="info">Bạn đang thêm lớp học cho khối: <%= tenLop %></p>

        <label>Thời gian học (bắt buộc):</label>
        <select name="ID_SlotHoc" class="form-select" >
            <option value="">Chọn thời gian học</option>
            <c:forEach var="slot" items="${slotHocList}">
                <option value="${slot.idSlotHoc}" ${slot.idSlotHoc == idSlotHoc ? 'selected' : ''}>${slot.slotThoiGian}</option>
            </c:forEach>
        </select>

        <label>Ngày học (bắt buộc):</label>
        <input type="date" name="NgayHoc" class="form-control" value="${ngayHoc != null ? ngayHoc : ''}" >

        <label>Sĩ số tối đa (bắt buộc):</label>
        <input type="number" name="SiSoToiDa" class="form-control" value="${siSoToiDa != null ? siSoToiDa : ''}" >

        <label>Ghi chú (không bắt buộc):</label>
        <input type="text" name="GhiChu" class="form-control" value="${ghiChu != null ? ghiChu : ''}">

        <label>Ảnh đại diện lớp học (không bắt buộc):</label>
        <input type="file" name="Image" class="form-control" accept="image/*">

        <div class="mt-3">
            <button type="submit" class="btn btn-primary">Thêm</button>
        </div>
         <div class="back-button">
        <button class="btn btn-secondary">
            <a href="${pageContext.request.contextPath}/ManageClass?action=refresh&ID_Khoi=<%= idKhoi != null ? idKhoi : "" %>&ID_KhoaHoc=<%= idKhoaHoc != null ? idKhoaHoc : "" %>" class="text-white text-decoration-none">
                Quay lại trang danh sách lớp học
            </a>
        </button>
    </div>
    </form>

    <!-- Nút quay lại -->
   

    <!-- Bootstrap 5 JS và Popper -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</body>
</html>