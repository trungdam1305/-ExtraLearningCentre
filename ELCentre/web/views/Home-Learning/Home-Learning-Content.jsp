<!--File: Home-Learning-Content.jsp
  Description: This interface page allows users to select an educational level 
               (Secondary or High-School) to proceed to the corresponding class list.
  Author: trungdam1305@gmail.com
  Created: 2025-06-23
  Version: 1.0
-->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Chọn Khối Lớp</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Bootstrap 5 CDN -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .class-box {
      background-color: #f9f9f9;
      border: 1px solid #ddd;
      border-radius: 10px;
      padding: 30px;
      height: 100%;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      text-align: center;
    }

    .class-box h5 {
      font-weight: bold;
      margin-bottom: 20px;
    }

    .class-box a {
      display: block;
      margin: 8px 0;
      color: #333;
      text-decoration: none;
      font-weight: 500;
      transition: all 0.2s;
    }

    .class-box a:hover {
      color: #0d6efd;
      text-decoration: underline;
    }
  </style>
</head>
<body>

<div class="container py-5">
  <div class="row justify-content-center">
    <!-- Secondary School Box -->
    <div class="col-md-5 d-flex">
      <div class="class-box w-100">
        <h5>Khối Trung Học Cơ Sở</h5>
        <a href="lop?ma=6">Lớp 6</a>
        <a href="lop?ma=7">Lớp 7</a>
        <a href="lop?ma=8">Lớp 8</a>
        <a href="lop?ma=9">Lớp 9</a>
      </div>
    </div>

    <!-- High-School Box -->
    <div class="col-md-5 d-flex">
      <div class="class-box w-100">
        <h5>Khối Trung Học Phổ Thông</h5>
        <a href="lop?ma=10">Lớp 10</a>
        <a href="lop?ma=11">Lớp 11</a>
        <a href="lop?ma=12">Lớp 12</a>
      </div>
    </div>
  </div>
</div>

<!-- Bootstrap Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
