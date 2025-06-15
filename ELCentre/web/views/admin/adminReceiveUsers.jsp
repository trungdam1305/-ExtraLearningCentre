<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản lý tài khoản</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f8fb;
                color: #1F4E79;
                margin: 20px;
            }

            h2 {
                text-align: center;
                color: #1F4E79;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px auto;
                background-color: #ffffff;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }

            th, td {
                padding: 10px 12px;
                border: 1px solid #d0d7de;
                text-align: center;
            }

            th {
                background-color: #1F4E79;
                color: white;
            }

            tr:nth-child(even) {
                background-color: #f0f4f8;
            }

            tr:hover {
                background-color: #d9e4f0;
            }

            .no-data {
                text-align: center;
                margin: 30px;
                color: red;
            }

            .back-button {
                text-align: center;
                margin-top: 30px;
            }

            .back-button a {
                background-color: #1F4E79;
                color: white;
                padding: 10px 20px;
                text-decoration: none;
                border-radius: 5px;
            }

            .back-button a:hover {
                background-color: #163b5c;
            }

            input[type="text"], select {
                padding: 8px;
                font-size: 16px;
                margin-bottom: 15px;
            }

            #pagination button {
                margin: 0 5px;
                padding: 5px 10px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <h2>Quản lý tài khoản</h2>

        <div style="display: flex; justify-content: flex-end; align-items: center; gap: 15px;">
            <input type="text" id="searchInput" placeholder="Tìm kiếm...">

            <label for="statusFilter" style="margin: 0;">Lọc theo trạng thái:</label>
            <select id="statusFilter">
                <option value="all">Tất cả</option>
                <option value="active">Active</option>
                <option value="inactive">Inactive</option>
            </select>

            <label for="roleFilter" style="margin: 0;">Lọc theo vai trò:</label>
            <select id="roleFilter">
                <option value="all">Tất cả</option>
                <option value="hocsinh">Học sinh</option>
                <option value="giaovien">Giáo viên</option>
                <option value="phuhuynh">Phụ huynh</option>
            </select>
        </div>


        <c:choose>
            <c:when test="${not empty sessionScope.taikhoans}">
                <table id="userTable">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Email</th>
                            <th>Vai Trò</th>
                            <th>Số điện thoại</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="tk" items="${sessionScope.taikhoans}">
                            <tr>
                                <td>${tk.ID_TaiKhoan}</td>
                                <td>${tk.email}</td>
                                <td>${tk.userType}</td>
                                <td>${tk.soDienThoai}</td>
                                <td>${tk.trangThai}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/adminActionWithUser?action=view&id=${tk.ID_TaiKhoan}&type=${tk.userType}">View</a> |
                                    <c:choose>
                                        <c:when test="${tk.trangThai == 'Active'}">
                                            <a href="${pageContext.request.contextPath}/adminActionWithUser?action=disable&id=${tk.ID_TaiKhoan}&type=${tk.userType}">Disable</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/adminActionWithUser?action=enable&id=${tk.ID_TaiKhoan}&type=${tk.userType}">Enable</a>
                                        </c:otherwise>
                                    </c:choose>
                                    | 
                                    <a href="${pageContext.request.contextPath}/adminActionWithUser?action=update&id=${tk.ID_TaiKhoan}&type=${tk.userType}">Update</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="no-data">
                    <p>${message != null ? message : 'Không có dữ liệu tài khoản để hiển thị.'}</p>
                </div>
            </c:otherwise>
        </c:choose>

        <div id="pagination" style="text-align: center; margin-top: 15px;"></div>

        <div class="back-button">
            <a href="${pageContext.request.contextPath}/views/admin/adminDashboard.jsp">Quay lại trang chủ</a>
        </div>

        
    </body>
</html>
