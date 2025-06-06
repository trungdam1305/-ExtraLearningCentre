<%-- 
    Document   : ViewCourse
    Created on : May 31, 2025, 10:33:02 PM
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
        
         <!-- Nút quay lại -->
    <form action="${pageContext.request.contextPath}/views/ManagerCourses2.jsp" method="get" style="margin-top: 10px;">
        <button type="submit">Quay lại</button>
    </form>
        <c:forEach var="lop" items="${danhSachLopHoc}">
    <div>
        
        
        <h3>${lop.tenLopHoc}</h3>
        <p>ID Khóa học: ${lop.ID_KhoaHoc}</p>
        <p>Sĩ số: ${lop.siSo}</p>
        <p>Thời gian học: ${lop.thoiGianHoc}</p>
        <p>Ghi chú: ${lop.ghiChu}</p>
        <p>Trạng thái: ${lop.trangThai}</p>
        <p>Số tiền: ${lop.soTien}</p>
        <p>Ngày tạo: ${lop.ngayTao}</p>
        <p><img src="${lop.image}" width="150px"/></p>
        <hr>
    </div>
</c:forEach>

    </body>
</html>
