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
        <title>Yêu cầu hỗ trợ</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-style.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-pagination.js@1.6/jquery.simplePagination.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simple-pagination.js@1.6/simplePagination.css">
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
                margin-left: 6px;
                vertical-align: middle;
            }

            .form-container, .support-list {
                background: white;
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 30px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            }

            .form-container h3 {
                margin-top: 0;
            }

            .form-container textarea,
            .form-container input[type="text"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 12px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 14px;
                resize: vertical;
            }

            .form-container button {
                padding: 10px 20px;
                background-color: #1F4E79;
                color: white;
                border: none;
                border-radius: 5px;
                font-weight: bold;
                font-size: 14px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .form-container button:hover {
                background-color: #163d5c;
            }

            .support-item {
                border-bottom: 1px solid #eee;
                padding: 12px 0;
            }

            .support-item:last-child {
                border-bottom: none;
            }

            .support-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                font-weight: 600;
                font-size: 16px;
            }

            .status {
                font-size: 13px;
                padding: 4px 10px;
                border-radius: 20px;
                text-transform: capitalize;
                font-weight: 500;
            }

            .status.pending {
                background-color: #ffc107;
                color: white;
            }

            .status.approved {
                background-color: #28a745;
                color: white;
            }

            .status.rejected {
                background-color: #dc3545;
                color: white;
            }

            .no-data {
                text-align: center;
                padding: 40px;
                color: #888;
                background: #fff;
                border-radius: 10px;
                font-size: 16px;
            }

            #pagination-container {
                margin-top: 20px;
                display: flex;
                justify-content: flex-end;
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
                <h2 style="margin: 0; color: white;">Yêu cầu hỗ trợ</h2>
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
                    
            <div class="main-content">
                <!-- Thanh tìm kiếm -->
                <div style="text-align: right; margin: 20px 0;">
                    <form method="get" style="display: inline-block;">
                        <input id="searchInput" type="text" name="keyword" placeholder="Tìm kiếm theo tiêu đề, mô tả..." value="${param.keyword}" style="padding: 8px; font-size: 14px; width: 300px;">
                        <button type="submit" class="action-btn">Tìm</button>
                    </form>
                </div>

                <div class="support-list">
                    <c:choose>
                        <c:when test="${not empty dsHoTro}">
                            <c:forEach var="ht" items="${dsHoTro}" varStatus="loop">
                                <c:if test="${empty param.keyword 
                                    or fn:containsIgnoreCase(ht.tenHoTro, param.keyword)
                                    or fn:containsIgnoreCase(ht.moTa, param.keyword)
                                    or fn:containsIgnoreCase(ht.phanHoi, param.keyword)
                                    or fn:containsIgnoreCase(ht.daDuyet, param.keyword)}">
                                    <div class="support-item">
                                        <div class="support-header">
                                            <span>${ht.tenHoTro}</span>
                                            <c:choose>
                                                <c:when test="${ht.daDuyet eq 'Đã duyệt'}">
                                                    <span class="status approved">Đã duyệt</span>
                                                </c:when>
                                                <c:when test="${ht.daDuyet eq 'Từ chối'}">
                                                    <span class="status rejected">Từ chối</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status pending">Chờ duyệt</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div style="margin-top: 6px; color: #555;">${ht.moTa}</div>
                                        <div style="font-size: 13px; color: #888; margin-top: 4px;">
                                            Gửi lúc: ${ht.thoiGian}
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                             <div id="pagination-container"></div>
                        </c:when>
                        <c:otherwise>
                            <div class="no-data">Không có hỗ trợ nào được gửi.</div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Form gửi hỗ trợ -->
                <div class="form-container">
                    <h3>Gửi yêu cầu hỗ trợ</h3>
                    <form action="StudentSupportServlet" method="post">
                        <input type="text" name="tenHoTro" placeholder="Tiêu đề hỗ trợ" required>
                        <textarea name="moTa" rows="4" placeholder="Mô tả chi tiết" required></textarea>
                        <button type="submit">Gửi yêu cầu</button>
                    </form>
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

                    $(document).ready(function () {
                        var itemsPerPage = 5;
                        var items = $(".support-item");
                        var numItems = items.length;

                        function showPage(items, page) {
                            var start = (page - 1) * itemsPerPage;
                            var end = start + itemsPerPage;
                            items.hide().slice(start, end).show();
                        }

                        if (numItems > 0) {
                            showPage(items, 1);
                            $('#pagination-container').pagination({
                                items: numItems,
                                itemsOnPage: itemsPerPage,
                                onPageClick: function (pageNumber) {
                                    showPage(items, pageNumber);
                                }
                            });
                        }
                    });
                </script>

                <!-- ️ SCRIPT PHÂN TRANG -->
                <script>
                    $(document).ready(function () {
                        var itemsPerPage = 5;
                        var items = $("#tableBody tr");
                        var numItems = items.length;

                        function showPage(items, page) {
                            var start = (page - 1) * itemsPerPage;
                            var end = start + itemsPerPage;
                            items.hide().slice(start, end).show();
                        }

                        if (numItems > 0) {
                            showPage(items, 1);
                            $('#pagination-container').pagination({
                                items: numItems,
                                itemsOnPage: itemsPerPage,
                                onPageClick: function (pageNumber) {
                                    showPage(items, pageNumber);
                                }
                            });
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
