/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.KhoaHocDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.KhoaHoc;

/**
 *
 * @author Vuh26
 */
public class Course_SortAttribute extends HttpServlet {

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
            out.println("<title>Servlet SortAttribute</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SortAttribute at " + request.getContextPath() + "</h1>");
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

    int page = Integer.parseInt(request.getParameter("page") != null ? request.getParameter("page") : "1");
    int pageSize = 8;

    String searchName = request.getParameter("name") != null ? request.getParameter("name") : "";
    String sortColumn = request.getParameter("sortColumn") != null ? request.getParameter("sortColumn") : "ID_KhoaHoc";
    String sortOrder = request.getParameter("sortOrder") != null ? request.getParameter("sortOrder") : "asc";

    KhoaHocDAO dao = new KhoaHocDAO();
    List<KhoaHoc> courses = dao.getCoursesSortedPaged(sortColumn, sortOrder, searchName, page, pageSize);
    int totalCourses = dao.countCourses(searchName);
    int totalPages = (int) Math.ceil((double) totalCourses / pageSize);

    request.setAttribute("list", courses); 
    request.setAttribute("totalPages", totalPages);
    request.setAttribute("pageNumber", page); 
    request.setAttribute("searchName", searchName);
    request.setAttribute("sortName", sortColumn); 
    request.setAttribute("sortOrder", sortOrder);
    request.setAttribute("totalCourses", totalCourses);
    request.getRequestDispatcher("/views/ResultFind.jsp").forward(request, response);
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
