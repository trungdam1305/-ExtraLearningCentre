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

  <!-- Bootstrap 5 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

  <style>
    body {
      background-color: #f8f9fa;
    }
    .section-title {
      font-weight: bold;
      text-transform: uppercase;
      font-size: 1.2rem;
      text-align: center;
      margin-bottom: 16px;
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
      border: 1px solid #ccc;
      padding: 16px;
      display: flex;
      align-items: center;
      border-radius: 6px;
      margin-bottom: 16px;
    }
    .info-box i {
      font-size: 1.4rem;
      color: #0d6efd;
      margin-right: 12px;
      min-width: 32px;
      text-align: center;
    }
    .contact-form .form-control {
      border-radius: 6px;
    }
    .btn-submit {
      background-color: #0d6efd;
      color: #fff;
      border: none;
      padding: 10px 24px;
      border-radius: 6px;
    }
  </style>
</head>
<body>
    
<div class="container py-5">
  <div class="row justify-content-center">
    <!-- Centre's information -->
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

    <!-- Form Contact -->
    <div class="col-lg-6 col-md-6">
      <div class="section-title">Kết nối với chúng tôi</div>

      <form class="contact-form" method="post" action="ContactServlet">
        <div class="mb-3">
          <label for="name" class="form-label">Tên bạn</label>
          <input type="text" class="form-control" id="name" name="name" placeholder="Tên của bạn" required>
        </div>

        <div class="mb-3">
          <label for="email" class="form-label">Email</label>
          <div class="input-group">
            <span class="input-group-text" style="height:46.6px"><i class="fas fa-envelope" ></i></span>
            <input type="email" class="form-control" id="email" name="email" placeholder="mail@example.com" required>
          </div>
        </div>

        <div class="mb-3">
          <label for="phone" class="form-label">Số điện thoại</label>
          <div class="input-group">
            <span class="input-group-text" style="height:46.6px"><i class="fas fa-phone-alt" ></i></span>
            <input type="tel" class="form-control" id="phone" name="phone" placeholder="Số điện thoại" required>
          </div>
        </div>

        <div class="mb-4">
          <label for="message" class="form-label">Nội dung bạn muốn nhắn nhủ</label>
          <textarea class="form-control" id="message" name="message" rows="5" placeholder="Nội dung..." required></textarea>
        </div>

        <div class="text-start">
          <button type="submit" class="btn btn-submit">Gửi đến chúng tôi</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
