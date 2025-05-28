<%-- 
    Document   : adminDashboard
    Created on : May 24, 2025, 2:44:16 PM
    Author     : wrx_Chur04
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard</title>
    </head>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            display: flex;
        }

        .sidebar {
            width: 250px;
            height: 100vh;
            background-color: #1F4E79;
            color: white;
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        }

        .sidebar h4 {
            margin: 0;
            margin-bottom: 20px;
        }

        .sidebar div {
            font-weight: bold;
            margin-top: 20px;
            font-size: 14px;
            text-transform: uppercase;
            color: #B0C4DE;
        }

        ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        li {
            margin: 10px 0;
        }

        a {
            text-decoration: none;
            color: white;
            display: block;
            padding: 5px 10px;
            border-radius: 5px;
        }

        a:hover {
            background-color: #163E5C;
        }

        hr.sidebar-items {
            margin: 15px 0;
            border: 0;
            border-top: 1px solid #B0C4DE;
        }
    </style>
    <body>
        <div class="sidebar">
            <div>
                <h4>EDU ADMIN</h4>
            </div>


            <hr class="sidebar_items">
            <div>Tổng quan</div>
            <ul>
                <li>
                    <a>
                        <i></i>
                        Dashboard
                    </a>
                </li>
            </ul>


            <hr class="sidebar-items">
            <div>Quản lý người dùng</div>
            <ul>
                <li>
                    <a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=hocsinh">
                        <i></i>
                        Học sinh
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=giaovien">
                        <i></i>
                        Giáo viên
                    </a>                                                                                                            
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=taikhoan">
                        <i></i>
                        Tài khoản
                    </a>
                </li>   
            </ul>





            <hr class="sidebar-items">
            <div> Quản lý tài chính</div>
            <ul>
                <li>
                    <a>
                        <i></i>
                        Học phí
                    </a>
                </li>
            </ul>
            
            
            
            <hr class="sidebar-items">
            <div>Quản lý học tập</div>
            <ul>
                <li>
                    <a>
                        <i></i>
                        Course
                    </a>
                </li>
            </ul>
            
            <hr class="sidebar-items">
            <div>Hệ thống</div>
            <ul>
                <li>
                    <a>
                        <i></i>
                        Cài đặt
                    </a>
                </li>
            </ul>

            
            <hr class="sidebar-items">
            
            <ul>
                <li>
                    <a>
                        <i></i>
                        Thông báo
                    </a>
                </li>
            </ul>
            
            <hr class="sidebar-items">
            
            <ul>
                <li>
                    <a>
                        <i></i>
                        Blog
                    </a>
                </li>
            </ul>
            
            <hr class="sidebar-items">
            
            <ul>
                <li>
                    <a>
                        <i></i>
                        Logout
                    </a>
                </li>
            </ul>
        </div>
    </body>
</html>

