/*
 * Servlet để lưu lương giáo viên với thưởng/phạt.
 * Tên class: SaveTeacherSalary
 * Package: controller.ManageCourses
 */
package controller.ManageCourses;

import dal.SalaryDAO;
import model.SalaryInfo;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SaveTeacherSalary extends HttpServlet {

    private SalaryDAO salaryDAO = new SalaryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Ngăn cache
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");

        // Chuyển hướng về trang tính lương nếu truy cập GET
        String idGiaoVien = request.getParameter("idGiaoVien");
        response.sendRedirect(request.getContextPath() + "/SalaryCalculation?idGiaoVien=" + idGiaoVien);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Ngăn cache
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");

        // Đảm bảo response không bị commit trước
        response.reset();

        try {
            // Kiểm tra và lấy tham số
            String idGiaoVienStr = request.getParameter("idGiaoVien");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            String bonusPenaltyStr = request.getParameter("bonusPenalty");

            // Kiểm tra tham số null
            if (idGiaoVienStr == null || startDate == null || endDate == null || bonusPenaltyStr == null) {
                request.setAttribute("error", "Thiếu tham số bắt buộc!");
                request.getRequestDispatcher("/views/admin/salaryTeacherView.jsp").forward(request, response);
                return;
            }

            int idGiaoVien = Integer.parseInt(idGiaoVienStr);
            double bonusPenalty = Double.parseDouble(bonusPenaltyStr);


            // Tính lại lương dự tính
            List<SalaryInfo> salaryList = salaryDAO.calculateTeacherSalary(idGiaoVien, startDate, endDate);

            // Kiểm tra nếu không có dữ liệu lương
            if (salaryList == null || salaryList.isEmpty()) {
                request.setAttribute("error", "Không có lớp học nào ở trạng thái 'Đang học' trong khoảng thời gian này!");
                request.getRequestDispatcher("/views/admin/salaryTeacherView.jsp").forward(request, response);
                return;
            }

            // Tính tổng lương cơ bản
            double totalBaseSalary = 0;
            for (SalaryInfo salary : salaryList) {
                totalBaseSalary += salary.getLuongDuTinh();
            }

            // Tính tổng lương bao gồm thưởng/phạt
            double totalSalary = totalBaseSalary + bonusPenalty;

            

            // Lưu lương
            salaryDAO.saveTeacherSalary(idGiaoVien, startDate, endDate, salaryList, bonusPenalty);

// Lấy lại dữ liệu mới từ cơ sở dữ liệu
            List<SalaryInfo> updatedSalaryList = salaryDAO.calculateTeacherSalary(idGiaoVien, startDate, endDate);
            SalaryInfo updatedSavedSalary = salaryDAO.getLatestSalaryForTeacher(idGiaoVien);
            double updatedTotalBaseSalary = 0;
            if (updatedSalaryList != null) {
                for (SalaryInfo salary : updatedSalaryList) {
                    updatedTotalBaseSalary += salary.getLuongDuTinh();
                }
            }
            double updatedTotalSalary = updatedTotalBaseSalary + bonusPenalty;

// Truyền dữ liệu mới vào request scope
            request.setAttribute("salaryList", updatedSalaryList);
            request.setAttribute("savedSalary", updatedSavedSalary);
            request.setAttribute("startDate", startDate);
            request.setAttribute("endDate", endDate);
            request.setAttribute("totalBaseSalary", updatedTotalBaseSalary);
            request.setAttribute("totalSalary", updatedTotalSalary);
            request.setAttribute("message", "Lưu lương thành công!");
            request.setAttribute("idGiaoVien", String.valueOf(idGiaoVien)); // Truyền idGiaoVien

// Forward trực tiếp để giữ giá trị trong request scope
            request.getRequestDispatcher("/views/admin/salaryTeacherView.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cơ sở dữ liệu khi lưu lương: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/salaryTeacherView.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Dữ liệu đầu vào không hợp lệ: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/salaryTeacherView.jsp").forward(request, response);
        } catch (IllegalStateException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: Response đã bị commit trước khi redirect: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/salaryTeacherView.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi không xác định khi lưu lương: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/salaryTeacherView.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet to save teacher salary with bonus/penalty";
    }
}
