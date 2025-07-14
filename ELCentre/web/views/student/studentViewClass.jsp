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
    <title>Lớp học đã đăng ký</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-pagination.js@1.6/jquery.simplePagination.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simple-pagination.js@1.6/simplePagination.css">

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
            padding: 30px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
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
            margin-top: 25px;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
            display: table !important;
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
            padding: 6px 14px;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            font-weight: bold;
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
        #pagination-container {
            margin-top: 20px;
            display: flex;
            justify-content: flex-end;
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
        <h2>Lớp học đã tham gia</h2>
        <div class="user-menu">
            <div class="user-toggle" onclick="toggleUserMenu()">
                <span><strong>${hocSinhInfo.hoTen}</strong>
                <img src="${pageContext.request.contextPath}/${hocSinhInfo.avatar}" class="user-avatar" alt="Avatar">
                ☰</span>
            </div>
            <div class="user-dropdown" id="userDropdown">
                <a href="${pageContext.request.contextPath}/ResetPasswordServlet" onclick="openModal(); return false;">🔐 Đổi mật khẩu</a>
                <a href="${pageContext.request.contextPath}/LogoutServlet">🚪 Đăng xuất</a>
            </div>
        </div>
    </div>

<!--     Debug: Display size of dsLopHoc 
    <p>Debug: Số lượng lớp học: <c:out value="${fn:length(dsLopHoc)}" /></p>-->

    <form method="get" style="display: flex; gap: 10px; flex-wrap: wrap; justify-content: flex-end; margin-bottom: 20px;">
        <c:set var="renderedClassCodes" value="," />
        <select name="classCode" style="padding: 8px; font-size: 14px;">
            <option value="">-- Tất cả mã lớp --</option>
            <c:forEach var="lop" items="${dsLopHoc}">
                <c:set var="curCode" value="${lop.classCode}" />
                <c:set var="matchStr" value=",${curCode}," />
                <c:if test="${not fn:contains(renderedClassCodes, matchStr)}">
                    <option value="${curCode}" ${param.classCode == curCode ? 'selected' : ''}>${curCode}</option>
                    <c:set var="renderedClassCodes" value="${renderedClassCodes}${curCode}," />
                </c:if>
            </c:forEach>
        </select>

        <c:set var="renderedKhoaHocs" value="," />
        <select name="khoaHoc" style="padding: 8px; font-size: 14px;">
            <option value="">-- Tất cả khóa học --</option>
            <c:forEach var="lop" items="${dsLopHoc}">
                <c:set var="curKhoa" value="${lop.tenKhoaHoc}" />
                <c:set var="matchKhoa" value=",${curKhoa}," />
                <c:if test="${not fn:contains(renderedKhoaHocs, matchKhoa)}">
                    <option value="${curKhoa}" ${param.khoaHoc == curKhoa ? 'selected' : ''}>${curKhoa}</option>
                    <c:set var="renderedKhoaHocs" value="${renderedKhoaHocs}${curKhoa}," />
                </c:if>
            </c:forEach>
        </select>

        <!-- Ô tìm kiếm -->
        <input id="searchInput" type="text" name="keyword" placeholder="Tìm kiếm..." value="${param.keyword}" style="padding: 8px; font-size: 14px; width: 250px;">

        <!-- Nút -->
        <button type="submit" class="action-btn">Tìm</button>
    </form>

    <c:choose>
        <c:when test="${not empty dsLopHoc}">
            <table id="courseTable">
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Mã lớp</th>
                        <th>Tên lớp</th>
                        <th>Khóa học</th>
                        <th>Sĩ số</th>
                        <th>Ngày tạo</th>
                        <th>Ghi chú</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody id="tableBody">
                    <c:forEach var="lop" items="${dsLopHoc}" varStatus="loop">
                        <c:if test="${(empty param.classCode or (lop.classCode != null and fn:containsIgnoreCase(lop.classCode, param.classCode))) 
                                      and (empty param.khoaHoc or (lop.tenKhoaHoc != null and fn:containsIgnoreCase(lop.tenKhoaHoc, param.khoaHoc))) 
                                      and (empty param.keyword 
                                           or (lop.classCode != null and fn:containsIgnoreCase(lop.classCode, param.keyword)) 
                                           or (lop.tenLopHoc != null and fn:containsIgnoreCase(lop.tenLopHoc, param.keyword)) 
                                           or (lop.tenKhoaHoc != null and fn:containsIgnoreCase(lop.tenKhoaHoc, param.keyword)) 
                                           or (lop.ghiChu != null and fn:containsIgnoreCase(lop.ghiChu, param.keyword)))}">
                            <tr>
                                <td>${loop.count}</td>
                                <td><c:out value="${lop.classCode}" default="N/A" /></td>
                                <td><c:out value="${lop.tenLopHoc}" default="N/A" /></td>
                                <td><c:out value="${lop.tenKhoaHoc}" default="N/A" /></td>
                                <td><c:out value="${lop.siSo}" default="0" /></td>
                                <td><c:out value="${lop.ngayTao}" default="N/A" /></td>
                                <td><c:out value="${lop.ghiChu}" default="N/A" /></td>
                                <td>
                                    <div class="action-buttons">
                                        <form action="StudentClassDetailServlet" method="get">
                                            <input type="hidden" name="classCode" value="${fn:escapeXml(lop.classCode)}">
                                            <button class="action-btn" type="submit">Xem giáo viên</button>
                                        </form>
                                        <button type="button" class="action-btn transfer"
                                                onclick="loadTransferOptions('${fn:escapeXml(lop.classCode)}')">
                                            Chuyển lớp
                                        </button>
                                        <form action="StudentLeaveClassServlet" method="post"
                                              onsubmit="return confirm('Bạn có chắc muốn rời khỏi lớp này?');">
                                            <input type="hidden" name="classCode" value="${fn:escapeXml(lop.classCode)}">
                                            <button class="action-btn leave" type="submit">Rời lớp</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                            <tr id="transfer-row-${fn:escapeXml(lop.classCode)}" style="display:none;">
                                <td colspan="8" id="transfer-content-${fn:escapeXml(lop.classCode)}"></td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </tbody>
            </table>
            <div id="pagination-container"></div>
        </c:when>
        <c:otherwise>
            <div class="no-data">
                <c:choose>
                    <c:when test="${not empty param.keyword or not empty param.classCode or not empty param.khoaHoc}">
                        Không tìm thấy lớp học nào khớp với tiêu chí tìm kiếm!
                    </c:when>
                    <c:otherwise>
                        Bạn chưa đăng ký lớp học nào!
                    </c:otherwise>
                </c:choose>
            </div>
        </c:otherwise>
    </c:choose>

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
    function loadTransferOptions(classCode) {
        const row = document.getElementById("transfer-row-" + classCode);
        const content = document.getElementById("transfer-content-" + classCode);
        if (!row || !content) {
            console.error("Transfer row or content not found for classCode: " + classCode);
            return;
        }

        if (row.style.display === "table-row") {
            row.style.display = "none";
            content.innerHTML = "";
            return;
        }

        fetch("LoadClassToTransferServlet?classCode=" + encodeURIComponent(classCode))
            .then(res => {
                if (!res.ok) throw new Error("Failed to fetch transfer options");
                return res.text();
            })
            .then(html => {
                content.innerHTML = html;
                row.style.display = "table-row";
            })
            .catch(err => {
                console.error(err);
                content.innerHTML = "<div style='color:red;'>Không thể tải danh sách lớp chuyển.</div>";
                row.style.display = "table-row";
            });
    }

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
        if (e.target === modal) {
            closeModal();
        }
    });

    $(document).ready(function () {
        var itemsPerPage = 5;
        var items = $("#tableBody tr:not([id^='transfer-row'])"); 
        var numItems = items.length;

        function showPage(items, page) {
            var start = (page - 1) * itemsPerPage;
            var end = start + itemsPerPage;
            items.hide().slice(start, end).show();
        }

        if (numItems > 0) {
            showPage(items, 1);
            $('#pagination-container').pagination({
                items: numItems,
                itemsOnPage: itemsPerPage,
                onPageClick: function (pageNumber) {
                    showPage(items, pageNumber);
                }
            });
        }
    });
</script>
</body>
</html>