<%-- 
    Document   : viewSubmissions.jsp
    Created on : Jul 9, 2025, 5:10:51 PM
    Author     : trungdam
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chấm bài - ${assignment.tenBaiTap}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <style>
            .attendance-table th { background-color: #f8f9fa; }
            .attendance-radio-group label { margin-right: 1.5rem; cursor: pointer; }
            .attendance-radio-group input { margin-right: 0.25rem; }
            h1 {
                margin-top: 30px;
                color: #1F4E79; 
                text-align: center;
                font-size: 24px; 
                font-weight: bold;
            }
                body {
                    margin: 0;
                    font-family: Arial, sans-serif;
                    display:        flex;
                    min-height: 100vh;
                    background-color: #f9f9f9;
                }

                .header {
                    transform: translateX(-40px);
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
                    width: 230px; 
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
                    margin-top: 10px;   
                    margin-left: 300px; 
                    padding: 80px 20px 20px 20px; 
                    flex: 1;
                    min-height: 100vh;
                    display: flex;
                    flex-direction: column;
                    gap: 30px;
                    
                    margin-right: auto;
                    max-width: calc(100% - 250px); 
                }

                .dashboard-stats {
                    display: flex;
                    gap: 20px;
                    flex-wrap: wrap;
                    transform: translate(145px, 30px);

                }

                .stat-card {
                    background: linear-gradient(135deg, #ffffff, #f0f4f8);
                    padding: 10px;
                    font-size: 14px;
                    border-radius: 10px;
                    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                    flex: 1 1 200px;
                    text-align: center;
                    transition: transform 0.2s;
                }

                .stat-card:hover {
                    transform: translateY(-5px);
                }

                .stat-card h3 {
                    margin-bottom: 15px;
                    color: #1F4E79;
                    font-weight: 700;
                    font-size: 18px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                .stat-card h3 i {
                    margin-right: 8px;
                }

                .stat-card p {
                    font-size: 24px;
                    font-weight: bold;
                    margin: 0;
                    color: #333;
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
                .filter-container {
                    display: flex;
                    align-items: center;
                    gap: 20px; 
                    flex-wrap: wrap;
                    justify-content: flex-end; 
                }


                .filter-container .filter-group {
                    display: flex;
                    align-items: center;
                    gap: 8px;
                }


                .filter-container label {
                    font-weight: bold;
                    color: #333;
                    white-space: nowrap; 
                }


                .filter-container input,
                .filter-container select {
                    padding: 8px 12px;
                    border: 1px solid #ccc;
                    border-radius: 6px;
                    min-width: 150px;
                }


                .filter-container button {
                    padding: 8px 15px;
                    background-color: #1F4E79;
                    color: white;
                    border: none;
                    border-radius: 6px;
                    cursor: pointer;
                    font-size: 16px;
                    display: flex;
                    align-items: center;
                }


                .filter-container button:hover {
                    background-color: #163E5C;
                }
                .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 25px;
                }

                .pagination a {
                    color: #555; 
                    text-decoration: none;
                    padding: 6px 12px; 
                    margin: 0 2px; 
                    border-radius: 4px; 
                    transition: background-color 0.3s, color 0.3s;
                    border: 1px solid #ddd;
                }

                
                .pagination a.active {
                    background-color: #1F4E79;
                    color: white;
                    border-color: #1F4E79; 
                    font-weight: bold;
                }

                .pagination a:hover:not(.active) {
                    background-color: #e2eaf0; 
                    color: #1F4E79;
                }
                
                    .btn-back {
                        display: inline-flex;       
                        
                        gap: 8px;                  

                        padding: 10px 20px;        
                        font-size: 15px;
                        font-weight: 500;
                        text-decoration: none;
                        margin: 20px 0px;
                        color: #1F4E79;             
                        background-color: transparent;
                        border: 2px solid #1F4E79;
                        border-radius: 8px;        

                        cursor: pointer;
                        transition: all 0.2s ease-in-out; 
                    }

                    .btn-back:hover {
                        background-color: #1F4E79; 
                        color: white;              
                        transform: translateY(-2px); 
                        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                    }
                
                .action-buttons {
                    display: flex;
                    align-items: center;
                    gap: 8px; 
                }

                .action-btn {
                    display: inline-flex;
                    align-items: center;
                    gap: 6px; 
                    padding: 6px 12px;
                    border-radius: 20px; 
                    color: white;
                    font-size: 13px;
                    font-weight: 500;
                    text-decoration: none;
                    border: none;
                    cursor: pointer;
                    transition: transform 0.2s ease, box-shadow 0.2s ease;
                    white-space: nowrap;
                }

                .action-btn:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 4px 8px rgba(0,0,0,0.15);
                }

                .action-btn.edit {
                    background-color: #f39c12; 
                }

                .action-btn.view-students {
                    background-color: #6c7a89;
                }

                .action-btn.upload {
                    background-color: #27ae60;
                }
        </style>
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
    <div class="main-wrapper">
        <div class="main-content">
            <div class="card">
                <!--Student's Name-->
                <div class="card-header">
                    <h3><i class="fas fa-edit"></i> Chấm bài cho: ${assignment.tenBaiTap}</h3>
                </div>
                <div class="card-body">
                    <c:if test="${param.grade == 'success'}"><div class="alert alert-success">Đã cập nhật điểm thành công!</div></c:if>
                    <c:if test="${param.grade == 'error'}"><div class="alert alert-danger">Có lỗi xảy ra khi cập nhật điểm.</div></c:if>
                    <!--Display information of students and their assignment-->
                    <table class="table table-bordered align-middle">
                        <thead>
                            <tr class="text-center">
                                <th>STT</th>
                                <th>Họ Tên Học Sinh</th>
                                <th>Tệp Đã Nộp</th>
                                <th>Điểm</th>
                                <th>Nhận xét của giáo viên</th>
                                <th style="width: 100px;">Hành Động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty submissionList}">
                                <tr><td colspan="6" class="text-center p-4">Chưa có học sinh nào nộp bài.</td></tr>
                            </c:if>
                            <c:forEach var="sub" items="${submissionList}" varStatus="loop">
                                <form action="${pageContext.request.contextPath}/teacherGetFromDashboard" method="post">
                                    <input type="hidden" name="action" value="gradeSubmission">
                                    <input type="hidden" name="assignmentId" value="${sub.ID_BaiTap}">
                                    <input type="hidden" name="studentId" value="${sub.ID_HocSinh}">
                                    <tr>
                                        <td class="text-center">${loop.count}</td>
                                        <td>${sub.hoTen} (${sub.maHocSinh})</td>
                                        <td class="text-center">
                                            <c:if test="${not empty sub.tepNop}">
                                                <a href="${pageContext.request.contextPath}/uploads/${sub.tepNop}" class="download-link" download>
                                                    <i class="fas fa-file-download"></i> Tải về
                                                </a>
                                            </c:if>
                                            <c:if test="${empty sub.tepNop}"><span class="text-muted">(Không nộp file)</span></c:if>
                                        </td>
                                        <!--Score-->
                                        <td>
                                            <input type="number" step="0.25" min="0" max="10" name="diem" class="form-control text-center" value="${sub.diem}">
                                        </td>
                                        <td>
                                            <textarea name="nhanXet" class="form-control" rows="1">${sub.nhanXet}</textarea>
                                        </td>
                                        <td class="text-center">
                                            <button type="submit" class="btn btn-sm btn-primary">Lưu</button>
                                        </td>
                                    </tr>
                                </form>
                            </c:forEach>
                        </tbody>
                    </table>
                    
                    <div class="mt-4">
                        <a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=assignments&classId=${assignment.ID_LopHoc}" class="btn-back">
                            <i class="fas fa-arrow-left"></i> Quay lại trang bài tập
                        </a>
                    </div>
                </div>
            </div>
        </div>
                            <div class="footer">
            <p>&copy; 2025 EL CENTRE. All rights reserved. | Developed by ELCentre</p>
        </div>
    </div>
</body>
</html>
