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
        .main-area {
            flex: 1;
            display: flex;
            flex-direction: column;
            background-color: #f4f6f9;
            overflow-x: auto;
        }
        .header {
            background-color: #1F4E79;
            color: white;
            padding: 16px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .user-toggle {
            cursor: pointer;
            color: white;
            font-weight: 500;
            display: flex;
            align-items: center;
        }
        .user-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            object-fit: cover;
            margin-left: 10px;
        }
        .main-content {
            flex: 1;
            padding: 30px;
        }
        .info-box {
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .section-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #1F4E79;
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
        .teacher-info-wrapper {
            display: flex;
            justify-content: space-between;
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
        .teacher-avatar {
            width: 120px;
            height: 120px;
            border-radius: 8px;
            overflow: hidden;
            background-color: #ddd;
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
    </style>
</head>
<body>
<div class="wrapper">
    <%@ include file="/views/parent/sidebar.jsp" %>
    <div class="main-area">
        <div class="header">
            <h2>Chi tiết lớp học</h2>
            <div class="user-toggle" onclick="toggleUserMenu()">
                <strong>${phuHuynh.hoTen}</strong>
                <img src="${pageContext.request.contextPath}/${sessionScope.phuHuynh.avatar}" alt="avatar" class="user-avatar">
            </div>
        </div>

        <div class="main-content">
            <a class="back-btn" href="${pageContext.request.contextPath}/ParentViewStudentDetailServlet?id=${hocSinhInfo.ID_HocSinh}">← Quay lại chi tiết học sinh</a>

            <div class="info-box">
                <div class="section-title">📘 Thông tin lớp học</div>
                <div class="info-grid">
                    <div class="info-item"><span class="label">Mã lớp:</span> ${lopHoc.classCode}</div>
                    <div class="info-item"><span class="label">Tên lớp:</span> ${lopHoc.tenLopHoc}</div>
                    <div class="info-item"><span class="label">Khóa học:</span> ${lopHoc.tenKhoaHoc}</div>
                    <div class="info-item"><span class="label">Sĩ số:</span> ${lopHoc.siSo} / ${lopHoc.siSoToiDa} (Min: ${lopHoc.siSoToiThieu})</div>
                    <div class="info-item"><span class="label">Phòng học:</span> ${lopHoc.ID_PhongHoc}</div>
                    <div class="info-item"><span class="label">Ngày tạo:</span> ${lopHoc.ngayTao}</div>
                    <div class="info-item" style="flex: 1 1 100%;"><span class="label">Ghi chú:</span> ${lopHoc.ghiChu}</div>
                </div>

                <div class="section-title">👨‍🏫 Giáo viên phụ trách</div>
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

        <%@ include file="/views/parent/footer.jsp" %>
    </div>
</div>

<script>
    function toggleUserMenu() {
        const dropdown = document.getElementById("userDropdown");
        dropdown.style.display = dropdown && dropdown.style.display === "block" ? "none" : "block";
    }
</script>
</body>
</html>
