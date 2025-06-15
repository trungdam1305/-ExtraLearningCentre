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
public class Class_SortAttribute extends HttpServlet {

    private static final int PAGE_SIZE = 5  ;

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
            out.println("<title>Servlet Class_SortAttribute</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Class_SortAttribute at " + request.getContextPath() + "</h1>");
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

        LopHocDAO lhd = new LopHocDAO();
        // Lấy các tham số truy vấn
        String searchName = request.getParameter("searchName");
        if(searchName == null || searchName.isEmpty()){
            searchName = null;
        }
        String sortColumn = request.getParameter("sortColumn");
        String sortOrder = request.getParameter("sortOrder");
        String pageStr = request.getParameter("page");
        String idKhoaStr = request.getParameter("ID_KhoaHoc");
        String idKhoiStr = request.getParameter("ID_Khoi");
        

        // Xử lý mặc định nếu tham số null
        int page = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
        int pageSize = 6;


        int idKhoaHoc = (idKhoaStr != null) ? Integer.parseInt(idKhoaStr) : -1;
        int idKhoi = (idKhoiStr != null) ? Integer.parseInt(idKhoiStr) : -1;

        if (sortColumn == null) {
            sortColumn = "ID_LopHoc";
        }
        if (sortOrder == null) {
            sortOrder = "asc";
        }

        // Gọi DAO để lấy dữ liệu lớp học
        List<LopHoc> danhSachLopHoc = lhd.getClassesSortedPaged(sortColumn, sortOrder, searchName, page, pageSize, idKhoaHoc, idKhoi);
        int totalItems = lhd.countClasses(searchName, idKhoaHoc, idKhoi);
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);

        // Gửi dữ liệu đến JSP
        request.setAttribute("danhSachLopHoc", danhSachLopHoc);
         request.setAttribute("totalItems", totalItems);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("searchName", searchName);
        request.setAttribute("sortColumn", sortColumn);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("ID_KhoaHoc", idKhoaHoc);
        request.setAttribute("ID_Khoi", idKhoi);

        request.getRequestDispatcher("/views/ViewCourse.jsp").forward(request, response);

        // request.getRequestDispatcher("views/ViewSortedClass.jsp").forward(request, response);
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
