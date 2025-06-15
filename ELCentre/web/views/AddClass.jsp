<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.KhoaHoc"%>
<%@page import="dal.KhoaHocDAO"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="vi">


    <html>
        <head><title>Thêm lớp học</title></head>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f6f9;
                margin: 0;
                padding: 20px;
            }

            h2 {
                text-align: center;
                color: #333;
                margin-bottom: 30px;
            }

            form {
                max-width: 600px;
                margin: 0 auto;
                background-color: #fff;
                padding: 25px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
                color: #333;
            }

            input[type="text"],
            input[type="number"],
            input[type="date"],
            textarea {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 14px;
                box-sizing: border-box;
            }

            textarea {
                resize: vertical;
                min-height: 80px;
            }

            button {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 6px;
                cursor: pointer;
                font-size: 14px;
                margin-right: 10px;
            }

            button:hover {
                background-color: #0056b3;
            }

            p {
                text-align: center;
                font-size: 14px;
            }

            p[style*="red"] {
                color: red;
                font-weight: bold;
            }

            p[style*="green"] {
                color: green;
                font-weight: bold;
            }

            form[action*="ManagerClass.jsp"] {
                text-align: center;
                margin-top: 20px;
            }
        </style>

        <body>

            <%
            String idKhoaHoc = request.getParameter("ID_KhoaHoc");
            if (idKhoaHoc == null) {
                idKhoaHoc = (String) request.getAttribute("ID_KhoaHoc");
            }

            String idKhoi = request.getParameter("ID_Khoi");
            if (idKhoi == null) {
                idKhoi = (String) request.getAttribute("ID_Khoi");
            }
            %>



            <form action="${pageContext.request.contextPath}/ManagerCourse" method="get" style="margin-top: 10px;">
                <input type="hidden" name="action" value="ViewCourse" />
                <input type="hidden" name="ID_KhoaHoc" value="<%= idKhoaHoc %>" />
                <input type="hidden" name="ID_Khoi" value="<%= idKhoi %>" />
                <button type="submit">Quay lại</button>
            </form>



            <%
    String tenLop = "Không xác định";
    if (idKhoi != null) {
        try {
            int idKhoi2 = Integer.parseInt(idKhoi);
            if (idKhoi2 >= 1 && idKhoi2 <= 7) {
                tenLop = "Lớp " + (idKhoi2 + 5);
            } else {
                tenLop = "Tổng ôn";
            }
        } catch (NumberFormatException e) {
            tenLop = "Dữ liệu không hợp lệ";
        }
    }
            %>


            <h2>Thêm lớp học</h2>  


            <form action="${pageContext.request.contextPath}/Class_AddClass" method="post" enctype="multipart/form-data">
                <input type="hidden" name="ID_KhoaHoc" value="<%= idKhoaHoc %>" />
                <input type="hidden" name="ID_Khoi" value="<%= idKhoi %>" />






                <label>Tên lớp học:</label>
                <input type="text" name="TenLopHoc" required /><br/>

                <label>Khóa học:</label>
                <p>Bạn đang thêm lớp học cho khóa có ID: <%= idKhoaHoc %></p>
                <label>Khối học:</label>
                <p>Bạn đang thêm lớp học cho khối : <%= tenLop  %></p>
                <br/>

                <label>Thời gian học:</label>
                <div id="timeContainer">
                    <div class="time-entry">
                        <select name="ThuTrongTuan">
                            <option value="Thứ 2">Thứ 2</option>
                            <option value="Thứ 3">Thứ 3</option>
                            <option value="Thứ 4">Thứ 4</option>
                            <option value="Thứ 5">Thứ 5</option>
                            <option value="Thứ 6">Thứ 6</option>
                            <option value="Thứ 7">Thứ 7</option>
                            <option value="Chủ nhật">Chủ nhật</option>
                        </select>
                        <input type="time" name="GioHoc" lang="vi" />
                        <button type="button" onclick="removeTime(this)">X</button>
                    </div>
                </div>

                <button type="button" onclick="addTime()">+ Thêm thời gian học</button>

                <script>
                    function addTime() {
                        const container = document.getElementById("timeContainer");
                        const div = document.createElement("div");
                        div.className = "time-entry";
                        div.innerHTML = `
                            <select name="ThuTrongTuan">
                                <option value="Thứ 2">Thứ 2</option>
                                <option value="Thứ 3">Thứ 3</option>
                                <option value="Thứ 4">Thứ 4</option>
                                <option value="Thứ 5">Thứ 5</option>
                                <option value="Thứ 6">Thứ 6</option>
                                <option value="Thứ 7">Thứ 7</option>
                                <option value="Chủ nhật">Chủ nhật</option>
                            </select>
                            <input type="time" name="GioHoc" lang="vi" />
                            <button type="button" onclick="removeTime(this)">X</button>
                        `;
                        container.appendChild(div);
                    }

                    function removeTime(btn) {
                        btn.parentElement.remove();
                    }
                </script>





                <label>Ghi chú:</label>
                <input type="text" name="GhiChu" /><br/>


                <label>Ảnh đại diện giáo viên (kích thước 3X4): </label>
                <input type="file" name="Image" accept="image/*" required="" /><br/>


                <br>
                <button type="submit">Thêm</button>
            </form>

            <c:if test="${not empty err}">
                <p style="color: red;">${err}</p>
            </c:if>

            <c:if test="${not empty suc}">
                <p style="color: green;">${suc}</p>
            </c:if>

            <%
    String sucParam = request.getParameter("suc");
    if ("1".equals(sucParam)) {
            %>
            <p style="color: green;">Thêm lớp học thành công!</p>
            <%
            }
            %>


        </body>
    </html>