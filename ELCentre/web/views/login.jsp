<%@page contentType="text/html" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="google-signin-client_id" content="495483511522-0e0jq9n40fkng5gpaogj1gifh9a8e7eu.apps.googleusercontent.com">
    <title>Login - EduPlus Center</title>

    <!-- Bootstrap & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

    <!-- Google Identity -->
    <script src="https://accounts.google.com/gsi/client" async defer></script>
    
    <style>
body {
    font-family: 'Segoe UI', sans-serif;
    margin: 0;
    padding: 0;
    background: linear-gradient(135deg, #1F4E79 0%, #3a6b9e 100%);
    min-height: 100vh;
}

.login-container {
    display: flex;
    height: 100vh;
}

.left-panel, .right-panel {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    color: white;
    position: relative;
}

.right-panel {
    /* Xoá nền trắng */
    background: none;
}

.login-box {
    width: 100%;
    max-width: 400px;
    background-color: #ffffff;
    border-radius: 10px;
    padding: 30px;
    box-shadow: 0 0 20px rgba(0,0,0,0.1);
    color: black;
    z-index: 1;
}




        .login-container { display: flex; height: 100vh; }
        .left-panel {
            flex: 1; background-color: #e1e3e8;
            display: flex; flex-direction: column;
            justify-content: center; align-items: center;
            padding: 2rem;
        }
        .right-panel {
            flex: 2; 
            
            display: flex; justify-content: center; align-items: center;
        }
        .login-box {
            width: 100%; max-width: 400px;
        }
        .login-box input { margin-bottom: 1rem; }
        .btn-login {
            width: 100%; background-color: #525a6d; color: white;
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
        
        body {
    font-family: 'Segoe UI', sans-serif;
    background-color: #f4f8fb;
    margin: 0;
    padding: 0;
}

.login-container {
    display: flex;
    height: 100vh;
    flex-wrap: wrap;
}

.left-panel {
    flex: 1;
    background: linear-gradient(135deg, #1F4E79 0%, #3a6b9e 100%);
    color: white;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding: 3rem;
    text-align: center;
    position: relative;
    overflow: hidden;
}

.left-panel::before {
    content: "";
    position: absolute;
    top: -50px;
    left: -50px;
    width: 300px;
    height: 300px;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 50%;
    z-index: 0;
}

.left-panel::after {
    content: "";
    position: absolute;
    bottom: -50px;
    right: -50px;
    width: 250px;
    height: 250px;
    background: rgba(255, 255, 255, 0.05);
    border-radius: 50%;
    z-index: 0;
}

.left-panel * {
    z-index: 1;
    position: relative;
}

.left-panel i {
    font-size: 60px;
    margin-bottom: 20px;
    color: #ffffff;
}

.left-panel h4 {
    font-size: 28px;
    font-weight: 700;
    margin-bottom: 15px;
}

.left-panel .slogan {
    font-size: 16px;
    font-style: italic;
    color: #dce5f1;
    max-width: 80%;
    margin: 0 auto 25px auto;
}

.left-panel .banner-box {
    background-color: rgba(255, 255, 255, 0.1);
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
}

.left-panel .decor-lines {
    display: flex;
    justify-content: space-between;
    margin-top: 30px;
    gap: 8px;
}

.left-panel .decor-lines div {
    width: 12px;
    height: 80px;
    background-color: rgba(255,255,255,0.4);
    border-radius: 6px;
}




.login-box {
    width: 100%;
    max-width: 400px;
    background-color: #ffffff;
    border-radius: 10px;
    padding: 30px;
    box-shadow: 0 0 20px rgba(0,0,0,0.08);
}

.login-box h3 {
    color: #1F4E79;
    margin-bottom: 20px;
    font-weight: bold;
}

.login-box .form-control {
    height: 42px;
    font-size: 14px;
    margin-bottom: 15px;
    border-radius: 5px;
}

.btn-login {
    width: 100%;
    background-color: #1F4E79;
    color: white;
    border: none;
    font-weight: 600;
    padding: 12px;
    font-size: 15px;
    border-radius: 6px;
    transition: background-color 0.3s ease;
}

.btn-login:hover {
    background-color: #163E5C;
}

.btn-dark,
.btn-secondary {
    width: 48%;
    padding: 10px;
    font-weight: bold;
    border-radius: 6px;
    border: none;
}

.btn-dark {
    background-color: #3b5998;
}

.btn-secondary {
    background-color: #db4437;
}

.btn-dark:hover {
    background-color: #2d4373;
}

.btn-secondary:hover {
    background-color: #c23321;
}

.small a {
    color: #1F4E79;
    text-decoration: none;
}

.small a:hover {
    text-decoration: underline;
}

.footer-chat {
    position: fixed;
    bottom: 0;
    right: 0;
    background-color: #1F4E79;
    color: white;
    padding: 8px 16px;
    border-top-left-radius: 8px;
    font-size: 14px;
}

@media (max-width: 768px) {
    .login-container {
        flex-direction: column;
    }
    .left-panel {
        display: none;
    }
    .right-panel {
        flex: none;
        padding: 30px 20px;
    }
}

.background-decor {
    position: relative;
    background: linear-gradient(135deg, #1F4E79 0%, #3a6b9e 100%);
    min-height: 100vh;
    overflow: hidden;
}

/* Các vòng tròn bóng nước */
.background-decor::before,
.background-decor::after {
    content: "";
    position: absolute;
    border-radius: 50%;
    background: rgba(255, 255, 255, 0.05);
    z-index: 0;
}

/* Vòng tròn trên bên trái */
.background-decor::before {
    width: 400px;
    height: 400px;
    top: -100px;
    left: -100px;
}

/* Vòng tròn dưới bên phải */
.background-decor::after {
    width: 300px;
    height: 300px;
    bottom: -80px;
    right: -80px;
}


    </style>
</head>

<body>
    <div class="background-decor">
    <div class="login-container">
        <!-- Left Panel -->
<div class="left-panel text-center">
    <i class="fas fa-chalkboard-teacher"></i>
    <h4><strong>Extra Learning Centre</strong></h4>
    <p class="slogan">Nâng bước tri thức - Vững bước tương lai</p>

    <div class="banner-box">
        <div class="text-muted small d-flex justify-content-between">
            <span>Welcome</span>
            <span>Edu+</span>
        </div>
        <div class="decor-lines mt-3">
            <div></div>
            <div></div>
            <div></div>
        </div>
    </div>
</div>


        <!-- Right Panel -->
        <div class="right-panel">
            <div class="login-box">
                <h3 class="fw-bold">|Đăng nhập hệ thống</h3>
                <p class="small">
                    Bạn đang quan tâm tới khóa học của chúng tôi? 
                    <br>
                    <a href="advice.jsp">Gửi yêu cầu tư vấn ngay!</a>
                    <br>
                    <a href="${pageContext.request.contextPath}/HomePage">Quay lại trang chủ</a>
                </p>
                <% String error = (String) session.getAttribute("error");
                    if (error != null) {
                 %>
                     <div class="alert alert-danger" role="alert">
                         <%= error %>
                     </div>
                 <%
                         session.removeAttribute("error"); 
                    }
                 %>

                <form action="<%= request.getContextPath() %>/LoginServlet" method="post" class="sign-in-form">
                    <input type="text" name="email" class="form-control" placeholder="Email">
                    <input type="password" name="password" class="form-control" placeholder="Mật khẩu">

                    <div class="d-flex justify-content-between align-items-center my-2">
                        <div>
                            <input type="checkbox" id="remember" name="remember">
                            <label for="remember" class="small">Ghi nhớ</label>
                        </div>
                        <a href="../views/forgotPassword.jsp" class="small">Quên mật khẩu?</a>
                    </div>

                     ✅ Google reCAPTCHA 
                    <div class="g-recaptcha mb-3" data-sitekey="6Ldf8E4rAAAAACIhQBZn-9343I1wWxzJwzawYS1s"></div>
 
                    <button type="submit" name="action" class="btn btn-login">Đăng nhập</button>
                </form>



                <div class="text-center mt-4">
                    <p class="small">Hoặc đăng nhập bằng</p>
                    <div class="d-flex justify-content-between">
                        <button class="btn btn-dark" onclick="FB.login(checkLoginState, {scope: 'public_profile,email'})">
                            <i class="fab fa-facebook-f"></i> Facebook
                        </button>
                        <button class="btn btn-secondary" onclick="onGoogleLoginClick()">
                            <i class="fab fa-google-plus-g"></i> Google
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>

    <div class="footer-chat">
        Chat với Extra Learning Centre
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Facebook SDK -->
    <script>
      window.fbAsyncInit = function () {
        FB.init({
          appId: '1385521559377546',
          cookie: true,
          xfbml: true,
          version: 'v22.0'
        });
        FB.AppEvents.logPageView();
      };

      (function (d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "https://connect.facebook.net/en_US/sdk.js";
        fjs.parentNode.insertBefore(js, fjs);
      }(document, 'script', 'facebook-jssdk'));

      function checkLoginState() {
        FB.getLoginStatus(function (response) {
          if (response.status === 'connected') {
            fetch('FacebookLoginServlet', {
              method: 'POST',
              headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
              body: 'accessToken=' + response.authResponse.accessToken
            })
            .then(res => res.text())
            .then(url => window.location.href = url);
          } else {
            alert("Vui lòng đăng nhập Facebook.");
          }
        });
      }
    </script>

    <!-- Google Login Script -->
    <script>
      function onGoogleLoginClick() {
        google.accounts.id.initialize({
          client_id: '495483511522-0e0jq9n40fkng5gpaogj1gifh9a8e7eu.apps.googleusercontent.com',
          callback: handleGoogleResponse
        });
        google.accounts.id.prompt(); // hoặc show popup
      }

      function handleGoogleResponse(response) {
        fetch('GoogleLoginServlet', {
          method: 'POST',
          headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
          body: 'credential=' + response.credential
        })
        .then(res => res.text())
        .then(url => window.location.href = url);
      }
    </script>
</body>
</html>
