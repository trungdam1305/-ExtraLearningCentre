<%@page contentType="text/html" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login - EduPlus Center</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f0eff5;
            }
            .login-container { display: flex; height: 100vh; }
            .left-panel {
                flex: 1; background-color: #e1e3e8;
                display: flex; flex-direction: column;
                justify-content: center; align-items: center;
                padding: 2rem;
            }
            .right-panel {
                flex: 2; background-color: white;
                display: flex; justify-content: center; align-items: center;
            }
            .login-box {
                width: 100%; max-width: 400px;
            }
            .login-box input { margin-bottom: 1rem; }
            .btn-login {
                width: 100%; background-color: #525a6d; color: white;
            }
            .btn-login {
                background-color: #1877F2; 
            }

            .btn-dark {
                background-color: #1877F2;
                color: white;
            }

            .btn-secondary {
                background-color: #DB4437; 
                color: white;
            }
            .btn-login:hover {
                background-color: #3e4454;
            }
            .footer-chat {
                position: fixed; bottom: 0; right: 0;
                background-color: #1877F2; color: white;
                padding: 8px 16px; border-top-left-radius: 8px;
            }
        </style>
    </head>
    
    <body>
        <div class="login-container">
            <!-- Left Panel -->
            <div class="left-panel text-center">
                <i class="fas fa-user-circle fa-4x mb-3"></i>
                <h4><strong>Extra Learning Centre</strong></h4>
                <div class="mt-5">
                    <div class="bg-light p-4 rounded">
                        <div class="d-flex justify-content-between text-muted small">
                            <span>Welcome</span><span>Edu</span>
                        </div>
                        <div class="mt-3 d-flex justify-content-around">
                            <div style="width: 10px; height: 100px; background-color: #7a7f8c;"></div>
                            <div style="width: 10px; height: 100px; background-color: #7a7f8c;"></div>
                            <div style="width: 10px; height: 100px; background-color: #7a7f8c;"></div>
                        </div>
                    </div>
                </div>
            </div>

        <!-- Right Panel -->
            <div class="right-panel">
                <div class="login-box">
                    <h3 class="fw-bold">|Đăng nhập hệ thống</h3>
                    <p class="small">Chưa có tài khoản? <a href="register.jsp">Đăng ký ngay</a></p>

                    <% String error = request.getParameter("error");
                       if (error != null) { %>
                        <div class="alert alert-danger"><%= error %></div>
                    <% } %>
                    
                    <form action="<%= request.getContextPath() %>/LoginServlet" method="post">
                        <input type="text" name="email" class="form-control" placeholder="Email">
                        <input type="password" name="password" class="form-control" placeholder="Mật khẩu">

                        <div class="d-flex justify-content-between align-items-center my-2">
                            <div>
                                <input type="checkbox" id="remember" name="remember">
                                <label for="remember" class="small">Ghi nhớ</label>
                            </div>
                            <a href="forgot_password.jsp" class="small">Quên mật khẩu?</a>
                        </div>

                        <button type="submit" class="btn btn-login">Đăng nhập</button>
                    </form>

                    <div class="text-center mt-4">
                        <p class="small">Hoặc đăng nhập bằng</p>
                        <div class="d-flex justify-content-between">
                            <button class="btn btn-dark" onclick="FB.login(checkLoginState, {scope: 'public_profile,email'})">
                                <i class="fab fa-facebook-f"></i> Facebook
                            </button>
                            <button class="btn btn-secondary" onclick="onGoogleLoginClick()">
                                <i class="fab fa-google-plus-g"></i> Google+
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    <div class="footer-chat">
        Chat với Extra Learning Centre
    </div>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    
    <!-- Facebook SDK -->
        <script>
          window.fbAsyncInit = function () {
            FB.init({
              appId: '1385521559377546', // 👉 dùng App ID thật
              cookie: true,
              xfbml: true,
              version: 'v22.0'
            });

            FB.AppEvents.logPageView();
          };

          (function (d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) { return; }
            js = d.createElement(s); js.id = id;
            js.src = "https://connect.facebook.net/en_US/sdk.js";
            fjs.parentNode.insertBefore(js, fjs);
          }(document, 'script', 'facebook-jssdk'));

          function checkLoginState() {
            FB.getLoginStatus(function (response) {
              if (response.status === 'connected') {
                // Gửi token về server để xử lý
                fetch('FacebookLoginServlet', {
                  method: 'POST',
                  headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                  body: 'accessToken=' + response.authResponse.accessToken
                })
                .then(res => res.text())
                .then(url => window.location.href = url); // Server trả về URL redirect
              } else {
                alert("Vui lòng đăng nhập Facebook.");
              }
            });
          }
        </script>
    </body>
</html>
