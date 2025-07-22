<%-- 
    Document   : Home-Header
    Created on : May 21, 2025, 1:29:23 PM
    Author     : admin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Extra Learning Centre</title>
    <!-- Link FontAwesome hoặc các CSS khác nếu cần -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
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
        #main-menu .menu-item-has-children {
            position: relative;
            padding-bottom: 15px; 
        }

        #main-menu .sub-menu {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            margin-top: -15px; 
            background-color: white;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            z-index: 1000;
            list-style: none;
            padding: 10px 0;
            min-width: 220px;
            border-radius: 6px;
        }

        #main-menu .menu-item-has-children:hover > .sub-menu {
            display: block;
        }

        #main-menu .sub-menu li a {
            padding: 10px 20px;
            display: block;
            color: #333;
            text-decoration: none;
            white-space: nowrap;
            transition: background-color 0.2s;
        }

        #main-menu .sub-menu li a:hover {
            background-color: #f5f5f5;
        }
    </style>
</head>
<body>
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
                                    <a href="${pageContext.request.contextPath}/HomePage">
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
                                    <a href="${pageContext.request.contextPath}/HomePageMaterial">
                                        <span class='menu-icon fa fa-gift'> </span>Tài Liệu Học
                                    </a>
                                </li>
                                <!--Blog-->
                                <li class="menu-item menu-item-has-children <%= (uri.contains("/HomePageBlog") || uri.contains("search-by-tag")) ? "current-menu-item" : "" %>">
                                <a href="${pageContext.request.contextPath}/HomePageBlog">
                                    <span class='menu-icon fa fa-pencil'></span>Bài Viết
                                </a>

                                <!--Submenu dropdown when hover-->
                                <ul class="sub-menu">
                                    <li class="menu-item">
                                        <a href="${pageContext.request.contextPath}/HomePageBlog">Tất cả bài viết</a>
                                    </li>

                                    <%-- Check if keytag null --%>
                                    <c:if test="${not empty allKeytags}">
                                        <li class="menu-item-divider" style="border-top: 1px solid #eee; margin: 5px 0;"></li>
                                        <li class="menu-item" style="padding: 5px 15px; color: #888; font-size: 0.9em;">Chủ đề nổi bật:</li>

                                        <%-- Loop allKeyTags --%>
                                        <c:forEach var="keyTag" items="${allKeytags}">
                                            <li class="menu-item">
                                                <a href="${pageContext.request.contextPath}/HomePageBlog?keywordId=0&keytagId=${keyTag.getID_KeyTag()}">
                                                    ${keyTag.getKeyTag()}
                                                </a>
                                            </li>
                                        </c:forEach>
                                    </c:if>
                                </ul>
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
