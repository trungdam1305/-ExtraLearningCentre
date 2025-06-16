<%-- 
    Document   : adminReceiveGiaoVien
    Created on : May 24, 2025, 11:28:36 PM
    Author     : wrx_Chur04
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All Teacher</title>
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
            
            .action-link {
                background-color: #1F4E79;
                color: white;
                padding: 6px 12px;
                margin: 2px;
                text-decoration: none;
                border-radius: 4px;
                display: inline-block;
                transition: background-color 0.3s;
                font-size: 14px;
            }

            .action-link:hover {
                background-color: #163b5c;
            }
        </style>
    </head>
    <body>
        <h2>Quản lý giáo viên</h2>
        <div style="display: flex; justify-content: flex-end; align-items: center; gap: 15px;">
            <input type="text" id="searchInput" placeholder="Tìm kiếm...">

            <label for="statusFilter" style="margin: 0;">Lọc theo chuyên môn:</label>
            <select id="statusFilter">
                <option value="all">Toán học</option>
                <option value="active">Lý</option>
                <option value="inactive">Hóa</option>
            </select>


        </div>
        <c:choose>
            <c:when test = "${not empty giaoviens}">
                <table>

                    <thead>
                        <tr>


                            <th>Họ và Tên</th>
                            <th>Chuyên Môn</th>
                            <th>Số điện thoại</th>
                            <th>Trường đang dạy</th>
                            <th>Lương</th>
                            <th>Ghi Chú</th>
                            <th>Trạng Thái</th>
                            <th>Ngày Tạo</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>

                    <tbody id="teacherTableBody">
                        <c:forEach var="giaovien" items="${giaoviens}">
                            <tr>

                                <td>${giaovien.getHoTen()}</td>
                                <td>${giaovien.getChuyenMon()}</td>
                                <td>${giaovien.getSDT()}</td>
                                <td>${giaovien.getTenTruongHoc()}</td>
                                <td>${giaovien.getLuong()}</td>
                                <td><c:out value="${giaovien.getGhiChu()}" default="Không có ghi chú" /></td>

                                <td>${giaovien.getTrangThai()}</td>
                                <td>${giaovien.getNgayTao()}</td>
                                <td>
                                    <a class="action-link" href="${pageContext.request.contextPath}/adminActionWithTeacher?action=view&id=${giaovien.getID_GiaoVien()}">Chi tiết</a> 
                                    | 
                                    <a class="action-link" href="${pageContext.request.contextPath}/adminActionWithTeacher?action=viewLopHocGiaoVien&id=${giaovien.getID_GiaoVien()}">Lớp đang dạy</a>  
                                    |
                                    <a  class="action-link" href="${pageContext.request.contextPath}/adminActionWithTeacher?action=update&id=${giaovien.getID_GiaoVien()}">Chỉnh sửa</a> 
                                </td>
                            </tr>   
                        </c:forEach>
                    </tbody>
                </table>    
            </c:when>
            <c:otherwise>   
                <div class="no-reports-message">
                    <c:if test="${not empty message}">
                        <p style="color: red;">${message}</p>
                    </c:if>
                    <p>Không có dữ liệu giáo viên để hiển thị.</p>
                </div>
            </c:otherwise>
        </c:choose>

        <div id="pagination" style="text-align:center; margin-top: 20px;"></div>
        <div class="back-button">
            <a href="${pageContext.request.contextPath}/views/admin/adminDashboard.jsp">Quay lại trang chủ</a>
        </div>

        <script>
            // Số dòng muốn hiển thị mỗi trang
            var soDongMoiTrang = 2;

            // Lấy tất cả dòng (tr) trong bảng giáo viên
            var tatCaDong = document.querySelectorAll("#teacherTableBody tr");

            // Tổng số trang = tổng số dòng chia cho số dòng mỗi trang (làm tròn lên)
            var tongSoTrang = Math.ceil(tatCaDong.length / soDongMoiTrang);

            // Nơi hiển thị các nút phân trang
            var phanTrangDiv = document.getElementById("pagination");

            // Hàm hiển thị trang số "trang"
            function hienThiTrang(trang) {
                // Ẩn tất cả dòng
                for (var i = 0; i < tatCaDong.length; i++) {
                    tatCaDong[i].style.display = "none";
                }

                // Hiện các dòng thuộc trang đang chọn
                var batDau = (trang - 1) * soDongMoiTrang;
                var ketThuc = batDau + soDongMoiTrang;
                for (var i = batDau; i < ketThuc && i < tatCaDong.length; i++) {
                    tatCaDong[i].style.display = "";
                }

                // Tạo lại các nút phân trang
                phanTrangDiv.innerHTML = "";
                for (var j = 1; j <= tongSoTrang; j++) {
                    var nut = document.createElement("button");
                    nut.innerText = j;

                    // Khi bấm vào nút thì sẽ gọi lại chính hàm này với số trang mới
                    nut.onclick = (function (trangDuocChon) {
                        return function () {
                            hienThiTrang(trangDuocChon);
                        };
                    })(j);

                    // Tô màu cho trang đang chọn
                    if (j === trang) {
                        nut.style.backgroundColor = "#1F4E79";
                        nut.style.color = "white";
                    }

                    phanTrangDiv.appendChild(nut);
                }
            }
            
            // Lần đầu gọi hàm để hiện trang 1
            hienThiTrang(1);
        </script>

    </body>
</html>
