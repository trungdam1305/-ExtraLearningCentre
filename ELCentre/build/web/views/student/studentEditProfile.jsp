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
    <title>Chỉnh sửa hồ sơ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-style.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
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
        }
        .header {
            background-color: #1F4E79;
            color: white;
            padding: 16px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            box-sizing: border-box;
        }
        .main-content {
            flex: 1;
            padding: 30px;
            max-width: 1200px;
            margin: 0 auto;
        }
        .profile-form {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .profile-grid {
            display: grid;
            grid-template-columns: 250px 1fr;
            gap: 30px;
        }
        .profile-image-box {
            text-align: center;
        }
        .avatar-box {
            width: 200px;
            height: 200px;
            background-color: #ccc;
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 10px;
        }
        .avatar-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .profile-image-box input[type="file"] {
            margin-top: 10px;
            font-size: 14px;
        }
        .profile-info-box {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        .profile-info-box label {
            display: block;
            margin-bottom: 4px;
            font-weight: 600;
            color: #444;
        }
        .profile-info-box input,
        .profile-info-box textarea,
        .profile-info-box select {
            width: 100%;
            padding: 10px;
            margin-bottom: 16px;
            border: 1px solid #ccc;
            border-radius: 6px;
            background-color: #f0f0f0;
            font-size: 15px;
            box-sizing: border-box;
        }
        .profile-info-box input[readonly] {
            background-color: #eaeaea;
            color: #999;
        }
        .profile-info-box textarea {
            grid-column: span 2;
        }
        .form-buttons {
            grid-column: span 2;
            display: flex;
            justify-content: flex-end;
            gap: 15px;
            margin-top: 20px;
        }
        .form-buttons button {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            font-size: 15px;
            transition: background-color 0.3s;
        }
        .form-buttons .cancel {
            background-color: #f0f0f0;
            color: #666;
        }
        .form-buttons .cancel:hover {
            background-color: #e0e0e0;
        }
        .form-buttons .save {
            background-color: #1F4E79;
            color: white;
        }
        .form-buttons .save:hover {
            background-color: #2a6ca6;
        }
        .user-menu {
            position: relative;
            font-size: 16px;
        }
        .user-toggle {
            cursor: pointer;
            color: #fff;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
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
            display: flex;
            align-items: center;
            padding: 10px;
            text-decoration: none;
            color: #333;
            font-size: 14px;
        }
        .user-dropdown a:hover {
            background-color: #f0f0f0;
        }
        .user-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            object-fit: cover;
        }
        /* Modal Styles */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
            transition: opacity 0.3s ease;
        }
        .modal-content {
            background: white;
            padding: 20px;
            border-radius: 10px;
            width: 400px;
            max-width: 90%;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
        }
        .modal-content h3 {
            margin: 0 0 20px;
            font-size: 18px;
        }
        .modal-content input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }
        .modal-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
        .modal-actions button {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
        }
        .modal-actions .action-btn {
            background-color: #1F4E79;
            color: white;
        }
        .modal-actions .action-btn.cancel {
            background-color: #f0f0f0;
            color: #666;
        }
        .modal-actions .action-btn:hover {
            opacity: 0.9;
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <%@ include file="/views/student/sidebar.jsp" %>
        <div class="main-area">
                <c:if test="${not empty sessionScope.message}">
                    <div class="message success">
                        <c:out value="${sessionScope.message}" />
                    </div>
                    <c:remove var="message" scope="session" />
                </c:if>            
            <div class="header">
                <h2 style="margin: 0;">Hồ sơ người dùng</h2>
                <div class="user-menu">
                    <div class="user-toggle" onclick="toggleUserMenu()">
                        <img src="${pageContext.request.contextPath}/${hocSinhInfo.avatar}" class="user-avatar" alt="Avatar">
                        <span><strong>${hocSinhInfo.hoTen}</strong></span>
                    </div>
                    <div class="user-dropdown" id="userDropdown">
                        <a href="#" onclick="openModal(); return false;">🔑 Đổi mật khẩu</a>
                        <a href="${pageContext.request.contextPath}/LogoutServlet">🚪 Đăng xuất</a>
                    </div>
                </div>
            </div>
            <div class="main-content">
                <form action="StudentEditProfileServlet" method="post" enctype="multipart/form-data" class="profile-form">
                    <div class="profile-grid">
                        <div class="profile-image-box">
                            <div class="avatar-box">
                                <c:choose>
                                    <c:when test="${not empty hocSinh.avatar}">
                                        <img src="${pageContext.request.contextPath}/${hocSinh.avatar}" alt="Avatar">
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fa fa-user"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <label for="profileImage" style="cursor: pointer; color: #1F4E79; font-weight: 600;">Thay đổi ảnh</label>
                            <input type="file" id="profileImage" name="profileImage" accept="image/png, image/jpeg" style="display: none;">
                        </div>
                        <div class="profile-info-box">
                            <div>
                                <label>Mã học sinh</label>
                                <input type="text" value="${hocSinh.maHocSinh}" readonly>
                            </div>
                            <div>
                                <label>Họ và tên</label>
                                <input type="text" name="hoTen" value="${hocSinh.hoTen}" required>
                            </div>
                            <div>
                                <label>Email</label>
                                <input type="text" value="${sessionScope.user.email}" readonly>
                            </div>
                            <div>
                                <label>Ngày sinh</label>
                                <input type="date" name="ngaySinh" value="${hocSinh.ngaySinh}">
                            </div>
                            <div>
                                <label>Địa chỉ</label>
                                <input type="text" name="diaChi" value="${hocSinh.diaChi}">
                            </div>
                            <div>
                                <label>Trường học</label>
                                <select name="idTruongHoc">
                                    <c:forEach var="t" items="${dsTruongHoc}">
                                        <option value="${t.ID_TruongHoc}" ${t.ID_TruongHoc == hocSinh.ID_TruongHoc ? 'selected' : ''}>
                                            ${t.tenTruongHoc}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div>
                                <label>Lớp đang học</label>
                                <input type="text" name="lopDangHoc" value="${hocSinh.lopDangHocTrenTruong}">
                            </div>
                            <div>
                                <label>Giới tính</label>
                                <select name="gioiTinh">
                                    <option value="Nam" ${hocSinh.gioiTinh == 'Nam' ? 'selected' : ''}>Nam</option>
                                    <option value="Nữ" ${hocSinh.gioiTinh == 'Nữ' ? 'selected' : ''}>Nữ</option>
                                </select>
                            </div>
                            <div>
                                <label>Số điện thoại phụ huynh</label>
                                <input type="text" name="sdtPhuHuynh" value="${hocSinh.SDT_PhuHuynh}">
                            </div>
                            <div>
                                <label>Giới thiệu bản thân</label>
                                <textarea name="ghiChu" rows="3">${hocSinh.ghiChu}</textarea>
                            </div>
                            <div class="form-buttons">
                                <button type="reset" class="cancel">Hủy</button>
                                <button type="submit" class="save">Lưu hồ sơ</button>
                            </div>
                        </div>
                    </div>
                </form>

                <!-- Modal Đổi mật khẩu -->
                <div id="passwordModal" class="modal-overlay" style="display: none;">
                    <div class="modal-content">
                        <h3>🔐 Đổi mật khẩu</h3>
                        <form method="post" action="${pageContext.request.contextPath}/ResetPasswordServlet">
                            <input type="password" name="currentPassword" placeholder="Mật khẩu hiện tại" required>
                            <input type="password" name="newPassword" placeholder="Mật khẩu mới" required>
                            <input type="password" name="confirmPassword" placeholder="Xác nhận mật khẩu" required>
                            <c:if test="${not empty requestScope.message}">
                                <p style="color: red; margin-top: 10px; text-align: center;">${requestScope.message}</p>
                            </c:if>
                            <div class="modal-actions">
                                <button type="submit" class="action-btn">Cập nhật</button>
                                <button type="button" class="action-btn cancel" onclick="closeModal()">Hủy</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <%@ include file="/views/student/footer.jsp" %>
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

        document.addEventListener("click", function (e) {
            const modal = document.getElementById("passwordModal");
            if (e.target === modal) {
                closeModal();
            }
        });
    </script>
</body>
</html>