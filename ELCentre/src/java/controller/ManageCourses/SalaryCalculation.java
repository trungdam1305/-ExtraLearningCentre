/*
 * Servlet để tính lương dự tính cho giáo viên.
 * Tên class: SalaryCalculation
 * Package: controller.ManageCourses
 */
package controller.ManageCourses;

import dal.SalaryDAO;
import model.SalaryInfo;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.nio.charset.StandardCharsets;

public class SalaryCalculation extends HttpServlet {

    private SalaryDAO salaryDAO = new SalaryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Ngăn cache
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");

        try {
            String idGiaoVienStr = request.getParameter("idGiaoVien");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");


            if (idGiaoVienStr == null || idGiaoVienStr.trim().isEmpty()) {
                idGiaoVienStr = (String) request.getAttribute("idGiaoVien");
            }
            if (startDate == null || startDate.trim().isEmpty()) {
                startDate = (String) request.getAttribute("startDate");
            }
            if (endDate == null || endDate.trim().isEmpty()) {
                endDate = (String) request.getAttribute("endDate");
            }

            int idGiaoVien;
            try {
                idGiaoVien = (idGiaoVienStr != null && !idGiaoVienStr.trim().isEmpty()) ? Integer.parseInt(idGiaoVienStr) : 0;
                if (idGiaoVien == 0) {
                    throw new NumberFormatException("ID giáo viên không hợp lệ");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID giáo viên không hợp lệ hoặc bị thiếu!");
                request.getRequestDispatcher("/views/admin/salaryTeacherView.jsp").forward(request, response);
                return;
            }


            // Lấy thông tin giáo viên
            SalaryDAO.TeacherInfo teacherInfo = salaryDAO.getTeacherInfo(idGiaoVien);
            if (teacherInfo == null) {
                request.setAttribute("error", "Không tìm thấy giáo viên!");
                request.getRequestDispatcher("/views/admin/salaryTeacherView.jsp").forward(request, response);
                return;
            }

            // Tính lương dự tính
            List<SalaryInfo> salaryList = salaryDAO.calculateTeacherSalary(idGiaoVien, startDate, endDate);

            // Tính tổng lương cơ bản
            double totalBaseSalary = 0;
            if (salaryList != null) {
                for (SalaryInfo salary : salaryList) {
                    totalBaseSalary += salary.getLuongDuTinh();
                }
            }

            // Lấy bản ghi lương mới nhất của giáo viên
            SalaryInfo savedSalary = salaryDAO.getLatestSalaryForTeacher(idGiaoVien);
            boolean isPaid = false;
            if (savedSalary != null) {
                try {
                    isPaid = salaryDAO.isSalaryPaid(savedSalary.getIdLuong());
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else {
            }

            // Lấy tham số message từ query string và đặt vào request scope
            String message = request.getParameter("message");
            if (message != null && !message.isEmpty()) {
                try {
                    message = java.net.URLDecoder.decode(message, StandardCharsets.UTF_8.toString());
                    request.setAttribute("message", message);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            // Chuyển đổi startDate và endDate từ salaryList hoặc request
            if (startDate == null || endDate == null || startDate.isEmpty() || endDate.isEmpty()) {
                if (salaryList != null && !salaryList.isEmpty()) {
                    startDate = salaryList.get(0).getChuKyBatDau();
                    endDate = salaryList.get(0).getChuKyKetThuc();
                }
            }

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date startDateObj = (startDate != null && !startDate.isEmpty()) ? sdf.parse(startDate) : null;
            Date endDateObj = (endDate != null && !endDate.isEmpty()) ? sdf.parse(endDate) : null;

            // Lưu vào request scope
            request.setAttribute("salaryList", salaryList);
            request.setAttribute("savedSalary", savedSalary);
            request.setAttribute("isPaid", isPaid); // Truyền trạng thái "Paid" vào request
            request.setAttribute("tenGiaoVien", teacherInfo.hoTen);
            request.setAttribute("idGiaoVien", idGiaoVien);
            request.setAttribute("startDate", startDate);
            request.setAttribute("endDate", endDate);
            request.setAttribute("startDateObj", startDateObj); // Thêm đối tượng Date để định dạng
            request.setAttribute("endDateObj", endDateObj);     // Thêm đối tượng Date để định dạng
            request.setAttribute("totalBaseSalary", totalBaseSalary);
            request.setAttribute("totalSalary", totalBaseSalary); // Mặc định là totalBaseSalary

            request.getRequestDispatcher("/views/admin/salaryTeacherView.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cơ sở dữ liệu khi tính lương: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/salaryTeacherView.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Dữ liệu đầu vào không hợp lệ: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/salaryTeacherView.jsp").forward(request, response);
        } catch (ParseException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi định dạng ngày: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/salaryTeacherView.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi không xác định khi tính lương: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/salaryTeacherView.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet to calculate teacher salary";
    }
}