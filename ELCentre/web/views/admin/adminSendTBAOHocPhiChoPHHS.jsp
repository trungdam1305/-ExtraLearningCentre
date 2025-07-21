<%-- 
    Document   : adminSendTBAOHocPhiChoPHHS
    Created on : Jul 21, 2025, 9:08:00 AM
    Author     : wrx_Chur04
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Soạn Thông Báo Học Phí</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #f0f4f8;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #1F4E79;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .notification-container {
            background-color: #ffffff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 700px;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #1F4E79;
            font-size: 24px;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: 600;
            font-size: 15px;
        }

        textarea {
            width: 100%;
            padding: 12px;
            font-size: 15px;
            margin-top: 8px;
            border: 1px solid #ccc;
            border-radius: 8px;
            resize: vertical;
            min-height: 140px;
        }

        button {
            margin-top: 25px;
            width: 100%;
            padding: 12px;
            background-color: #1F4E79;
            color: #ffffff;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-weight: bold;
            letter-spacing: 0.5px;
        }

        button:hover {
            background-color: #163b5c;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            text-decoration: none;
            color: #1F4E79;
            font-size: 14px;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="notification-container">
    <h2>Soạn nội dung thông báo học phí</h2>

    <form action="adminActionWithTuition" method="post">
        <!-- Hidden inputs to submit correct data -->
        <input type="hidden" name="ID_TKHocSinh" value="${ID_TKHocSinh}" />
        <input type="hidden" name="ID_TKPhuHuynh" value="${ID_TKPhuHuynh}" />
        <input type="hidden" name="soTienDong" value="${soTienDong}" />
        <input type="hidden" name="thang" value="${thang}" />
        <input type="hidden" name="nam" value="${nam}" />
        <input type="hidden" name="TenHocSinh" value="${TenHocSinh}" />
        <input type="hidden" name="TenLopHoc" value="${TenLopHoc}" />

        <!-- Nội dung gửi phụ huynh -->
        <label for="contentPH">Nội dung gửi phụ huynh:</label>
        <textarea name="contentPH" id="contentPH">
Kính gửi quý phụ huynh,

Trung tâm Anh ngữ ELCENTRE xin thông báo học phí của học sinh ${TenHocSinh} – lớp ${sessionScope.tenlop} cho tháng ${thang}/${nam} như sau:

Số tiền cần đóng: ${soTienDong} VNĐ

Quý phụ huynh vui lòng hoàn tất học phí đúng hạn để đảm bảo quá trình học tập của học sinh diễn ra thuận lợi.

Trân trọng cảm ơn quý phụ huynh đã đồng hành cùng ELCENTRE!
        </textarea>

        <!-- Nội dung gửi học sinh -->
        <label for="contentHS">Nội dung gửi học sinh:</label>
        <textarea name="contentHS" id="contentHS">
Chào em ${TenHocSinh},

Đây là thông báo học phí tháng ${thang}/${nam} của em tại lớp ${sessionScope.tenlop}. Số tiền: ${soTienDong} VNĐ.

Chúc em học tập tốt và đạt kết quả cao nhé!

– ELCENTRE –
        </textarea>

        <button type="submit">Gửi thông báo</button>
    </form>

    <a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=hocphi" class="back-link">← Quay lại danh sách lớp</a>
   
</div>
</body>
</html>
