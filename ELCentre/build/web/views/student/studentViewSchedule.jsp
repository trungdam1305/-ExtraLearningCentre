<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="${pageContext.request.contextPath}/views/login.jsp" />
</c:if>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lịch học của tôi</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-style.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f6f9;
        }
        .sidebar {
            width: 260px;
            background-color: #1F4E79;
            height: 100vh;
            padding: 20px;
            color: white;
            position: fixed;
        }
        .sidebar-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 25px;
        }
        .sidebar-section {
            margin-top: 20px;
            font-size: 20px;
            font-weight: bold;
            color: #a9c0dc;
            letter-spacing: 1px;
            border-top: 1px solid #3e5f87;
            padding-top: 10px;
        }
        .sidebar a {
            display: block;
            text-decoration: none;
            color: white;
            padding: 8px 0;
            font-size: 20px;
            transition: background-color 0.2s ease;
        }
        .sidebar a:hover {
            background-color: #294f78;
            padding-left: 10px;
        }
        .logout-link {
            margin-top: 30px;
            font-weight: bold;
            color: #ffcccc;
        }
        .main-content {
            margin-left: 270px; 
            padding: 50px;
            width: calc(100vw - 260px); 
            box-sizing: border-box; 
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
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

<!-- Sidebar cố định -->
<div class="sidebar">
    <div class="sidebar-title">STUDENT</div>
    <div class="sidebar-section">TỔNG QUAN</div>
    <a href="${pageContext.request.contextPath}/StudentDashboardServlet">Trang chủ</a>
    <div class="sidebar-section">HỌC TẬP</div>
    <a href="${pageContext.request.contextPath}/StudentEnrollClassServlet">Đăng ký học</a>
    <a href="${pageContext.request.contextPath}/StudentViewClassServlet"><strong>Lớp học</strong></a>
    <a href="${pageContext.request.contextPath}/StudentViewScheduleServlet">Lịch học</a>
    <div class="sidebar-section">TÀI CHÍNH</div>
    <a href="${pageContext.request.contextPath}/StudentPaymentServlet">Học phí</a>
    <div class="sidebar-section">HỆ THỐNG</div>
    <a href="${pageContext.request.contextPath}/StudentViewNotificationServlet">Thông báo</a>
    <a href="${pageContext.request.contextPath}/StudentEditProfileServlet">Tài khoản</a>
    <a href="${pageContext.request.contextPath}/StudentSupportServlet">Hỗ trợ</a>
    <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout-link">Đăng xuất</a>
</div>

<!-- Nội dung chính -->
<div class="main-content">
    <div class="header">
        <h2>Lịch học của tôi</h2>
        <span>Xin chào ${sessionScope.user.email}</span>
    </div>

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
</script>
</body>
</html>
