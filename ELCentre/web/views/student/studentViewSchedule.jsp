<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:if test="${empty sessionScope.user}">
    <c:redirect url="${pageContext.request.contextPath}/views/login.jsp" />
</c:if>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Trang chủ</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-style.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-pagination.js@1.6/jquery.simplePagination.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simple-pagination.js@1.6/simplePagination.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                margin: 0;
                padding: 0;
                display: flex;
                background-color: #f4f6f9;
            }
            .logout-link {
                margin-top: 30px;
                font-weight: bold;
                color: #ffcccc;
            }
            .main-content {
                flex: 1;
                padding: 0px;
            }
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
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
            table {
                width: 100%;
                border-collapse: collapse;
                background-color: white;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
            }
            th, td {
                padding: 12px 14px;
                text-align: center;
                border-bottom: 1px solid #ddd;
                font-size: 15px;
            }
            th {
                background-color: #1F4E79;
                color: white;
            }
            .no-data {
                background-color: white;
                padding: 40px;
                text-align: center;
                color: #888;
                border-radius: 10px;
                font-size: 18px;
                box-shadow: 0 1px 4px rgba(0,0,0,0.05);
            }
            .action-buttons {
                display: flex;
                justify-content: center;
                gap: 6px;
                flex-wrap: wrap;
            }
            .action-buttons form {
                margin: 0;
            }
            .action-btn {
                padding: 6px 12px;
                border: none;
                border-radius: 4px;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                color: white;
                background-color: #1F4E79;
                transition: background-color 0.2s ease;
            }
            .action-btn:hover {
                background-color: #163d5c;
            }
            .action-btn.transfer {
                background-color: #f0ad4e;
            }
            .action-btn.transfer:hover {
                background-color: #d99632;
            }
            .action-btn.leave {
                background-color: #d9534f;
            }
            .action-btn.leave:hover {
                background-color: #b52b27;
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
                /* Css phân trang và menu người dùng */
                #pagination-lophoc,
                #pagination-thongbao,
                #pagination-lichhoc {
                    margin-top: 20px;
                    display: flex;
                    justify-content: flex-end; /* căn phải */
                }

                .pagination {
                    list-style: none;
                    padding-left: 0;
                    margin: 0;
                    display: flex;
                    gap: 6px;
                }

                .pagination li {
                    display: inline;
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
                    transition: background-color 0.2s ease;
                    border: none;
                }

                .pagination li a:hover,
                .pagination li span:hover {
                    background-color: #163d5c;
                }

                .pagination li.active span {
                    background-color: #163d5c;
                }
                            /* Wrapper layout */
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
               overflow-x: auto;
            }
            
            .header {
                background-color: #1F4E79;
                color: white;
                padding: 16px 30px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            
            .main-content {
                flex: 1;
                padding: 30px;
                max-width: 100%; /* Đảm bảo không giới hạn chiều rộng */
                box-sizing: border-box; /* Bao gồm padding trong chiều rộng */
            }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #1F4E79;
            color: white;
        }
        .no-data {
            text-align: center;
            padding: 40px;
            font-size: 18px;
            color: #999;
            background-color: white;
            border-radius: 10px;
        }
        
        .timetable-wrapper {
            margin-top: 40px;
        }

        .timetable {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
        }

        .timetable th, .timetable td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ddd;
            font-size: 15px;
        }

        .timetable th {
            background-color: #1F4E79;
            color: white;
        }

        .timetable td.active {
            background-color: #d4edda;
            font-weight: bold;
            color: #155724;
            border: 2px solid #28a745;
            border-radius: 4px;
        }
        
        .schedule-controls {
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap; /* Cho phép xuống dòng trên màn hình nhỏ */
                gap: 15px;
                margin-bottom: 20px;
                padding: 15px;
                background-color: #f8f9fa;
                border: 1px solid #e9ecef;
                border-radius: 8px;
            }

            /* Khu vực chứa các nút bấm */
            .schedule-controls .nav-buttons {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .schedule-controls .nav-button {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                padding: 8px 15px;
                background-color: #1F4E79;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                transition: background-color 0.2s;
            }

            .schedule-controls .nav-button:hover {
                background-color: #163E5C;
            }

            /* Khu vực hiển thị tuần hiện tại */
            .schedule-controls .current-week-display {
                font-size: 1.1em;
                font-weight: bold;
                color: #333;
                text-align: center;
                flex-grow: 1; /* Cho phép co giãn để lấp đầy không gian */
            }

            /* Khu vực chọn tuần cụ thể */
            .schedule-controls .week-picker-form {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .schedule-controls .week-picker-form label {
                font-weight: 500;
            }

            .schedule-controls .week-picker-form input[type="week"] {
                padding: 5px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .schedule-controls .week-picker-form button {
                 padding: 8px 12px;
                background-color: #555;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            .schedule-controls .week-picker-form button:hover {
                background-color: #333;
            }   
            
            .attendance-status {
                display: inline-block;
                padding: 4px 10px;
                border-radius: 12px;
                font-size: 13px;
                font-weight: bold;
                color: white;
                text-align: center;
                width: 85px; /* Đặt chiều rộng cố định để các trạng thái đều nhau */
            }

            .status-present {
                background-color: #28a745; /* Xanh lá */
            }

            .status-absent {
                background-color: #dc3545; /* Đỏ */
            }

            .status-late {
                background-color: #ffc107; /* Vàng */
                color: #333;
            }

            .status-pending {
                background-color: #6c757d; /* Xám */
            }
            
            .modal-overlay {
                display: none; /* Mặc định ẩn */
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.6);
                justify-content: center;
                align-items: center;
            }

            /* Nội dung của modal */
            .modal-content {
                background-color: #fefefe;
                padding: 25px 30px;
                border: 1px solid #888;
                width: 80%;
                max-width: 500px; /* Chiều rộng tối đa */
                border-radius: 10px;
                position: relative;
                box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
                animation: fadeIn 0.3s;
            }

            /* Nút đóng (dấu X) */
            .close-button {
                color: #aaa;
                position: absolute;
                top: 10px;
                right: 20px;
                font-size: 28px;
                font-weight: bold;
            }

            .close-button:hover,
            .close-button:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }

            @keyframes fadeIn {
                from {opacity: 0; transform: scale(0.9);}
                to {opacity: 1; transform: scale(1);}
            }
    </style>
</head>
    <body>
        <div class="wrapper">
        <%@ include file="/views/student/sidebar.jsp" %>
        <div class="main-area">
            <c:if test="${not empty sessionScope.message}">
                <div class="message success">
                    <c:out value="${sessionScope.message}" />
                </div>
                <c:remove var="message" scope="session" />
            </c:if>            
        <!-- Header -->
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
                <h2 style="margin: 0; color: white;">Lịch học</h2>
                <div class="user-menu">
                    <div class="user-toggle" onclick="toggleUserMenu()" style="color: white;">
                        <span><strong>${hocSinhInfo.hoTen}</strong>
                            <img src="${pageContext.request.contextPath}/${hocSinhInfo.avatar}" class="user-avatar" alt="Avatar">
                            ☰
                        </span>
                    </div>
                    <div class="user-dropdown" id="userDropdown">
                        <a href="${pageContext.request.contextPath}/ResetPasswordServlet" onclick="openModal(); return false;">🔑 Đổi mật khẩu</a>
                        <a href="${pageContext.request.contextPath}/LogoutServlet">🚪 Đăng xuất</a>
                    </div>
                </div>
            </div>
                    
            <div class="main-content" style="padding: 30px;">
                <div class="data-table-container schedule-container">
                        <h3 class="section-title"><i class="fas fa-calendar-alt"></i> Thời Khóa Biểu</h3>

                        <div class="schedule-controls">
                            <div class="nav-buttons">
                                <a href="StudentViewScheduleServlet?viewDate=${previousWeekLink}" class="nav-button"><i class="fas fa-chevron-left"></i> Tuần trước</a>
                                <a href="StudentViewScheduleServlet" class="nav-button"><i class="fas fa-calendar-day"></i> Tuần này</a>
                                <a href="StudentViewScheduleServlet?viewDate=${nextWeekLink}" class="nav-button">Tuần sau <i class="fas fa-chevron-right"></i></a>
                            </div>

                            <div class="current-week-display">
                                <span>${displayWeekRange}</span>
                            </div>
                            
                            <form action="StudentViewScheduleServlet" method="GET" class="week-picker-form">
                                <label for="week-picker">Chọn tuần:</label>
                                <input type="week" id="week-picker" name="week" value="${selectedWeekValue}">
                                <button type="submit">Xem</button>
                            </form>

                        </div>                                
                        <table class="table table-bordered schedule-grid">
                            <thead>
                                <tr>
                                    <th style="width: 12%; background-color: #343a40;">Ca học</th>
                                    <c:forEach var="date" items="${weekDates}">
                                        <th style="width: 12.5%;">
                                            <%
                                                // get date from object in servlet
                                                Object obj = pageContext.getAttribute("date");
                                                if (obj instanceof java.time.LocalDate) {
                                                    java.time.LocalDate currentDate = (java.time.LocalDate) obj;

                                                    // format for day in week
                                                    java.util.Locale localeVN = new java.util.Locale("vi", "VN");
                                                    java.time.format.DateTimeFormatter dayFormatter = 
                                                        java.time.format.DateTimeFormatter.ofPattern("EEEE", localeVN);

                                                    // format for date (day and month)
                                                    java.time.format.DateTimeFormatter dateFormatter = 
                                                        java.time.format.DateTimeFormatter.ofPattern("dd/MM");

                                                    // HTML file
                                                    out.print(currentDate.format(dayFormatter));
                                                    out.print("<br><small>");
                                                    out.print(currentDate.format(dateFormatter));
                                                    out.print("</small>");
                                                }
                                            %>
                                        </th>
                                    </c:forEach>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="slot" items="${timeSlots}">
                                    <tr>
                                        <td class="slot-time">${slot.slotThoiGian}</td>

                                        <c:forEach var="date" items="${weekDates}" varStatus="loop">
                                            <c:set var="dayOfWeek" value="${date.dayOfWeek.value}" />
                                            <c:set var="key" value="${slot.ID_SlotHoc}-${dayOfWeek}"/>
                                            <c:set var="lh" value="${scheduleMap[key]}" />

                                            <td>
                                                        <div class="mt-auto">
                                                            <c:choose>
                                                                <c:when test="${not empty lh}">
                                                                    <div class="class-info schedule-cell-clickable" 
                                                                        data-note="${lh.ghiChu}" 
                                                                        data-classname="${lh.tenLopHoc}">
                                                                        <div>
                                                                            <div class="class-info-name">${lh.tenLopHoc}</div>
                                                                            <div class="class-info-room"><i class="fas fa-map-marker-alt fa-xs"></i> ${lh.tenPhongHoc}</div>
                                                                        </div>
                                                                        <div class="mt-auto">
                                                                            <c:set var="statusText" value="----" />
                                                                            <c:set var="statusClass" value="status-pending" />
                                                                            <c:if test="${not empty lh.trangThaiDiemDanh}">
                                                                                <c:choose>
                                                                                    <c:when test="${lh.trangThaiDiemDanh == 'Có mặt'}">
                                                                                        <c:set var="statusText" value="Có mặt" />
                                                                                        <c:set var="statusClass" value="status-present" />
                                                                                    </c:when>
                                                                                    <c:when test="${lh.trangThaiDiemDanh == 'Vắng'}">
                                                                                        <c:set var="statusText" value="Vắng" />
                                                                                        <c:set var="statusClass" value="status-absent" />
                                                                                    </c:when>
                                                                                    <c:when test="${lh.trangThaiDiemDanh == 'Đi muộn'}">
                                                                                        <c:set var="statusText" value="Đi muộn" />
                                                                                        <c:set var="statusClass" value="status-late" />
                                                                                    </c:when>
                                                                                </c:choose>
                                                                            </c:if>
                                                                            <span class="attendance-status ${statusClass}">${statusText}</span>
                                                                        </div>
                                                                    </div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>    

        

              <div id="noteModal" class="modal-overlay">
                <div class="modal-content">
                    <span class="close-button">&times;</span>
                    <h3 id="modalClassName">Tên lớp học</h3>
                    <hr>
                    <p id="modalNoteContent"></p>
                </div>
            </div>
                                
<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Lấy các phần tử của modal
        const modal = document.getElementById('noteModal');
        const modalClassName = document.getElementById('modalClassName');
        const modalNoteContent = document.getElementById('modalNoteContent');
        const closeButton = document.querySelector('.close-button');

        // Lấy tất cả các ô lịch học có thể click
        const clickableCells = document.querySelectorAll('.schedule-cell-clickable');

        // Thêm sự kiện click cho mỗi ô
        clickableCells.forEach(cell => {
            cell.addEventListener('click', function () {
                // Lấy dữ liệu từ thuộc tính data-* của ô được click
                const className = cell.dataset.classname;
                let note = cell.dataset.note;

                // Kiểm tra nếu ghi chú rỗng hoặc không có
                if (!note || note.trim() === '' || note.trim() === 'null') {
                    note = 'Không có ghi chú cho buổi học này.';
                }

                // Gán dữ liệu vào modal
                modalClassName.textContent = className;
                modalNoteContent.textContent = note;

                // Hiển thị modal
                modal.style.display = 'flex';
            });
        });

        // Hàm để đóng modal
        function closeModal() {
            modal.style.display = 'none';
        }

        // Đóng modal khi click vào nút X
        closeButton.addEventListener('click', closeModal);

        // Đóng modal khi click ra ngoài vùng nội dung
        window.addEventListener('click', function (event) {
            if (event.target === modal) {
                closeModal();
            }
        });
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

                $(document).ready(function () {
                    var itemsPerPage = 5;
                    var items = $("#tableBody tr:not([id^='transfer-row'])"); 
                    var numItems = items.length;

                    function showPage(items, page) {
                        var start = (page - 1) * itemsPerPage;
                        var end = start + itemsPerPage;
                        items.hide().slice(start, end).show();
                    }

                    if (numItems > 0) {
                        showPage(items, 1);
                        $('#pagination-container').pagination({
                            items: numItems,
                            itemsOnPage: itemsPerPage,
                            onPageClick: function (pageNumber) {
                                showPage(items, pageNumber);
                            }
                        });
                    }
                });
                </script>
                
                </div>
                <%@ include file="/views/student/footer.jsp" %>
            </div>
        </div>    
    </body>
</html>