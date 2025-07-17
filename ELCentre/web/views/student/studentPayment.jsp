<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${empty sessionScope.user}">
    <c:redirect url="${pageContext.request.contextPath}/views/login.jsp" />
</c:if>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thông tin học phí</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            body {
                font-family: 'Segoe UI', Arial, sans-serif;
                margin: 0;
                padding: 0;
                display: flex;
                background-color: #f4f6f9;
                color: #333;
            }
            .main-content {
                flex: 1;
                padding: 20px;
                max-width: 1200px;
                margin: 0 auto;
            }
            .header {
                margin-bottom: 20px;
                text-align: center;
            }
            .header h2 {
                color: #1F4E79;
                font-size: 28px;
                margin: 0;
            }
            .debug {
                background: #ffe6e6;
                padding: 10px;
                margin-bottom: 20px;
                border: 1px solid #ff9999;
                border-radius: 5px;
                font-size: 14px;
            }
            .no-data {
                background: white;
                padding: 40px;
                text-align: center;
                color: #888;
                border-radius: 10px;
                font-size: 18px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            .info-box {
                background: white;
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 20px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            .info-box h3 {
                color: #1F4E79;
                font-size: 20px;
                margin-top: 0;
            }
            .info-box p {
                margin: 8px 0;
                font-size: 16px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                border-radius: 10px;
                margin-top: 20px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                display: table !important;
            }
            th, td {
                padding: 12px;
                text-align: center;
                border-bottom: 1px solid #e0e0e0;
            }
            th {
                background-color: #1F4E79;
                color: white;
                font-weight: 600;
                font-size: 15px;
            }
            td {
                font-size: 14px;
                color: #333;
            }
            tr:hover {
                background-color: #f8f9fa;
            }
            .action-buttons {
                display: flex;
                justify-content: center;
                gap: 8px;
            }
            .action-btn {
                padding: 8px 16px;
                border: none;
                border-radius: 4px;
                font-size: 14px;
                font-weight: 500;
                cursor: pointer;
                color: white;
                transition: background-color 0.2s;
            }
            .action-btn.detail {
                background-color: #1F4E79;
            }
            .action-btn.detail:hover {
                background-color: #163d5c;
            }
            .action-btn.export {
                background-color: #28a745;
            }
            .action-btn.export:hover {
                background-color: #218838;
            }
            .action-btn.pay {
                background-color: #f0ad4e;
            }
            .action-btn.pay:hover {
                background-color: #d99632;
            }
            .message {
                margin-bottom: 20px;
                padding: 12px;
                border-radius: 5px;
                font-size: 14px;
                text-align: center;
            }
            .message.success {
                color: green;
                background-color: #e6ffe6;
                border: 1px solid #b2ffb2;
            }
        </style>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/simplePagination.js/1.6/jquery.simplePagination.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/simplePagination.js/1.6/simplePagination.css">
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
                padding: 0px;
            }
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 25px;
                background: white;
                border-radius: 10px;
                overflow: hidden;
            }
            th, td {
                border-bottom: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }
            th {
                background-color: #1F4E79;
                color: white;
            }
            .section-box {
                display: flex;
                gap: 30px;
                margin-top: 40px;
            }
            .section {
                flex: 1;
                background: white;
                padding: 20px;
                border-radius: 10px;
            }
            .section h3 {
                color: #1F4E79;
                margin-bottom: 15px;
            }
            .section .box-item {
                background-color: #eef2f7;
                margin-bottom: 10px;
                padding: 10px;
                border-radius: 5px;
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
            
            .header {
                position: sticky;
                top: 0;
                z-index: 999;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
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
            .new-support-btn {
                background-color: #1F4E79;
                color: white;
                padding: 8px 14px;
                border-radius: 5px;
                font-weight: bold;
                text-decoration: none;
                transition: background-color 0.3s ease;
                font-size: 14px;
            }

            .new-support-btn i {
                margin-right: 6px;
            }

            .new-support-btn:hover {
                background-color: #163d5c;
            }
            /* Wrapper layout */
            .wrapper {
                display: flex;
                min-height: 100vh;
                width: 100%;
            }
            
            .main-area {
               flex: 1;
               display: flex;
               flex-direction: column;
               background-color: #f4f6f9;
               overflow-x: auto;
            }
            
            .header {
                background-color: #1F4E79;
                color: white;
                padding: 16px 30px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            
            .main-content {
                flex: 1;
                padding: 30px;
                max-width: 100%; /* Đảm bảo không giới hạn chiều rộng */
                box-sizing: border-box; /* Bao gồm padding trong chiều rộng */
            }
        </style>
    </head>
    <body>
        <div class="wrapper">
            <%@ include file="/views/student/sidebar.jsp" %>
            <div class="main-area">
        
            <c:if test="${not empty sessionScope.message}">
                <div class="message success">
                    <c:out value="${sessionScope.message}" />
                </div>
                <c:remove var="message" scope="session" />
            </c:if>
                
             <div class="header" style="
                background-color: #1F4E79;
                color: white;
                padding: 16px 30px;
                margin: 0;
                width: 100%;
                box-sizing: border-box;
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-radius: 0;
                position: relative;
                top: 0;
                left: 0;
                z-index: 999;
            ">
                <h2 style="margin: 0; color: white;">Thông tin học phí</h2>
                <div class="user-menu">
                    <div class="user-toggle" onclick="toggleUserMenu()" style="color: white;">
                        <span><strong>${hocSinhInfo.hoTen}</strong>
                            <img src="${pageContext.request.contextPath}/${hocSinhInfo.avatar}" class="user-avatar" alt="Avatar">
                            ☰
                        </span>
                    </div>
                    <div class="user-dropdown" id="userDropdown">
                        <a href="${pageContext.request.contextPath}/ResetPasswordServlet" onclick="openModal(); return false;">🔑 Đổi mật khẩu</a>
                        <a href="${pageContext.request.contextPath}/LogoutServlet">🚪 Đăng xuất</a>
                    </div>
                </div>
            </div>

            <div class="main-content" style="padding: 30px;">
                <c:if test="${not empty hocSinhInfo}">
                    <div class="info-box">
                        <h3>Thông tin học sinh</h3>
                        <p><strong>Họ tên:</strong> <c:out value="${hocSinhInfo.hoTen}" default="N/A" /></p>
                        <p><strong>Tổng học phí:</strong> <fmt:formatNumber value="${tongHocPhi != null ? tongHocPhi : 0}" type="currency" currencySymbol="₫" /></p>
                        <p><strong>Đã đóng:</strong> <fmt:formatNumber value="${tongDaDong != null ? tongDaDong : 0}" type="currency" currencySymbol="₫" /></p>
                        <p><strong>Còn thiếu:</strong> <fmt:formatNumber value="${tongConThieu != null ? tongConThieu : 0}" type="currency" currencySymbol="₫" /></p>
                    </div>
                </c:if>

                <c:choose>
                    <c:when test="${not empty dsHocPhi && fn:length(dsHocPhi) > 0}">
                        <table id="payment-table">
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Môn học</th>
                                    <th>Mã lớp</th>
                                    <th>Tổng học phí</th>
                                    <th>Đã đóng</th>
                                    <th>Còn thiếu</th>
                                    <th>Phương thức thanh toán</th>
                                    <th>Trạng thái</th>
                                    <th>Ngày thanh toán</th>
                                    <th>Ghi chú</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="hocPhi" items="${dsHocPhi}" varStatus="loop">
                                    <tr>
                                        <td>${loop.count}</td>
                                        <td><c:out value="${hocPhi.monHoc}" default="N/A" /></td>
                                        <td><c:out value="${hocPhi.ID_LopHoc}" default="N/A" /></td>
                                        <td><fmt:formatNumber value="${hocPhi.tongHocPhi != null ? hocPhi.tongHocPhi : 0}" type="currency" currencySymbol="₫" /></td>
                                        <td><fmt:formatNumber value="${hocPhi.soTienDaDong != null ? hocPhi.soTienDaDong : 0}" type="currency" currencySymbol="₫" /></td>
                                        <td><fmt:formatNumber value="${hocPhi.conThieu != null ? hocPhi.conThieu : 0}" type="currency" currencySymbol="₫" /></td>
                                        <td><c:out value="${hocPhi.phuongThucThanhToan}" default="N/A" /></td>
                                        <td><c:out value="${hocPhi.tinhTrangThanhToan}" default="N/A" /></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${hocPhi.ngayThanhToan != null && hocPhi.ngayThanhToan.getClass().getName() == 'java.util.Date'}">
                                                    <fmt:formatDate value="${hocPhi.ngayThanhToan}" pattern="dd/MM/yyyy" />
                                                </c:when>
                                                <c:otherwise>N/A</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><c:out value="${hocPhi.ghiChu}" default="N/A" /></td>
                                        <td>
                                            <div class="action-buttons">
                                                <form action="${pageContext.request.contextPath}/StudentPaymentDetailServlet" method="get">
                                                    <input type="hidden" name="idHocPhi" value="${hocPhi.ID_HocPhi != null ? hocPhi.ID_HocPhi : ''}">
                                                    <button class="action-btn detail" type="submit" title="Xem chi tiết"><i class="fas fa-eye"></i> Xem</button>
                                                </form>
                                                <form action="${pageContext.request.contextPath}/ExportPaymentServlet" method="post">
                                                    <input type="hidden" name="idHocPhi" value="${hocPhi.ID_HocPhi != null ? hocPhi.ID_HocPhi : ''}">
                                                    <button class="action-btn export" type="submit" title="Xuất hóa đơn"><i class="fas fa-file-download"></i> Xuất</button>
                                                </form>
                                                <c:if test="${hocPhi.conThieu != null && hocPhi.conThieu > 0}">
                                                    <button class="action-btn pay" onclick="alert('Chức năng thanh toán đang được phát triển!')" title="Thanh toán"><i class="fas fa-credit-card"></i> Thanh toán</button>
                                                </c:if>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div id="pagination"></div>
                    </c:when>
                    <c:otherwise>
                        <div class="no-data">Không có thông tin học phí nào!</div>
                    </c:otherwise>
                </c:choose>
            

                <script>
                    $(document).ready(function() {
                        console.log("JavaScript loaded successfully");
                        // Phân trang (nếu cần)
                        var itemsPerPage = 10;
                        var $table = $('#payment-table');
                        var $rows = $table.find('tbody tr');
                        var totalRows = $rows.length;
                        var totalPages = Math.ceil(totalRows / itemsPerPage);

                        if (totalRows > itemsPerPage) {
                            $rows.hide();
                            $rows.slice(0, itemsPerPage).show();
                            $('#pagination').pagination({
                                items: totalRows,
                                itemsOnPage: itemsPerPage,
                                cssStyle: 'light-theme',
                                onPageClick: function(pageNumber) {
                                    var start = (pageNumber - 1) * itemsPerPage;
                                    var end = start + itemsPerPage;
                                    $rows.hide();
                                    $rows.slice(start, end).show();
                                }
                            });
                        }
                    });
                </script>
                
                <!-- Java script thanh menu người dùng --> 
                <script>
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
                </script>
                
                                <!-- 🔐 MODAL ĐỔI MẬT KHẨU -->
                <div id="passwordModal" class="modal-overlay" style="display: none;">
                    <div class="modal-content">
                        <h3>🔐 Đổi mật khẩu</h3>
                        <!-- ✅ submit bình thường, không dùng fetch -->
                        <form method="post" action="${pageContext.request.contextPath}/ResetPasswordServlet">
                            <input type="password" name="currentPassword" placeholder="Mật khẩu hiện tại" required>
                            <input type="password" name="newPassword" placeholder="Mật khẩu mới" required>
                            <input type="password" name="confirmPassword" placeholder="Xác nhận mật khẩu" required>
                            <div class="modal-actions">
                                <button type="submit" class="action-btn">Cập nhật</button>
                                <button type="button" class="action-btn cancel" onclick="closeModal()">Hủy</button>
                            </div>
                        </form>
                        <!-- ✅ Hiển thị thông báo (nếu có) -->
                        <c:if test="${not empty requestScope.message}">
                            <p style="color: red; margin-top: 10px;">${requestScope.message}</p>
                        </c:if>
                    </div>
                </div>

                <script>
                    function openModal() {
                        document.getElementById("passwordModal").style.display = "flex";
                    }

                    function closeModal() {
                        document.getElementById("passwordModal").style.display = "none";
                    }

                    // Đóng modal nếu bấm ra ngoài
                    document.addEventListener("click", function(e) {
                        const modal = document.getElementById("passwordModal");
                        if (e.target === modal) {
                            closeModal();
                        }
                    });
                </script>
                </div>
                <%@ include file="/views/student/footer.jsp" %>
            </div>
        </div>            
    </body>
</html>