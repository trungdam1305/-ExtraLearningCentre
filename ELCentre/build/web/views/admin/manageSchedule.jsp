<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Lịch Học</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .calendar-table {
            width: 100%;
            border-collapse: collapse;
        }
        .calendar-table th, .calendar-table td {
            border: 1px solid #ddd;
            text-align: center;
            padding: 10px;
            vertical-align: top;
            height: 100px;
        }
        .calendar-table th {
            background-color: #f8f9fa;
        }
        .has-schedule {
            background-color: #d4edda !important;
        }
        .no-schedule {
            background-color: #ffffff;
        }
        .today {
            border: 2px solid #007bff;
        }
        .btn-view {
            font-size: 0.8rem;
            padding: 5px 10px;
        }
        .modal-body {
            max-height: 400px;
            overflow-y: auto;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center mb-4">Lịch Học Tháng ${month}/${year}</h2>

    <form method="get" action="${pageContext.request.contextPath}/ManageSchedule" class="mb-4">
        <div class="row">
            <div class="col-md-3">
                <label for="month" class="form-label">Tháng:</label>
                <select name="month" id="month" class="form-select">
                    <c:forEach var="m" begin="1" end="12">
                        <option value="${m}" <c:if test="${month == m}">selected</c:if>>${m}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-3">
                <label for="year" class="form-label">Năm:</label>
                <select name="year" id="year" class="form-select">
                    <c:forEach var="y" begin="${currentYear - 5}" end="${currentYear + 5}">
                        <option value="${y}" <c:if test="${year == y}">selected</c:if>>${y}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-3 align-self-end">
                <button type="submit" class="btn btn-primary">Xem Lịch</button>
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
                    <button type="button" class="btn btn-primary btn-view"
                            data-bs-toggle="modal"
                            data-bs-target="#scheduleModal"
                            data-day="<%= day %>">Xem Lớp</button>
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
</div>

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
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Chuyển dữ liệu JSTL sang JS object an toàn
        const lichHocList = [
            <c:forEach items="${lichHocList}" var="lich">
            {
                tenLopHoc: "${not empty lich.tenLopHoc ? lich.tenLopHoc : 'N/A'}",
                tenPhongHoc: "${not empty lich.tenPhongHoc ? lich.tenPhongHoc : 'N/A'}",
                slotThoiGian: "${not empty lich.slotThoiGian ? lich.slotThoiGian : 'N/A'}",
                ghiChu: "${not empty lich.ghiChu ? lich.ghiChu : ''}",
                day: ${lich.ngayHoc.dayOfMonth}
            },
            </c:forEach>
        ];
        
        console.log("Dữ liệu lịch học:", lichHocList); // Kiểm tra trong console

        // Xử lý sự kiện click
        document.querySelectorAll('.btn-view').forEach(btn => {
            btn.addEventListener('click', function() {
                const selectedDay = parseInt(this.getAttribute('data-day'));
                document.getElementById('modalDay').textContent = 
                    selectedDay + '/' + ${month} + '/' + ${year};
                
                // Lọc lịch học theo ngày
                const schedules = lichHocList.filter(item => item.day === selectedDay);
                const tbody = document.getElementById('scheduleTableBody');
                tbody.innerHTML = '';
                
                if (schedules.length > 0) {
                    schedules.forEach(item => {
                        tbody.innerHTML += `
                            <tr>
                                <td>${item.tenLopHoc}</td>
                                <td>${item.tenPhongHoc}</td>
                                <td>${item.slotThoiGian}</td>
                                <td>${item.ghiChu}</td>
                            </tr>
                        `;
                    });
                } else {
                    tbody.innerHTML = '<tr><td colspan="4">Không có lịch học</td></tr>';
                }
            });
        });
    });
</script>

</body>
</html>