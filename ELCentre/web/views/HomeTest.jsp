<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Danh sách lớp học</title>
</head>
<body>

<c:choose>
    <c:when test="${empty lopHoc}">
        <h2>Biến lopHoc rỗng hoặc null</h2>
    </c:when>
    <c:otherwise>
        <h2>Danh sách lớp học (Số lượng: ${fn:length(lopHoc)})</h2>
        <table border="1" cellpadding="8" cellspacing="0">
            <thead>
                <tr>
                    <th>Mã lớp học</th>
                    <th>Tên lớp học</th>
                    <th>Số tiền</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="lop" items="${lopHoc}">
                    <tr>
                        <td>${lop.ID_LopHoc}</td>
                        <td>${lop.getTenLopHoc()}</td>
                        <td>${lop.getSoTien()}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:otherwise>
</c:choose>

</body>
</html>
