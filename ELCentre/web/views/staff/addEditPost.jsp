<!--Add and Edit Post jsp
Author : trungdam
-->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${formTitle} - EL CENTRE</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="<c:url value='img/ckeditor/ckeditor.js' />"></script>
    <style>
        /* Your existing common CSS styles go here. */
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            display: flex;
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
            margin-left: 250px;
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

        .admin-profile {
            position: relative;
            display: flex;
            align-items: center;
            cursor: pointer;
            margin-right: 20px;
        }

        .admin-profile .admin-img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #B0C4DE;
            margin-right: 10px;
        }

        .admin-profile span {
            font-size: 14px;
            color: #B0C4DE;
            font-weight: 600;
            max-width: 150px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .admin-profile i {
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
            min-width: 180px;
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
            padding: 8px 10px;
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
            margin-left: 270px;
            padding: 80px 20px 20px 20px;
            flex: 1;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            gap: 30px;
            margin-right: auto;
            max-width: calc(100% - 250px);
        }
        
        .footer {
            background-color: #1F4E79;
            color: #B0C4DE;
            text-align: center;
            padding: 5px 0;
            position: fixed;
            width: calc(100% - 250px);
            bottom: 0;
            margin-left: 250px;
            box-shadow: 0 -2px 5px rgba(0,0,0,0.1);
        }

        .footer p {
            margin: 0;
            font-size: 14px;
        }
        h1 {
            color: #1F4E79;
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 25px;
        }

        .card {
            background: linear-gradient(135deg, #ffffff, #f0f4f8);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .card-header {
            background-color: transparent;
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-header h3 {
            margin: 0;
            color: #1F4E79;
            display: flex;
            align-items: center;
            font-size: 22px;
        }

        .card-header h3 i {
            margin-right: 10px;
            color: #1F4E79;
        }

        .current-image-preview {
            max-width: 200px;
            height: auto;
            display: block;
            margin-top: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .ck-editor__editable_inline {
            min-height: 300px; /* Set a minimum height for the editor */
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
    <!--Sidebar-->
    <div class="sidebar">
            <h4>EL CENTRE</h4>
            <img src="<%= request.getContextPath() %>/img/SieuLogo-xoaphong.png" alt="Center Logo" class="sidebar-logo">
            <div class="sidebar-section-title">Tổng quan</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/staffGoToFirstPage"><i class="fas fa-chart-line"></i> Dashboard</a></li>
            </ul>
            <div class="sidebar-section-title">Quản lý học tập</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/Staff_ManageCourse"><i class="fas fa-book"></i> Khoá học</a></li>
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
                <li><a href="${pageContext.request.contextPath}/staffGetConsultationRequests"><i class="fas fa-blog"></i> Yêu cầu tư vấn</a></li>
            </ul>
            <div class="sidebar-section-title">Khác</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/ManagePost"><i class="fas fa-blog"></i> Bài Viết</a></li>
                <li><a href="${pageContext.request.contextPath}/ManageMaterial"><i class="fas fa-envelope-open-text"></i> Tài Liệu</a></li>                
                <li><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </div>

    <main class="main-content">
        <h1>${formTitle}</h1>

        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-pen-to-square"></i> Chi tiết Blog</h3>
            </div>
            <div class="card-body">
                <!--Error message-->
                <c:if test="${not empty param.error}">
                    <div class="alert alert-danger" role="alert">
                        <strong>Lỗi!</strong> ${param.error == 'upload_failed' ? 'Tải ảnh lên thất bại. Vui lòng thử lại.' : 'Đã có lỗi xảy ra.'}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/ManagePost" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="${blog == null ? 'addBlog' : 'updateBlog'}">
                    <c:if test="${blog != null}">
                        <input type="hidden" name="id" value="${blog.ID_Blog}">
                    </c:if>

                    <div class="mb-3">
                        <label for="blogTitle" class="form-label">Tiêu đề Blog <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="blogTitle" name="blogTitle" value="${blog.blogTitle}" required>
                    </div>

                    <div class="mb-3">
                        <label for="blogDescription" class="form-label">Mô tả ngắn <span class="text-danger">*</span></label>
                        <textarea class="form-control" id="blogDescription" name="blogDescription" rows="3" required>${blog.blogDescription}</textarea>
                    </div>
                    
                    <div class="mb-3">
                        <label for="noiDung" class="form-label">Nội dung chi tiết <span class="text-danger">*</span></label>
                        <textarea class="form-control" id="noiDung" name="noiDung" rows="10">${blog.noiDung}</textarea>
                    </div>

                    <!--Select KeyTag-->
                    <div class="mb-3">
                        <label for="idKeyTag" class="form-label">KeyTag</label>
                        <select class="form-select" id="idKeyTag" name="idKeyTag">
                            <%-- Default option: value="0" and selected if blog is new or ID_KeyTag is 0 --%>
                            <option value="0" ${blog == null || blog.ID_KeyTag == 0 ? 'selected' : ''}>Chọn KeyTag (Tùy chọn)</option> 
                            <c:forEach var="kt" items="${availableKeyTags}">
                                <option value="${kt.ID_KeyTag}" ${blog != null && blog.ID_KeyTag == kt.ID_KeyTag ? 'selected' : ''}>
                                    ${kt.getKeyTag()}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <!--Select KeyWord-->
                    <div class="mb-3">
                        <label for="idKeyword" class="form-label">KeyWord (SEO)</label>
                        <select class="form-select" id="idKeyword" name="idKeyword">
                            <%-- Default option: value="0" and selected if blog is new or ID_Keyword is 0 --%>
                            <option value="0" ${blog == null || blog.ID_Keyword == 0 ? 'selected' : ''}>Chọn Keyword (Tùy chọn)</option> 
                            <c:forEach var="kw" items="${availableKeywords}">
                                <option value="${kw.ID_Keyword}" ${blog != null && blog.ID_Keyword == kw.ID_Keyword ? 'selected' : ''}>
                                    ${kw.getKeyword()}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <!--Select PhanLoaiBlog-->
                    <div class="mb-3">
                        <label for="idPhanLoai" class="form-label">Phân loại Blog</label>
                        <select class="form-select" id="idPhanLoai" name="idPhanLoai">
                            <option value="" ${blog == null || blog.ID_PhanLoai == null || blog.ID_PhanLoai == 0 ? 'selected' : ''}>Chọn Phân loại (Tùy chọn)</option> 
                            <c:forEach var="phanLoai" items="${phanLoaiList}">
                                <option value="${phanLoai.ID_PhanLoai}" ${blog != null && blog.ID_PhanLoai == phanLoai.ID_PhanLoai ? 'selected' : ''}>
                                    ${phanLoai.phanLoai}
                                </option>
                            </c:forEach>
                        </select>
                    </div>


                    <div class="mb-3">
                        <label for="image" class="form-label">Ảnh đại diện</label>
                        <input type="file" class="form-control" id="image" name="image" accept="image/*">
                        <c:if test="${blog != null && not empty blog.image}">
                            <div class="mt-2">
                                Ảnh hiện tại: <br>
                                <img src="${pageContext.request.contextPath}/img/blog_images/${blog.image}" alt="Ảnh Blog" class="current-image-preview">
                            </div>
                        </c:if>
                    </div>

                    <div class="text-center mt-4">
                        <button type="submit" class="btn btn-primary btn-lg me-2">
                            <i class="fas fa-save me-2"></i> ${blog == null ? 'Thêm mới' : 'Cập nhật'}
                        </button>
                        <a href="${pageContext.request.contextPath}/ManagePost" class="btn btn-secondary btn-lg">
                            <i class="fas fa-arrow-alt-circle-left me-2"></i> Quay lại
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <div class="footer">
        <p>© 2025 EL CENTRE. All rights reserved. | Developed by EL CENTRE</p>
    </div>

    <script>
        function toggleDropdown() {
            document.getElementById("adminDropdown").classList.toggle("active");
        }

        window.onclick = function(event) {
            if (!event.target.matches('.admin-profile') && !event.target.matches('.admin-profile *')) {
                var dropdowns = document.getElementsByClassName("dropdown-menu");
                for (var i = 0; i < dropdowns.length; i++) {
                    var openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('active')) {
                        openDropdown.classList.remove('active');
                    }
                }
            }
        };
        
        $(document).ready(function () {
        if (typeof CKEDITOR !== 'undefined') {
            CKEDITOR.replace('noiDung');
        } else {
            console.error("CKEDITOR không tồn tại. Chắc chắn bạn đã import đúng chưa?");
        }
    });

    </script>
</body>
</html>