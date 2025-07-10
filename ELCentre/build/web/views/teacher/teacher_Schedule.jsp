<%-- 
    Document   : teacher_Schedule
    Created on : July 8, 2025, 11:00:00 PM
    Author     : Vuh26
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*, java.text.*" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Dạy Giáo Viên</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Font Awesome for additional icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        /* General container styling */
        .content-container {
            padding: 16px;
            max-width: 100%;
            margin: 0 auto;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
            padding-bottom: 40px;
        }

        /* Calendar styling */
        h2 {
            text-align: center;
            color: #003087;
            margin-bottom: 15px;
            font-size: 1.5rem;
            font-weight: 600;
        }
        .calendar-table {
            width: 98%;
            max-width: 1400px;
            margin: 0 auto;
            border-collapse: collapse;
            font-size: 0.9rem;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }
        .calendar-table th, .calendar-table td {
            border: 1px solid #dee2e6;
            text-align: center;
            padding: 8px;
            vertical-align: top;
            width: 14.2857%;
        }
        .calendar-table th {
            background-color: #2196F3;
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            height: 30px;
        }
        .calendar-table td {
            height: 100px;
        }
        .has-schedule {
            background-color: #d4edda !important;
        }
        .no-schedule {
            background-color: #ffffff;
        }
        .today {
            border: 2px solid #007bff;
            background-color: #e6f0fa;
        }
        .btn-view {
            background-color: #17a2b8;
            border-color: #17a2b8;
            color: white;
            font-size: 0.8rem;
            padding: 3px 6px;
            border-radius: 6px;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }
        .btn-view:hover {
            background-color: #117a8b;
            border-color: #117a8b;
            transform: translateY(-2px);
        }
        .btn-view i {
            margin-right: 4px;
        }
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 16px;
        }
        .form-container .form-select,
        .form-container .form-control {
            border-radius: 8px;
            border: 1px solid #ced4da;
            box-shadow: none;
            transition: border-color 0.3s ease;
            height: 32px;
            font-size: 0.9rem;
        }
        .form-container .form-select:focus,
        .form-container .form-control:focus {
            border-color: #003087;
            box-shadow: 0 0 5px rgba(0, 48, 135, 0.3);
        }
        .modal-content {
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .modal-header {
            background-color: #003087;
            color: white;
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
        }
        .modal-header h5 {
            font-size: 1.1rem;
        }
        .modal-body {
            max-height: 400px;
            overflow-y: auto;
            font-size: 0.9rem;
        }
        .modal-body table {
            font-size: 0.9rem;
        }
        .modal-footer .btn {
            font-size: 0.9rem;
        }
        .alert-custom-success {
            background-color: #22c55e;
            border-color: #22c55e;
            color: white;
            border-radius: 8px;
            padding: 8px;
            margin-bottom: 10px;
            font-size: 0.9rem;
            text-align: center;
        }
        .alert-custom-danger {
            background-color: #ef4444;
            border-color: #ef4444;
            color: white;
            border-radius: 8px;
            padding: 8px;
            margin-bottom: 10px;
            font-size: 0.9rem;
            text-align: center;
        }

        /* Scroll to Top Button */
        #scrollToTopBtn {
            display: none;
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            font-size: 16px;
            cursor: pointer;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            z-index: 1000;
            transition: background-color 0.3s ease;
        }
        #scrollToTopBtn:hover {
            background-color: #0056b3;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .content-container {
                padding: 12px;
                margin: 10px;
                margin-top: 15px;
            }
            h2 {
                font-size: 1.2rem;
            }
            .form-container {
                max-width: 100%;
                padding: 12px;
            }
            .form-container .form-select,
            .form-container .form-control {
                font-size: 0.8rem;
                height: 28px;
            }
            .calendar-table {
                font-size: 0.7rem;
            }
            .calendar-table th, .calendar-table td {
                padding: 5px;
                height: 80px;
            }
            .calendar-table th {
                font-size: 0.7rem;
                height: 25px;
            }
            .btn-view {
                font-size: 0.7rem;
                padding: 2px 4px;
            }
            .modal-header h5 {
                font-size: 0.9rem;
            }
            .modal-body {
                font-size: 0.7rem;
            }
            .modal-body table {
                font-size: 0.7rem;
            }
            .modal-footer .btn {
                font-size: 0.7rem;
            }
            .alert-custom-success,
            .alert-custom-danger {
                font-size: 0.7rem;
                padding: 6px;
            }
            #scrollToTopBtn {
                bottom: 10px;
                right: 10px;
                width: 30px;
                height: 30px;
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
   <div class="content-container">
        <div class="form-container">
            <h2>Lịch Dạy Tháng ${month}/${year}</h2>

            <!-- Thông báo -->
            <c:if test="${not empty err}">
                <div class="alert alert-custom-danger">${fn:escapeXml(err)}</div>
            </c:if>
            <c:if test="${not empty suc}">
                <div class="alert alert-custom-success">${fn:escapeXml(suc)}</div>
            </c:if>

            <form method="get" action="${pageContext.request.contextPath}/teacher-schedule" class="mb-4">
                <input type="hidden" name="idTKGiaoVien" value="${idTKGiaoVien}">
                <div class="row g-2 align-items-end">
                    <div class="col-md-3">
                        <label for="month" class="form-label">Tháng:</label>
                        <select name="month" id="month" class="form-select" onchange="this.form.submit()">
                            <c:forEach var="m" begin="1" end="12">
                                <option value="${m}" ${month == m ? 'selected' : ''}>${m}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label for="year" class="form-label">Năm:</label>
                        <select name="year" id="year" class="form-select" onchange="this.form.submit()">
                            <c:forEach var="y" begin="${currentYear - 5}" end="${currentYear + 5}">
                                <option value="${y}" ${year == y ? 'selected' : ''}>${y}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <button type="submit" class="btn btn-custom-action"><i class="bi bi-search"></i> Xem Lịch</button>
                    </div>
                </div>
            </form>

            <!-- Tạo lịch -->
            <%
                int m = (Integer) request.getAttribute("month");
                int y = (Integer) request.getAttribute("year");
                Calendar cal = new GregorianCalendar(y, m - 1, 1);
                int daysInMonth = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
                int firstDayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
                if (firstDayOfWeek == Calendar.SUNDAY) firstDayOfWeek = 7;
                else firstDayOfWeek--;

                int today = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
                int currentMonth = Calendar.getInstance().get(Calendar.MONTH) + 1;
                int currentYear = Calendar.getInstance().get(Calendar.YEAR);
                Set<Integer> scheduleDays = (Set<Integer>) request.getAttribute("scheduleDays");
            %>

            <table class="calendar-table table">
                <thead>
                    <tr>
                        <th>Thứ Hai</th>
                        <th>Thứ Ba</th>
                        <th>Thứ Tư</th>
                        <th>Thứ Năm</th>
                        <th>Thứ Sáu</th>
                        <th>Thứ Bảy</th>
                        <th>Chủ Nhật</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int day = 1;
                        boolean started = false;
                        for (int week = 0; week < 6 && day <= daysInMonth; week++) {
                    %>
                    <tr>
                        <%
                            for (int dow = 1; dow <= 7; dow++) {
                                if (!started && dow == firstDayOfWeek) started = true;
                                if (started && day <= daysInMonth) {
                                    boolean hasSchedule = scheduleDays != null && scheduleDays.contains(day);
                                    boolean isToday = (day == today && m == currentMonth && y == currentYear);
                        %>
                        <td class="<%= hasSchedule ? "has-schedule" : "no-schedule" %> <%= isToday ? "today" : "" %>">
                            <div><%= day %></div>
                            <% if (hasSchedule) { %>
                            <button type="button" class="btn btn-view"
                                    data-bs-toggle="modal"
                                    data-bs-target="#scheduleModal"
                                    data-day="<%= day %>"><i class="bi bi-eye"></i> Xem Lớp</button>
                            <% } %>
                        </td>
                        <%
                                    day++;
                                } else {
                        %>
                        <td class="no-schedule"></td>
                        <%
                                }
                            }
                        %>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

            <!-- Modal -->
            <div class="modal fade" id="scheduleModal" tabindex="-1" aria-labelledby="scheduleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="scheduleModalLabel">Lịch Học Ngày <span id="modalDay"></span></h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                        </div>
                        <div class="modal-body">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Lớp</th>
                                        <th>Phòng</th>
                                        <th>Thời Gian</th>
                                        <th>Ghi Chú</th>
                                    </tr>
                                </thead>
                                <tbody id="scheduleTableBody"></tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"><i class="bi bi-x"></i> Đóng</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Nút Scroll to Top -->
    <button id="scrollToTopBtn" onclick="scrollToTop()" title="Cuộn lên đầu trang">↑</button>

    <!-- Bootstrap 5 JS và Popper -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    <script>
        // Hiển thị/n ẩn nút khi cuộn
        window.onscroll = function () {
            var scrollBtn = document.getElementById("scrollToTopBtn");
            if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
                scrollBtn.style.display = "block";
            } else {
                scrollBtn.style.display = "none";
            }
        };

        // Hàm cuộn lên đầu trang
        function scrollToTop() {
            window.scrollTo({top: 0, behavior: "smooth"});
        }

        // Xử lý lịch học
        document.addEventListener('DOMContentLoaded', function() {
            const lichHocList = [
                <c:forEach items="${lichHocList}" var="lich" varStatus="status">
                    {
                        tenLopHoc: "${fn:escapeXml(lich.tenLopHoc != null ? lich.tenLopHoc : 'N/A')}",
                        tenPhongHoc: "${fn:escapeXml(lich.tenPhongHoc != null ? lich.tenPhongHoc : 'N/A')}",
                        slotThoiGian: "${fn:escapeXml(lich.slotThoiGian != null ? lich.slotThoiGian : 'N/A')}",
                        ghiChu: "${fn:escapeXml(lich.ghiChu != null ? lich.ghiChu : '')}",
                        day: ${lich.ngayHoc != null ? lich.ngayHoc.dayOfMonth : 0}
                    }<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ];

            document.querySelectorAll('.btn-view').forEach(btn => {
                btn.addEventListener('click', function() {
                    const selectedDay = parseInt(this.getAttribute('data-day'));
                    document.getElementById('modalDay').textContent = selectedDay + '/' + ${month} + '/' + ${year};

                    const schedules = lichHocList.filter(item => item.day === selectedDay);
                    const tbody = document.getElementById('scheduleTableBody');
                    tbody.innerHTML = '';

                    if (schedules.length > 0) {
                        schedules.forEach(item => {
                            const row = document.createElement('tr');
                            const td1 = document.createElement('td');
                            td1.textContent = item.tenLopHoc || 'N/A';
                            const td2 = document.createElement('td');
                            td2.textContent = item.tenPhongHoc || 'N/A';
                            const td3 = document.createElement('td');
                            td3.textContent = item.slotThoiGian || 'N/A';
                            const td4 = document.createElement('td');
                            td4.textContent = item.ghiChu || '';
                            row.appendChild(td1);
                            row.appendChild(td2);
                            row.appendChild(td3);
                            row.appendChild(td4);
                            tbody.appendChild(row);
                        });
                    } else {
                        tbody.innerHTML = '<tr><td colspan="4">Không có lịch học</td></tr>';
                    }
                });
            });
        });
    </script>
</body>
</html>l