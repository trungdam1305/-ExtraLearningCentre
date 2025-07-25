    <%-- 
        Document   : takeAttendance
        Created on : Jul 9, 2025, 2:24:57 AM
        Author     : trungdam
    --%>

    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Điểm Danh Lớp Học</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
                     overflow-y: auto;
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
    </head>
    <body>
        <div class="header">
        <div class="left-title">
            Staff Dashboard <i class="fas fa-tachometer-alt"></i>
        </div>
        <div class="admin-profile" onclick="toggleDropdown()">
            <c:forEach var="staff" items="${staffs}">
                <img src="${staff.getAvatar()}" alt="Staff Photo" class="admin-img">
                <span>${staff.getHoTen()}</span>
            </c:forEach>
            <i class="fas fa-caret-down"></i>
            <div class="dropdown-menu" id="adminDropdown">
                <a href="${pageContext.request.contextPath}/staffChangePassword"><i class="fas fa-key"></i> Change Password</a>
                <a href="${pageContext.request.contextPath}/staffUpdateInfo"><i class="fas fa-user-edit"></i> Update Information</a>
                <a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>
    </div>

    <div class="sidebar">
        <h4>EL CENTRE</h4>
        <img src="<%= request.getContextPath() %>/img/SieuLogo-xoaphong.png" alt="Center Logo" class="sidebar-logo">
        <div class="sidebar-section-title">Tổng quan</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/staffGoToFirstPage"><i class="fas fa-chart-line"></i> Dashboard</a></li>
        </ul>
        <div class="sidebar-section-title">Quản lý học tập</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/ManageCourse"><i class="fas fa-book"></i> Khoá học</a></li>
            <li><a href="${pageContext.request.contextPath}/StaffManageTimeTable"><i class="fas fa-calendar-alt"></i> Thời Khóa Biểu</a></li>
            <li><a href="${pageContext.request.contextPath}/StaffManageAttendance"><i class="fas fa-check-square"></i> Điểm danh</a></li>
        </ul>
        <div class="sidebar-section-title">Quản lý tài chính</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/staffViewSalary"><i class="fas fa-money-check-alt"></i> Học phí</a></li>
        </ul>
        <div class="sidebar-section-title">Hỗ trợ</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/staffGetSupportRequests"><i class="fas fa-envelope-open-text"></i> Yêu cầu hỗ trợ</a></li>
        </ul>
        <div class="sidebar-section-title">Khác</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/ManagePost"><i class="fas fa-blog"></i> Bài Viết</a></li>
            <li><a href="${pageContext.request.contextPath}/ManageMaterial"><i class="fas fa-file-alt"></i> Tài Liệu</a></li> <li><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
    </div>
        <div class="main-content">            
            <div>
                <!--Attendance for each slot-->
                <div class="card">
                    <div class="card-header">
                        <h3>Điểm Danh Buổi Học (Mã Lớp Học : ${classId}) </h3>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty saveStatus}">
                            <c:if test="${saveStatus == 'success'}">
                                <div class="alert alert-success" role="alert">
                                    <strong>Thành công!</strong> Đã lưu thành công tác vụ
                                </div>
                            </c:if>
                            <c:if test="${saveStatus == 'error'}">
                                <div class="alert alert-danger" role="alert">
                                    <strong>Có lỗi!</strong> Không thể lưu điểm danh, vui lòng thử lại.
                                </div>
                            </c:if>
                        </c:if>
                        <c:if test="${empty studentList}">
                            <div class="alert alert-warning">Lớp học này chưa có học sinh nào.</div>
                        </c:if>
                            
                        <c:if test="${not empty studentList}">
                            <form action="${pageContext.request.contextPath}/StaffManageTimeTable" method="post">
                                <input type="hidden" name="action" value="saveAttendance">
                                <input type="hidden" name="scheduleId" value="${scheduleId}">
                                <input type="hidden" name="classId" value="${classId}">
                                <!--Table display data and status for check student's attendance-->
                                <table class="table table-bordered table-hover attendance-table">
                                    <thead>
                                        <tr>
                                            <th scope="col" style="width: 5%;">STT</th>
                                            <th scope="col" style="width: 20%;">Tên Học Sinh</th>
                                            <th scope="col" style="width: 50%;">Trạng Thái</th>
                                            <th scope="col" style="width: 25%;">Avatar</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="student" items="${studentList}" varStatus="loop">
                                            <tr>
                                                <td>${loop.count}</td>
                                                <td>
                                                    ${student.hoTen}
                                                    <input type="hidden" name="studentId" value="${student.getID_HocSinh()}">
                                                </td>
                                                <td class="attendance-radio-group">
                                                    <input type="radio" id="present_${student.getID_HocSinh()}" name="status_${student.getID_HocSinh()}" value="Có mặt" required
                                                           <c:if test="${student.getTrangThai() == 'Có mặt'}">checked</c:if>>
                                                    <label for="present_${student.getID_HocSinh()}">Có mặt</label>

                                                    <input type="radio" id="absent_${student.getID_HocSinh()}" name="status_${student.getID_HocSinh()}" value="Vắng" 
                                                           <c:if test="${student.getTrangThai() == 'Vắng'}">checked</c:if>>
                                                    <label for="absent_${student.getID_HocSinh()}">Vắng</label>

                                                    <input type="radio" id="late_${student.getID_HocSinh()}" name="status_${student.getID_HocSinh()}" value="Đi muộn"
                                                           <c:if test="${student.getTrangThai() == 'Đi muộn'}">checked</c:if>>
                                                    <label for="late_${student.getID_HocSinh()}">Đi muộn</label>
                                                </td>
                                                <td>
                                                    <img src="${pageContext.request.contextPath}/img/avatar/${student.avatar}" 
                                                         alt="${student.hoTen}" 
                                                         class="teacher-img"
                                                         style="width: 80px; height: 80px; border-radius: 30%; object-fit: cover;" >
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <!--Note for each slot-->
                                <div class="mt-4">
                                    <label for="scheduleNotes" class="form-label fw-bold">Đánh giá & Ghi chú buổi học:</label>
                                    <textarea class="form-control" 
                                              id="scheduleNotes" 
                                              name="scheduleNotes" 
                                              rows="5" 
                                              placeholder="Nhập nhận xét về buổi học, tình hình học tập của lớp, các vấn đề cần lưu ý...">${currentNotes}</textarea>
                                </div>
                                <div class="mt-4">
                                    <button type="submit" class="btn btn-primary"><i class="fas fa-save me-2"></i>Lưu & Hoàn tất</button>
                                        <a href="${pageContext.request.contextPath}/StaffManageTimeTable?action=viewDetail&classId=${classId}" class="btn btn-secondary btn-sm">
                                            <i class="fas fa-arrow-alt-circle-left"></i> Quay lại lịch học
                                        </a>                                
                                </div>
                            </form>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
                        <div class="footer">
            <p>&copy; 2025 EL CENTRE. All rights reserved. | Developed by ELCentre</p>
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

    </script>
    </body>
    </html>