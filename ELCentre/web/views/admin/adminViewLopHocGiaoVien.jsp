
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh Sách Lớp Học Giáo Viên</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        img.avatar {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 50%;
        }
        .error {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>
    <h2>Danh Sách Lớp Học Giáo Viên</h2>

    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>

    <c:if test="${empty lopHocs}">
        <p class="error">Không tìm thấy lớp học nào cho giáo viên này.</p>
    </c:if>

    <c:if test="${not empty lopHocs}">
        <table>
            <thead>
                <tr>
                    <th>Mã Lớp</th>
                    <th>Tên Lớp</th>
                    <th>Khóa Học</th>
                    <th>Sĩ Số</th>
                    <th>Sĩ Số Tối Đa</th>
                    <th>Sĩ Số Tối Thiểu</th>
                    <th>Trạng Thái</th>
                    <th>Số Tiền</th>
                    <th>Ngày Tạo</th>
                    <th>Ghi Chú</th>
                    <th>Hình Ảnh Lớp</th>
                    <th>Thứ Tự</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="lopHoc" items="${lopHocs}">
                    <tr>
                        <td>${lopHoc.classCode}</td>
                        <td>${lopHoc.tenLopHoc}</td>
                        <td>${lopHoc.idKhoaHoc}</td>
                        <td>${lopHoc.siSo}</td>
                        <td>${lopHoc.siSoToiDa}</td>
                        <td>${lopHoc.siSoToiThieu}</td>
                        <td>${lopHoc.trangThai}</td>
                        <td>${lopHoc.soTien} VND</td>
                        <td>${lopHoc.ngayTao}</td>
                        <td>${lopHoc.ghiChu}</td>
                        <td>
                            <c:if test="${not empty lopHoc.avatarGiaoVien}">
                                <img src="${pageContext.request.contextPath}/images/${lopHoc.avatarGiaoVien}" alt="Hình lớp" class="avatar">
                            </c:if>
                            <c:if test="${empty lopHoc.avatarGiaoVien}">
                                Không có ảnh
                            </c:if>
                        </td>
                        <td>${lopHoc.order}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <br>
    <a href="${pageContext.request.contextPath}/views/admin/dashboard">Quay lại Dashboard</a>
</body>
</html>