<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.KhoaHoc"%>
<%@page import="dal.KhoaHocDAO"%>
<%@page import="java.util.*"%>

<html>
    <head><title>Thêm khóa học</title></head>
    <body>
        <h2>Thêm khóa học khóa học</h2>  
        <form action="${pageContext.request.contextPath}/AddKhoaHoc" method="get">

            <label>Tên khóa học:</label>
            <input type="text" name="TenKhoaHoc"  required/><br/>

            <label>Mô tả:</label>
            <textarea name="MoTa"></textarea><br/>

            <label>Thời gian bắt đầu:</label>
            <input type="date" name="ThoiGianBatDau" min="${today}" /><br/>

            <label>Thời gian kết thúc:</label>
            <input type="date" name="ThoiGianKetThuc" min="${today}" /><br/>


            <label>Ghi chú:</label>
            <input type="text" name="GhiChu" /><br/>

           
            <button type="submit">Thêm</button>
        </form>

        <c:if test="${not empty err}">
            <p style="color: red;">${err}</p>
        </c:if>

        <c:if test="${not empty suc}">
            <p style="color: green;">${suc}</p>
        </c:if>
        <!-- Nút quay lại -->
        <form action="${pageContext.request.contextPath}/views/ManagerCourses2.jsp" method="get" style="margin-top: 10px;">
            <button type="submit">Quay lại</button>
        </form>

    </body> 
</html>
