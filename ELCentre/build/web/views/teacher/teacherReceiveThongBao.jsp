<%-- 
    Document   : teacherReceiveThongBao
    Created on : Jul 17, 2025, 5:37:03 PM
    Author     : wrx_Chur04
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông Báo</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #1F4E79;
            --secondary-color: #163E5C;
            --accent-color: #B0C4DE;
            --background-color: #F9F9F9;
            --card-background: #FFFFFF;
            --text-color: #2C3E50;
            --muted-text: #7F8C8D;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: var(--background-color);
            display: flex;
            min-height: 100vh;
            color: var(--text-color);
        }

        .header {
            background-color: var(--primary-color);
            color: white;
            padding: 15px 30px;
            position: fixed;
            top: 0;
            left: 250px;
            right: 0;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }

        .header .left-title {
            font-size: 1.5rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .teacher-profile {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            position: relative;
        }

        .teacher-profile img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            border: 2px solid var(--accent-color);
            object-fit: cover;
        }

        .teacher-profile span {
            font-size: 0.9rem;
            font-weight: 500;
            color: var(--accent-color);
            max-width: 150px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .teacher-profile i {
            color: var(--accent-color);
        }

        .dropdown-menu {
            display: none;
            position: absolute;
            top: 50px;
            right: 0;
            background: var(--secondary-color);
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            min-width: 180px;
            z-index: 1001;
        }

        .dropdown-menu.active {
            display: block;
        }

        .dropdown-menu a {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            color: white;
            text-decoration: none;
            font-size: 0.9rem;
            transition: background-color 0.2s ease;
        }

        .dropdown-menu a:hover {
            background-color: var(--primary-color);
        }

        .dropdown-menu a i {
            margin-right: 10px;
        }

        .sidebar {
            width: 250px;
            background-color: var(--primary-color);
            color: white;
            padding: 20px;
            position: fixed;
            top: 0;
            bottom: 0;
            box-shadow: 2px 0 4px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .sidebar h4 {
            font-size: 1.25rem;
            font-weight: 700;
            letter-spacing: 1.2px;
            margin-bottom: 15px;
            text-align: center;
        }

        .sidebar-logo {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid var(--accent-color);
            margin-bottom: 20px;
        }

        .sidebar-section-title {
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            color: var(--accent-color);
            margin: 20px 0 10px;
            border-bottom: 1px solid var(--accent-color);
            padding-bottom: 5px;
            width: 100%;
            text-align: left;
        }

        .sidebar-menu {
            list-style: none;
            width: 100%;
        }

        .sidebar-menu li {
            margin: 8px 0;
        }

        .sidebar-menu li a {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            color: white;
            text-decoration: none;
            font-size: 0.9rem;
            border-radius: 6px;
            transition: background-color 0.2s ease;
        }

        .sidebar-menu li a:hover {
            background-color: var(--secondary-color);
        }

        .sidebar-menu li a i {
            margin-right: 12px;
        }

        .main-content {
            margin-left: 270px;
            padding: 100px 20px 20px;
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .notification-title {
            font-size: 1.75rem;
            font-weight: 600;
            color: var(--primary-color);
            text-align: center;
            margin-bottom: 20px;
        }

        .notification-box {
            background: var(--card-background);
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            width: 100%;
            max-width: 800px;
            display: none; /* Initially hidden, shown by JS */
        }

        .notification-item {
            background-color: #F8F9FA;
            padding: 15px;
            margin-bottom: 10px;
            border-radius: 6px;
            border-left: 4px solid var(--primary-color);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .notification-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .notification-item div:first-child {
            font-size: 1rem;
            font-weight: 500;
            color: var(--text-color);
            line-height: 1.4;
        }

        .notification-time {
            font-size: 0.85rem;
            color: var(--muted-text);
            font-style: italic;
            text-align: right;
        }

        .no-data {
            color: #E74C3C;
            font-weight: 500;
            text-align: center;
            padding: 15px;
            font-size: 1rem;
            background: var(--card-background);
            border-radius: 6px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            width: 100%;
            max-width: 800px;
            margin-top: 20px;
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
            gap: 10px;
        }

        .pagination a {
            text-decoration: none;
            padding: 8px 12px;
            border-radius: 4px;
            font-size: 0.9rem;
            color: var(--primary-color);
            background-color: var(--card-background);
            border: 1px solid var(--accent-color);
            transition: background-color 0.2s ease, color 0.2s ease;
            cursor: pointer;
        }

        .pagination a:hover {
            background-color: var(--primary-color);
            color: white;
        }

        .pagination a.active {
            background-color: var(--primary-color);
            color: white;
            font-weight: 600;
        }

        .pagination a.disabled {
            color: var(--muted-text);
            border-color: var(--muted-text);
            cursor: not-allowed;
        }

        .pagination a.disabled:hover {
            background-color: var(--card-background);
            color: var(--muted-text);
        }

        .footer {
            background-color: var(--primary-color);
            color: var(--accent-color);
            text-align: center;
            padding: 10px 0;
            position: fixed;
            bottom: 0;
            left: 250px;
            right: 0;
            box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.1);
        }

        .footer p {
            font-size: 0.85rem;
            margin: 0;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 200px;
            }

            .header, .footer {
                left: 200px;
            }

            .main-content {
                margin-left: 220px;
                padding: 80px 15px 15px;
            }

            .notification-box, .no-data {
                width: 100%;
                max-width: 100%;
            }

            .notification-title {
                font-size: 1.5rem;
            }

            .pagination a {
                padding: 6px 10px;
                font-size: 0.85rem;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="left-title">
            Thông Báo <i class="fas fa-bell"></i>
        </div>
        <div class="teacher-profile" onclick="toggleDropdown()">
            <img src="${pageContext.request.contextPath}/img/${gv.getAvatar()}" alt="Teacher Photo" class="teacher-img">
            <span>${user.getEmail()}</span>
            <i class="fas fa-caret-down"></i>
            <div class="dropdown-menu" id="teacherDropdown">
                <a href="#"><i class="fas fa-key"></i> Đổi Mật Khẩu</a>
                <a href="#"><i class="fas fa-user-edit"></i> Cập Nhật Thông Tin</a>
            </div>
        </div>
    </div>

    <div class="sidebar">
        <h4>EL CENTRE</h4>
        <img src="${pageContext.request.contextPath}/img/SieuLogo-xoaphong.png" alt="Center Logo" class="sidebar-logo">
        <div class="sidebar-section-title">Tổng Quan</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/TeacherDashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
        </ul>
        <div class="sidebar-section-title">Quản Lý Học Tập</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=lophoc"><i class="fas fa-book"></i> Lớp Học</a></li>
            <li><a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=diemdanh"><i class="fas fa-check-circle"></i> Điểm Danh</a></li>
        </ul>
        <div class="sidebar-section-title">Khác</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=thongbao"><i class="fas fa-bell"></i> Thông Báo</a></li>
            <li><a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=hotro"><i class="fas fa-question-circle"></i> Yêu Cầu Hỗ Trợ</a></li>
            <li><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Đăng Xuất</a></li>
        </ul>
    </div>

    <div class="main-content">
        <h2 class="notification-title">Danh Sách Thông Báo</h2>
        <c:choose>
            <c:when test="${not empty dsThongBao}">
               
                <div class="notification-box" id="notificationBox">
                    <c:forEach var="tb" items="${dsThongBao}">
                        <div class="notification-item" data-noiDung="${tb.noiDung}" data-thoiGian="${tb.thoiGian}">
                            <div>${tb.noiDung}</div>
                            <div class="notification-time">${tb.thoiGian}</div>
                        </div>
                    </c:forEach>
                </div>
                <div class="pagination" id="pagination"></div>
            </c:when>
            <c:otherwise>
                <div class="no-data">Bạn hiện không có thông báo nào.</div>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="footer">
        <p>© 2025 EL CENTRE. All rights reserved. | Developed by ELCentre</p>
    </div>

    <script>
        function toggleDropdown() {
            const dropdown = document.getElementById('teacherDropdown');
            dropdown.classList.toggle('active');
        }

       
        document.addEventListener('click', function(event) {
            const profile = document.querySelector('.teacher-profile');
            const dropdown = document.getElementById('teacherDropdown');
            if (!profile.contains(event.target)) {
                dropdown.classList.remove('active');
            }
        });

      
        document.addEventListener('DOMContentLoaded', function() {
            const pageSize = 10; 
            const notificationBox = document.getElementById('notificationBox');
            const pagination = document.getElementById('pagination');
            const notifications = Array.from(document.querySelectorAll('.notification-item'));
            const totalNotifications = notifications.length;
            const totalPages = Math.ceil(totalNotifications / pageSize);
            let currentPage = 1;

            function displayNotifications(page) {
              
                notificationBox.innerHTML = '';

               
                const start = (page - 1) * pageSize;
                const end = Math.min(start + pageSize, totalNotifications);

                
                for (let i = start; i < end; i++) {
                    notificationBox.appendChild(notifications[i]);
                }

             
                notificationBox.style.display = 'block';

             
                updatePagination(page);
            }

            function updatePagination(page) {
                pagination.innerHTML = '';

               
                const prevButton = document.createElement('a');
                prevButton.innerHTML = '<i class="fas fa-chevron-left"></i> Trước';
                prevButton.className = page === 1 ? 'disabled' : '';
                prevButton.onclick = () => {
                    if (page > 1) {
                        currentPage--;
                        displayNotifications(currentPage);
                    }
                };
                pagination.appendChild(prevButton);

      
                for (let i = 1; i <= totalPages; i++) {
                    const pageButton = document.createElement('a');
                    pageButton.textContent = i;
                    pageButton.className = i === page ? 'active' : '';
                    pageButton.onclick = () => {
                        currentPage = i;
                        displayNotifications(currentPage);
                    };
                    pagination.appendChild(pageButton);
                }

              
                const nextButton = document.createElement('a');
                nextButton.innerHTML = 'Tiếp <i class="fas fa-chevron-right"></i>';
                nextButton.className = page === totalPages ? 'disabled' : '';
                nextButton.onclick = () => {
                    if (page < totalPages) {
                        currentPage++;
                        displayNotifications(currentPage);
                    }
                };
                pagination.appendChild(nextButton);
            }

            
            if (totalNotifications > 0) {
                displayNotifications(currentPage);
            }
        });
    </script>
</body>
</html>