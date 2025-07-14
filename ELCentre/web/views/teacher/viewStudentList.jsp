<%-- 
    Document   : viewStudentList.jsp
    Created on : Jul 9, 2025, 1:50:13 PM
    Author     : admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh Sách Học Sinh - ${lopHoc.tenLopHoc}</title>
    <%-- Nhúng file CSS chung của bạn --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css"> 
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
     <style>
            .attendance-table th { background-color: #f8f9fa; }
            .attendance-radio-group label { margin-right: 1.5rem; cursor: pointer; }
            .attendance-radio-group input { margin-right: 0.25rem; }
            h1 {
                margin-top: 30px;
                color: #1F4E79; /* Màu chữ */
                text-align: center; /* Căn giữa */
                font-size: 24px; /* Cỡ chữ */
                font-weight: bold; /* In đậm */
            }
                body {
                    margin: 0;
                    font-family: Arial, sans-serif;
                    display:        flex;
                    min-height: 100vh;
                    background-color: #f9f9f9;
                }

                .header {
                    background-color: #1F4E79;
                    color: white;
                    padding: 5px 20px;
                    text-align: left;
                    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                    position: fixed;
                    width: calc(100% - 250px);
                    margin-left: 290px;
                    z-index: 1000;
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    font-size: 20px;
                }

                .header .left-title {
                    font-size: 24px;
                    letter-spacing: 1px;
                    display: flex;
                    align-items: center;
                }

                .header .left-title i {
                    margin-left: 10px;
                }

                .teacher-profile {
                    position: relative;
                    display: flex;
                    flex-direction: column;
                    align-items: center; 
                    cursor: pointer;
                    margin-left: 20px; 
                    margin-right: 100px; 

                }

                .teacher-profile .teacher-img {
                    width: 40px;
                    height: 40px;
                    border-radius: 50%; 
                    object-fit: cover;
                    border: 2px solid #B0C4DE;
                    margin-bottom: 5px;

                }

                .teacher-profile span {
                    font-size: 14px;
                    color: #B0C4DE;
                    font-weight: 600;
                    max-width: 250px;
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                }

                .teacher-profile i {
                    color: #B0C4DE;
                    margin-left: 10px;
                }

                .dropdown-menu {
                    display: none;
                    position: absolute;
                    top: 50px;
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
                    transition: background-color 0.3s ease;
                }

                .dropdown-menu a:hover {
                    background-color: #1F4E79;
                }

                .dropdown-menu a i {
                    margin-right: 8px;
                }

                .sidebar {
                    width: 250px;
                    background-color: #1F4E79;
                    color: white;
                    padding: 20px;
                    box-shadow: 2px 0 5px rgba(0,0,0,0.1);
                    display: flex;
                    flex-direction: column;
                    height: 100vh;
                    position: fixed;
                }

                .sidebar h4 {
                    margin: 0 auto; 
                    font-weight: bold;
                    letter-spacing: 1.5px;
                    text-align: center; 
                    width: 230px; /* nhỏ hơn 250px */
                }

                .sidebar-logo {
                    width: 60px;
                    height: 60px;
                    border-radius: 50%; 
                    object-fit: cover;
                    margin: 15px auto;
                    display: block;
                    border: 3px solid #B0C4DE;
                }

                .sidebar-section-title {
                    font-weight: bold;
                    margin-top: 30px;
                    font-size: 14px;
                    text-transform: uppercase;
                    color: #B0C4DE;
                    border-bottom: 1px solid #B0C4DE;
                    padding-bottom: 5px;
                }

                ul.sidebar-menu {
                    list-style: none;
                    padding-left: 0;
                    margin: 10px 0 0 0;
                }

                ul.sidebar-menu li {
                    margin: 10px 0;
                }

                ul.sidebar-menu li a {
                    color: white;
                    text-decoration: none;
                    font-size: 14px;
                    display: flex;
                    align-items: center;
                    border-radius: 5px;
                    transition: background-color 0.3s ease;
                }

                ul.sidebar-menu li a:hover {
                    background-color: #163E5C;
                }

                ul.sidebar-menu li a i {
                    margin-right: 10px;
                }

                .main-content {
                    margin-top: 30px;
                    margin-left: 300px; /* Keep this to offset for sidebar */
                    padding: 80px 20px 20px 20px; /* Adjust padding as needed */
                    flex: 1;
                    min-height: 100vh;
                    display: flex;
                    flex-direction: column;
                    gap: 30px;
                    margin-right: auto;
                    /* Adjust this to account for sidebar width */
                    max-width: calc(100% - 300px);
                }

                .data-table-container {
                    background: linear-gradient(135deg, #ffffff, #f0f4f8);
                    padding: 20px;
                    border-radius: 10px;
                    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                }

                h3.section-title {
                    margin-top: 0;
                    margin-bottom: 15px;
                    color: #1F4E79;
                    font-weight: 700;
                    font-size: 20px;
                    border-bottom: 2px solid #1F4E79;
                    padding-bottom: 5px;
                    display: flex;
                    align-items: center;
                }

                h3.section-title i {
                    margin-right: 8px;
                }

                table {
                    width: 100%;
                    border-collapse: collapse;
                }

                table th, table td {
                    border: 1px solid #ccc;
                    padding: 8px 12px;
                    text-align: left;
                }

                table th {
                    background-color: #e2eaf0;
                    color: #1F4E79;
                }

                p.no-data {
                    color: red;
                    font-weight: 600;
                    text-align: center;
                    padding: 15px 0;
                }

                .tables-wrapper {
                    display: flex;
                    gap: 20px;
                    transform: translate(145px, 30px);
                }

                .tables-wrapper .data-table-container {
                    background: linear-gradient(135deg, #ffffff, #f0f4f8);
                    padding: 15px;
                    border-radius: 8px;
                    box-shadow: 0 2px 6px rgb(0 0 0 / 0.1);
                }

                .tables-wrapper .data-table-container:first-child {
                    flex: 7;
                }

                .tables-wrapper .data-table-container:last-child {
                    flex: 3;
                }

                /* Footer Styles */
                .footer {
                    background-color: #1F4E79;
                    color: #B0C4DE;
                    text-align: center;
                    padding: 5px 0;
                    position: fixed;
                    width: calc(100% - 250px);
                    bottom: 0;
                    margin-left: 290px;
                    box-shadow: 0 -2px 5px rgba(0,0,0,0.1);
                }

                .footer p {
                    margin: 0;
                    font-size: 14px;

                }
                /* === NÚT QUAY LẠI TÙY CHỈNH === */
                .btn-back {
                    display: inline-flex;       /* Căn chỉnh icon và chữ */
                    align-items: center;
                    gap: 8px;                   /* Khoảng cách giữa icon và chữ */

                    padding: 10px 20px;         /* Tăng kích thước cho dễ nhấn */
                    font-size: 15px;
                    font-weight: 500;
                    text-decoration: none;
                    
                    margin: 20px 0px    ;
                    color: #1F4E79;             /* Màu chữ và viền theo màu chủ đạo */
                    background-color: transparent;
                    border: 2px solid #1F4E79;
                    border-radius: 8px;         /* Bo góc mềm mại */

                    cursor: pointer;
                    transition: all 0.2s ease-in-out; /* Hiệu ứng chuyển động mượt mà */
                }

                /* Hiệu ứng khi di chuột vào nút */
                .btn-back:hover {
                    background-color: #1F4E79;  /* Đổi màu nền */
                    color: white;               /* Đổi màu chữ */
                    transform: translateY(-2px); /* Hiệu ứng nhấc lên nhẹ */
                    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                }
        </style>
</head>
<body>
    <div class="header">
                <div class="left-title">
                    Teacher Dashboard <i class="fas fa-tachometer-alt"></i>
                </div>
                <!-- User's email and option to change or update information-->
                <div class="teacher-profile" onclick="toggleDropdown()">
                    <img src="${pageContext.request.contextPath}/img/${gv.getAvatar()}" alt="Admin Photo" class="teacher-img">
                    <span>${user.getEmail()} </span>
                    <i class="fas fa-caret-down"></i>
                    <div class="dropdown-menu" id="teacherDropdown">
                        <a href="#"><i class="fas fa-key"></i> Change Password</a>
                        <a href="#"><i class="fas fa-user-edit"></i> Update Information</a>
                    </div>
                </div>
        </div>
        <!--Navigation Bar-->    
            <div class="sidebar">
                <h4>EL CENTRE</h4>
                <img src="<%= request.getContextPath() %>/img/SieuLogo-xoaphong.png" alt="Center Logo" class="sidebar-logo">
                <div class="sidebar-section-title">Tổng quan</div>
                <ul class="sidebar-menu">
                    <li><a href="${pageContext.request.contextPath}/TeacherDashboard">Dashboard</a></li>
                </ul>
                <!--Academy Management-->
                <div class="sidebar-section-title">Quản lý học tập</div>
                <ul class="sidebar-menu">
                    <!--Teacher's Class Management-->
                <li style="padding-top: 4px"><a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=lophoc"><i class="fas fa-book"></i>Lớp Học</a></li>
                    <!--Attendance's Management-->
                    <li style="padding-top: 4px"><a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=diemdanh"><i class="fas fa-book"></i>Điểm Danh</a></li>
                </ul>
                <!--Other Management-->
                <div class="sidebar-section-title">Khác</div>
                <ul class="sidebar-menu">
                    <!--Teacher's Notification Management-->
                    <li style="padding-top: 4px"><a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=thongbao"><i class="fas fa-bell"></i> Thông báo</a></li>
                    <!--Blog's View-->
                    <li style="padding-top: 4px"><a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=blog"><i class="fas fa-blog"></i> Blog</a></li>
                    <!--Help Request to Admin-->
                    <li style="padding-top: 4px"><a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=hotro"><i class="fas fa-question"></i> Yêu Cầu Hỗ Trợ</a></li>
                    <!--Logout-->
                    <li style="padding-top: 4px"><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                </ul>
            </div>
    
        <div class="main-content">
            <div class="card">
                <div class="card-header" style="text-align: center;">
                    <h3>
                        <i class="fas fa-users"></i> Danh Sách Học Sinh Lớp: ${lopHoc.tenLopHoc} (${lopHoc.classCode})
                    </h3>
                </div>
                <div class="card-body">
                    <c:if test="${empty studentList}">
                        <div class="alert alert-info">Chưa có học sinh nào trong lớp này.</div>
                    </c:if>

                    <c:if test="${not empty studentList}">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Mã Học Sinh</th>
                                    <th>Họ Tên</th>
                                    <th>Ngày Sinh</th>
                                    <th>Giới Tính</th>
                                    <th>Lớp đang học tại trường</th>
                                    <th>SĐT Phụ Huynh</th>
                                    <th>Ảnh</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="student" items="${studentList}" varStatus="loop">
                                    <tr>
                                        <td>${loop.count}</td>
                                        <td>${student.maHocSinh}</td>
                                        <td>${student.hoTen}</td>
                                        <td>
                                            <%-- Bắt đầu Scriptlet --%>
                                            <%
                                                // Lấy đối tượng 'student' từ vòng lặp forEach của JSTL
                                                Object obj = pageContext.getAttribute("student");

                                                if (obj instanceof model.HocSinh) {
                                                    model.HocSinh currentStudent = (model.HocSinh) obj;

                                                    // Lấy ngày sinh (kiểu java.time.LocalDate)
                                                    java.time.LocalDate ngaySinh = currentStudent.getNgaySinh();

                                                    // QUAN TRỌNG: Kiểm tra xem ngày sinh có null không trước khi định dạng
                                                    if (ngaySinh != null) {
                                                        // Tạo một đối tượng định dạng ngày tháng
                                                        java.time.format.DateTimeFormatter formatter = 
                                                            java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy");

                                                        // Dùng out.print() để in ra chuỗi đã định dạng
                                                        out.print(ngaySinh.format(formatter));
                                                    }
                                                    // Nếu ngaySinh là null, thẻ <td> sẽ được in ra trống, không gây lỗi
                                                }
                                            %>
                                            <%-- Kết thúc Scriptlet --%>
                                        </td>
                                        <td>${student.gioiTinh}</td>
                                        <td>${student.getLopDangHocTrenTruong()}</td>
                                        <td>${student.SDT_PhuHuynh}</td>
                                        <td>
                                            <img src="${pageContext.request.contextPath}/img/avatar/${student.avatar}" 
                                                 alt="Avatar" style="width: 50px; height: 50px; border-radius: 30%; object-fit: cover;">
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                    
                    <div class="mt-4" style="text-align: center;">
                        <a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=lophoc" class="btn-back" >
                            <i class="fas fa-arrow-left"></i> Quay lại danh sách lớp
                        </a>
                    </div>
                </div>
            </div>
        </div>  
                            <div class="footer">
            <p>&copy; 2025 EL CENTRE. All rights reserved. | Developed by ELCentre</p>
        </div>
</body>
</html>