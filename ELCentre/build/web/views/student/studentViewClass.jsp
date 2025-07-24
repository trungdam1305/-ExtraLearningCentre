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
        <title>Lớp học đã đăng ký</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-style.css">
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                margin: 0;
                padding: 0;
                display: flex;
                background-color: #f4f6f9;
            }
            .logout-link {
                margin-top: 30px;
                font-weight: bold;
                color: #ffcccc;
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
                background-color: white;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
            }
            th, td {
                padding: 12px 14px;
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
                box-shadow: 0 1px 4px rgba(0,0,0,0.05);
            }

            .action-buttons {
                display: flex;
                justify-content: center;
                gap: 6px;
                flex-wrap: wrap;
            }

            .action-buttons form {
                margin: 0;
            }

            .action-btn {
                padding: 6px 12px;
                border: none;
                border-radius: 4px;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                color: white;
                background-color: #1F4E79;
                transition: background-color 0.2s ease;
            }
            .action-btn:hover {
                background-color: #163d5c;
            }
            .action-btn.transfer {
                background-color: #f0ad4e;
            }
            .action-btn.transfer:hover {
                background-color: #d99632;
            }
            .action-btn.leave {
                background-color: #d9534f;
            }
            .action-btn.leave:hover {
                background-color: #b52b27;
            }
            .action-btn.assignment {
                background-color: #5E936C;
            }
            .action-btn.assignment:hover {
                background-color: #3E5F44;
            }
        </style>
    </head>
    <body>
    <!-- MAIN CONTENT -->
    <div class="main-content">
        <div class="header">
            <h2>Lớp học đã đăng ký</h2>
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
                            <th>Sĩ số</th>
                            <th>Ghi chú</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="lop" items="${dsLopHoc}" varStatus="i">
                            <tr>
                                <td>${i.index + 1}</td>
                                <td>${lop.classCode}</td>
                                <td>${lop.tenLopHoc}</td>
                                <td>${lop.tenKhoaHoc}</td>
                                <td>${lop.siSo}</td>
                                <td>${lop.ghiChu}</td>
                                <td>
                                    <div class="action-buttons">
                                        <form action="StudentClassDetailServlet" method="get">
                                            <input type="hidden" name="classCode" value="${lop.classCode}">
                                            <button class="action-btn" type="submit">Xem giáo viên</button>
                                        </form>
                                        <form action="StudentAssignmentServlet" method="get">
                                            <input type="hidden" name="classId" value="${lop.ID_LopHoc}">
                                            <button class="action-btn assignment" type="submit">Xem Bài Tập</button>
                                        </form>
                                        <form action="StudentTransferClassServlet" method="post">
                                            <input type="hidden" name="classCode" value="${lop.classCode}">
                                            <button class="action-btn transfer" type="submit">Chuyển lớp</button>
                                        </form>
                                        <form action="StudentLeaveClassServlet" method="post" onsubmit="return confirm('Bạn có chắc muốn rời khỏi lớp này?');">
                                            <input type="hidden" name="classCode" value="${lop.classCode}">
                                            <button class="action-btn leave" type="submit">Rời lớp</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="no-data">Bạn chưa đăng ký lớp học nào!</div>
            </c:otherwise>
        </c:choose>
    </div>
    </body>
</html>
