<%-- 
    Document   : staffHeader
    Created on : Jul 23, 2025, 2:33:35 PM
    Author     : Vuh26
--%>

<%-- staffHeader.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    .header {
        background-color: #1F4E79;
        color: white;
        padding: 4px 8px;
        text-align: left;
        position: fixed;
        width: calc(100% - 160px);
        left: 160px;
        right: 0;
        top: 0;
        z-index: 1000;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }
    .header .left-title {
        font-size: 0.83rem;
        letter-spacing: 1px;
        display: flex;
        align-items: center;
    }
    .header .left-title i {
        margin-right: 8px;
    }
    .admin-profile {
        position: relative;
        display: flex;
        flex-direction: column;
        align-items: center;
        cursor: pointer;
        margin-left: 50px;
    }
    .admin-profile .admin-img {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        object-fit: cover;
        border: 2px solid #B0C4DE;
        margin-bottom: 5px;
    }
    .admin-profile span {
        font-size: 0.75rem;
        color: #B0C4DE;
        font-weight: 600;
        max-width: 250px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        margin-right: 40px;
    }
    .admin-profile i {
        color: #B0C4DE;
        margin-left: 10px;
    }
    .dropdown-menu {
        display: none;
        position: absolute;
        top: 50px;
        right: 0;
        background: #163E5C;
        border-radius: 5px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        min-width: 150px;
        z-index: 1001;
    }
    .dropdown-menu.active {
        display: block;
    }
    .dropdown-menu a {
        display: block;
        padding: 10px 15px;
        color: white;
        text-decoration: none;
        font-size: 0.75rem;
        transition: background-color 0.3s ease;
    }
    .dropdown-menu a:hover {
        background-color: #1F4E79;
    }
    .dropdown-menu a i {
        margin-right: 8px;
    }
</style>
<div class="header">
    <div class="left-title">
        Staff Dashboard <i class="fas fa-tachometer-alt"></i>
    </div>
    <div class="admin-profile" onclick="toggleDropdown()">
        <c:forEach var="staff" items="${staffs}">
            <img src="${staff.getAvatar()}" alt="Staff Photo" class="admin-img">
            <span>${staff.getHoTen()}</span>
        </c:forEach>
        <i class="fas fa-caret-down"></i>
        <div class="dropdown-menu" id="adminDropdown">
            <a href="#"><i class="fas fa-key"></i> Change Password</a>
            <a href="#"><i class="fas fa-user-edit"></i> Update Information</a>
        </div>
    </div>
</div>
<script>
    function toggleDropdown() {
        const dropdown = document.getElementById('adminDropdown');
        dropdown.classList.toggle('active');
    }

    document.addEventListener('click', function (event) {
        const profile = document.querySelector('.admin-profile');
        const dropdown = document.getElementById('adminDropdown');
        if (!profile.contains(event.target)) {
            dropdown.classList.remove('active');
        }
    });
</script>
