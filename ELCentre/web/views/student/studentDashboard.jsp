<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard</title>
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
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
            background: white;
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            border-bottom: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #1F4E79;
            color: white;
        }

        .section-box {
            display: flex;
            gap: 30px;
            margin-top: 40px;
        }

        .section {
            flex: 1;
            background: white;
            padding: 20px;
            border-radius: 10px;
        }

        .section h3 {
            color: #1F4E79;
            margin-bottom: 15px;
        }

        .section .box-item {
            background-color: #eef2f7;
            margin-bottom: 10px;
            padding: 10px;
            border-radius: 5px;
        }
    </style>
</head>
<body>

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
    <a href="${pageContext.request.contextPath}/views/student/studentEditProfile.jsp">Tài khoản</a>

    <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout-link">Đăng xuất</a>
</div>

<div class="main-content">
    <div class="header">
        <h2>Student dashboard</h2>
        <span>Xin chào ${sessionScope.user.email}</span>
    </div>

    <h3>Lớp học đã đăng kí</h3>
    <table>
        <thead>
            <tr>
                <th>STT</th>
                <th>Tên Lớp học</th>
                <th>Khóa học</th>
                <th>Thời gian</th>
                <th>Ghi chú</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="lop" items="${dsLopHoc}" varStatus="stt">
                <tr>
                    <td>${stt.index + 1}</td>
                    <td>${lop.tenLopHoc}</td>
                    <td>${lop.khoaHoc.tenKhoaHoc}</td>
                    <td>${lop.thoiGianHoc}</td>
                    <td><i class="fa fa-edit"></i></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="section-box">
        <div class="section">
            <h3>Thông báo</h3>
            <c:forEach var="tb" items="${dsThongBao}">
                <div class="box-item">${tb.noiDung}</div>
            </c:forEach>
        </div>
        <div class="section">
            <h3>Lịch học sắp diễn ra</h3>
            <c:forEach var="lh" items="${lichHocSapToi}">
                <div class="box-item">
                    Thứ ${lh.thu} Ngày ${lh.ngayHoc} : ${lh.tenLop} Slot ${lh.slot}
                </div>
            </c:forEach>
        </div>
    </div>
</div>

</body>
</html>
