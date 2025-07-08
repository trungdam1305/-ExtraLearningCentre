<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="${pageContext.request.contextPath}/views/login.jsp" />
</c:if>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lịch học của tôi</title>
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
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #1F4E79;
            color: white;
        }
        .no-data {
            text-align: center;
            padding: 40px;
            font-size: 18px;
            color: #999;
            background-color: white;
            border-radius: 10px;
        }
        
        .timetable-wrapper {
            margin-top: 40px;
        }

        .timetable {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
        }

        .timetable th, .timetable td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ddd;
            font-size: 15px;
        }

        .timetable th {
            background-color: #1F4E79;
            color: white;
        }

        .timetable td.active {
            background-color: #d4edda;
            font-weight: bold;
            color: #155724;
            border: 2px solid #28a745;
            border-radius: 4px;
        }

    </style>
</head>
<body>

<!-- Sidebar cố định -->
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
    <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout-link">Đăng xuất</a>
</div>

<!-- Nội dung chính -->
<div class="main-content">
    <div class="header">
        <h2>Lịch học của tôi</h2>
        <span>Xin chào ${sessionScope.user.email}</span>
    </div>

    <c:choose>
        <c:when test="${not empty lichHocList}">
            <table>
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Ngày học</th>
                        <th>Giờ học</th>
                        <th>Lớp học</th>
                        <th>Phòng học</th>
                        <th>Ghi chú</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="lh" items="${lichHocList}" varStatus="i">
                        <tr>
                            <td>${i.index + 1}</td>
                            <td>${lh.ngayHoc}</td>
                            <td>${lh.slotThoiGian}</td>
                            <td>${lh.tenLopHoc}</td>
                            <td>${lh.tenPhongHoc}</td>
                            <td>${lh.ghiChu}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <div class="no-data">Bạn chưa có lịch học nào sắp tới!</div>
        </c:otherwise>
    </c:choose>
    <br>        
            
    <div class="timetable-wrapper">
        <h3>🗓️ Thời khóa biểu tuần này</h3>
        <table class="timetable">
            <thead>
                <tr>
                    <th>Giờ học</th>
                    <th>Thứ 2</th>
                    <th>Thứ 3</th>
                    <th>Thứ 4</th>
                    <th>Thứ 5</th>
                    <th>Thứ 6</th>
                    <th>Thứ 7</th>
                    <th>Chủ nhật</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>07:00 - 09:00</td>
                    <td class="active">Toán NC</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td class="active">Anh Văn</td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>09:30 - 11:30</td>
                    <td></td>
                    <td class="active">Lý 9 nâng cao</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <!-- Thêm nhiều slot hơn nếu cần -->
            </tbody>
        </table>
    </div>
        
</div>

</body>
</html>
