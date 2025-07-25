<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:if test="${empty sessionScope.user}">
    <c:redirect url="${pageContext.request.contextPath}/views/login.jsp" />
</c:if>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ phụ huynh</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simple-pagination.js@1.6/simplePagination.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-pagination.js@1.6/jquery.simplePagination.js"></script>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            background-color: #f4f6f9;
        }
        .wrapper {
            display: flex;
            min-height: 100vh;
            width: 100%;
        }
        .main-area {
            flex: 1;
            display: flex;
            flex-direction: column;
            background-color: #f4f6f9;
            min-width: 0; /* ✅ Ngăn overflow chiều ngang */
        }
        .main-content {
            flex: 1;
            padding: 30px;
            box-sizing: border-box;
        }
        .header {
            background-color: #1F4E79;
            color: white;
            padding: 16px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap; 
            box-sizing: border-box;
        }
        .user-toggle {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
            max-width: 100%;
            overflow-wrap: anywhere; 
        }
        .user-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            object-fit: cover;
            margin-left: 10px;
            border: 2px solid #ccc;
        }

/* === Danh sách con nổi bật hơn === */
.child-card {
    background: linear-gradient(to right, #ffffff, #f0f6ff);
    border: 1px solid #d0ddee;
    border-radius: 12px;
    padding: 18px 24px;
    margin-bottom: 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.06);
    transition: transform 0.2s ease, box-shadow 0.2s ease;
}
.child-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 6px 15px rgba(0, 0, 0, 0.12);
}

.child-info {
    display: flex;
    align-items: center;
    gap: 20px;
}

.child-avatar {
    width: 72px;
    height: 72px;
    border-radius: 50%;
    object-fit: cover;
    border: 3px solid #1F4E79;
    box-shadow: 0 0 0 3px #e3edf9;
    background-color: white;
}

.child-details {
    font-size: 15px;
    line-height: 1.6;
    color: #333;
}

.child-details strong {
    font-size: 18px;
    color: #1F4E79;
}

.child-action {
    margin-left: auto;
}

.child-action a {
    background-color: #1F4E79;
    color: white;
    padding: 10px 18px;
    border-radius: 8px;
    text-decoration: none;
    font-weight: bold;
    font-size: 14px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    transition: background-color 0.2s ease, transform 0.2s ease;
}

.child-action a:hover {
    background-color: #163d5c;
    transform: translateY(-1px);
}

        /* Sections */
        .section-box {
            display: flex;
            gap: 30px;
            margin-top: 40px;
        }
        .section {
            flex: 1;
            background: white;
            padding: 20px;
            border-radius: 10px;
        }
        .section h3 {
            color: #1F4E79;
            margin-bottom: 15px;
        }
        .box-item {
            background-color: #eef2f7;
            margin-bottom: 10px;
            padding: 10px;
            border-radius: 5px;
        }

        /* Pagination */
        #pagination-thongbao,
        #pagination-lichhoc {
            margin-top: 20px;
            display: flex;
            justify-content: flex-end;
        }
        .pagination {
            list-style: none;
            padding-left: 0;
            margin: 0;
            display: flex;
            gap: 6px;
        }
        .pagination li a,
        .pagination li span {
            display: inline-block;
            padding: 6px 14px;
            font-size: 14px;
            font-weight: bold;
            border-radius: 4px;
            background-color: #1F4E79;
            color: #fff;
            text-decoration: none;
            border: none;
        }
        .pagination li a:hover,
        .pagination li span:hover,
        .pagination li.active span {
            background-color: #163d5c;
        }

        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.4);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 2000;
        }
        .modal-content {
            background: white;
            padding: 30px;
            border-radius: 10px;
            width: 360px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
            position: relative;
        }
        .modal-content input {
            width: 100%;
            padding: 10px;
            margin-bottom: 12px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
        }
        .modal-actions {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }
        .modal-actions .cancel {
            background-color: #999;
        }
        
                    .header {
                position: sticky;
                top: 0;
                z-index: 999;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }

            .user-menu {
                position: relative;
                font-size: 16px;
            }

            .user-toggle {
                cursor: pointer;
                color: #1F4E79;
                font-weight: 500;
            }

            .user-dropdown {
                display: none;
                position: absolute;
                right: 0;
                top: 100%;
                background: white;
                border: 1px solid #ddd;
                border-radius: 6px;
                min-width: 180px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                z-index: 999;
            }

            .user-dropdown a {
                display: block;
                padding: 10px;
                text-decoration: none;
                color: #333;
                font-size: 14px;
            }

            .user-dropdown a:hover {
                background-color: #f0f0f0;
            }
            .user-avatar {
                width: 32px;
                height: 32px;
                border-radius: 50%;
                object-fit: cover;
                margin-right: 8px;
                vertical-align: middle;
            }
            
            /* Css cho đổi mật khẩu */
            .modal-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.4);
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 2000;
            }

            .modal-content {
                background: white;
                padding: 30px;
                border-radius: 10px;
                width: 360px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.3);
                position: relative;
            }

            .modal-content h3 {
                margin-top: 0;
                color: #1F4E79;
                text-align: center;
            }

            .modal-content input {
                width: 100%;
                padding: 10px;
                margin-bottom: 12px;
                border-radius: 6px;
                border: 1px solid #ccc;
                font-size: 14px;
            }

            .modal-actions {
                display: flex;
                justify-content: space-between;
                gap: 10px;
            }

            .modal-actions .cancel {
                background-color: #999;
            }
    </style>
