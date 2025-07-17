<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:if test="${empty sessionScope.user}">
    <c:redirect url="${pageContext.request.contextPath}/views/login.jsp" />
</c:if>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Parent Dashboard</title>
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
            flex-wrap: wrap;
        }
        .section {
            flex: 1;
            background: white;
            padding: 20px;
            border-radius: 10px;
            min-width: 350px;
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
    <div class="sidebar-title">PHỤ HUYNH</div>
    <div class="sidebar-section">TỔNG QUAN</div>
    <a href="${pageContext.request.contextPath}/ParentDashboardServlet">Trang chủ</a>
    <div class="sidebar-section">HỌC TẬP</div>
    <a href="${pageContext.request.contextPath}/ParentViewClassServlet">Lớp học</a>
    <a href="${pageContext.request.contextPath}/ParentViewScheduleServlet">Lịch học</a>
    <div class="sidebar-section">TÀI CHÍNH</div>
    <a href="${pageContext.request.contextPath}/ParentPaymentServlet">Học phí</a>
    <div class="sidebar-section">HỆ THỐNG</div>
    <a href="${pageContext.request.contextPath}/ParentViewNotificationServlet">Thông báo</a>
    <a href="${pageContext.request.contextPath}/ParentEditProfileServlet">Tài khoản</a>
    <a href="${pageContext.request.contextPath}/ParentSupportServlet">Hỗ trợ</a>
    <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout-link">Đăng xuất</a>
</div>

<div class="main-content">
    <div class="header">
        <h2>Parent Dashboard</h2>
        <span>Xin chào ${sessionScope.user.email}</span>
    </div>

    <h3>Con của bạn</h3>
    <table>
        <thead>
        <tr>
            <th>STT</th>
            <th>Họ tên</th>
            <th>Mã HS</th>
            <th>Trường học</th>
            <th>Lớp</th>
            <th>Ghi chú</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="hs" items="${dsCon}" varStatus="stt">
            <tr>
                <td>${stt.index + 1}</td>
                <td>${hs.hoTen}</td>
                <td>${hs.maHocSinh}</td>
                <td>${hs.tenTruongHoc}</td>
                <td>${hs.lopDangHocTrenTruong}</td>
                <td>${hs.ghiChu}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="section-box">
        <div class="section">
            <h3>Thông báo</h3>
            <c:choose>
                <c:when test="${empty dsThongBao}">
                    <div class="box-item" style="color: #999; font-style: italic;">
                        Chưa có thông báo nào.
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="tb" items="${dsThongBao}">
                        <div class="box-item">
                            <div><strong>${tb.noiDung}</strong></div>
                            <div style="font-size: 13px; color: #666;">🕒 ${tb.thoiGian}</div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="section">
            <h3>Điểm tổng kết</h3>
            <c:choose>
                <c:when test="${empty dsKetQua}">
                    <div class="box-item" style="color: #999; font-style: italic;">
                        Chưa có điểm tổng kết nào.
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="diem" items="${dsKetQua}">
                        <div class="box-item">
                            👨‍🎓 <strong>${diem.hoTenHocSinh}</strong> — ${diem.tenLopHoc} (${diem.tenKhoaHoc}): <strong>${diem.diemTongKet}</strong>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="section">
        <h3>Lịch học sắp tới</h3>
        <c:choose>
            <c:when test="${empty lichHocSapToi}">
                <div class="box-item" style="color: #999; font-style: italic;">
                    Không có lịch học nào sắp tới.
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="lh" items="${lichHocSapToi}">
                    <div class="box-item">
                        📅 <strong>${lh.ngayHoc}</strong> — <strong>${lh.hoTenHocSinh}</strong>, lớp: <strong>${lh.tenLopHoc}</strong>, slot: ${lh.slotThoiGian}
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>
