<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/views/student/sidebar.jsp" %>
<c:if test="${empty sessionScope.user}">
    <c:redirect url="${pageContext.request.contextPath}/views/login.jsp" />
</c:if>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa hồ sơ</title>
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
            padding: 30px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        .profile-form {
            background: white;
            padding: 30px;
            border-radius: 10px;
        }
        .profile-grid {
            display: flex;
            gap: 40px;
        }
        .avatar-box {
            width: 180px;
            height: 180px;
            background-color: #ccc;
            border-radius: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 48px;
            color: #fff;
            overflow: hidden;
        }
        .avatar-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .profile-image-box input[type="file"] {
            margin-top: 10px;
        }
        .profile-info-box {
            flex: 1;
        }
        .profile-info-box label {
            display: block;
            margin-bottom: 4px;
            font-weight: 600;
            color: #444;
        }
        .profile-info-box input,
        .profile-info-box textarea,
        .profile-info-box select {
            width: 100%;
            padding: 10px;
            margin-bottom: 16px;
            border: 1px solid #ccc;
            border-radius: 6px;
            background-color: #f0f0f0;
            font-size: 15px;
        }
        .profile-info-box input[readonly] {
            background-color: #eaeaea;
            color: #999;
        }
        .form-buttons {
            display: flex;
            justify-content: flex-end;
            gap: 20px;
            margin-top: 20px;
        }
        .form-buttons button {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            font-size: 15px;
        }
        .form-buttons .cancel {
            background-color: transparent;
            color: #999;
        }
        .form-buttons .save {
            background-color: #1F4E79;
            color: white;
        }
    </style>
</head>
<body>
    <div class="main-content">
        <div class="header">
            <h2>Chỉnh sửa hồ sơ</h2>
            <span>Xin chào ${sessionScope.user.email}</span>
        </div>
        <form action="StudentEditProfileServlet" method="post" enctype="multipart/form-data" class="profile-form">
            <div class="profile-grid">
                <div class="profile-image-box">
                    <div class="avatar-box">
                        <c:choose>
                            <c:when test="${not empty hocSinh.avatar}">
                                <img src="${pageContext.request.contextPath}/${hocSinh.avatar}" alt="Avatar">
                            </c:when>
                            <c:otherwise>
                                <i class="fa fa-user"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <input type="file" name="profileImage" accept="image/png, image/jpeg">
                </div>
                <div class="profile-info-box">
                    <label>Mã học sinh</label>
                    <input type="text" value="${hocSinh.maHocSinh}" readonly>
                    <label>Họ và tên</label>
                    <input type="text" name="hoTen" value="${hocSinh.hoTen}" required>
                    <label>Email</label>
                    <input type="text" value="${sessionScope.user.email}" readonly>
                    <label>Ngày sinh</label>
                    <input type="date" name="ngaySinh" value="${hocSinh.ngaySinh}">
                    <label>Địa chỉ</label>
                    <input type="text" name="diaChi" value="${hocSinh.diaChi}">
                    <label>Trường học</label>
                    <select name="idTruongHoc">
                        <c:forEach var="t" items="${dsTruongHoc}">
                            <option value="${t.ID_TruongHoc}" ${t.ID_TruongHoc == hocSinh.ID_TruongHoc ? 'selected' : ''}>
                                ${t.tenTruongHoc}
                            </option>
                        </c:forEach>
                    </select>
                    <label>Lớp đang học</label>
                    <input type="text" name="lopDangHoc" value="${hocSinh.lopDangHocTrenTruong}">
                    <label>Giới tính</label>
                    <select name="gioiTinh">
                        <option value="Nam" ${hocSinh.gioiTinh == 'Nam' ? 'selected' : ''}>Nam</option>
                        <option value="Nữ" ${hocSinh.gioiTinh == 'Nữ' ? 'selected' : ''}>Nữ</option>
                    </select>
                    <label>Số điện thoại phụ huynh</label>
                    <input type="text" name="sdtPhuHuynh" value="${hocSinh.SDT_PhuHuynh}">
                    <label>Giới thiệu bản thân</label>
                    <textarea name="ghiChu" rows="3">${hocSinh.ghiChu}</textarea>
                    <div class="form-buttons">
                        <button type="reset" class="cancel">Hủy</button>
                        <button type="submit" class="save">Lưu hồ sơ</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</body>
</html>