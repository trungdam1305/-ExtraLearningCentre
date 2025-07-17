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
        <title>Đăng ký học</title>

        <!-- 📚 CSS chính của hệ thống -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-style.css">

        <!-- 📚 Thư viện jQuery và phân trang -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-pagination.js@1.6/jquery.simplePagination.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simple-pagination.js@1.6/simplePagination.css">

        <!-- 🎨 Custom Style -->
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
                margin-right: 8px;
                vertical-align: middle;
            }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
        }
        th, td {
            padding: 12px 14px;
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
            box-shadow: 0 1px 4px rgba(0,0,0,0.05);
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
        <!-- Header -->
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
                <h2 style="margin: 0; color: white;">Đăng ký học</h2>
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
        <div class="main-content" style="padding: 30px;">       
            <!-- 🔍 FORM tìm kiếm và lọc -->
            <form method="get" style="display: flex; gap: 10px; flex-wrap: wrap; align-items: center; justify-content: flex-end; margin-bottom: 20px;">

                <!-- Filter theo khối từ dsKhoaHoc -->
                <c:set var="renderedKhois" value="," />
                <select name="khoi" style="padding: 8px; font-size: 14px;">
                    <option value="">-- Tất cả khối --</option>
                    <c:forEach var="khoa" items="${dsKhoaHoc}">
                        <c:if test="${not fn:contains(renderedKhois, ',' += khoa.tenKhoi += ',')}">
                            <option value="${khoa.tenKhoi}" ${param.khoi == khoa.tenKhoi ? 'selected' : ''}>${khoa.tenKhoi}</option>
                            <c:set var="renderedKhois" value="${renderedKhois}${khoa.tenKhoi}," />
                        </c:if>
                    </c:forEach>
                </select>

                <!-- Filter theo năm học (rút từ ngày bắt đầu) -->
                <c:set var="renderedYears" value="," />
                <select name="nam" style="padding: 8px; font-size: 14px;">
                    <option value="">-- Tất cả năm --</option>
                    <c:forEach var="khoa" items="${dsKhoaHoc}">
                        <c:set var="namBatDau" value="${fn:substring(khoa.thoiGianBatDau, 0, 4)}" />
                        <c:if test="${not fn:contains(renderedYears, ',' += namBatDau += ',')}">
                            <option value="${namBatDau}" ${param.nam == namBatDau ? 'selected' : ''}>${namBatDau}</option>
                            <c:set var="renderedYears" value="${renderedYears}${namBatDau}," />
                        </c:if>
                    </c:forEach>
                </select>

                <!-- Ô tìm kiếm -->
                <input id="searchInput" type="text" name="keyword" placeholder="Tìm kiếm..." value="${param.keyword}" style="padding: 8px; font-size: 14px; width: 250px;">

                <!-- Nút -->
                <button type="submit" class="action-btn">Tìm</button>
            </form>
                

            <!-- 📋 BẢNG DANH SÁCH KHÓA HỌC -->
            <c:choose>
                <c:when test="${not empty dsKhoaHoc}">
                    <table id="courseTable">
                        <thead>
                            <tr>
                                <th>STT</th>
                                <th>Tên khóa học</th>
                                <th>Mã khối</th>
                                <th>Tên Khối</th>
                                <th>Mô tả</th>
                                <th>Thời gian</th>
                                <th>Ghi chú</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody id="tableBody">
                            <c:forEach var="khoa" items="${dsKhoaHoc}" varStatus="loop">
                                <c:set var="namBatDau" value="${fn:substring(khoa.thoiGianBatDau, 0, 4)}" />
                                <c:if test="${(empty param.khoi or khoa.tenKhoi == param.khoi) 
                                    and (empty param.nam or namBatDau == param.nam)
                                    and (empty param.keyword 
                                        or fn:containsIgnoreCase(khoa.tenKhoaHoc, param.keyword)
                                        or fn:containsIgnoreCase(khoa.courseCode, param.keyword)
                                        or fn:containsIgnoreCase(khoa.tenKhoi, param.keyword)
                                        or fn:containsIgnoreCase(khoa.moTa, param.keyword)
                                        or fn:containsIgnoreCase(khoa.ghiChu, param.keyword)
                                        or fn:containsIgnoreCase(khoa.thoiGianBatDau, param.keyword)
                                        or fn:containsIgnoreCase(khoa.thoiGianKetThuc, param.keyword))
                                }">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td>${khoa.tenKhoaHoc}</td>
                                        <td>${khoa.courseCode}</td>
                                        <td>${khoa.tenKhoi}</td>
                                        <td>${khoa.moTa}</td>
                                        <td>${khoa.thoiGianBatDau} đến ${khoa.thoiGianKetThuc}</td>
                                        <td>${khoa.ghiChu}</td>
                                        <td>
                                            <form action="StudentViewLopTrongKhoaServlet" method="get">
                                                <input type="hidden" name="idKhoaHoc" value="${khoa.ID_KhoaHoc}">
                                                <button class="action-btn" type="submit">Xem lớp</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- Phân trang -->
                    <div id="pagination-container"></div>
                </c:when>
                <c:otherwise>
                    <div class="no-data">Không có khóa học nào đang mở để đăng ký.</div>
                </c:otherwise>
            </c:choose>
        

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
