/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.ManageCourses;

import java.io.IOException;
import java.io.PrintWriter;

import dal.SalaryDAO;
import model.SalaryInfo;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Vuh26
 */
public class SalaryCalculation extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SalaryCalculationServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SalaryCalculationServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private SalaryDAO salaryDAO = new SalaryDAO();

    @Override
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idGiaoVien = Integer.parseInt(request.getParameter("idGiaoVien"));
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");

            // Lấy thông tin giáo viên
            SalaryDAO.TeacherInfo teacherInfo = salaryDAO.getTeacherInfo(idGiaoVien);
            if (teacherInfo == null) {
                request.setAttribute("error", "Không tìm thấy giáo viên!");
                request.getRequestDispatcher("/views/admin/salaryTeacherView.jsp").forward(request, response);
                return;
            }

            // Tính lương dự tính
            List<SalaryInfo> salaryList = salaryDAO.calculateTeacherSalary(idGiaoVien, startDate, endDate);
            System.out.println("SalaryCalculationServlet: Calculated salary for ID_GiaoVien=" + idGiaoVien + 
                              ", salaryList size=" + (salaryList != null ? salaryList.size() : 0));

            // Tính tổng lương cơ bản
            double totalBaseSalary = 0;
            if (salaryList != null) {
                for (SalaryInfo salary : salaryList) {
                    totalBaseSalary += salary.getLuongDuTinh();
                }
            }

            // Lưu vào request và session
            request.setAttribute("salaryList", salaryList);
            request.getSession().setAttribute("salaryList", salaryList); // Lưu vào session
            request.setAttribute("tenGiaoVien", teacherInfo.hoTen);
            request.setAttribute("idGiaoVien", idGiaoVien);
            request.setAttribute("startDate", startDate);
            request.setAttribute("endDate", endDate);
            request.setAttribute("totalBaseSalary", totalBaseSalary);
            request.setAttribute("totalSalary", totalBaseSalary);

            request.getRequestDispatcher("/views/admin/salaryTeacherView.jsp").forward(request, response);

        } catch (SQLException | NumberFormatException e) {
            System.out.println("Error in SalaryCalculationServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tính lương: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/salaryTeacherView.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
