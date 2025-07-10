<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/views/student/sidebar.jsp" %>
<c:if test="${empty sessionScope.user}">
    <c:redirect url="${pageContext.request.contextPath}/views/login.jsp" />
</c:if>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách lớp trong khóa học</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-style.css">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f9;
            display: flex;
        }
        .logout-link {
            margin-top: 35px;
            font-weight: bold;
            color: #ffcccc;
            font-size: 16px;
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
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            padding: 12px;
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
        }
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
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
            text-decoration: none;
        }
        .action-btn:hover {
            background-color: #163d5c;
        }
        .enroll {
            background-color: #28a745;
        }
        .enroll:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<!-- MAIN CONTENT -->
<div class="main-content">
    <div class="header">
        <h2>Danh sách lớp trong khóa học</h2>
        <span>Xin chào ${sessionScope.user.email}</span>
    </div>
    
    

    <c:choose>
        <c:when test="${not empty dsLopHoc}">
            <table>
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Mã lớp</th>
                        <th>Tên lớp</th>
                        <th>Khóa học</th>
                        <th>Thời gian học</th>
                        <th>Sĩ số</th>
                        <th>Ngày tạo</th>
                        <th>Ghi chú</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="lop" items="${dsLop}" varStatus="i">
                        <tr>
                            <td>${i.index + 1}</td>
                            <td>${lop.classCode}</td>
                            <td>${lop.tenLopHoc}</td>
                            <td>${lop.tenKhoaHoc}</td>
                            <td>${lop.thoiGianBatDau} → ${lop.thoiGianKetThuc}</td>
                            <td>${lop.siSo}/${lop.siSoToiDa}</td>
                            <td>${lop.ngayTao}</td>
                            <td>${lop.ghiChu}</td>
                            <td>
                                <div class="action-buttons">
                                    <form action="StudentClassDetailServlet" method="get">
                                        <input type="hidden" name="classCode" value="${lop.classCode}">
                                        <button class="action-btn" type="submit">Chi tiết</button>
                                    </form>
                                    <form action="StudentRequestEnrollServlet" method="post">
                                        <input type="hidden" name="classCode" value="${lop.classCode}">
                                        <button class="action-btn enroll" type="submit">Đăng ký</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <div class="no-data">Không có lớp học nào trong khóa học này.</div>
        </c:otherwise>
    </c:choose>
            
            
</div>
</body>
</html>
