<%-- 
    Document   : Home-Header
    Created on : May 21, 2025, 1:29:23 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <!--Introduction Bar -->
        <div id="wrapper">
            <div class="top-bar">
                <div class="container">
                	<div class="float-left">
						 Tham gia các khóa học của chúng tôi/<a href="${pageContext.request.contextPath}/views/login.jsp" title="Tham gia khóa học">Enroll</a>                    
                        </div>
                	<div class="float-right">                            	
                            <a href="${pageContext.request.contextPath}/views/login.jsp" title="Login Now" style="text-decoration: underline">Đăng nhập tại đây!</a></div>
                </div>
            </div>
                
    	<!-- header starts here -->
        <div id="header-wrapper">
	    	<!-- main menu container starts here -->
                <div class="menu-main-menu-container header1" >
                    <div class="container">
                        <!-- Centre's Logo-->
                        <div id="logo">	
                            <a href="${pageContext.request.contextPath}/HomePage" title="Extra Learning Centre Theme">
				<img width="160" height="90" class="normal_logo" src="${pageContext.request.contextPath}/img/SieuLogo.png" alt="Extra Learning Centre Theme" title="Extra Learning Centre Theme" />
				<img class="retina_logo" src="${pageContext.request.contextPath}/img/SieuLogo.png" alt="Extra Learning Centre Theme" title="Extra Learning Centre Theme" style="width:174px; height:94px;"/>
                            </a>                        
                        </div>
                        <!--Search for Courses bar -->
			<div id="primary-menu">
                            <form action="${pageContext.request.contextPath}/SearchCourses" method="" style="display: flex; align-items: center; transform: translateY(20px)">
                                <input type="text" name="query" placeholder="Tìm Khóa Học..." style="padding: 5px 8px; border-radius: 3px; border: 1px solid #ccc; font-size: 14px;" />
                                <button type="submit" style="padding: 6px 10px; transform: translateY(-15px); border: none; border-radius: 4px" class="dt-sc-button small">
                                    <i class="fa fa-search"></i>
                                </button>
                            </form> 
                        <!--Navigation Bar-->
                            <nav id="main-menu">
                                <ul id="menu-main-menu" class="menu" style="position: relative; transform: translateY(-10px); display: flex; align-items: center; gap: 30px 20px ;">
                                    <!--HomePage-->
                                    <li id="menu-item-34" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-home current-menu-item page_item page-item-8 current_page_item menu-item-depth-0 menu-item-simple-parent ">
                                        <a href="${pageContext.request.contextPath}/HomePage">
                                            <span class='menu-icon fa fa-home'> </span>Trang chủ
                                        </a>
                                    </li>
                                    <!--Courses-->
                                    <li id="menu-item-66" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-depth-0 menu-item-megamenu-parent  megamenu-3-columns-group">
                                        <a href="${pageContext.request.contextPath}/HomePage">
                                            <span class='menu-icon fa fa-shopping-cart'> </span>Khóa Học
                                        </a>
                                    </li>
                                    <!--Learning Materials-->
                                    <li id="menu-item-4081" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-depth-0 menu-item-simple-parent ">
                                        <a href="${pageContext.request.contextPath}/HomePage">
                                            <span class='menu-icon fa fa-gift'> </span>Tài Liệu Học
                                        </a>
                                    </li>
                                    <!--Learning Class-->
                                    <li id="menu-item-4140" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-depth-0 menu-item-simple-parent ">
                                        <a href="${pageContext.request.contextPath}/HomePage">
                                            <span class='menu-icon fa fa-book'> </span>Học Bài
                                        </a>
                                    </li>
                                    <!--Blog-->
                                    <li id="menu-item-29" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-depth-0 menu-item-megamenu-parent  megamenu-3-columns-group">
                                        <a href="${pageContext.request.contextPath}/HomePage">
                                            <span class='menu-icon fa fa-pencil'> </span>Blog
                                        </a>
                                    </li>
                                    <!--About Us-->
                                    <li id="menu-item-26" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-depth-0 menu-item-megamenu-parent  megamenu-4-columns-group">
                                        <a href="${pageContext.request.contextPath}/HomePage">
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
</html>
