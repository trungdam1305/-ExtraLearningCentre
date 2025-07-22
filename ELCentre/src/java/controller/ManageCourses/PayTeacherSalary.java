/*
 * Servlet để thanh toán lương giáo viên.
 * Tên class: PayTeacherSalary
 * Package: controller.ManageCourses
 */

package controller.ManageCourses;

import dal.SalaryDAO;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.SalaryInfo;

public class PayTeacherSalary extends HttpServlet {
    
    private SalaryDAO salaryDAO = new SalaryDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Ngăn cache
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");

        try {
            int idLuong = Integer.parseInt(request.getParameter("idLuong"));
            int idGiaoVien = Integer.parseInt(request.getParameter("idGiaoVien"));
            String chuKyBatDau = request.getParameter("startDate"); // Lấy từ hidden input
            String chuKyKetThuc = request.getParameter("endDate"); // Lấy từ hidden input

            System.out.println("PayTeacherSalary: Processing payment for ID_Luong=" + idLuong + 
                              ", ID_GiaoVien=" + idGiaoVien + 
                              ", ChuKyBatDau=" + chuKyBatDau + ", ChuKyKetThuc=" + chuKyKetThuc);

            // Lấy chu kỳ từ bản ghi hiện tại nếu không có trong request
            if (chuKyBatDau == null || chuKyKetThuc == null) {
                SalaryInfo salary = salaryDAO.getLatestSalaryForTeacher(idGiaoVien);
                if (salary != null) {
                    chuKyBatDau = salary.getChuKyBatDau();
                    chuKyKetThuc = salary.getChuKyKetThuc();
                }
            }

            // Cập nhật trạng thái thành "Paid" cho tất cả bản ghi có cùng chu kỳ
            int rowsAffected = salaryDAO.markSalariesAsPaid(idGiaoVien, chuKyBatDau, chuKyKetThuc);
            System.out.println("PayTeacherSalary: Updated " + rowsAffected + " record(s) to 'Paid' for ID_GiaoVien=" + idGiaoVien + 
                              ", ChuKyBatDau=" + chuKyBatDau + ", ChuKyKetThuc=" + chuKyKetThuc);

            // Chuẩn bị thông báo và redirect
            String message = URLEncoder.encode("Đã thanh toán lương cho giáo viên!", StandardCharsets.UTF_8.toString());
            response.sendRedirect(request.getContextPath() + "/SalaryCalculation?idGiaoVien=" + idGiaoVien +
                                "&startDate=" + (chuKyBatDau != null ? chuKyBatDau : "") +
                                "&endDate=" + (chuKyKetThuc != null ? chuKyKetThuc : "") +
                                "&message=" + message);

        } catch (NumberFormatException e) {
            System.out.println("NumberFormatException in PayTeacherSalary: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/SalaryCalculation?idGiaoVien=" + request.getParameter("idGiaoVien") +
                                "&message=" + URLEncoder.encode("Lỗi: Dữ liệu đầu vào không hợp lệ", StandardCharsets.UTF_8.toString()));
        } catch (SQLException e) {
            System.out.println("SQL Error in PayTeacherSalary: " + e.getMessage() +
                              " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/SalaryCalculation?idGiaoVien=" + request.getParameter("idGiaoVien") +
                                "&message=" + URLEncoder.encode("Lỗi: Lỗi cơ sở dữ liệu khi thanh toán lương", StandardCharsets.UTF_8.toString()));
        } catch (Exception e) {
            System.out.println("Unexpected Error in PayTeacherSalary: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/SalaryCalculation?idGiaoVien=" + request.getParameter("idGiaoVien") +
                                "&message=" + URLEncoder.encode("Lỗi: Lỗi không xác định khi thanh toán lương", StandardCharsets.UTF_8.toString()));
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet to pay teacher salary";
    }
}