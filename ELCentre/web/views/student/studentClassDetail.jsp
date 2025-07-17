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

        <!-- 📚 Thư viện jQuery và phân trang -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-pagination.js@1.6/jquery.simplePagination.js"></script>
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
            .logout-link {
                margin-top: 30px;
                font-weight: bold;
                color: #ffcccc;
            }
            .main-content {
                flex: 1;
                padding: 0px;
            }
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
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
                margin-right: 90px; 
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
         
            .user-menu {
                position: relative;
                font-size: 16px;
            }

            .user-toggle {
                cursor: pointer;
                color: #1F4E79;
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
            .user-avatar {
                width: 32px;
                height: 32px;
                border-radius: 50%;
                object-fit: cover;
                margin-right: 8px;
                vertical-align: middle;
            }
                        /* Wrapper layout */
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
            }
            
            .main-content {
                flex: 1;
                padding: 30px;
                max-width: 100%; /* Đảm bảo không giới hạn chiều rộng */
                box-sizing: border-box; /* Bao gồm padding trong chiều rộng */
            }

        </style>
    </head>
    <body>
        <div class="wrapper">
            <%@ include file="/views/student/sidebar.jsp" %>
            <div class="main-area">
            
            <div class="header" style="
                background-color: #1F4E79;
                color: white;
                padding: 16px 30px;
                margin: 0;
                width: 100%;
                box-sizing: border-box;
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-radius: 0;
                position: relative;
                top: 0;
                left: 0;
                z-index: 999;
            ">
                <h2 style="margin: 0; color: white;">Chi tiết lớp học</h2>
                <div class="user-menu">
                    <div class="user-toggle" onclick="toggleUserMenu()" style="color: white;">
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

            <!-- MAIN CONTENT -->
                <div class="main-content">
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
                                    <!-- Java script thanh menu người dùng --> 
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
                </script>
        
                <!-- 🔐 MODAL ĐỔI MẬT KHẨU -->
                <div id="passwordModal" class="modal-overlay" style="display: none;">
                    <div class="modal-content">
                        <h3>🔐 Đổi mật khẩu</h3>
                        <!-- ✅ submit bình thường, không dùng fetch -->
                        <form method="post" action="${pageContext.request.contextPath}/ResetPasswordServlet">
                            <input type="password" name="currentPassword" placeholder="Mật khẩu hiện tại" required>
                            <input type="password" name="newPassword" placeholder="Mật khẩu mới" required>
                            <input type="password" name="confirmPassword" placeholder="Xác nhận mật khẩu" required>
                            <div class="modal-actions">
                                <button type="submit" class="action-btn">Cập nhật</button>
                                <button type="button" class="action-btn cancel" onclick="closeModal()">Hủy</button>
                            </div>
                        </form>
                        <!-- ✅ Hiển thị thông báo (nếu có) -->
                        <c:if test="${not empty requestScope.message}">
                            <p style="color: red; margin-top: 10px;">${requestScope.message}</p>
                        </c:if>
                    </div>
                </div>

                <script>
                    function openModal() {
                        document.getElementById("passwordModal").style.display = "flex";
                    }

                    function closeModal() {
                        document.getElementById("passwordModal").style.display = "none";
                    }

                    // Đóng modal nếu bấm ra ngoài
                    document.addEventListener("click", function(e) {
                        const modal = document.getElementById("passwordModal");
                        if (e.target === modal) {
                            closeModal();
                        }
                    });
                </script>        
                </div>
                <%@ include file="/views/student/footer.jsp" %>
            </div>            
        </div>                
    </body>
</html>
