<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:if test="${empty sessionScope.user}">
    <c:redirect url="${pageContext.request.contextPath}/views/login.jsp" />
</c:if>
<%@ include file="/views/student/sidebar.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-pagination.js@1.6/jquery.simplePagination.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simple-pagination.js@1.6/simplePagination.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

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
            padding: 40px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
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
            /* Css phân trang và menu người dùng */
            #pagination-lophoc,
            #pagination-thongbao,
            #pagination-lichhoc {
                margin-top: 20px;
                display: flex;
                justify-content: flex-end; /* căn phải */
            }

            .pagination {
                list-style: none;
                padding-left: 0;
                margin: 0;
                display: flex;
                gap: 6px;
            }

            .pagination li {
                display: inline;
            }

            .pagination li a,
            .pagination li span {
                display: inline-block;
                padding: 6px 14px;
                font-size: 14px;
                font-weight: bold;
                border-radius: 4px;
                background-color: #1F4E79;
                color: #fff;
                text-decoration: none;
                transition: background-color 0.2s ease;
                border: none;
            }

            .pagination li a:hover,
            .pagination li span:hover {
                background-color: #163d5c;
            }

            .pagination li.active span {
                background-color: #163d5c;
            }
    </style>
</head>
<body>
<div class="main-content">
    <div class="header">
        <h2>Lịch học của tôi</h2>
        <div class="user-menu">
            <div class="user-toggle" onclick="toggleUserMenu()">
                <span><strong>${hocSinhInfo.hoTen}</strong>
                    <img src="${pageContext.request.contextPath}/${hocSinhInfo.avatar}" class="user-avatar" alt="Avatar"> ☰
                </span>
            </div>
            <div class="user-dropdown" id="userDropdown">
                <a href="${pageContext.request.contextPath}/ResetPasswordServlet" onclick="openModal(); return false;">🔑 Đổi mật khẩu</a>
                <a href="${pageContext.request.contextPath}/LogoutServlet">🚪 Đăng xuất</a>
            </div>
        </div>
    </div>

