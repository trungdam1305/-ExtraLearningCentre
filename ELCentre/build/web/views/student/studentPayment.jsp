<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${empty sessionScope.user}">
    <c:redirect url="${pageContext.request.contextPath}/views/login.jsp" />
</c:if>
<%@ include file="/views/student/sidebar.jsp" %>

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
</head>
<body>
<div class="main-content">
    <c:if test="${not empty sessionScope.message}">
        <div class="message success">
            <c:out value="${sessionScope.message}" />
        </div>
        <c:remove var="message" scope="session" />
    </c:if>

    <div class="header">
        <h2>Thông tin học phí</h2>
    </div>

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
</div>

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
</body>
</html>