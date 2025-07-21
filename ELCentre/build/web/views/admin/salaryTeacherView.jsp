<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lương Dự Tính Giáo Viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f8;
            margin: 0;
        }
        .content-container {
            margin-left: 250px;
            padding: 100px 40px 60px;
            min-height: 100vh;
            box-sizing: border-box;
        }
        .header {
            background-color: #1F4E79;
            color: white;
            padding: 12px 24px;
            position: fixed;
            top: 0;
            left: 250px;
            right: 0;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header .left-title {
            font-size: 20px;
            font-weight: 600;
        }
        .sidebar {
            width: 250px;
            background-color: #1F4E79;
            color: white;
            position: fixed;
            height: 100vh;
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        }
        .sidebar h4 {
            text-align: center;
            font-weight: bold;
        }
        .sidebar-logo {
            display: block;
            margin: 15px auto;
            width: 90px;
            height: 90px;
            border-radius: 50%;
            border: 2px solid #B0C4DE;
            object-fit: cover;
        }
        .sidebar-section-title {
            margin-top: 25px;
            font-size: 13px;
            color: #B0C4DE;
            text-transform: uppercase;
            border-bottom: 1px solid #B0C4DE;
            padding-bottom: 5px;
        }
        .sidebar-menu {
            list-style: none;
            padding: 0;
            margin: 10px 0;
        }
        .sidebar-menu li {
            margin: 8px 0;
        }
        .sidebar-menu a {
            display: flex;
            align-items: center;
            color: white;
            text-decoration: none;
            padding: 8px 12px;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .sidebar-menu a:hover {
            background-color: #163E5C;
        }
        .sidebar-menu a i {
            margin-right: 10px;
        }
        .table {
            font-size: 14px;
            background-color: white;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            border-radius: 10px;
            overflow: hidden;
        }
        .table th, .table td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }
        .table th {
            background-color: #e2eaf0;
            color: #1F4E79;
            font-weight: 600;
        }
        .bonus-penalty-section {
            margin-top: 20px;
            padding: 15px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        .total-salary {
            font-size: 18px;
            font-weight: bold;
            color: #1F4E79;
            margin-top: 15px;
        }
        .footer {
            background-color: #1F4E79;
            color: #B0C4DE;
            text-align: center;
            padding: 10px;
            font-size: 13px;
            position: fixed;
            bottom: 0;
            left: 250px;
            right: 0;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <div class="left-title">
            Lương Dự Tính Giáo Viên <i class="fas fa-money-check-alt"></i>
        </div>
    </div>

    <!-- Sidebar -->
    <div class="sidebar">
        <h4>EL CENTRE</h4>
        <img src="${pageContext.request.contextPath}/img/SieuLogo-xoaphong.png" alt="Center Logo" class="sidebar-logo">
        <div class="sidebar-section-title">Tổng quan</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/adminGoToFirstPage"><i class="fas fa-chart-line"></i> Dashboard</a></li>
        </ul>
        <div class="sidebar-section-title">Quản lý người dùng</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=hocsinh">Học sinh</a></li>
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=giaovien">Giáo viên</a></li>
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=taikhoan">Tài khoản</a></li>
        </ul>
        <div class="sidebar-section-title">Quản lý tài chính</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=hocphi"><i class="fas fa-money-bill-wave"></i> Học phí</a></li>
        </ul>
        <div class="sidebar-section-title">Quản lý học tập</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/ManageCourse"><i class="fas fa-book"></i> Khoá học</a></li>
            <li><a href="${pageContext.request.contextPath}/ManageSchedule"><i class="fas fa-calendar-alt"></i> Lịch học</a></li>
        </ul>
        <div class="sidebar-section-title">Hệ thống</div>
        <ul class="sidebar-menu">
            <li><a href="#"><i class="fas fa-cog"></i> Cài đặt</a></li>
        </ul>
        <div class="sidebar-section-title">Khác</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=yeucautuvan"><i class="fas fa-blog"></i> Yêu cầu tư vấn</a></li>
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=thongbao"><i class="fas fa-bell"></i> Thông báo</a></li>
            <li><a href="#"><i class="fas fa-blog"></i> Blog</a></li>
            <li><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="content-container">
        <h2>Lương Dự Tính Giáo Viên: ${tenGiaoVien}</h2>
        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">${error}</div>
        </c:if>
        <c:if test="${not empty message}">
            <div class="alert alert-success" role="alert">${message}</div>
        </c:if>

        <!-- Form chọn khoảng thời gian -->
        <form action="${pageContext.request.contextPath}/SalaryCalculation" method="get" class="mb-4">
            <input type="hidden" name="idGiaoVien" value="${idGiaoVien}">
            <div class="row">
                <div class="col-md-4">
                    <label for="startDate" class="form-label">Từ ngày:</label>
                    <input type="date" id="startDate" name="startDate" class="form-control" value="${startDate}">
                </div>
                <div class="col-md-4">
                    <label for="endDate" class="form-label">Đến ngày:</label>
                    <input type="date" id="endDate" name="endDate" class="form-control" value="${endDate}">
                </div>
                <div class="col-md-4 align-self-end">
                    <button type="submit" class="btn btn-primary">Tính Lương</button>
                </div>
            </div>
        </form>

        <!-- Bảng lương dự tính -->
        <c:if test="${not empty salaryList}">
            <div class="table-responsive">
                <table class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th>ID Lớp</th>
                            <th>Tên Lớp</th>
                            <th>Số Buổi Dạy</th>
                            <th>Sĩ Số Thực Tế</th>
                            <th>Học Phí (VNĐ)</th>
                            <th>Lương Dự Tính (VNĐ)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="salary" items="${salaryList}">
                            <tr>
                                <td>${salary.idLopHoc}</td>
                                <td>${salary.tenLopHoc}</td>
                                <td>${salary.soBuoiDay}</td>
                                <td>${salary.siSo}</td>
                                <td><fmt:formatNumber value="${salary.hocPhi}" pattern="#,##0.00"/></td>
                                <td><fmt:formatNumber value="${salary.luongDuTinh}" pattern="#,##0.00"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

        <!-- Thưởng/Phạt -->
        <div class="bonus-penalty-section">
            <form action="${pageContext.request.contextPath}/SaveTeacherSalary" method="post">
                <input type="hidden" name="idGiaoVien" value="${idGiaoVien}">
                <input type="hidden" name="startDate" value="${startDate}">
                <input type="hidden" name="endDate" value="${endDate}">
                <div class="row">
                    <div class="col-md-6">
                        <label for="bonusPenalty" class="form-label">Thưởng/Phạt (VNĐ):</label>
                        <input type="number" id="bonusPenalty" name="bonusPenalty" class="form-control" 
                               placeholder="Nhập số tiền thưởng/phạt (âm để phạt)" value="${bonusPenalty != null ? bonusPenalty : 0}">
                    </div>
                    <div class="col-md-6 align-self-end">
                        <button type="submit" class="btn btn-success">Lưu Lương</button>
                    </div>
                </div>
            </form>
            <div class="total-salary">
                Tổng lương: <span id="totalSalary"><fmt:formatNumber value="${totalSalary != null ? totalSalary : 0}" pattern="#,##0.00"/></span> VNĐ
            </div>
        </div>

        <!-- Nút quay lại -->
        <div class="mt-3">
            <a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=giaovien" class="btn btn-secondary">Quay lại danh sách giáo viên</a>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>© 2025 EL CENTRE. All rights reserved. | Developed by wrx_Chur04</p>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Hàm định dạng số với dấu phẩy và 2 chữ số thập phân
        function formatNumber(number) {
            return new Intl.NumberFormat('vi-VN', { 
                minimumFractionDigits: 2, 
                maximumFractionDigits: 2 
            }).format(number);
        }

        // Cập nhật tổng lương khi nhập thưởng/phạt
        document.getElementById('bonusPenalty').addEventListener('input', function() {
            const baseSalary = ${totalBaseSalary != null ? totalBaseSalary : 0};
            const bonusPenalty = parseFloat(this.value) || 0;
            const totalSalary = baseSalary + bonusPenalty;
            document.getElementById('totalSalary').textContent = formatNumber(totalSalary);
        });
    </script>
</body>
</html>