<!--     Debug: Display size of lichHocList 
    <p>Debug: Số lượng lịch học: <c:out value="${fn:length(lichHocList)}" /></p>-->

    <!-- Filter Form -->
    <form method="get" style="display: flex; gap: 10px; flex-wrap: wrap; justify-content: flex-end; margin-bottom: 20px;">
        <c:set var="renderedClasses" value="," />
        <select name="tenLopHoc" style="padding: 8px; font-size: 14px;">
            <option value="">-- Tất cả lớp học --</option>
            <c:forEach var="lh" items="${lichHocList}">
                <c:set var="curClass" value="${lh.tenLopHoc}" />
                <c:set var="matchClass" value=",${curClass}," />
                <c:if test="${not fn:contains(renderedClasses, matchClass)}">
                    <option value="${curClass}" ${param.tenLopHoc == curClass ? 'selected' : ''}>${curClass}</option>
                    <c:set var="renderedClasses" value="${renderedClasses}${curClass}," />
                </c:if>
            </c:forEach>
        </select>

        <c:set var="renderedDates" value="," />
        <select name="ngayHoc" style="padding: 8px; font-size: 14px;">
            <option value="">-- Tất cả ngày học --</option>
            <c:forEach var="lh" items="${lichHocList}">
                <c:set var="curDate" value="${lh.ngayHoc}" />
                <c:set var="matchDate" value=",${curDate}," />
                <c:if test="${not fn:contains(renderedDates, matchDate)}">
                    <option value="${curDate}" ${param.ngayHoc == curDate ? 'selected' : ''}>${curDate}</option>
                    <c:set var="renderedDates" value="${renderedDates}${curDate}," />
                </c:if>
            </c:forEach>
        </select>

        <input id="searchInput" type="text" name="keyword" placeholder="Tìm kiếm..." value="${param.keyword}" style="padding: 8px; font-size: 14px; width: 250px;">
        <button type="submit" class="action-btn">Tìm</button>
    </form>

    <c:choose>
        <c:when test="${not empty lichHocList}">
            <table id="lichhocTable">
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Ngày học</th>
                        <th>Giờ học</th>
                        <th>Lớp học</th>
                        <th>Phòng học</th>
                        <th>Ghi chú</th>
                    </tr>
                </thead>
                <tbody id="tableBody">
                    <c:forEach var="lh" items="${lichHocList}" varStatus="loop">
                        <c:if test="${(empty param.tenLopHoc or (lh.tenLopHoc != null and fn:containsIgnoreCase(lh.tenLopHoc, param.tenLopHoc))) 
                                      and (empty param.ngayHoc or (lh.ngayHoc != null and fn:containsIgnoreCase(lh.ngayHoc, param.ngayHoc))) 
                                      and (empty param.keyword 
                                           or (lh.tenLopHoc != null and fn:containsIgnoreCase(lh.tenLopHoc, param.keyword)) 
                                           or (lh.ngayHoc != null and fn:containsIgnoreCase(lh.ngayHoc, param.keyword)) 
                                           or (lh.slotThoiGian != null and fn:containsIgnoreCase(lh.slotThoiGian, param.keyword)) 
                                           or (lh.tenPhongHoc != null and fn:containsIgnoreCase(lh.tenPhongHoc, param.keyword)) 
                                           or (lh.ghiChu != null and fn:containsIgnoreCase(lh.ghiChu, param.keyword)))}">
                            <tr>
                                <td>${loop.count}</td>
                                <td><c:out value="${lh.ngayHoc}" default="N/A" /></td>
                                <td><c:out value="${lh.slotThoiGian}" default="N/A" /></td>
                                <td><c:out value="${lh.tenLopHoc}" default="N/A" /></td>
                                <td><c:out value="${lh.tenPhongHoc}" default="N/A" /></td>
                                <td><c:out value="${lh.ghiChu}" default="N/A" /></td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </tbody>
            </table>
            <div id="pagination-lichhoc"></div>
        </c:when>
        <c:otherwise>
            <div class="no-data">
                <c:choose>
                    <c:when test="${not empty param.keyword or not empty param.tenLopHoc or not empty param.ngayHoc}">
                        Không tìm thấy lịch học nào khớp với tiêu chí tìm kiếm!
                    </c:when>
                    <c:otherwise>
                        Bạn chưa có lịch học nào sắp tới!
                    </c:otherwise>
                </c:choose>
            </div>
        </c:otherwise>
    </c:choose>

    <div class="timetable-wrapper">
        <h3>🗓️ Thời khóa biểu tuần này</h3>
        <c:if test="${empty timeSlots or empty daysOfWeek}">
            <div class="no-data">Không thể hiển thị thời khóa biểu do thiếu dữ liệu cấu hình!</div>
        </c:if>
        <c:if test="${not empty timeSlots and not empty daysOfWeek}">
            <table class="timetable">
                <thead>
                    <tr>
                        <th>Giờ học</th>
                        <c:forEach var="day" items="${daysOfWeek}">
                            <th>${day}</th>
                        </c:forEach>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="slot" items="${timeSlots}">
                        <tr>
                            <td>${slot}</td>
                            <c:forEach var="day" items="${daysOfWeek}">
                                <c:set var="className" value="${timetableData[slot][day]}" />
                                <td class="${not empty className ? 'active' : ''}">
                                    <c:out value="${className}" default="" />
                                </td>
                            </c:forEach>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>

    <!-- Modal for Password Change -->
    <div id="passwordModal" class="modal-overlay" style="display: none;">
        <div class="modal-content">
            <h3>🔐 Đổi mật khẩu</h3>
            <form method="post" action="${pageContext.request.contextPath}/ResetPasswordServlet">
                <input type="password" name="currentPassword" placeholder="Mật khẩu hiện tại" required>
                <input type="password" name="newPassword" placeholder="Mật khẩu mới" required>
                <input type="password" name="confirmPassword" placeholder="Xác nhận mật khẩu" required>
                <div class="modal-actions">
                    <button type="submit" class="action-btn">Cập nhật</button>
                    <button type="button" class="action-btn cancel" onclick="closeModal()">Hủy</button>
                </div>
            </form>
            <c:if test="${not empty requestScope.message}">
                <p style="color: red; margin-top: 10px;">${requestScope.message}</p>
            </c:if>
        </div>
    </div>
</div>

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
            $('#pagination-lichhoc').pagination({
                items: numItems,
                itemsOnPage: itemsPerPage,
                onPageClick: function (pageNumber) {
                    showPage(items, pageNumber);
                }
            });
        }
    });

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

    function openModal() {
        document.getElementById("passwordModal").style.display = "flex";
    }

    function closeModal() {
        document.getElementById("passwordModal").style.display = "none";
    }

    document.addEventListener("click", function(e) {
        const modal = document.getElementById("passwordModal");
        if (e.target === modal) closeModal();
    });
</script>
</body>
</html>