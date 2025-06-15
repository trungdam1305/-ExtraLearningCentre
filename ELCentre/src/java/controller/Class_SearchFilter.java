/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.LopHocDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.LopHoc;

/**
 *
 * @author Vuh26
 */
public class Class_SearchFilter extends HttpServlet {

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
            out.println("<title>Servlet Class_SearchFilter</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Class_SearchFilter at " + request.getContextPath() + "</h1>");
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
    @Override
     protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy tham số tìm kiếm và lọc
            String name = request.getParameter("name");
            String filterStatus = request.getParameter("filterStatus");

            int page = 1;
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException ignored) {
            }

            int ID_KhoaHoc = Integer.parseInt(request.getParameter("ID_KhoaHoc"));
            int ID_Khoi = Integer.parseInt(request.getParameter("ID_Khoi"));
            int pageSize = 5;

            // Lấy dữ liệu từ DAO
            LopHocDAO dao = new LopHocDAO();
            List<LopHoc> danhSachLopHoc = dao.searchAndFilterLopHoc(name, filterStatus, page, pageSize, ID_KhoaHoc, ID_Khoi);
            int totalItems = dao.countClasses(name, filterStatus, ID_KhoaHoc, ID_Khoi);
            int totalPages = (int) Math.ceil((double) totalItems / pageSize);

            // Truyền dữ liệu qua JSP
            request.setAttribute("danhSachLopHoc", danhSachLopHoc);
            request.setAttribute("totalItems", totalItems);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("page", page);
            request.setAttribute("ID_KhoaHoc", ID_KhoaHoc);
            request.setAttribute("ID_Khoi", ID_Khoi);
            request.setAttribute("searchName", name);
            request.setAttribute("filterStatus", filterStatus);

            request.getRequestDispatcher("/views/ViewCourse.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Lỗi truy vấn dữ liệu lớp học", e);
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