</head>
<body>
<div class="wrapper">
    <%@ include file="/views/parent/sidebar.jsp" %>
    <div class="main-area">
        <c:if test="${not empty sessionScope.message}">
                    <div class="message success">
                        <c:out value="${sessionScope.message}" />
                    </div>
                    <c:remove var="message" scope="session" />
                </c:if>  
        <div class="header" style="
                background-color: #1F4E79;
                color: white;
                padding: 16px 30px;
                margin: 0;
                width: 100%;
                box-sizing: border-box;
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-radius: 0;
                position: relative;
                top: 0;
                left: 0;
                z-index: 999;
            ">
        
            <h2 style="margin: 0; color: white;">Trang chủ phụ huynh</h2>
            <div class="user-menu">
                <div class="user-toggle" onclick="toggleUserMenu()" style="color: white;">
                    <span>👋 Xin chào <strong>${phuHuynhInfo.hoTen}</strong>
                    <img src="${pageContext.request.contextPath}/${phuHuynhInfo.avatar}" class="user-avatar" alt="Avatar">
                    ☰
                    </span>
                </div>
                <div class="user-dropdown" id="userDropdown">
                    <a href="${pageContext.request.contextPath}/ResetPasswordServlet" onclick="openModal(); return false;">🔑 Đổi mật khẩu</a>
                    <a href="${pageContext.request.contextPath}/LogoutServlet">🚪 Đăng xuất</a>
                </div>
            </div>
        </div>
        

        <div class="main-content">
            <h3>Danh sách con</h3>
            <c:forEach var="child" items="${dsCon}">
                <div class="child-card">
                    <div class="child-info">
                        <img src="${pageContext.request.contextPath}/${child.avatar}" alt="avatar" class="child-avatar">
                        <div class="child-details">
                            <strong>${child.hoTen}</strong><br>
                            Lớp: ${child.lopDangHocTrenTruong}<br>
                            Ngày sinh: ${child.ngaySinh}
                        </div>
                    </div>
                    <div class="child-action">
                        <a href="${pageContext.request.contextPath}/ParentViewStudentDetailServlet?id=${child.ID_HocSinh}">Xem chi tiết</a>
                    </div>
                </div>
            </c:forEach>

            <div class="section-box">
                <div class="section">
                    <h3>Thông báo</h3>
                    <div id="listThongBao">
                        <c:choose>
                            <c:when test="${empty dsThongBao}">
                                <div class="box-item" style="color: #999; font-style: italic;">
                                    Bạn chưa có thông báo nào.
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="tb" items="${dsThongBao}">
                                    <div class="box-item" style="display: flex; justify-content: space-between; align-items: stretch; border: 1px solid #ddd;">
                                        <div style="padding: 10px; flex: 1;">
                                            <div style="font-weight: 500;">${tb.noiDung}</div>
                                            <div style="font-size: 13px; color: #666;">🕒 ${tb.thoiGian}</div>
                                        </div>
                                        <c:set var="trangThai" value="${empty tb.status ? 'Chưa đọc' : tb.status}" />
                                        <c:choose>
                                            <c:when test="${trangThai eq 'Đã đọc'}">
                                                <div style="padding: 10px 15px; background-color: #e6f4ea; color: #2e7d32;">${trangThai}</div>
                                            </c:when>
                                            <c:otherwise>
                                                <div style="padding: 10px 15px; background-color: #fdecea; color: #c62828;">${trangThai}</div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div id="pagination-thongbao"></div>
                </div>
                
                <div class="section">
                    <h3>Thông báo</h3>
                    <div id="listLichHoc">
                        <c:choose>
                            <c:when test="${empty lichHocSapToi}">
                                <div class="box-item" style="color: #999; font-style: italic;">
                                    Không có lịch học sắp tới.
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="lh" items="${lichHocSapToi}">
                                    <div class="box-item">
                                        📅 <strong>${fn:substring(lh.ngayHoc, 8, 10)}/${fn:substring(lh.ngayHoc, 5, 7)}/${fn:substring(lh.ngayHoc, 0, 4)}</strong>
                                        – <strong>${lh.tenHocSinh}</strong> – Lớp: <strong>${lh.tenLopHoc}</strong>, Slot: ${lh.slotThoiGian}
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div id="pagination-lichhoc"></div>
                </div>
            </div>    
        </div>
                <%@ include file="/views/parent/footer.jsp" %>
    </div>
