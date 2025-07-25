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
    <title>Trang chủ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-pagination.js@1.6/jquery.simplePagination.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simple-pagination.js@1.6/simplePagination.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        html, body {
    height: 100%;
    margin: 0;
    padding: 0;
}

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

        .sidebar {
            flex: 0 0 260px;
            background-color: #1F4E79;
            height: 100%;
            padding: 20px;
            color: white;
            box-sizing: border-box;
            overflow-y: auto;
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
        }

        .main-content {
            flex: 1;
            padding: 30px;
            max-width: 100%;
            box-sizing: border-box;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100%;
        }

        .user-menu {
            position: relative;
            font-size: 16px;
        }

        .user-toggle {
            cursor: pointer;
            color: white;
            font-weight: 500;
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
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
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

        .user-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 8px;
            vertical-align: middle;
        }

        .form-box {
            background-color: white;
            border-radius: 10px;
            padding: 40px; /* Tăng padding để form trông lớn hơn */
            width: 95%; /* Tăng lên 95% chiều rộng của .main-content */
            max-width: 1000px; /* Tăng giới hạn tối đa để form lớn hơn */
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
        }

        .form-box h2 {
            margin-bottom: 20px;
            color: #1F4E79;
            font-size: 24px; /* Tăng kích thước tiêu đề */
        }

        .form-group {
            margin-bottom: 20px; /* Tăng khoảng cách giữa các nhóm */
        }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 8px; /* Tăng khoảng cách dưới label */
            color: #333;
            font-size: 16px; /* Tăng kích thước chữ label */
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 15px; /* Tăng padding để trường nhập liệu lớn hơn */
            border-radius: 6px; /* Tăng bo góc nhẹ */
            border: 1px solid #ccc;
            font-size: 16px; /* Tăng kích thước chữ */
            box-sizing: border-box;
        }

        textarea {
            height: 150px; /* Tăng chiều cao textarea */
            resize: vertical;
        }

        .submit-btn {
            margin-top: 20px; /* Tăng khoảng cách trên nút */
            padding: 12px 25px; /* Tăng kích thước nút */
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px; /* Tăng kích thước chữ nút */
        }

        .submit-btn:hover {
            background-color: #218838;
        }

        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.4);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 2000;
        }

        .modal-content {
            background: white;
            padding: 30px;
            border-radius: 10px;
            width: 360px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            position: relative;
        }

        .modal-content h3 {
            margin-top: 0;
            color: #1F4E79;
            text-align: center;
        }

        .modal-content input {
            width: 100%;
            padding: 10px;
            margin-bottom: 12px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
            box-sizing: border-box;
        }

        .modal-actions {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }

        .action-btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            color: white;
            background-color: #1F4E79;
            transition: background-color 0.2s ease;
        }

        .action-btn:hover {
            background-color: #163d5c;
        }

        .modal-actions .cancel {
            background-color: #999;
        }

        #pagination-lichhoc {
            margin-top: 20px;
            display: flex;
            justify-content: flex-end;
        }

        .pagination {
            list-style: none;
            padding-left: 0;
            margin: 0;
            display: flex;
            gap: 6px;
        }

        .pagination li {
            display: inline;
        }

        .pagination li a,
        .pagination li span {
            display: inline-block;
            padding: 6px 14px;
            font-size: 14px;
            font-weight: bold;
            border-radius: 4px;
            background-color: #1F4E79;
            color: #fff;
            text-decoration: none;
            transition: background-color 0.2s ease;
            border: none;
        }

        .pagination li a:hover,
        .pagination li span:hover {
            background-color: #163d5c;
        }

        .pagination li.active span {
            background-color: #163d5c;
        }

        .footer {
            background-color: #1F4E79;
            color: white;
            text-align: center;
            padding: 15px 30px;
            width: 100%;
            box-sizing: border-box;
            flex-shrink: 0;
        }

        .footer p {
            margin: 0;
            font-size: 14px;
            font-family: 'Segoe UI', sans-serif;
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
                <h2 style="margin: 0; color: white;">Gửi yêu cầu hỗ trợ</h2>
                <div class="user-menu">
                    <div class="user-toggle" onclick="toggleUserMenu()">
                        <span><strong>${hocSinhInfo.hoTen}</strong>
                            <img src="${pageContext.request.contextPath}/${hocSinhInfo.avatar}" class="user-avatar" alt="Avatar">
                            ☰
                        </span>
                    </div>
                    <div class="user-dropdown" id="userDropdown">
                        <a href="${pageContext.request.contextPath}/ResetPasswordServlet" onclick="openModal(); return false;">🔑 Đổi mật khẩu</a>
                        <a href="${pageContext.request.contextPath}/LogoutServlet">🚪 Đăng xuất</a>
                    </div>
                </div>
            </div>
            <div class="main-content">
                <div class="form-box">
                    <h2>Gửi yêu cầu hỗ trợ</h2>
                    <form action="${pageContext.request.contextPath}/StudentSupportServlet" method="post">
                        <div class="form-group">
                            <label for="tenHoTro">Tiêu đề hỗ trợ:</label>
                            <input type="text" id="tenHoTro" name="tenHoTro" required>
                        </div>
                        <div class="form-group">
                            <label for="moTa">Mô tả chi tiết:</label>
                            <textarea id="moTa" name="moTa" required></textarea>
                        </div>
                        <input type="hidden" name="idTaiKhoan" value="${sessionScope.user.ID_TaiKhoan}">
                        <button type="submit" class="submit-btn">Gửi yêu cầu</button>
                    </form>
                </div>
                <!-- Modal for Password Change -->
                <div id="passwordModal" class="modal-overlay" style="display: none;">
                    <div class="modal-content">
                        <h3>🔐 Đổi mật khẩu</h3>
                        <form method="post" action="${pageContext.request.contextPath}/ResetPasswordServlet">
                            <input type="password" name="currentPassword" placeholder="Mật khẩu hiện tại" required>
                            <input type="password" name="newPassword" placeholder="Mật khẩu mới" required>
                            <input type="password" name="confirmPassword" placeholder="Xác nhận mật khẩu" required>
                            <div class="modal-actions">
                                <button type="submit" class="action-btn">Cập nhật</button>
                                <button type="button" class="action-btn cancel" onclick="closeModal()">Hủy</button>
                            </div>
                        </form>
                        <c:if test="${not empty requestScope.message}">
                            <p style="color: red; margin-top: 10px;">${requestScope.message}</p>
                        </c:if>
                    </div>
                </div>
            </div>
            <%@ include file="/views/student/footer.jsp" %>
        </div>
    </div>

    <script>
        function toggleUserMenu() {
            const dropdown = document.getElementById("userDropdown");
            dropdown.style.display = (dropdown.style.display === "block") ? "none" : "block";
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

        document.addEventListener("click", function(e) {
            const modal = document.getElementById("passwordModal");
            if (e.target === modal) closeModal();
        });
    </script>
</body>
</html>