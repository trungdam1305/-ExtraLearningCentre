<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${empty sessionScope.user}">
    <c:redirect url="${pageContext.request.contextPath}/views/login.jsp" />
</c:if>

<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết học sinh</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simple-pagination.js@1.6/simplePagination.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            background-color: #f4f6f9;
        }
        .wrapper { display: flex; min-height: 100vh; width: 100%; }
        .main-area { flex: 1; display: flex; flex-direction: column; background-color: #f4f6f9; overflow-x: auto; }
        .header {
            background-color: #1F4E79;
            color: white;
            padding: 16px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .main-content {
            flex: 1;
            padding: 30px;
            max-width: 100%;
            box-sizing: border-box;
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
        .info-item .label {
            font-weight: bold;
            color: #333;
            display: inline-block;
            min-width: 140px;
        }
        .back-btn {
            display: inline-block;
            margin-bottom: 20px;
            text-decoration: none;
            color: #1F4E79;
            font-weight: bold;
        }
        .back-btn:hover { text-decoration: underline; }

        .class-list li {
            padding: 6px 0;
        }

        .user-menu {
            position: relative;
            font-size: 16px;
        }
        .user-toggle {
            cursor: pointer;
            color: white;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .user-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            object-fit: cover;
        }
        .user-dropdown {
            display: none;
            position: absolute;
            right: 0;
            top: 100%;
            background: white;
            border: 1px solid #ddd;
            border-radius: 6px;
            min-width: 180px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            z-index: 999;
        }
        .user-dropdown a {
            display: block;
            padding: 10px;
            text-decoration: none;
            color: #333;
            font-size: 14px;
        }
        .user-dropdown a:hover {
            background-color: #f0f0f0;
        }
        .class-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .class-table th, .class-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
            font-size: 15px;
        }

        .class-table th {
            background-color: #1F4E79;
            color: white;
        }

        .class-table tbody tr:hover {
            background-color: #f9f9f9;
        }

        .class-table .btn-view,
        .class-table .btn-grade,
        .class-table .btn-attendance {
            text-decoration: none;
            margin-right: 8px;
            padding: 6px 10px;
            font-size: 13px;
            border-radius: 5px;
            color: white;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .btn-view { background-color: #007bff; }
        .btn-view:hover { background-color: #0056b3; }

        .btn-grade { background-color: #28a745; }
        .btn-grade:hover { background-color: #1e7e34; }

        .btn-attendance { background-color: #17a2b8; }
        .btn-attendance:hover { background-color: #117a8b; }

    </style>
</head>
<body>
    <div class="wrapper">
        <%@ include file="/views/parent/sidebar.jsp" %>
        <div class="main-area">
            <div class="header">
                <h2>Chi tiết học sinh</h2>
                <div class="user-menu">
                    <div class="user-toggle" onclick="toggleUserMenu()">
                        <img src="${pageContext.request.contextPath}/${phuHuynh.avatar}" class="user-avatar" alt="Avatar">
                        <span><strong>${phuHuynh.hoTen}</strong></span>
                    </div>
                    <div class="user-dropdown" id="userDropdown">
                        <a href="${pageContext.request.contextPath}/ResetPasswordServlet" onclick="openModal(); return false;">🔑 Đổi mật khẩu</a>
                        <a href="${pageContext.request.contextPath}/LogoutServlet">🚪 Đăng xuất</a>
                    </div>
                </div>
            </div>

            <div class="main-content">
                <a class="back-btn" href="${pageContext.request.contextPath}/ParentDashboardServlet">← Quay lại trang chính</a>

                <div class="info-box">
                    <div class="section-title">👶 Thông tin học sinh</div>
                    <div class="info-grid">
                        <div class="info-item"><span class="label">Họ tên:</span> ${hocSinh.hoTen}</div>
                        <div class="info-item"><span class="label">Ngày sinh:</span> ${hocSinh.ngaySinh}</div>
                        <div class="info-item"><span class="label">Lớp hiện tại:</span> ${hocSinh.lopDangHocTrenTruong}</div>
                        <div class="info-item"><span class="label">Trạng thái:</span> ${hocSinh.trangThai}</div>
                        <div class="info-item" style="flex: 1 1 100%;"><span class="label">Ghi chú:</span> ${hocSinh.ghiChu}</div>
                    </div>

                    <div class="section-title">📚 Danh sách lớp học đã đăng ký</div>
                    <c:choose>
                        <c:when test="${not empty danhSachLop}">
                            <table class="class-table">
                                <thead>
                                    <tr>
                                        <th>STT</th>
                                        <th>Tên lớp</th>
                                        <th>Mã lớp</th>
                                        <th>Sĩ số</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="lop" items="${danhSachLop}" varStatus="loop">
                                        <tr>
                                            <td>${loop.count}</td>
                                            <td>${lop.tenLopHoc}</td>
                                            <td>${lop.classCode}</td>
                                            <td>${lop.siSo}/${lop.siSoToiDa}</td>
                                            <td>
                                               
                                                <a href="${pageContext.request.contextPath}/ParentViewClassDetailServlet?idHocSinh=${hocSinh.ID_HocSinh}&classCode=${lop.classCode}" class="btn-view">Xem chi tiết</a>

                                                <a href="${pageContext.request.contextPath}/ParentViewStudentAttendanceInClass?idHocSinh=${hocSinh.ID_HocSinh}&idLopHoc=${lop.ID_LopHoc}" class="btn-attendance">Xem điểm danh</a>

                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <p>Học sinh hiện chưa đăng ký lớp học nào.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <%@ include file="/views/parent/footer.jsp" %>
        </div>
    </div>

    <script>
        function toggleUserMenu() {
            const dropdown = document.getElementById("userDropdown");
            dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
        }
        document.addEventListener("click", function (event) {
            const toggle = document.querySelector(".user-toggle");
            const dropdown = document.getElementById("userDropdown");
            if (!toggle.contains(event.target) && !dropdown.contains(event.target)) {
                dropdown.style.display = "none";
            }
        });
        function openModal() {
            document.getElementById("passwordModal").style.display = "flex";
        }
        function closeModal() {
            document.getElementById("passwordModal").style.display = "none";
        }
    </script>
</body>
</html>
