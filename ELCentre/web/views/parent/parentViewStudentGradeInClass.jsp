<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="${pageContext.request.contextPath}/views/login.jsp" />
</c:if>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xem điểm học sinh</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-style.css">
    <style>
body {
    margin: 0;
    padding: 0;
    font-family: 'Segoe UI', sans-serif;
    background-color: #f4f6f9;
}

.wrapper {
    display: flex;
    min-height: 100vh;
    width: 100%;
}

.main-area {
    flex: 1;
    display: flex;
    flex-direction: column;
    background-color: #f4f6f9;
    overflow-x: auto;
    min-height: 100vh;
}

.header {
    background-color: #1F4E79;
    color: white;
    padding: 16px 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    position: sticky;
    top: 0;
    z-index: 999;
}

.user-menu {
    display: flex;
    align-items: center;
    gap: 10px;
    position: relative;
}

.user-toggle {
    display: flex;
    align-items: center;
    gap: 10px;
    cursor: pointer;
    color: white;
    font-weight: 500;
}

.user-avatar {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    object-fit: cover;
    border: 2px solid white;
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

.main-content {
    padding: 30px;
    max-width: 960px;
    margin: 0 auto;
    width: 100%;
    box-sizing: border-box;
}

.info-box {
    background: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.section-title {
    font-size: 20px;
    font-weight: bold;
    color: #1F4E79;
    margin-bottom: 20px;
}

.table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 15px;
}

.table th, .table td {
    border: 1px solid #ccc;
    padding: 10px;
    text-align: center;
}

.table th {
    background-color: #f4f4f4;
    color: #333;
}

.main-content a {
    color: #1F4E79;
    font-weight: bold;
    display: inline-block;
    margin-top: 20px;
}

.main-content a:hover {
    text-decoration: underline;
}

    </style>
</head>
<body>
<div class="wrapper">
    <%@ include file="/views/parent/sidebar.jsp" %>

    <div class="main-area">
        <div class="header">
            <h2>Điểm học sinh</h2>
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
            <div class="info-box">
                <div class="section-title">📘 Điểm học sinh: ${hocSinh.hoTen}</div>
                <p><strong>Lớp:</strong> ${lopHoc.tenLopHoc} (${lopHoc.classCode})</p>

                <table class="table">
                    <thead>
                        <tr>
                            <th>Điểm kiểm tra</th>
                            <th>Điểm bài tập</th>
                            <th>Điểm giữa kỳ</th>
                            <th>Điểm cuối kỳ</th>
                            <th>Điểm tổng kết</th>
                            <th>Thời gian cập nhật</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>${diem.diemKiemTra}</td>
                            <td>${diem.diemBaiTap}</td>
                            <td>${diem.diemGiuaKy}</td>
                            <td>${diem.diemCuoiKy}</td>
                            <td><strong>${diem.diemTongKet}</strong></td>
                            <td><fmt:formatDate value="${thoiGianCapNhat}" pattern="dd/MM/yyyy HH:mm" /></td>
                        </tr>
                    </tbody>
                </table>

                <a href="javascript:history.back()" style="display: inline-block; margin-top: 20px;">← Quay lại</a>
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

    function openModal() {
        document.getElementById("passwordModal").style.display = "flex";
    }

    function closeModal() {
        document.getElementById("passwordModal").style.display = "none";
    }

    document.addEventListener("click", function (event) {
        const toggle = document.querySelector(".user-toggle");
        const dropdown = document.getElementById("userDropdown");
        if (!toggle.contains(event.target) && !dropdown.contains(event.target)) {
            dropdown.style.display = "none";
        }
    });
</script>
</body>
</html>
