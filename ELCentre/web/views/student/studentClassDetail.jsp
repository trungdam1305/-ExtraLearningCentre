<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="${pageContext.request.contextPath}/views/login.jsp" />
</c:if>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết lớp học</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-style.css">
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                margin: 0;
                padding: 0;
                display: flex;
                background-color: #f4f6f9;
            }
            .sidebar {
                width: 260px;
                background-color: #1F4E79;
                height: 100vh;
                padding: 20px;
                color: white;
            }
            .sidebar-title {
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 25px;
            }
            .sidebar-section {
                margin-top: 20px;
                font-size: 20px;
                font-weight: bold;
                color: #a9c0dc;
                letter-spacing: 1px;
                border-top: 1px solid #3e5f87;
                padding-top: 10px;
            }
            .sidebar a {
                display: block;
                text-decoration: none;
                color: white;
                padding: 8px 0;
                font-size: 20px;
                transition: background-color 0.2s ease;
            }
            .sidebar a:hover {
                background-color: #294f78;
                padding-left: 10px;
            }
            .logout-link {
                margin-top: 30px;
                font-weight: bold;
                color: #ffcccc;
            }
            .main-content {
                flex: 1;
                padding: 30px;
            }
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
            }
            .info-box {
                background: white;
                border-radius: 10px;
                padding: 30px;
                box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            }
            .section-title {
                color: #1F4E79;
                font-size: 20px;
                font-weight: bold;
                margin-bottom: 20px;
                border-bottom: 1px solid #ddd;
                padding-bottom: 6px;
            }
            .info-grid {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                margin-bottom: 30px;
            }
            .info-item {
                flex: 1 1 45%;
                font-size: 16px;
            }
            .info-item span.label {
                font-weight: bold;
                color: #333;
                display: inline-block;
                min-width: 140px;
            }
            .teacher-avatar {
                width: 120px;
                height: 120px;
                border-radius: 8px;
                overflow: hidden;
                background-color: #ddd;
                margin-left: auto;
                margin-right: 900px; 
                align-self: center;
            }
            .teacher-avatar img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            .back-btn {
                display: inline-block;
                margin-bottom: 20px;
                text-decoration: none;
                color: #1F4E79;
                font-weight: bold;
            }
            .back-btn:hover {
                text-decoration: underline;
            }
            .teacher-info-wrapper {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                gap: 30px;
                margin-top: 20px;
            }

            .teacher-details {
                flex: 1;
                display: flex;
                flex-direction: column;
                gap: 10px;
                font-size: 16px;
            }

            .teacher-details .label {
                font-weight: bold;
                color: #333;
                display: inline-block;
                min-width: 140px;
            }

        </style>
    </head>
    <body>

    <!-- SIDEBAR -->
    <div class="sidebar">
        <div class="sidebar-title">STUDENT</div>
        <div class="sidebar-section">TỔNG QUAN</div>
        <a href="${pageContext.request.contextPath}/StudentDashboardServlet">Trang chủ</a>
        <div class="sidebar-section">HỌC TẬP</div>
        <a href="${pageContext.request.contextPath}/StudentEnrollClassServlet">Đăng ký học</a>
        <a href="${pageContext.request.contextPath}/StudentViewClassServlet"><strong>Lớp học</strong></a>
        <a href="${pageContext.request.contextPath}/StudentViewScheduleServlet">Lịch học</a>
        <div class="sidebar-section">TÀI CHÍNH</div>
        <a href="${pageContext.request.contextPath}/StudentPaymentServlet">Học phí</a>
        <div class="sidebar-section">HỆ THỐNG</div>
        <a href="${pageContext.request.contextPath}/StudentViewNotificationServlet">Thông báo</a>
        <a href="${pageContext.request.contextPath}/StudentEditProfileServlet">Tài khoản</a>
        <a href="${pageContext.request.contextPath}/StudentSupportServlet">Hỗ trợ</a>
        <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout-link">Đăng xuất</a>
    </div>

    <!-- MAIN CONTENT -->
    <div class="main-content">
        <div class="header">
            <h2>Chi tiết lớp học</h2>
            <span>Xin chào ${sessionScope.user.email}</span>
        </div>

        <a class="back-btn" href="${pageContext.request.contextPath}/StudentViewClassServlet">← Quay lại danh sách lớp học đã đăng ký</a>

        <div class="info-box">
            <div class="section-title">📘 Thông tin lớp học</div>
            <div class="info-grid">
                <div class="info-item"><span class="label">Mã lớp:</span> ${lopHoc.classCode}</div>
                <div class="info-item"><span class="label">Tên lớp:</span> ${lopHoc.tenLopHoc}</div>
                <div class="info-item"><span class="label">Khóa học:</span> ${lopHoc.tenKhoaHoc}</div>
                <div class="info-item"><span class="label">Sĩ số:</span> ${lopHoc.siSo} / ${lopHoc.siSoToiDa} (min: ${lopHoc.siSoToiThieu})</div>
                <div class="info-item"><span class="label">Phòng học:</span> ${lopHoc.ID_PhongHoc}</div>
                <div class="info-item"><span class="label">Ngày tạo:</span> ${lopHoc.ngayTao}</div>
                <div class="info-item" style="flex: 1 1 100%;"><span class="label">Ghi chú:</span> ${lopHoc.ghiChu}</div>
            </div>

            <div class="section-title">👨‍🏫 Thông tin giáo viên phụ trách</div>
            <div class="teacher-info-wrapper">
                <div class="teacher-details">
                    <div><span class="label">Họ tên:</span> ${giaoVien.hoTen}</div>
                    <div><span class="label">Email:</span> ${giaoVien.email}</div>
                    <div><span class="label">SĐT:</span> ${giaoVien.SDT}</div>
                    <div><span class="label">Chuyên môn:</span> ${giaoVien.chuyenMon}</div>
                </div>
                <div class="teacher-avatar">
                    <c:if test="${not empty giaoVien.avatar}">
                        <img src="${pageContext.request.contextPath}/${giaoVien.avatar}" alt="Ảnh giáo viên">
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    </body>
</html>
