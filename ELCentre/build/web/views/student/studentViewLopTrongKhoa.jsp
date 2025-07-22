<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${empty sessionScope.user}">
    <c:redirect url="${pageContext.request.contextPath}/views/login.jsp" />
</c:if>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách lớp trong khóa học</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-style.css">
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
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
            font-size: 15px;
        }
        th {
            background-color: #1F4E79;
            color: white;
        }
        .no-data {
            background-color: white;
            padding: 40px;
            text-align: center;
            color: #888;
            border-radius: 10px;
            font-size: 18px;
        }
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
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
            text-decoration: none;
        }
        .action-btn:hover {
            background-color: #163d5c;
        }
        .enroll {
            background-color: #28a745;
        }
        .enroll:hover {
            background-color: #218838;
        }
        .header {
                position: sticky;
                top: 0;
                z-index: 999;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
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
                    .action-buttons {
            display: flex;
            justify-content: center;
            gap: 6px;
            flex-wrap: wrap;
        }
        .action-buttons form {
            margin: 0;
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
        .action-btn.transfer {
            background-color: #f0ad4e;
        }
        .action-btn.transfer:hover {
            background-color: #d99632;
        }
        .action-btn.leave {
            background-color: #d9534f;
        }
        .action-btn.leave:hover {
            background-color: #b52b27;
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
                <h2 style="margin: 0; color: white;">Danh sách lớp học trong khóa</h2>
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
                <c:if test="${not empty sessionScope.message}">
                    <div style="margin-bottom: 20px; padding: 10px; color: green; background-color: #e6ffe6; border: 1px solid #b2ffb2; border-radius: 4px;">
                        ${sessionScope.message}
                    </div>
                    <c:remove var="message" scope="session" />
                </c:if>
                <!-- Ô tìm kiếm -->
                <input id="searchInput" type="text" name="keyword" placeholder="Tìm kiếm..." value="${param.keyword}" style="padding: 8px; font-size: 14px; width: 250px;">

                <!-- Nút -->
                <button type="submit" class="action-btn">Tìm</button>
                <c:choose>
                    <c:when test="${not empty dsLop}">
                        <table>
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Mã lớp</th>
                                    <th>Tên lớp</th>
                                    <th>Khóa học</th>
                                    <th>Thời gian học</th>
                                    <th>Sĩ số</th>
                                    <th>Ngày tạo</th>
                                    <th>Ghi chú</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="lop" items="${dsLop}" varStatus="i">
                                    <tr>
                                        <td>${i.index + 1}</td>
                                        <td>${lop.classCode}</td>
                                        <td>${lop.tenLopHoc}</td>
                                        <td>${lop.tenKhoaHoc}</td>
                                        <td>${lop.thoiGianBatDau} → ${lop.thoiGianKetThuc}</td>
                                        <td>${lop.siSo}/${lop.siSoToiDa}</td>
                                        <td>${lop.ngayTao}</td>
                                        <td>${lop.ghiChu}</td>
                                        <td>
                                            <div class="action-buttons">
                                                <form action="StudentClassDetailServlet" method="get">
                                                    <input type="hidden" name="classCode" value="${lop.classCode}">
                                                    <button class="action-btn" type="submit">Chi tiết</button>
                                                </form>
                                                <form action="StudentRequestEnrollServlet" method="post">
                                                    <input type="hidden" name="classCode" value="${lop.classCode}">
                                                    <button class="action-btn enroll" type="submit">Đăng ký</button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                    <div id="pagination-lophoc"></div>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="no-data">Không có lớp học nào trong khóa học này.</div>
                    </c:otherwise>
                </c:choose>
                        
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
                        <!-- Java script phân trang -->            
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
