<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hồ sơ người dùng</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f9;
            display: flex;
        }

        /* Sidebar đồng bộ */
        .sidebar {
            width: 260px;
            background-color: #1F4E79;
            height: 100vh;
            padding: 24px;
            color: white;
        }

        .sidebar-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 30px;
            letter-spacing: 1px;
        }

        .sidebar-section {
            margin-top: 25px;
            font-size: 20px;
            font-weight: bold;
            color: #c2d6f0;
            letter-spacing: 1.2px;
            border-top: 1px solid #3e5f87;
            padding-top: 12px;
        }

        .sidebar a {
            display: block;
            text-decoration: none;
            color: white;
            padding: 10px 0;
            font-size: 20px;
            transition: background-color 0.2s ease, padding-left 0.2s;
        }

        .sidebar a:hover {
            background-color: #294f78;
            padding-left: 12px;
        }

        .logout-link {
            margin-top: 35px;
            font-weight: bold;
            color: #ffcccc;
            font-size: 16px;
        }

        /* Main content */
        .main-content {
            flex: 1;
            padding: 40px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .profile-form {
            display: flex;
            gap: 50px;
        }

        .avatar-section {
            flex: 1;
            text-align: center;
        }

        .avatar-box {
            width: 180px;
            height: 180px;
            background-color: #ccc;
            border-radius: 10px;
            margin: 0 auto 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
            color: #fff;
        }

        .avatar-section small {
            display: block;
            margin: 10px 0;
            font-size: 13px;
            color: #777;
        }

        .info-section {
            flex: 2;
        }

        .info-section label {
            display: block;
            margin-bottom: 4px;
            font-weight: 600;
            color: #444;
        }

        .info-section input,
        .info-section textarea,
        .info-section select {
            width: 100%;
            padding: 10px;
            margin-bottom: 16px;
            border: 1px solid #ccc;
            border-radius: 6px;
            background-color: #f0f0f0;
            font-size: 15px;
        }

        .info-section input[readonly] {
            background-color: #eaeaea;
            color: #999;
        }

        .form-buttons {
            display: flex;
            justify-content: flex-end;
            gap: 20px;
            margin-top: 20px;
        }

        .form-buttons button {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            font-size: 15px;
        }

        .form-buttons .cancel {
            background-color: transparent;
            color: #999;
        }

        .form-buttons .save {
            background-color: #1F4E79;
            color: white;
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <div class="sidebar-title">STUDENT</div>

    <div class="sidebar-section">TỔNG QUAN</div>
    <a href="${pageContext.request.contextPath}/views/student/studentDashboard.jsp">Trang chủ</a>

    <div class="sidebar-section">HỌC TẬP</div>
    <a href="${pageContext.request.contextPath}/views/student/studentEnrollClass.jsp">Đăng ký học</a>
    <a href="${pageContext.request.contextPath}/views/student/studentViewSchedule.jsp">Lớp học</a>
    <a href="${pageContext.request.contextPath}/views/student/studentViewSchedule.jsp">Lịch học</a>

    <div class="sidebar-section">TÀI CHÍNH</div>
    <a href="${pageContext.request.contextPath}/views/student/studentPayment.jsp">Học phí</a>

    <div class="sidebar-section">HỆ THỐNG</div>
    <a href="${pageContext.request.contextPath}/views/student/studentViewNotification.jsp">Thông báo</a>
    <a href="${pageContext.request.contextPath}/views/student/studentEditProfile.jsp"><strong>Tài khoản</strong></a>

    <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout-link">Đăng xuất</a>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="header">
        <h2>Hồ sơ người dùng</h2>
        <span>Xin chào ${sessionScope.user.email}</span>
    </div>

    <form action="UpdateProfileServlet" method="post" enctype="multipart/form-data" class="profile-form">
        <!-- Ảnh đại diện -->
        <div class="avatar-section">
            <div class="avatar-box">
                <i class="fa fa-user"></i> <!-- Hoặc ảnh thật -->
            </div>
            <small>Tải lên ảnh của bạn (jpg hoặc png)</small>
            <input type="file" name="profileImage">
            <button type="button" style="margin-top: 10px;">Xóa ảnh</button>
        </div>

        <!-- Thông tin cá nhân -->
        <div class="info-section">
            <label>Họ và tên</label>
            <input type="text" name="hoTen" value="${hocSinh.hoTen}">

            <label>Email</label>
            <input type="text" name="email" value="${user.email}" readonly>

            <label>Ngày sinh</label>
            <input type="date" name="ngaySinh" value="${hocSinh.ngaySinh}">

            <label>Địa chỉ</label>
            <input type="text" name="diaChi" value="${hocSinh.diaChi}">

            <label>Trường học</label>
            <input type="text" name="truongHoc" value="${hocSinh.tenTruongHoc}">

            <label>Giới tính</label>
            <select name="gioiTinh">
                <option value="Nam" ${hocSinh.gioiTinh == 'Nam' ? 'selected' : ''}>Nam</option>
                <option value="Nữ" ${hocSinh.gioiTinh == 'Nữ' ? 'selected' : ''}>Nữ</option>
            </select>

            <label>Số điện thoại phụ huynh</label>
            <input type="text" name="sdtPhuHuynh" value="${hocSinh.SDT_PhuHuynh}">

            <label>Giới thiệu bản thân</label>
            <textarea name="ghiChu" rows="3">${hocSinh.ghiChu}</textarea>

            <div class="form-buttons">
                <button type="button" class="cancel">Hủy</button>
                <button type="submit" class="save">Lưu hồ sơ</button>
            </div>
        </div>
    </form>
</div>

</body>
</html>
