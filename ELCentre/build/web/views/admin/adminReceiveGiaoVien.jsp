<%-- 
    Document   : adminReceiveGiaoVien
    Created on : May 29, 2025, 16:22:36 PM
    Author     : chuvv
    Purpose    : This page displays a list of all teachers (giáo viên) in the EL CENTRE system, including details like name, specialization, 
                 contact info, salary, and status. It supports filtering by specialization, searching, and pagination, 
                 with action links for viewing details, managing classes, and editing teacher records.
    Parameters:
    - Parameters:(Handle from adminGetFromDashboard servlet)
    - Method to get data from database in GiaoVienDAO - admminGetAllGiaoVien
    - @Param giaoviens (ArrayList<GiaoVien>): A request attribute containing the list of teacher objects fetched from the database.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="dal.AdminDAO" %>
<%@ page import="model.Admin" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <title>Quản lý giáo viên</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            :root {
                --main-color: #1F4E79;
                --hover-color: #163E5C;
                --accent-color: #B0C4DE;
                --bg-color: #f4f6f8;
                --text-color: #333;
            }

            body {
                margin: 0;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: var(--bg-color);
            }

            .header {
                background-color: var(--main-color);
                color: white;
                padding: 12px 24px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                position: fixed;
                top: 0;
                left: 250px;
                right: 0;
                z-index: 1000;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            }

            .header .left-title {
                font-size: 20px;
                font-weight: 600;
            }

            .admin-profile {
                display: flex;
                align-items: center;
                position: relative;
                cursor: pointer;
            }

            .admin-img {
                width: 36px;
                height: 36px;
                border-radius: 50%;
                border: 2px solid var(--accent-color);
                margin-right: 10px;
            }

            .admin-profile span {
                color: var(--accent-color);
                font-weight: 600;
                max-width: 180px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .admin-profile i {
                color: var(--accent-color);
                margin-left: 8px;
            }

            .dropdown-menu {
                position: absolute;
                top: 48px;
                right: 0;
                background-color: var(--hover-color);
                display: none;
                border-radius: 4px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.15);
                min-width: 160px;
                z-index: 1001;
            }

            .dropdown-menu.active {
                display: block;
            }

            .dropdown-menu a {
                display: block;
                color: white;
                padding: 10px 15px;
                font-size: 14px;
                text-decoration: none;
            }

            .dropdown-menu a:hover {
                background-color: var(--main-color);
            }

            .sidebar {
                width: 250px;
                background-color: var(--main-color);
                color: white;
                position: fixed;
                height: 100vh;
                padding: 20px;
                box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            }

            .sidebar h4 {
                text-align: center;
                font-weight: bold;
            }

            .sidebar-logo {
                display: block;
                margin: 15px auto;
                width: 90px;
                height: 90px;
                border-radius: 50%;
                border: 2px solid var(--accent-color);
                object-fit: cover;
            }

            .sidebar-section-title {
                margin-top: 25px;
                font-size: 13px;
                color: var(--accent-color);
                text-transform: uppercase;
                border-bottom: 1px solid var(--accent-color);
                padding-bottom: 5px;
            }

            .sidebar-menu {
                list-style: none;
                padding: 0;
                margin: 10px 0;
            }

            .sidebar-menu li {
                margin: 8px 0;
            }

            .sidebar-menu a {
                display: flex;
                align-items: center;
                color: white;
                text-decoration: none;
                padding: 8px 12px;
                border-radius: 4px;
                transition: background-color 0.3s;
            }

            .sidebar-menu a:hover {
                background-color: var(--hover-color);
            }

            .sidebar-menu a i {
                margin-right: 10px;
            }

            .main-content {
                margin-left: 250px;
                padding: 100px 40px 60px;
                background-color: var(--bg-color);
                min-height: 100vh;
                box-sizing: border-box;
            }

            .page-header {
                display: flex;
                justify-content: center;
                margin-bottom: 20px;
            }

            .page-header h2 {
                font-size: 24px;
                color: var(--main-color);
                display: flex;
                align-items: center;
                gap: 10px;
                margin: 0;
            }

            .filter-bar {
                display: flex;
                justify-content: flex-end; /* Đẩy sang phải */
                flex-wrap: wrap;
                gap: 20px;
                margin-bottom: 20px;
                align-items: center;
            }

            .filter-group {
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .filter-group label {
                font-weight: 600;
                font-size: 14px;
                color: #333;
            }

            .filter-group input[type="text"],
            .filter-group select {
                padding: 8px 12px;
                font-size: 14px;
                border: 1px solid #ccc;
                border-radius: 6px;
            }

            .filter-group input[type="text"] {
                min-width: 250px;
                flex-grow: 1;
            }

            .filter-bar button {
                padding: 8px 14px;
                background-color: var(--main-color);
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 14px;
            }


            table {
                width: 100%;
                border-collapse: collapse;
                font-size: 14px;
                background-color: white;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
                border-radius: 10px;
                overflow: hidden;
            }

            table th, table td {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: center;
            }

            table th {
                background-color: #e2eaf0;
                color: var(--main-color);
                font-weight: 600;
            }

            .status-badge {
                padding: 4px 10px;
                border-radius: 20px;
                font-size: 13px;
                font-weight: bold;
                text-transform: uppercase;
                display: inline-block;
                min-width: 80px;
                text-align: center;
            }

            .status-badge.active {
                background-color: #d4f4dd;
                color: #2ecc71;
                border: 1px solid #2ecc71;
            }

            

            .status-badge.finished {
                background-color: #e0e0e0;
                color: #7f8c8d;
                border: 1px solid #7f8c8d;
            }

            .status-badge.inactive {
                background-color: #fce1e1;
                color: #e74c3c;
                border: 1px solid #e74c3c;
            }
            .action-buttons {
                display: flex;
                justify-content: center;
                gap: 8px;
                flex-wrap: wrap;
            }

            .btn-action {
                padding: 6px 12px;
                border: none;
                border-radius: 5px;
                font-size: 13px;
                cursor: pointer;
                text-decoration: none;
                font-weight: 600;
                transition: background-color 0.2s;
            }

            .btn-action.view {
                background-color: #3498db;
                color: white;
            }

            .btn-action.update {
                background-color: #f39c12;
                color: white;
            }

            .btn-action.enable {
                background-color: #2ecc71;
                color: white;
            }

            .btn-action:hover {
                opacity: 0.85;
            }

            .no-data {
                text-align: center;
                color: red;
                font-weight: 600;
                margin: 20px 0;
            }

            #pagination {
                margin-top: 20px;
                text-align: center;
            }

            #pagination button {
                margin: 0 4px;
                padding: 6px 10px;
                border: none;
                border-radius: 4px;
                background-color: #ddd;
                cursor: pointer;
                font-size: 14px;
            }

            #pagination button.active {
                background-color: var(--main-color);
                color: white;
            }

            .back-button {
                text-align: right;
                margin-top: 20px;
            }

            .back-button a {
                text-decoration: none;
                color: var(--main-color);
                font-weight: 600;
            }

            .footer {
                background-color: var(--main-color);
                color: var(--accent-color);
                text-align: center;
                padding: 10px;
                font-size: 13px;
                position: fixed;
                bottom: 0;
                left: 250px;
                right: 0;
            }

            .data-table-wrapper {
                background-color: #ffffff;
                padding: 20px 25px;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
                margin-top: 20px;
            }

        </style>
    </head>
    <body>
        <div class="header">
            <div class="left-title">
                Quản lý giáo viên <i class="fas fa-chalkboard-teacher"></i>
            </div>
            <div class="admin-profile" onclick="toggleDropdown()">
                <%
                      ArrayList<Admin> admins  = (ArrayList) AdminDAO.getNameAdmin();
                      
                %>
                <img src="<%= admins.get(0).getAvatar() %>" alt="Admin Photo" class="admin-img">
                <span><%= admins.get(0).getHoTen() %></span>
                <i class="fas fa-caret-down"></i>
                <div class="dropdown-menu" id="adminDropdown">
                    <a href="#"><i class="fas fa-key"></i> Change Password</a>
                    <a href="#"><i class="fas fa-user-edit"></i> Update Information</a>
                </div>
            </div>
        </div>

        <div class="sidebar">
            <h4>EL CENTRE</h4>
            <img src="<%= request.getContextPath() %>/img/SieuLogo-xoaphong.png" alt="Center Logo" class="sidebar-logo">
            <div class="sidebar-section-title">Tổng quan</div>
            <ul class="sidebar-menu">
                 <li><a href="${pageContext.request.contextPath}/adminGoToFirstPage"><i class="fas fa-chart-line"></i> Dashboard</a></li>
                
            </ul>

            <div class="sidebar-section-title">Quản lý người dùng</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=hocsinh">Học sinh</a></li>
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=giaovien">Giáo viên</a></li>
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=taikhoan">Tài khoản</a></li>
            </ul>

            <div class="sidebar-section-title">Quản lý tài chính</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=hocphi"><i class="fas fa-money-bill-wave"></i> Học phí</a></li>
            </ul>

            <div class="sidebar-section-title">Quản lý học tập</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/ManageCourse"><i class="fas fa-book"></i> Khoá học</a></li>
            </ul>

            <div class="sidebar-section-title">Hệ thống</div>
            <ul class="sidebar-menu">
                <li><a href="#"><i class="fas fa-cog"></i> Cài đặt</a></li>
            </ul>

            <div class="sidebar-section-title">Khác</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=yeucautuvan"><i class="fas fa-blog"></i>Yêu cầu tư vấn</a></li>
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=thongbao"><i class="fas fa-bell"></i> Thông báo</a></li>
                <li><a href="#"><i class="fas fa-blog"></i> Blog</a></li>
                <li><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </div>

        <div class="main-content">
            <c:if test="${not empty message}">
                <div style="color: red; font-weight: bold; margin-bottom: 15px; text-align: center;">
                    ${message}
                </div>
            </c:if>
            <div class="page-header">
                <h2><i class="fas fa-chalkboard-teacher"></i> Tất cả giáo viên</h2>
            </div>

            <form  action="${pageContext.request.contextPath}/adminFindInFilterGroup" method="post">
                <div class="filter-bar">
                    <div class="filter-group">
                        <label for="keyword">Từ khóa:</label>
                        <input type="text" id="keyword" name="keyword" placeholder="Tìm kiếm...">
                    </div>
                    <div class="filter-group">
                        <label for="chuyenmon">Chuyên môn</label>
                        <select id="chuyenmon" name="chuyenmon">
                            <option value="">Tất cả</option>
                            <option value="Toán">Toán</option>
                            <option value="Lý">Lý</option>
                            <option value="Hóa">Hóa</option>
                        </select>
                    </div>
                    <div class="filter-group">
                        <label for="trangthaiday">Trạng thái dạy</label>
                        <select id="trangthaiday" name="trangthaiday">
                            <option value="">Tất cả</option>
                            <option value="Đang dạy">Đang dạy</option>
                            <option value="Chờ dạy">Chưa lớp</option>
                            <option value="Đã dạy">Đã dạy</option>
                        </select>
                    </div>
                    <button><i class="fas fa-search"></i></button>
                </div>
            </form>


            <c:choose>
                <c:when test="${not empty sessionScope.giaoviens}">
                    <div class="data-table-wrapper">
                        <table>
                            <thead>
                                <tr>
                                    <th>ID Giáo viên</th>
                                    <th>Họ và Tên</th>
                                    <th>Chuyên Môn</th>
                                    <th>Số điện thoại</th>
                                    <th>Trường đang dạy</th>
                                    <th>Lớp đang dạy trên trường</th>

                                    <th>Trạng thái dạy tại EL CENTRE</th>

                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody id="teacherTableBody">
                                <c:forEach var="giaovien" items="${sessionScope.giaoviens}">
                                    <tr>
                                        <td>${giaovien.getID_GiaoVien()}</td>
                                        <td>${giaovien.getHoTen()}</td>
                                        <td>${giaovien.getChuyenMon()}</td>
                                        <td>${giaovien.getSDT()}</td>
                                        <td>${giaovien.getTenTruongHoc()}</td>
                                        <td>${giaovien.getLopDangDayTrenTruong()}</td>

                                        <td>
                                            <span class="status-badge
                                                  ${giaovien.trangThaiDay == 'Đang dạy' ? 'active' :
                                                    giaovien.trangThaiDay == 'Chờ dạy' ? 'waiting' :
                                                    giaovien.trangThaiDay == 'Đã dạy' ? 'finished' : 'inactive'}">
                                                      ${giaovien.trangThaiDay}
                                                  </span>
                                            </td>




                                            <td class="action-buttons">
                                                <a class="btn-action view" title="Chi tiết thông tin và chỉnh sửa thông tin" href="${pageContext.request.contextPath}/adminActionWithTeacher?action=view&id=${giaovien.getID_GiaoVien()}&idTaiKhoan=${giaovien.getID_TaiKhoan()}">
                                                    <i class="fas fa-user-edit"></i> Chi tiết và chỉnh sửa
                                                </a>
                                                <a class="btn-action update" title="Xem lớp đang dạy của giáo viên và chuyển lớp" href="${pageContext.request.contextPath}/adminActionWithTeacher?action=viewLopHocGiaoVien&id=${giaovien.getID_GiaoVien()}">
                                                   <i class="fas fa-chalkboard-teacher"></i> Xem lớp & Chuyển lớp
                                                </a>

                                                <a class="btn-action enable" title="Gửi thông báo" href="${pageContext.request.contextPath}/views/admin/adminSendNotificationTeacher.jsp?idtaikhoan=${giaovien.getID_TaiKhoan()}">
                                                    <i class="fas fa-bell"></i> Gửi thông báo
                                                
                                            </td>
                                        </tr>   
                                    </c:forEach>
                                </tbody>
                            </table>    
                        </c:when>
                        <c:otherwise>   
                            <div class="no-data">
                                <c:if test="${not empty message}">
                                    <p style="color: red;">${message}</p>
                                </c:if>
                                <p>Không có dữ liệu giáo viên để hiển thị.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <div id="pagination" style="text-align:center; margin-top: 20px;"></div>
                </div>
                <div class="back-button">
                    <a href="${pageContext.request.contextPath}/adminGoToFirstPage">← Quay lại trang chủ</a>
                    
                </div>
            </div>

            <!-- Footer -->
            <div class="footer">
                <p>© 2025 EL CENTRE. All rights reserved. | Developed by wrx_Chur04</p>
            </div>

            <script>
                function toggleDropdown() {
                    const dropdown = document.getElementById('adminDropdown');
                    dropdown.classList.toggle('active');
                }

                document.addEventListener('click', function (event) {
                    const profile = document.querySelector('.admin-profile');
                    const dropdown = document.getElementById('adminDropdown');
                    if (!profile.contains(event.target)) {
                        dropdown.classList.remove('active');
                    }
                });
                const tableBody = document.getElementById("teacherTableBody");
                let allRows = [], filteredRows = [], currentPage = 1;
                const rowsPerPage = 12;

                window.onload = () => {
                    allRows = Array.from(tableBody.querySelectorAll("tr"));
                    filteredRows = [...allRows];
                    renderPage();
                };

                function renderPage() {
                    tableBody.innerHTML = "";
                    const start = (currentPage - 1) * rowsPerPage;
                    const end = start + rowsPerPage;
                    filteredRows.slice(start, end).forEach(row => tableBody.appendChild(row));
                    renderPagination();
                }

                function renderPagination() {
                    const totalPages = Math.ceil(filteredRows.length / rowsPerPage);
                    const pagination = document.getElementById("pagination");
                    pagination.innerHTML = "";

                    const maxPagesToShow = 3;
                    let startPage = Math.max(1, currentPage - 1);
                    let endPage = Math.min(totalPages, startPage + maxPagesToShow - 1);


                    if (endPage - startPage + 1 < maxPagesToShow) {
                        startPage = Math.max(1, endPage - maxPagesToShow + 1);
                    }


                    if (currentPage > 1) {
                        const prevBtn = document.createElement("button");
                        prevBtn.textContent = "«";
                        prevBtn.onclick = () => {
                            currentPage--;
                            renderPage();
                        };
                        pagination.appendChild(prevBtn);
                    }


                    for (let i = startPage; i <= endPage; i++) {
                        const btn = document.createElement("button");
                        btn.textContent = i;
                        btn.style.backgroundColor = (i === currentPage) ? "#1F4E79" : "#ddd";
                        btn.style.color = (i === currentPage) ? "white" : "black";
                        btn.onclick = () => {
                            currentPage = i;
                            renderPage();
                        };
                        pagination.appendChild(btn);
                    }


                    if (currentPage < totalPages) {
                        const nextBtn = document.createElement("button");
                        nextBtn.textContent = "»";
                        nextBtn.onclick = () => {
                            currentPage++;
                            renderPage();
                        };
                        pagination.appendChild(nextBtn);
                    }
                }
            </script>

        </body>
    </html>