<%-- 
    Document   : viewCour
    Created on : May 29, 2025, 10:05:45 AM
    Author     : Vuh26
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Chưa có lớp học nào được tổ chức</h1>
        <!-- Nút quay lại -->
        <form action="${pageContext.request.contextPath}/views/ManagerCourses2.jsp" method="get" style="margin-top: 10px;">
            <button type="submit">Quay lại</button>
        </form>
    </body>
</html>
