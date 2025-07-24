<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Login - EduPlus Center</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
        }

        .login-container {
            display: flex;
            height: 100vh;
        }

        .left-panel {
            flex: 1;
            overflow: hidden;
            position: relative;
        }

        .left-panel img {
            width: 100%;
            height: 100vh;
            object-fit: cover;
            position: absolute;
            top: 0;
            left: 0;
            transition: opacity 1s ease-in-out;
        }

        .right-panel {
            flex: 1.2;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #eef1f5, #dfe3ec); /* có thể thay bằng background-image sau */
        }

        .login-box {
            width: 100%;
            max-width: 400px;
            padding: 30px;
            background-color: #ffffffee;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .btn-login {
            width: 100%;
            background-color: #525a6d;
            color: white;
        }

        .btn-login:hover {
            background-color: #3e4454;
        }

        header, footer {
            background-color: #343a40;
            color: white;
            text-align: center;
            padding: 10px 0;
        }

        .g-recaptcha {
            transform: scale(1.05);
            transform-origin: 0 0;
        }
        
    </style>
</head>

<body>
<header>
    <h5>🌐 Extra Learning Centre</h5>
</header>

<div class="login-container">
    <!-- Left Panel: Image Slideshow -->
    <div class="left-panel">
        <img src="../img/content/R.jpg" class="slide" style="opacity:1;">
        <img src="../img/content/a.png" class="slide" style="opacity:0;">
        <img src="../img/content/d.webp" class="slide" style="opacity:0;">
    </div>

    <!-- Right Panel: Login Form -->
    <div class="right-panel">
        <div class="login-box">
            <h3 class="fw-bold">|Đăng nhập hệ thống</h3>

            <p class="small mb-3">
                <a href="advice.jsp">Gửi yêu cầu tư vấn</a> |
                <a href="${pageContext.request.contextPath}/HomePage">Trang chủ</a>
            </p>

            <% String error = (String) session.getAttribute("error");
               if (error != null) { %>
            <div class="alert alert-danger" role="alert">
                <%= error %>
            </div>
            <% session.removeAttribute("error"); } %>

            <form action="<%= request.getContextPath() %>/LoginServlet" method="post" class="sign-in-form">
                <input type="text" name="email" class="form-control mb-3" placeholder="Email" required>
                <input type="password" name="password" class="form-control mb-3" placeholder="Mật khẩu" required>

                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div>
                        <input type="checkbox" id="remember" name="remember">
                        <label for="remember" class="small">Ghi nhớ</label>
                    </div>
                    <a href="../views/forgotPassword.jsp" class="small">Quên mật khẩu?</a>
                </div>

<!--                <div class="g-recaptcha mb-3" data-sitekey="6Ldf8E4rAAAAACIhQBZn-9343I1wWxzJwzawYS1s"></div>-->

                <button type="submit" class="btn btn-login">Đăng nhập</button>
            </form>
        </div>
    </div>

</div>

<!-- Footer -->
<div class="footer">
    <p>© 2025 EL CENTRE. All rights reserved. | Developed by ELCentre</p>
</div>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>

<!-- Slideshow Script -->
<script>
    const slides = document.querySelectorAll('.slide');
    let currentIndex = 0;

    setInterval(() => {
        slides[currentIndex].style.opacity = 0;
        currentIndex = (currentIndex + 1) % slides.length;
        slides[currentIndex].style.opacity = 1;
    }, 5000); // 5 giây chuyển ảnh
</script>
</body>
</html>
