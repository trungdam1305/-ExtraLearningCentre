<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Phê duyệt yêu cầu tư vấn</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f8fb;
        }

        /* SIDEBAR */
        .sidebar {
            width: 250px;
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            background-color: #1F4E79;
            color: white;
            padding: 20px;
            box-sizing: border-box;
        }

        .sidebar h4 {
            text-align: center;
            font-weight: bold;
        }

        .sidebar-logo {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 50%;
            margin: 15px auto;
            display: block;
            border: 3px solid #B0C4DE;
        }

        .sidebar-section-title {
            font-size: 14px;
            text-transform: uppercase;
            margin-top: 30px;
            border-bottom: 1px solid #B0C4DE;
            color: #B0C4DE;
            padding-bottom: 5px;
        }

        .sidebar-menu {
            list-style: none;
            padding: 0;
        }

        .sidebar-menu li a {
            display: block;
            color: white;
            padding: 8px 12px;
            text-decoration: none;
            border-radius: 5px;
            margin: 5px 0;
            transition: background-color 0.3s ease;
        }

        .sidebar-menu li a:hover {
            background-color: #163E5C;
        }

        /* HEADER */
        .header {
            margin-left: 250px;
            height: 60px;
            background-color: #1F4E79;
            color: white;
            padding: 0 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-sizing: border-box;
        }

        .left-title {
            font-size: 20px;
            font-weight: bold;
        }

        .admin-profile {
            display: flex;
            align-items: center;
            cursor: pointer;
            position: relative;
        }

        .admin-img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #B0C4DE;
            margin-right: 10px;
        }

        .admin-profile span {
            color: #B0C4DE;
            font-weight: 600;
        }

        .dropdown-menu {
            display: none;
            position: absolute;
            top: 60px;
            right: 0;
            background: #163E5C;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            min-width: 150px;
            z-index: 1001;
        }

        .dropdown-menu.active {
            display: block;
        }

        .dropdown-menu a {
            display: block;
            padding: 10px 15px;
            color: white;
            text-decoration: none;
            font-size: 14px;
        }

        .dropdown-menu a:hover {
            background-color: #1F4E79;
        }

        /* MAIN CONTENT */
        .main-content {
            margin-left: 250px;
            padding: 20px;
            min-height: calc(100vh - 120px); /* trừ header và footer */
            box-sizing: border-box;
        }

        h2 {
            color: #1F4E79;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px auto;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 10px 12px;
            border: 1px solid #d0d7de;
            text-align: center;
        }

        th {
            background-color: #1F4E79;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f0f4f8;
        }

        tr:hover {
            background-color: #d9e4f0;
        }

        .no-data {
            text-align: center;
            margin: 30px;
            color: red;
        }

        .back-button {
            text-align: center;
            margin-top: 30px;
        }

        .back-button a {
            background-color: #1F4E79;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
        }

        .back-button a:hover {
            background-color: #163b5c;
        }

        /* FOOTER */
        .footer {
            margin-left: 250px;
            height: 60px;
            background-color: #1F4E79;
            color: #B0C4DE;
            text-align: center;
            line-height: 60px;
        }
        .action-buttons {
    display: flex;
    flex-wrap: wrap;
    gap: 6px;
    justify-content: center;
    align-items: center;
}

.action-buttons form {
    display: inline-block;
}

.action-buttons button {
    padding: 6px 10px;
    background-color: #1F4E79;
    color: white;
    border: none;
    border-radius: 4px;
    font-size: 13px;
    cursor: pointer;
    transition: background-color 0.2s ease;
}

