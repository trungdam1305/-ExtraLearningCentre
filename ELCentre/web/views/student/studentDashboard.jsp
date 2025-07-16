<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/views/student/sidebar.jsp" %>
<c:if test="${empty sessionScope.user}">
    <c:redirect url="${pageContext.request.contextPath}/views/login.jsp" />
</c:if>
<!DOCTYPE html>
<html>
    <!<!-- CSS -->
    <head>
        <meta charset="UTF-8">
        <title>Trang chủ</title>
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
            .action-btn {
                padding: 6px 14px;
                border: none;
                border-radius: 4px;
                font-size: 14px;
                font-weight: bold;
                cursor: pointer;
                color: white;
                background-color: #1F4E79;
                transition: background-color 0.2s ease;
            }
            .action-btn:hover {
                background-color: #163d5c;
            }
            /* Css phân trang và menu người dùng */
            #pagination-lophoc,
            #pagination-thongbao,
            #pagination-lichhoc {
                margin-top: 20px;
                display: flex;
                justify-content: flex-end; /* căn phải */
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
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
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
            
            /* Css cho đổi mật khẩu */
            .modal-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.4);
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
                box-shadow: 0 4px 20px rgba(0,0,0,0.3);
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
            }

            .modal-actions {
                display: flex;
                justify-content: space-between;
                gap: 10px;
            }

            .modal-actions .cancel {
                background-color: #999;
            }
            .new-support-btn {
                background-color: #1F4E79;
                color: white;
                padding: 8px 14px;
                border-radius: 5px;
                font-weight: bold;
                text-decoration: none;
                transition: background-color 0.3s ease;
                font-size: 14px;
            }

            .new-support-btn i {
                margin-right: 6px;
            }

            .new-support-btn:hover {
                background-color: #163d5c;
            }





        </style>
    </head>
    <body>
        <div class="main-content">
            <!<!-- Header -->
            <div class="header">
                <h2>Trang chủ</h2>
                <div class="user-menu">
                    <div class="user-toggle" onclick="toggleUserMenu()">
                        <span>👋 Xin chào <strong>${hocSinhInfo.hoTen}</strong> 
                        <img src="${pageContext.request.contextPath}/${hocSinhInfo.avatar}" class="user-avatar" alt="Avatar">
                        ☰ </span>
                    </div>
                    <div class="user-dropdown" id="userDropdown">
                        <a href="${pageContext.request.contextPath}/ResetPasswordServlet" onclick="openModal(); return false;">🔑 Đổi mật khẩu</a>
                        <a href="${pageContext.request.contextPath}/LogoutServlet">🚪 Đăng xuất</a>
                    </div>
                </div>
            </div>
                                  
            <!--Hiển thị thông tin lớp học đã đăng kí của học sinh-->
            <h3>Lớp học đã đăng ký</h3>

            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                <!-- Nút Gửi hỗ trợ mới -->
                <a href="${pageContext.request.contextPath}/StudentSupportServlet" class="new-support-btn">
                    <i class="fas fa-plus-circle"></i> Gửi hỗ trợ mới
                </a>

                <!-- Ô tìm kiếm -->
                <form method="get" style="display: flex; align-items: center; gap: 10px;">
                    <input id="searchInput" type="text" name="keyword" placeholder="Tìm kiếm..." 
                           value="${param.keyword}" 
                           style="padding: 8px; font-size: 14px; width: 300px;">
                    <button type="submit" class="action-btn">Tìm</button>
                </form>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Mã Lớp</th>
                        <th>Tên Lớp học</th>
                        <th>Khóa học</th>
                        <th>Sĩ Số</th>
                        <th>Ghi chú</th>
                    </tr>
                </thead>
                <tbody id="tableLopHoc">
                    <c:forEach var="lop" items="${dsLopHoc}" varStatus="stt">
                        <tr>
                            <td>${stt.index + 1}</td>
                            <td>${lop.classCode}</td>
                            <td>${lop.tenLopHoc}</td>
                            <td>${lop.tenKhoaHoc}</td>
                            <td>${lop.siSo} học sinh</td>
                            <td>${lop.ghiChu}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>                  
            <!<!-- Phân trang -->
            <div id="pagination-lophoc"></div>
            
            <!<!-- Thông báo và lịch học sắp tới -->
            <div class="section-box">
                <div class="section">
                    <h3>Thông báo</h3>
                    <div id="listThongBao">
                        <c:choose>
                            <c:when test="${empty dsThongBao}">
                                <div class="box-item" style="color: #999; font-style: italic;">
                                    Bạn chưa có thông báo nào.
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="tb" items="${dsThongBao}">
                                    <div class="box-item">
                                        <div style="font-weight: 500;">${tb.noiDung}</div>
                                        <div style="font-size: 13px; color: #666;">🕒 ${tb.thoiGian}</div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div id="pagination-thongbao"></div>
                </div>

                <div class="section">
                    <h3>Lịch học sắp diễn ra</h3>
                    <div id="listLichHoc">
                        <c:choose>
                            <c:when test="${empty lichHocSapToi}">
                                <div class="box-item" style="color: #999; font-style: italic;">
                                    Bạn không có lịch học nào sắp tới.
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="lh" items="${lichHocSapToi}">
                                    <div class="box-item">
                                        📅 <strong>${lh.ngayHoc}</strong> — Lớp: <strong>${lh.tenLopHoc}</strong>, Slot: ${lh.slotThoiGian}
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div id="pagination-lichhoc"></div>
                </div>
            </div>
        </div>          
        
        <!<!-- Java script phân trang -->            
        <script>
            $(document).ready(function () {
                function applyPagination(containerSelector, itemSelector, paginationSelector, itemsPerPage = 5) {
                    const items = $(containerSelector).children(itemSelector);
                    const numItems = items.length;

                    if (numItems === 0) return;

                    function showPage(page) {
                        const start = (page - 1) * itemsPerPage;
                        const end = start + itemsPerPage;
                        items.hide().slice(start, end).show();
                    }

                    showPage(1);
                    $(paginationSelector).pagination({
                        items: numItems,
                        itemsOnPage: itemsPerPage,
                        onPageClick: function (pageNumber) {
                            showPage(pageNumber);
                        }
                    });
                }

                // Gọi hàm cho từng khu vực
                applyPagination("#tableLopHoc", "tr", "#pagination-lophoc", 5);
                applyPagination("#listThongBao", ".box-item", "#pagination-thongbao", 5);
                applyPagination("#listLichHoc", ".box-item", "#pagination-lichhoc", 5);
            });
        </script>
        
        <!<!-- Java script thanh menu người dùng --> 
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
    </body>
</html>
