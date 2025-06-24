<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard</title>
    <style>
        body {
            display: flex;
            font-family: Arial, sans-serif;
            margin: 0;
        }
        .sidebar {
            width: 200px;
            background-color: #f5f5f5;
            height: 100vh;
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        }
        .sidebar a {
            display: block;
            padding: 10px 0;
            color: #333;
            text-decoration: none;
            font-weight: bold;
        }
        .sidebar a:hover {
            color: #007bff;
        }
        .main-content {
            flex: 1;
            padding: 30px;
            background-color: #fff;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .account {
            position: relative;
        }
        .account-name {
            cursor: pointer;
            font-weight: bold;
        }
        .dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            min-width: 160px;
            z-index: 1;
        }
        .dropdown-content a {
            padding: 10px;
            display: block;
            color: #333;
            text-decoration: none;
        }
        .dropdown-content a:hover {
            background-color: #f1f1f1;
        }

        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
            background-color: #fefefe;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ccc;
            text-align: center;
        }
        .sections {
            display: flex;
            gap: 20px;
            margin-top: 30px;
        }
        .section-box {
            flex: 1;
            padding: 15px;
            background-color: #f9f9f9;
            box-shadow: 0 0 5px rgba(0,0,0,0.1);
        }
    </style>
    <script>
        function toggleDropdown() {
            var dropdown = document.getElementById("accountDropdown");
            dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
        }
    </script>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <img src="${pageContext.request.contextPath}/assets/logo.png" style="width: 100%; margin-bottom: 20px;" />
        <a href="${pageContext.request.contextPath}/StudentDashboard.jsp">Trang chủ</a>
        <a href="${pageContext.request.contextPath}/DangKyHocServlet">Đăng kí học</a>
        <a href="${pageContext.request.contextPath}/LopHocServlet">Lớp học</a>
        <a href="${pageContext.request.contextPath}/LichHocServlet">Lịch học</a>
        <a href="${pageContext.request.contextPath}/HocPhiServlet">Học phí</a>
        <a href="${pageContext.request.contextPath}/ThongBaoServlet">Thông báo</a>
        <a href="${pageContext.request.contextPath}/TaiKhoanServlet">Tài khoản</a>
        <a href="${pageContext.request.contextPath}/LogoutServlet">Đăng xuất</a>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="header">
            <h2>Student Dashboard</h2>
            <div class="account">
                <span class="account-name" onclick="toggleDropdown()">Xin chào, ${sessionScope.hoten} &#9662;</span>
                <div class="dropdown-content" id="accountDropdown">
                    <a href="${pageContext.request.contextPath}/views/student/studentEditProfile.jsp">Chỉnh sửa hồ sơ</a>
                    <a href="${pageContext.request.contextPath}/views/student/studentChangePassword.jsp">Đổi mật khẩu</a>
                    <a href="${pageContext.request.contextPath}/LogoutServlet">Đăng xuất</a>
                </div>
            </div>
        </div>

        <!-- Lớp học đã đăng ký -->
        <h3>Lớp học đã đăng ký</h3>
        <table>
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Tên Lớp học</th>
                    <th>Khóa Học</th>
                    <th>Thời gian</th>
                    <th>Ghi chú</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="lop" items="${sessionScope.dsLopHoc}" varStatus="i">
                    <tr>
                        <td>${i.index + 1}</td>
                        <td>${lop.tenLop}</td>
                        <td>${lop.khoaHoc}</td>
                        <td>${lop.thoiGian}</td>
                        <td><a href="${pageContext.request.contextPath}/XemGhiChuServlet?id=${lop.id}">✎</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Thông báo & Lịch học sắp tới -->
        <div class="sections">
            <div class="section-box">
                <h4>Thông báo</h4>
                <c:forEach var="tb" items="${sessionScope.dsThongBao}">
                    <p>- ${tb.noiDung}</p>
                </c:forEach>
            </div>
            <div class="section-box">
                <h4>Lịch học sắp diễn ra</h4>
                <c:forEach var="lich" items="${sessionScope.dsLichHocSapToi}">
                    <p>Thứ ${lich.thu} - Ngày ${lich.ngay}: ${lich.tenLop} Slot ${lich.slot}</p>
                </c:forEach>
            </div>
        </div>
    </div>
</body>
</html>