</div>

<!-- JavaScript -->
<script>
    $(document).ready(function () {
        function applyPagination(containerSelector, itemSelector, paginationSelector, itemsPerPage = 5) {
            const items = $(containerSelector).children(itemSelector);
            const numItems = items.length;
            if (numItems === 0) return;
            function showPage(page) {
                const start = (page - 1) * itemsPerPage;
                const end = start + itemsPerPage;
                items.hide().slice(start, end).show();
            }
            showPage(1);
            $(paginationSelector).pagination({
                items: numItems,
                itemsOnPage: itemsPerPage,
                onPageClick: function (pageNumber) {
                    showPage(pageNumber);
                }
            });
        }
        applyPagination("#listThongBao", ".box-item", "#pagination-thongbao", 1);
        applyPagination("#listLichHoc", ".box-item", "#pagination-lichhoc", 3);
    });

    function toggleUserMenu() {
        const dropdown = document.getElementById("userDropdown");
        dropdown.style.display = (dropdown.style.display === "block") ? "none" : "block";
    }
    document.addEventListener("click", function (event) {
        const toggle = document.querySelector(".user-toggle");
        const dropdown = document.getElementById("userDropdown");
        if (!toggle.contains(event.target) && !dropdown.contains(event.target)) {
            dropdown.style.display = "none";
        }
    });

    function openModal() {
        document.getElementById("passwordModal").style.display = "flex";
    }
    function closeModal() {
        document.getElementById("passwordModal").style.display = "none";
    }
    document.addEventListener("click", function(e) {
        const modal = document.getElementById("passwordModal");
        if (e.target === modal) {
            closeModal();
        }
    });
</script>

<!-- Modal -->
<div id="passwordModal" class="modal-overlay" style="display: none;">
    <div class="modal-content">
        <h3>🔐 Đổi mật khẩu</h3>
        <form method="post" action="${pageContext.request.contextPath}/ResetPasswordServlet">
            <input type="password" name="currentPassword" placeholder="Mật khẩu hiện tại" required>
            <input type="password" name="newPassword" placeholder="Mật khẩu mới" required>
            <input type="password" name="confirmPassword" placeholder="Xác nhận mật khẩu" required>
            <div class="modal-actions">
                <button type="submit" class="action-btn">Cập nhật</button>
                <button type="button" class="action-btn cancel" onclick="closeModal()">Hủy</button>
            </div>
        </form>
        <c:if test="${not empty requestScope.message}">
            <p style="color: red; margin-top: 10px;">${requestScope.message}</p>
        </c:if>
    </div>
</div>


</body>
</html>

