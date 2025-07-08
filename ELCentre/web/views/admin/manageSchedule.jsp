    <%-- 
        Document   : manageSchedule
        Created on : July 8, 2025, 11:00:00 PM
        Author     : Vuh26
    --%>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <%@ page import="java.util.*, java.text.*, java.util.UUID, dal.AdminDAO, model.Admin" %>
    <!DOCTYPE html>
    <html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản Lý Lịch Học</title>
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Font Awesome for additional icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <style>
            * {
                box-sizing: border-box;
            }
            body {
                margin: 0;
                padding: 0;
                background-color: #f4f6f9;
            }

            /* General container styling */
            .content-container {
                padding: 6px;
                max-width: 100%;
                margin: 0 auto;
                margin-left: 160px;
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                margin-top: 60px;
                padding-bottom: 40px;
            }

            /* Header styling */
            .header {
                background-color: #1F4E79;
                color: white;
                padding: 4px 8px;
                text-align: left;
                position: fixed;
                width: calc(100% - 160px);
                left: 160px;
                right: 0;
                top: 0;
                z-index: 1000;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            .header .left-title {
                font-size: 0.83rem;
                letter-spacing: 1px;
                display: flex;
                align-items: center;
            }
            .header .left-title i {
                margin-right: 8px;
            }

            /* Footer styling */
            .footer {
                background-color: #1F4E79;
                color: #B0C4DE;
                text-align: center;
                padding: 3px 0;
                position: fixed;
                width: calc(100% - 160px);
                left: 160px;
                right: 0;
                bottom: 0;
                z-index: 1000;
            }
            .footer p {
                margin: 0;
                font-size: 0.5rem;
            }

            /* Sidebar styling */
            .sidebar {
                width: 160px;
                background-color: #1F4E79;
                color: white;
                padding: 6px;
                box-shadow: 2px 0 5px rgba(0,0,0,0.1);
                display: flex;
                flex-direction: column;
                height: 100vh;
                position: fixed;
                left: 0;
                top: 0;
                z-index: 1001;
            }
            .sidebar h4 {
                margin: 0 auto;
                font-weight: bold;
                letter-spacing: 1.5px;
                text-align: center;
                font-size: 0.9rem;
            }
            .sidebar-logo {
                width: 60px;
                height: 60px;
                border-radius: 50%;
                object-fit: cover;
                margin: 5px auto;
                display: block;
                border: 3px solid #B0C4DE;
            }
            .sidebar-section-title {
                font-weight: bold;
                margin-top: 15px;
                font-size: 11px;
                text-transform: uppercase;
                color: #B0C4DE;
                border-bottom: 1px solid #B0C4DE;
                padding-bottom: 3px;
            }
            ul.sidebar-menu {
                list-style: none;
                padding-left: 0;
                margin: 4px 0 0 0;
            }
            ul.sidebar-menu li {
                margin: 4px 0;
            }
            ul.sidebar-menu li a {
                color: white;
                text-decoration: none;
                padding: 4px 6px;
                display: flex;
                align-items: center;
                border-radius: 5px;
                font-size: 0.75rem;
                transition: background-color 0.3s ease;
            }
            ul.sidebar-menu li a:hover {
                background-color: #163E5C;
            }
            ul.sidebar-menu li a i {
                margin-right: 5px;
            }

            /* Calendar styling */
            h2 {
                text-align: center;
                color: #003087;
                margin-bottom: 15px;
                font-size: 1.07rem;
                font-weight: 600;
            }
            .calendar-table {
                width: 98%;
                max-width: 1400px; /* Tăng chiều rộng bảng */
                margin: 0 auto;
                border-collapse: collapse;
                font-size: 0.58rem;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            }
            .calendar-table th, .calendar-table td {
                border: 1px solid #dee2e6;
                text-align: center;
                padding: 8px;
                vertical-align: top;
                width: 14.2857%; /* Độ rộng cố định cho 7 cột (100% / 7) */
            }
            .calendar-table th {
                background-color: #2196F3;
                color: black;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 0.6rem;
                height: 30px; /* Giảm chiều cao hàng tiêu đề */
            }
            .calendar-table td {
                height: 100px;
            }
            .has-schedule {
                background-color: #d4edda !important;
            }
            .no-schedule {
                background-color: #ffffff;
            }
            .today {
                border: 2px solid #007bff;
                background-color: #e6f0fa;
            }
            .btn-view {
                background-color: #17a2b8;
                border-color: #17a2b8;
                color: white;
                font-size: 0.5rem;
                padding: 3px 5px;
                border-radius: 6px;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }
            .btn-view:hover {
                background-color: #117a8b;
                border-color: #117a8b;
                transform: translateY(-2px);
            }
            .btn-view i {
                margin-right: 4px;
            }
            .btn-custom-action {
                background-color: #003087;
                border-color: #003087;
                color: white;
                border-radius: 6px;
                padding: 6px 12px;
                font-size: 0.58rem;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }
            .btn-custom-action:hover {
                background-color: #00215a;
                border-color: #00215a;
                transform: translateY(-2px);
            }
            .btn-custom-action i {
                margin-right: 4px;
            }
            .btn-secondary {
                background-color: #6b7280;
                border-color: #6b7280;
                color: white;
                border-radius: 6px;
                padding: 4px 8px;
                font-size: 0.57rem;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }
            .btn-secondary:hover {
                background-color: #4b5563;
                border-color: #4b5563;
                transform: translateY(-2px);
            }
            .modal-content {
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }
            .modal-header {
                background-color: #003087;
                color: white;
                border-top-left-radius: 8px;
                border-top-right-radius: 8px;
            }
            .modal-header h5 {
                font-size: 0.8rem;
            }
            .modal-body {
                max-height: 400px;
                overflow-y: auto;
                font-size: 0.58rem;
            }
            .modal-body table {
                font-size: 0.58rem;
            }
            .modal-footer .btn {
                font-size: 0.57rem;
            }
            .form-container {
                max-width: 600px;
                margin: 0 auto;
                padding: 16px;
            }
            .form-container .form-select,
            .form-container .form-control {
                border-radius: 8px;
                border: 1px solid #ced4da;
                box-shadow: none;
                transition: border-color 0.3s ease;
                height: 28px;
                font-size: 0.57rem;
            }
            .form-container .form-select:focus,
            .form-container .form-control:focus {
                border-color: #003087;
                box-shadow: 0 0 5px rgba(0, 48, 135, 0.3);
            }
            .alert-custom-success {
                background-color: #22c55e;
                border-color: #22c55e;
                color: white;
                border-radius: 8px;
                padding: 8px;
                margin-bottom: 10px;
                font-size: 0.57rem;
                text-align: center;
            }
            .alert-custom-danger {
                background-color: #ef4444;
                border-color: #ef4444;
                color: white;
                border-radius: 8px;
                padding: 8px;
                margin-bottom: 10px;
                font-size: 0.57rem;
                text-align: center;
            }

            /* Scroll to Top Button */
            #scrollToTopBtn {
                display: none;
                position: fixed;
                bottom: 15px;
                right: 15px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 50%;
                width: 40px;
                height: 40px;
                font-size: 14px;
                cursor: pointer;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
                z-index: 1000;
                transition: background-color 0.3s ease;
            }
            #scrollToTopBtn:hover {
                background-color: #0056b3;
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .content-container {
                    padding: 8px;
                    margin: 5px;
                    margin-left: 0;
                    margin-top: 50px;
                    padding-bottom: 30px;
                }
                h2 {
                    font-size: 0.8rem;
                }
                .form-container {
                    max-width: 100%;
                    padding: 12px;
                }
                .form-container .form-select,
                .form-container .form-control {
                    font-size: 0.38rem;
                    height: 26px;
                }
                .calendar-table {
                    font-size: 0.5rem;
                }
                .calendar-table th, .calendar-table td {
                    padding: 5px;
                    height: 80px;
                    width: 14.2857%; /* Giữ độ rộng cố định */
                }
                .calendar-table th {
                    font-size: 0.5rem;
                    height: 25px; /* Giảm chiều cao hàng tiêu đề trên mobile */
                }
                .btn-view {
                    font-size: 0.48rem;
                    padding: 2px 4px;
                }
                .btn-custom-action {
                    font-size: 0.38rem;
                    padding: 4px 8px;
                }
                .btn-secondary {
                    font-size: 0.38rem;
                    padding: 3px 6px;
                }
                .modal-header h5 {
                    font-size: 0.7rem;
                }
                .modal-body {
                    font-size: 0.5rem;
                }
                .modal-body table {
                    font-size: 0.5rem;
                }
                .modal-footer .btn {
                    font-size: 0.38rem;
                }
                .alert-custom-success,
                .alert-custom-danger {
                    font-size: 0.38rem;
                    padding: 6px;
                    margin-bottom: 8px;
                }
                #scrollToTopBtn {
                    bottom: 8px;
                    right: 8px;
                    width: 30px;
                    height: 30px;
                    font-size: 12px;
                }
                .sidebar {
                    width: 100%;
                    height: auto;
                    position: relative;
                    box-shadow: none;
                    padding: 5px;
                }
                .header, .footer {
                    width: 100%;
                    margin-left: 0;
                    left: 0;
                    right: 0;
                }
                .sidebar h4 {
                    font-size: 0.85rem;
                }
                .sidebar-logo {
                    width: 50px;
                    height: 50px;
                    margin: 5px auto;
                }
                .sidebar-section-title {
                    margin-top: 12px;
                    font-size: 10px;
                    padding-bottom: 3px;
                }
                ul.sidebar-menu {
                    margin: 4px 0 0 0;
                }
                ul.sidebar-menu li {
                    margin: 4px 0;
                }
                ul.sidebar-menu li a {
                    padding: 3px 5px;
                    font-size: 0.7rem;
                }
                ul.sidebar-menu li a i {
                    margin-right: 5px;
                }
            }
        </style>
    </head>
    <body>
        <!-- Tạo CSRF token nếu chưa tồn tại -->
        <c:if test="${empty sessionScope.csrfToken}">
            <% 
                String csrfToken = UUID.randomUUID().toString();
                session.setAttribute("csrfToken", csrfToken);
            %>
        </c:if>

        <div class="header">
            <div class="left-title">
                Admin Dashboard <i class="fas fa-tachometer-alt"></i>
            </div>
            <div class="admin-profile" onclick="toggleDropdown()">
                <%
                    ArrayList<Admin> admins = (ArrayList) AdminDAO.getNameAdmin();
                    String adminAvatar = admins != null && !admins.isEmpty() ? admins.get(0).getAvatar() : "/img/default-avatar.png";
                    String adminName = admins != null && !admins.isEmpty() ? admins.get(0).getHoTen() : "Admin";
                %>
                <img src="<%= request.getContextPath() + adminAvatar %>" alt="Admin Photo" class="admin-img">
                <span><%= adminName %></span>
                <i class="fas fa-caret-down"></i>
                <div class="dropdown-menu" id="adminDropdown">
                    <a href="#"><i class="fas fa-key"></i> Đổi mật khẩu</a>
                    <a href="#"><i class="fas fa-user-edit"></i> Cập nhật thông tin</a>
                </div>
            </div>
        </div>

        <div class="sidebar">
            <h4>EL CENTRE</h4>
            <img src="<%= request.getContextPath() %>/img/SieuLogo-xoaphong.png" alt="Center Logo" class="sidebar-logo">
            <div class="sidebar-section-title">Tổng quan</div>
            <ul class="sidebar-menu">
                <li><a href="#"><i class="fas fa-chart-line"></i> Dashboard</a></li>
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
                <li><a href="${pageContext.request.contextPath}/ManageCourse"><i class="fas fa-calendar-alt"></i> Lịch học</a></li>
            </ul>
            <div class="sidebar-section-title">Hệ thống</div>
            <ul class="sidebar-menu">
                <li><a href="#"><i class="fas fa-cog"></i> Cài đặt</a></li>
            </ul>
            <div class="sidebar-section-title">Khác</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=yeucautuvan"><i class="fas fa-blog"></i> Yêu cầu tư vấn</a></li>
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=thongbao"><i class="fas fa-bell"></i> Thông báo</a></li>
                <li><a href="#"><i class="fas fa-blog"></i> Blog</a></li>
                <li><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </div>

        <div class="content-container">
            <div class="form-container">
                <h2>Lịch Học Tháng ${month}/${year}</h2>

                <!-- Thông báo -->
                <c:if test="${not empty err}">
                    <div class="alert alert-custom-danger">${fn:escapeXml(err)}</div>
                </c:if>
                <c:if test="${not empty suc}">
                    <div class="alert alert-custom-success">${fn:escapeXml(suc)}</div>
                </c:if>

                <form method="get" action="${pageContext.request.contextPath}/ManageSchedule" class="mb-4">
                    <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
                    <div class="row g-2 align-items-end">
                        <div class="col-md-3">
                            <label for="month" class="form-label">Tháng:</label>
                            <select name="month" id="month" class="form-select" onchange="this.form.submit()">
                                <c:forEach var="m" begin="1" end="12">
                                    <option value="${m}" ${month == m ? 'selected' : ''}>${m}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label for="year" class="form-label">Năm:</label>
                            <select name="year" id="year" class="form-select" onchange="this.form.submit()">
                                <c:forEach var="y" begin="${currentYear - 5}" end="${currentYear + 5}">
                                    <option value="${y}" ${year == y ? 'selected' : ''}>${y}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <button type="submit" class="btn btn-custom-action"><i class="bi bi-search"></i> Xem Lịch</button>
                        </div>
                    </div>
                </form>

                <!-- Tạo lịch -->
                <%
                    int m = (Integer) request.getAttribute("month");
                    int y = (Integer) request.getAttribute("year");
                    Calendar cal = new GregorianCalendar(y, m - 1, 1);
                    int daysInMonth = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
                    int firstDayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
                    if (firstDayOfWeek == Calendar.SUNDAY) firstDayOfWeek = 7;
                    else firstDayOfWeek--;

                    int today = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
                    int currentMonth = Calendar.getInstance().get(Calendar.MONTH) + 1;
                    int currentYear = Calendar.getInstance().get(Calendar.YEAR);
                    Set<Integer> scheduleDays = (Set<Integer>) request.getAttribute("scheduleDays");
                %>

                <table class="calendar-table table">
                    <thead>
                    <tr>
                        <th>Thứ Hai</th>
                        <th>Thứ Ba</th>
                        <th>Thứ Tư</th>
                        <th>Thứ Năm</th>
                        <th>Thứ Sáu</th>
                        <th>Thứ Bảy</th>
                        <th>Chủ Nhật</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        int day = 1;
                        boolean started = false;
                        for (int week = 0; week < 6 && day <= daysInMonth; week++) {
                    %>
                    <tr>
                        <%
                            for (int dow = 1; dow <= 7; dow++) {
                                if (!started && dow == firstDayOfWeek) started = true;
                                if (started && day <= daysInMonth) {
                                    boolean hasSchedule = scheduleDays != null && scheduleDays.contains(day);
                                    boolean isToday = (day == today && m == currentMonth && y == currentYear);
                        %>
                        <td class="<%= hasSchedule ? "has-schedule" : "no-schedule" %> <%= isToday ? "today" : "" %>">
                            <div><%= day %></div>
                            <% if (hasSchedule) { %>
                                <button type="button" class="btn btn-view"
                                        data-bs-toggle="modal"
                                        data-bs-target="#scheduleModal"
                                        data-day="<%= day %>"><i class="bi bi-eye"></i> Xem Lớp</button>
                            <% } %>
                        </td>
                        <%
                                    day++;
                                } else {
                        %>
                        <td class="no-schedule"></td>
                        <%
                                }
                            }
                        %>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>

                <!-- Modal -->
                <div class="modal fade" id="scheduleModal" tabindex="-1" aria-labelledby="scheduleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="scheduleModalLabel">Lịch Học Ngày <span id="modalDay"></span></h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                            </div>
                            <div class="modal-body">
                                <table class="table table-striped">
                                    <thead>
                                    <tr>
                                        <th>Lớp</th>
                                        <th>Phòng</th>
                                        <th>Thời Gian</th>
                                        <th>Ghi Chú</th>
                                    </tr>
                                    </thead>
                                    <tbody id="scheduleTableBody"></tbody>
                                </table>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"><i class="bi bi-x"></i> Đóng</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="footer">
            <p>© 2025 EL CENTRE. Bản quyền thuộc về EL CENTRE.</p>
        </div>

        <!-- Nút Scroll to Top -->
        <button id="scrollToTopBtn" onclick="scrollToTop()" title="Cuộn lên đầu trang">↑</button>

        <!-- Bootstrap 5 JS và Popper -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <script>
            // Hiển thị/n ẩn nút khi cuộn
            window.onscroll = function () {
                var scrollBtn = document.getElementById("scrollToTopBtn");
                if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
                    scrollBtn.style.display = "block";
                } else {
                    scrollBtn.style.display = "none";
                }
            };

            // Hàm cuộn lên đầu trang
            function scrollToTop() {
                window.scrollTo({top: 0, behavior: "smooth"});
            }

            // Toggle dropdown menu
            function toggleDropdown() {
                const dropdown = document.getElementById('adminDropdown');
                dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
            }

            // Xử lý lịch học
            document.addEventListener('DOMContentLoaded', function() {
                const lichHocList = [
                    <c:forEach items="${lichHocList}" var="lich" varStatus="status">
                        {
                            tenLopHoc: "${fn:escapeXml(lich.tenLopHoc != null ? lich.tenLopHoc : 'N/A')}",
                            tenPhongHoc: "${fn:escapeXml(lich.tenPhongHoc != null ? lich.tenPhongHoc : 'N/A')}",
                            slotThoiGian: "${fn:escapeXml(lich.slotThoiGian != null ? lich.slotThoiGian : 'N/A')}",
                            ghiChu: "${fn:escapeXml(lich.ghiChu != null ? lich.ghiChu : '')}",
                            day: ${lich.ngayHoc != null ? lich.dayOfMonth : 0}
                        }<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ];

                document.querySelectorAll('.btn-view').forEach(btn => {
                    btn.addEventListener('click', function() {
                        const selectedDay = parseInt(this.getAttribute('data-day'));
                        document.getElementById('modalDay').textContent = selectedDay + '/' + ${month} + '/' + ${year};

                        const schedules = lichHocList.filter(item => item.day === selectedDay);
                        const tbody = document.getElementById('scheduleTableBody');
                        tbody.innerHTML = '';

                        if (schedules.length > 0) {
                            schedules.forEach(item => {
                                const row = document.createElement('tr');
                                const td1 = document.createElement('td');
                                td1.textContent = item.tenLopHoc || 'N/A';
                                const td2 = document.createElement('td');
                                td2.textContent = item.tenPhongHoc || 'N/A';
                                const td3 = document.createElement('td');
                                td3.textContent = item.slotThoiGian || 'N/A';
                                const td4 = document.createElement('td');
                                td4.textContent = item.ghiChu || '';
                                row.appendChild(td1);
                                row.appendChild(td2);
                                row.appendChild(td3);
                                row.appendChild(td4);
                                tbody.appendChild(row);
                            });
                        } else {
                            tbody.innerHTML = '<tr><td colspan="4">Không có lịch học</td></tr>';
                        }
                    });
                });
            });
        </script>
    </body>
    </html>