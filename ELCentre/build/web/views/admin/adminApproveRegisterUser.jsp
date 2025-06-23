<%-- 
    Document   : adminApproveRegisterUser
    Created on : 5 thg 6, 2025, 22:44:31
    Author     : vkhan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Phê duyệt yêu cầu tư vấn</title>
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
    </style>
</head>
<body>
    <h2>Danh sách yêu cầu tư vấn</h2>
    <%
        String successMessage = (String) session.getAttribute("successMessage");
        String errorMessage = (String) session.getAttribute("errorMessage");
        if (successMessage != null) {
    %>
        <div style="color: green; text-align: center; font-weight: bold;"><%= successMessage %></div>
    <%
            session.removeAttribute("successMessage");
        } else if (errorMessage != null) {
    %>
        <div style="color: red; text-align: center; font-weight: bold;"><%= errorMessage %></div>
    <%
            session.removeAttribute("errorMessage");
        }
    %>
    
    
    <c:choose>
        <c:when test="${not empty requestScope.listTuVan}">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nội dung</th>
                        <th>Thời gian</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="tb" items="${requestScope.listTuVan}">
                        <tr>
                            <td>${tb.ID_ThongBao}</td>
                            <td>${tb.noiDung}</td>
                            <td>${tb.thoiGian}</td>
                            <td>
                                <form action="${pageContext.request.contextPath}/views/sendAdviceMail.jsp" method="get">

                                    <input type="hidden" name="id" value="${tb.ID_ThongBao}" />
                                    <button type="submit">Gửi email tư vấn</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <div class="no-data">
                <p>Không có yêu cầu tư vấn nào.</p>
            </div>
        </c:otherwise>
    </c:choose>
    <div style="text-align:center; margin-top: 20px;">
        <c:if test="${totalPages > 1}">
            <c:forEach begin="1" end="${totalPages}" var="i">
                <c:choose>
                    <c:when test="${i == currentPage}">
                        <span style="margin: 0 5px; font-weight: bold; color: #1F4E79;">${i}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/adminApproveRegisterUser.jsp?page=${i}"
                           style="margin: 0 5px; color: #1F4E79; text-decoration: none;">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </c:if>
    </div>


    <div class="back-button">
        <a href="${pageContext.request.contextPath}/views/admin/adminDashboard.jsp">Quay lại trang chủ</a>
    </div>
</body>
</html>
