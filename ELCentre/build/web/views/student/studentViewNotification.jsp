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
        <title>Thông báo của tôi</title>
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
            .user-menu { position: relative; font-size: 16px; }
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
            .user-dropdown a:hover { background-color: #f0f0f0; }
            .user-avatar {
                width: 32px;
                height: 32px;
                border-radius: 50%;
                object-fit: cover;
                margin-right: 8px;
                vertical-align: middle;
            }
            .notification-box {
                background-color: white;
                border-radius: 10px;
                padding: 20px;
                margin-top: 25px;
            }
            .notification-item {
                padding: 12px;
                border-bottom: 1px solid #ddd;
                font-size: 15px;
            }
            .notification-item:last-child { border-bottom: none; }
            .notification-time {
                font-size: 13px;
                color: #888;
                margin-top: 5px;
            }
            .no-data {
                background: white;
                border-radius: 10px;
                padding: 40px;
                text-align: center;
                font-size: 18px;
                color: #999;
                margin-top: 25px;
            }
            #pagination-container {
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
            }
            .pagination li a:hover,
            .pagination li span:hover,
            .pagination li.active span {
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
                <c:if test="${not empty sessionScope.message}">
                    <div class="message success">
                        <c:out value="${sessionScope.message}" />
                    </div>
                    <c:remove var="message" scope="session" />
                </c:if>            
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
                <h2 style="margin: 0; color: white;">Thông báo</h2>
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
            <!-- FORM TÌM KIẾM -->
            <div style="text-align: right; margin-top: 20px;">
                <form method="get" style="display: inline-block;">
                    <input type="text" name="keyword" placeholder="Tìm kiếm..." value="${param.keyword}"
                           style="padding: 8px; font-size: 14px; width: 300px;">
                    <button type="submit" class="action-btn">Tìm</button>
                </form>
            </div>

            <!-- DANH SÁCH THÔNG BÁO -->
                <c:choose>
                    <c:when test="${not empty dsThongBao}">
                        <div class="notification-box" id="notificationBox">
                            <c:forEach var="tb" items="${dsThongBao}">
                                <c:if test="${empty param.keyword 
                                    or fn:containsIgnoreCase(tb.noiDung, param.keyword)
                                    or fn:containsIgnoreCase(tb.thoiGian, param.keyword)}">
                                    <div class="notification-item">
                                        <div>${tb.noiDung}</div>
                                        <div class="notification-time">${tb.thoiGian}</div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                        <div id="pagination-container"></div>
                    </c:when>
                    <c:otherwise>
                        <div class="no-data">Bạn hiện không có thông báo nào.</div>
                    </c:otherwise>
                </c:choose>
            

                <!-- JS: Menu người dùng -->
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

                <!-- JS: Phân trang -->
                <script>
                    $(document).ready(function () {
                        var itemsPerPage = 6;
                        var items = $("#notificationBox .notification-item");
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