.action-buttons button:hover {
    background-color: #163e5c;
}

    </style>
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <h4>EL CENTRE</h4>
        <img src="${pageContext.request.contextPath}/img/SieuLogo-xoaphong.png" class="sidebar-logo" alt="Logo">
        
        <div class="sidebar-section-title">Tổng quan</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/adminGoToFirstPage">Dashboard</a></li>
        </ul>

        <div class="sidebar-section-title">Quản lý người dùng</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=hocsinh">Học sinh</a></li>
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=giaovien">Giáo viên</a></li>
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=taikhoan">Tài khoản</a></li>
        </ul>

        <div class="sidebar-section-title">Quản lý tài chính</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=hocphi">Học phí</a></li>
        </ul>

        <div class="sidebar-section-title">Quản lý học tập</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/ManageCourse">Khoá học</a></li>
            <li><a href="${pageContext.request.contextPath}/ManageSchedule">Lịch học</a></li>
        </ul>

        <div class="sidebar-section-title">Hệ thống</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/ManageSlider">Cài đặt HomePage</a></li>
        </ul>

        <div class="sidebar-section-title">Khác</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=yeucautuvan">Yêu cầu tư vấn</a></li>
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=thongbao">Thông báo</a></li>
            <li><a href="${pageContext.request.contextPath}/LogoutServlet">Logout</a></li>
        </ul>
    </div>

    <!-- Header -->
    <div class="header">
        <div class="left-title">Admin Dashboard</div>
        <div class="admin-profile" onclick="toggleDropdown()">
            <c:forEach var="ad" items="${admins}">
                <img src="${ad.avatar}" class="admin-img" alt="Admin">
                <span>${ad.hoTen}</span>
            </c:forEach>
            <i class="fas fa-caret-down"></i>
            <div class="dropdown-menu" id="adminDropdown">
                <a href="#"><i class="fas fa-key"></i> Đổi mật khẩu</a>
                <a href="#"><i class="fas fa-user-edit"></i> Cập nhật thông tin</a>
            </div>
        </div>
    </div>

    <!-- Main content -->
    <div class="main-content">
    <h2>Danh sách yêu cầu tư vấn</h2>

        <%-- Thông báo thành công/thất bại --%>
        <%
            String successMessage = (String) session.getAttribute("successMessage");
            String errorMessage = (String) session.getAttribute("errorMessage");
            if (successMessage != null) {
        %>
            <div style="color: green; text-align: center; font-weight: bold;"><%= successMessage %></div>
        <%
                session.removeAttribute("successMessage");
            } else if (errorMessage != null) {
        %>
            <div style="color: red; text-align: center; font-weight: bold;"><%= errorMessage %></div>
        <%
                session.removeAttribute("errorMessage");
            }
        %>

        <c:choose>
            <c:when test="${not empty requestScope.listTuVan}">


                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Họ tên</th>
                            <th>Email</th>
                            <th>SĐT</th>
                            <th>Nội dung tư vấn</th>
                            <th>Thời gian</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="tb" items="${requestScope.listTuVan}">
                            <tr>
                                <td>${tb.ID_ThongBao}</td>
                                <td>${tb.hoTen}</td>
                                <td>${tb.email}</td>
                                <td>${tb.soDienThoai}</td>
                                <td>${tb.noiDungTuVan}</td>
                                <td>${tb.thoiGian}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty tb.status}">${tb.status}</c:when>
                                        <c:otherwise>Chưa đọc</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <!-- Gửi email kết quả tư vấn -->
                                    <form action="${pageContext.request.contextPath}/views/sendAdviceMail.jsp" method="get" style="display:inline;">
                                        <input type="hidden" name="id" value="${tb.ID_ThongBao}" />
                                        <button type="submit">Gửi email kết quả tư vấn</button>
                                    </form>

                                    <!-- Tạo tài khoản trạng thái Pending -->
                                    <form action="${pageContext.request.contextPath}/adminActionWithAdvice" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="createPendingAccount" />
                                        <input type="hidden" name="email" value="${tb.email}" />
                                        <input type="hidden" name="sdt" value="${tb.soDienThoai}" />
                                        <input type="hidden" name="hoTen" value="${tb.hoTen}" />
                                        <button type="submit">Tạo tài khoản</button>
                                    </form>

                                    <!-- Cập nhật nội dung tư vấn -->
                                    <form action="${pageContext.request.contextPath}/adminActionWithAdvice" method="get" style="display:inline;">
                                        <input type="hidden" name="action" value="update" />
                                        <input type="hidden" name="id" value="${tb.ID_ThongBao}" />
                                        <button type="submit">Cập nhật tư vấn</button>
                                    </form>

                                    <!-- Xoá tư vấn -->
                                    <form action="${pageContext.request.contextPath}/adminActionWithAdvice" method="post" style="display:inline;" onsubmit="return confirm('Bạn có chắc muốn xoá yêu cầu tư vấn này?');">
                                        <input type="hidden" name="action" value="delete" />
                                        <input type="hidden" name="id" value="${tb.ID_ThongBao}" />
                                        <button type="submit">Xoá</button>
                                    </form>

                                    <!-- Cập nhật trạng thái -->
                                    <form action="${pageContext.request.contextPath}/adminActionWithAdvice" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="markRead" />
                                        <input type="hidden" name="id" value="${tb.ID_ThongBao}" />
                                        <button type="submit">Cập nhật trạng thái</button>
                                    </form>
                                </td>    
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="no-data">Không có yêu cầu tư vấn nào.</div>
            </c:otherwise>
        </c:choose>

        <div class="back-button">
            <a href="${pageContext.request.contextPath}/views/admin/adminDashboard.jsp">Quay lại trang chủ</a>
        </div>
    </div>


    <!-- Footer -->
    <div class="footer">
        &copy; 2025 EL CENTRE. All rights reserved. | Developed by EL CENTRE
    </div>

    <script>
        function toggleDropdown() {
            document.getElementById('adminDropdown').classList.toggle('active');
        }

        document.addEventListener('click', function (event) {
            const profile = document.querySelector('.admin-profile');
            const dropdown = document.getElementById('adminDropdown');
            if (!profile.contains(event.target)) {
                dropdown.classList.remove('active');
            }
        });
    </script>

</body>
</html>
