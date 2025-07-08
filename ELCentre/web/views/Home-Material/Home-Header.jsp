<%-- 
    Document   : Home-Header
    Created on : May 21, 2025, 1:29:23 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Extra Learning Centre</title>
    <!-- Link FontAwesome hoặc các CSS khác nếu cần -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Thêm CSS cơ bản cho menu active */
        .current-menu-item > a {
            color: #fff !important;
            background: rgb(201, 32, 39) !important;
            border-radius: 4px;
            padding: 8px 16px;
        }
        .menu > li > a {
            color: #333;
            text-decoration: none;
            padding: 8px 16px;
            transition: background 0.2s, color 0.2s;
        }
        .menu > li > a:hover {
            background: #f0f0f0;
        }
        .menu {
            list-style: none;
            margin: 0;
            padding: 0;
        }
    </style>
</head>
<body>
    <%-- Lấy URI hiện tại để xác định menu active --%>
    <%
        String uri = request.getRequestURI();
        String context = request.getContextPath();
    %>
    <!--Introduction Bar -->
    <div id="wrapper">
        <div class="top-bar">
            <div class="container">
                <div class="float-left">
                    Tham gia các khóa học của chúng tôi/
                    <a href="<%= context %>/views/login.jsp" title="Tham gia khóa học">Enroll</a>                    
                </div>
                <div class="float-right">                            	
                    <a href="<%= context %>/views/login.jsp" title="Login Now" style="text-decoration: underline">Đăng nhập tại đây!</a>
                </div>
            </div>
        </div>
            
        <!-- header starts here -->
        <div id="header-wrapper">
            <!-- main menu container starts here -->
            <div class="menu-main-menu-container header1" >
                <div class="container">
                    <!-- Centre's Logo-->
                    <div id="logo">	
                        <a href="<%= context %>/HomePage" title="Extra Learning Centre Theme">
                            <img width="160" height="90" class="normal_logo" src="<%= context %>/img/SieuLogo.png" alt="Extra Learning Centre Theme" title="Extra Learning Centre Theme" />
                            <img class="retina_logo" src="<%= context %>/img/SieuLogo.png" alt="Extra Learning Centre Theme" title="Extra Learning Centre Theme" style="width:174px; height:94px;"/>
                        </a>                        
                    </div>
                    <!--Search for Courses bar -->
                    <div id="primary-menu">
                        <form action="<%= context %>/SearchCourses" method="get" style="display: flex; align-items: center; transform: translateY(20px)">
                            <input type="text" name="query" placeholder="Tìm Khóa Học..." style="padding: 5px 8px; border-radius: 3px; border: 1px solid #ccc; font-size: 14px;" />
                            <button type="submit" style="padding: 6px 10px; transform: translateY(-15px); border: none; border-radius: 4px" class="dt-sc-button small">
                                <i class="fa fa-search"></i>
                            </button>
                        </form> 
                        <!--Navigation Bar-->
                        <nav id="main-menu">
                            <ul id="menu-main-menu" class="menu" style="position: relative; transform: translateY(-10px); display: flex; align-items: center; gap: 30px 20px;">
                                <!--HomePage-->
                                <li class="menu-item <%= (uri.contains("/HomePage")) ? "current-menu-item" : "" %>">
                                    <a href="<%= context %>/HomePage">
                                        <span class='menu-icon fa fa-home'> </span>Trang chủ
                                    </a>
                                </li>
                                <!--Courses-->
                                <li class="menu-item <%= uri.contains("/Home-Course") ? "current-menu-item" : "" %>">
                                    <a href="<%= context %>/HomePageCourse">
                                        <span class='menu-icon fa fa-shopping-cart'> </span>Khóa Học
                                    </a>
                                </li>
                                <!--Learning Materials-->
                                <li class="menu-item <%= uri.contains("/Home-Material") ? "current-menu-item" : "" %>">
                                    <a href="<%= context %>/HomePageMaterial">
                                        <span class='menu-icon fa fa-gift'> </span>Tài Liệu Học
                                    </a>
                                </li>
                                <!--Blog-->
                                <li class="menu-item <%= uri.contains("/Home-Blog") ? "current-menu-item" : "" %>">
                                    <a href="<%= context %>/HomePageBlog">
                                        <span class='menu-icon fa fa-pencil'> </span>Blog
                                    </a>
                                </li>
                                <!--About Us-->
                                <li class="menu-item <%= uri.contains("/Home-Introduction") ? "current-menu-item" : "" %>">
                                    <a href="<%= context %>/views/Home-Introduction/Homepage-Introduction.jsp">
                                        <span class='menu-icon fa fa-picture-o'> </span>Giới thiệu
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>       
                </div>
            </div>
        </div>
    </div>
</body>
</html>
