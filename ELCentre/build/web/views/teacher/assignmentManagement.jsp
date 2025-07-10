    <%--
        Document    : assignmentManagement.jsp
        Created on  : Jul 9, 2025
        Author      : (Your Name)
        Purpose     : Trang quản lý bài tập cho giáo viên
    --%>

    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản Lý Bài Tập - ${lopHoc.tenLopHoc}</title>

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
                    
                    .btn-main-action {
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        gap: 8px;

                        background-color: #1F4E79; /* Màu xanh chủ đạo */
                        color: white;

                        padding: 12px 24px; /* Kích thước lớn hơn để nổi bật */
                        font-size: 16px;
                        font-weight: 500;

                        border: none;
                        border-radius: 8px;

                        cursor: pointer;
                        text-decoration: none;

                        /* Hiệu ứng đổ bóng nhẹ nhàng */
                        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.15);
                        transition: all 0.3s ease;
                    }

                    /* Hiệu ứng khi di chuột */
                    .btn-main-action:hover {
                        transform: translateY(-3px); /* Hiệu ứng nhấc lên rõ hơn */
                        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
                        filter: brightness(110%); /* Sáng hơn một chút */
                    }

                    .btn-main-action i {
                        font-size: 15px;
                    }
                    
                    /* === LINK TẢI VỀ ĐƠN GIẢN === */
                    .download-link {
                        color: #0d6efd; /* Màu xanh dương của link */
                        text-decoration: none; /* Bỏ gạch chân mặc định */
                        font-weight: 500;
                        display: inline-flex;
                        align-items: center;
                        gap: 5px; /* Khoảng cách nhỏ giữa icon và chữ */
                        transition: all 0.2s ease;
                    }

                    /* Hiệu ứng khi di chuột */
                    .download-link:hover {
                        text-decoration: underline; /* Thêm lại gạch chân khi hover */
                        color: #0b5ed7; /* Màu link hơi sẫm lại */
                    }
                    /* --- Tùy chỉnh chung cho Pop-up (Modal) --- */
                    #createAssignmentModal .modal-content {
                        margin-top:150px;
                        margin-left: 50px   
                    }

                    #createAssignmentModal .modal-header {
                        background-color: #f8f9fa; /* Màu nền nhẹ cho header */
                        border-bottom: 1px solid #dee2e6;
                    }

                    #createAssignmentModal .modal-title {
                        color: #1F4E79; /* Màu tiêu đề theo màu chủ đạo */
                        font-weight: 500;
                    }

                    /* --- Style cho các nhãn (Label) --- */
                    #createAssignmentModal .form-label {
                        font-weight: 500;
                        color: #495057;
                        margin-bottom: 0.5rem;
                    }

                    /* --- Style cho các ô nhập liệu (Input, Textarea) --- */
                    #createAssignmentModal .form-control {
                        background-color: #f8f9fa; /* Nền xám nhẹ để nổi bật */
                        border: 1px solid #ced4da;
                        border-radius: 8px; /* Bo góc mềm mại */
                        padding: 12px 15px; /* Tăng padding cho dễ nhìn */
                        transition: border-color 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
                    }

                    /* Hiệu ứng khi focus vào ô nhập liệu */
                    #createAssignmentModal .form-control:focus {
                        background-color: #fff;
                        border-color: #86b7fe; /* Màu xanh dương của Bootstrap khi focus */
                        box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
                        outline: none;
                    }

                    /* --- Style riêng cho ô chọn file --- */
                    #createAssignmentModal .form-control[type="file"] {
                        padding: 8px 15px;
                    }

                    /* Tùy chỉnh chữ và icon trong nút chọn file của trình duyệt */
                    #createAssignmentModal .form-control[type="file"]::file-selector-button {
                        background-color: #1F4E79;
                        color: white;
                        border: none;
                        padding: 8px 12px;
                        border-radius: 6px;
                        cursor: pointer;
                        transition: background-color 0.2s ease;
                    }

                    #createAssignmentModal .form-control[type="file"]::file-selector-button:hover {
                        background-color: #163E5C;
                    }

                    /* --- Style cho các nút bấm trong Footer --- */
                    #createAssignmentModal .modal-footer {
                        border-top: 1px solid #dee2e6;
                        background-color: #f8f9fa;
                    }

                    /* Nút chính "Đăng Bài" */
                    #createAssignmentModal .btn-primary {
                        background-color: #1F4E79;
                        border-color: #1F4E79;
                        padding: 10px 25px;
                        font-weight: 500;
                        border-radius: 6px;
                    }

                    #createAssignmentModal .btn-primary:hover {
                        background-color: #163E5C;
                        border-color: #163E5C;
                    }

                    /* Nút phụ "Hủy" */
                    #createAssignmentModal .btn-secondary {
                        padding: 10px 25px;
                        font-weight: 500;
                        border-radius: 6px;
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

                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h3>Quản lý bài tập lớp: ${lopHoc.tenLopHoc}</h3>
                    <button type="button" class="btn-main-action" data-bs-toggle="modal" data-bs-target="#createAssignmentModal">
                        <i class="fas fa-plus-circle"></i> Đăng Bài Tập Mới
                    </button>
                </div>

                <div class="card">
                    <div class="card-header">
                        <h4><i class="fas fa-list-alt"></i> Danh sách bài tập đã giao</h4>
                    </div>
                    <div class="card-body">
                        <c:if test="${param.create == 'success'}">
                            <div class="alert alert-success">Đã đăng bài tập mới thành công!</div>
                        </c:if>
                        <c:if test="${param.create == 'error'}">
                            <div class="alert alert-danger">Có lỗi xảy ra, không thể đăng bài tập.</div>
                        </c:if>

                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Tên Bài Tập</th>
                                    <th>Tài Liệu</th>
                                    <th>Ngày Giao</th>
                                    <th>Hạn Nộp</th>
                                    <th>Hành Động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="bt" items="${assignmentList}">
                                    <tr>
                                        <td>${bt.tenBaiTap}</td>
                                        <td>
                                            <c:if test="${not empty bt.fileName}">
                                                <a href="${pageContext.request.contextPath}/uploads/${bt.fileName}" class="download-link" download>
                                                    <i class="fas fa-download"></i> Tải về
                                                </a>
                                            </c:if>
                                            <c:if test="${empty bt.fileName}">
                                                <span class="text-muted">(Không có)</span>
                                            </c:if>
                                        </td>
                                        <td>
                                            <%-- Scriptlet định dạng Ngày Giao --%>
                                            <%
                                                Object objNgayTao = pageContext.getAttribute("bt");
                                                if (objNgayTao instanceof model.TaoBaiTap) {
                                                    model.TaoBaiTap currentBt = (model.TaoBaiTap) objNgayTao;
                                                    java.time.LocalDate ngayTao = currentBt.getNgayTao();
                                                    if (ngayTao != null) {
                                                        out.print(ngayTao.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy")));
                                                    }
                                                }
                                            %>
                                        </td>
                                        <td>
                                            <%-- Scriptlet định dạng Hạn Nộp --%>
                                            <%
                                                Object objDeadline = pageContext.getAttribute("bt");
                                                if (objDeadline instanceof model.TaoBaiTap) {
                                                    model.TaoBaiTap currentBt = (model.TaoBaiTap) objDeadline;
                                                    java.time.LocalDate deadline = currentBt.getDeadline();
                                                    if (deadline != null) {
                                                        out.print(deadline.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy")));
                                                    }
                                                }
                                            %>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=viewSubmissions&assignmentId=${bt.ID_BaiTap}" class="btn btn-sm btn-info btn-back">
                                                Xem bài nộp
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty assignmentList}">
                                    <tr><td colspan="5" class="text-center">Chưa có bài tập nào được giao.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="mt-4" style="text-align: center;">
                    <a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=lophoc" class="btn-back">
                        <i class="fas fa-arrow-left"></i> Quay lại danh sách lớp
                    </a>
                </div>
            </div>
        </div>

        <div class="modal fade" id="createAssignmentModal" tabindex="-1" aria-labelledby="modalLabel" hidden>
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <form action="${pageContext.request.contextPath}/teacherGetFromDashboard" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="action" value="createAssignment">
                        <input type="hidden" name="classId" value="${lopHoc.ID_LopHoc}">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalLabel"><i class="fas fa-plus-circle"></i> Đăng bài tập mới cho lớp ${lopHoc.tenLopHoc}</h5>
                        </div>
                        <div class="modal-body">
                            <table style="width: 100%; border-spacing: 0 15px; border-collapse: separate;">
                            <tbody>
                                <tr>
                                    <td style="width: 150px; padding-right: 15px; text-align: right;">
                                        <label for="tenBaiTap" class="form-label">Tên bài tập:</label>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control" id="tenBaiTap" name="tenBaiTap" required>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 150px; padding-right: 15px; text-align: right; vertical-align: top;">
                                        <label for="moTa" class="form-label">Mô tả / Yêu cầu:</label>
                                    </td>
                                    <td>
                                        <textarea class="form-control" id="moTa" name="moTa" rows="1"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 150px; padding-right: 15px; text-align: right;">
                                        <label for="deadline" class="form-label">Hạn nộp:</label>
                                    </td>
                                    <td>
                                        <input type="date" class="form-control" id="deadline" name="deadline" required>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 150px; padding-right: 15px; text-align: right;">
                                        <label for="assignmentFile" class="form-label">Đính kèm file:</label>
                                    </td>
                                    <td>
                                        <input class="form-control" type="file" id="assignmentFile" name="assignmentFile">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary" style="color:white">Đăng Bài</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
         <div class="footer">
            <p>&copy; 2025 EL CENTRE. All rights reserved. | Developed by ELCentre</p>
        </div>                
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
    </html>