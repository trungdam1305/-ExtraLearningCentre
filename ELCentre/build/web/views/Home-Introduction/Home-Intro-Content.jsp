<%-- 
  File: Home-Intro-Content.jsp
  Description: Contact section with organization information and a contact form.
  Author: trungdam1305
  Created on: Jun 23, 2025
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Liên hệ</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;700&display=swap" rel="stylesheet">

  <style>
    /* ✅ ÁP DỤNG FONT CHỮ CHO TOÀN BỘ TRANG */
    body {
      font-family: 'Be Vietnam Pro', sans-serif;
    }
    .section-title {
      font-weight: 700; /* Sử dụng font weight đậm hơn */
      text-transform: uppercase;
      font-size: 1.2rem;
      text-align: center;
      margin-bottom: 16px;
      color: #343a40;
    }
    .section-title::after {
      content: "";
      display: block;
      width: 60px;
      height: 3px;
      background: #0d6efd;
      margin: 8px auto 0;
    }
    .info-box {
      background-color: #fff;
      border: 1px solid #dee2e6;
      padding: 16px;
      display: flex;
      align-items: center;
      border-radius: 8px; /* Tăng độ bo góc */
      margin-bottom: 16px;
      transition: box-shadow 0.3s ease;
    }
    .info-box:hover {
        box-shadow: 0 4px 15px rgba(0,0,0,0.07);
    }
    .info-box i {
      font-size: 1.4rem;
      color: #0d6efd;
      margin-right: 16px; /* Tăng khoảng cách */
      min-width: 32px;
      text-align: center;
    }
    .contact-form {
      background-color: #fff;
      border-radius: 8px;
      border: 1px solid #dee2e6;
    }
    .contact-form .form-control, .contact-form .form-select {
      border-radius: 8px;
      padding: 12px;
    }
    .contact-form .form-label {
        font-weight: 500;
        color: #495057;
    }
    .btn-submit {
      background-color: #0d6efd;
      color: #fff;
      border: none;
      padding: 12px 30px;
      border-radius: 8px;
      font-weight: 700; /* Sử dụng font weight đậm hơn */
      transition: background-color 0.3s ease;
      margin-top: -10px; /* Thêm một chút khoảng cách phía trên nút */
      display: inline-block; /* Đảm bảo nút không chiếm toàn bộ chiều ngang nếu có vấn đề về container */
    }
    .btn-submit:hover {
        background-color: #0b5ed7;
    }
    .text-start {
        text-align: left !important; /* Đảm bảo nút căn trái */
    }
  </style>
</head>
<body>
    
<div class="container py-5">
  <div class="row justify-content-center">
    <div class="col-lg-5 col-md-6 mb-4">
      <div class="section-title">Thông tin về chúng tôi</div>

      <div class="info-box">
        <i class="fas fa-map-marker-alt"></i>
        <span>KM số 29 Đại Lộ Thăng Long, Hà Nội, Việt Nam</span>
      </div>
      <div class="info-box">
        <i class="fas fa-envelope"></i>
        <span>g3swpelcentre@gmail.com</span>
      </div>
      <div class="info-box">
        <i class="fas fa-phone-alt"></i>
        <span>0972178865</span>
      </div>
    </div>

    <div class="col-lg-6 col-md-6" style="padding-bottom: 20px">
      <div class="section-title">Kết nối với chúng tôi</div>

      <form class="contact-form p-4" style="background-color: #fff; border-radius: 8px; border: 1px solid #dee2e6; " method="post" action="${pageContext.request.contextPath}/Advice">
        <div class="p-4"> 
         <div class="mb-3">
             <label for="name" class="form-label">Tên bạn</label>
             <input type="text" class="form-control" id="name" name="fullName" placeholder="Tên của bạn" required>
         </div>

         <div class="mb-3">
             <label for="email" class="form-label">Email</label>
             <div class="input-group">
                 <span class="input-group-text" style="height:46.66px"><i class="fas fa-envelope"></i></span>
                 <input type="email" class="form-control" id="email" name="email" placeholder="mail@example.com" required>
             </div>
         </div>

         <div class="mb-3">
             <label for="phone" class="form-label">Số điện thoại</label>
             <div class="input-group">
                 <span class="input-group-text" style="height:46.66px"><i class="fas fa-phone-alt"></i></span>
                 <input type="tel" class="form-control" id="phone" name="phone" placeholder="Số điện thoại" required>
             </div>
         </div>

         <div class="mb-4">
             <label for="message" class="form-label">Nội dung bạn muốn nhắn nhủ</label>
             <textarea class="form-control" id="message" name="NoiDung" rows="5" placeholder="Nội dung..." required></textarea>
         </div>

         <div class="text-start">
             <button type="submit" class="btn btn-submit">Gửi đến chúng tôi</button>
         </div>
     </div>
      </form>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>