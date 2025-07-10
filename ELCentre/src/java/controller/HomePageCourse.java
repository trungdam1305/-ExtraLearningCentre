/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.KhoaHocDAO;
import dal.KhoiHocDAO;
import dal.LopHocDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.KhoaHoc;
import model.KhoiHoc;
import model.LopHocTheoNhomDTO;
import java.util.Map;
import model.SubjectCategoryDTO;

/**
 *
 * @author admin
 */
public class HomePageCourse extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet HomePageCourse</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomePageCourse at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    // Set response and request encoding to handle UTF-8 characters
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");

    // Initialize DAOs to access grade (KhoiHoc) and course (KhoaHoc) data
    KhoiHocDAO khDAO = new KhoiHocDAO();
    KhoaHocDAO dao = new KhoaHocDAO();

    // Get search keyword and selected grade filter from the request
    String keyword = request.getParameter("keyword");
    String idKhoi = request.getParameter("ID_Khoi");
    List<KhoaHoc> allCourses = dao.homepageGetAllKhoaHoc();
    // Initialize pagination parameters (default page = 1, page size = 12)
    int page = 1;
    int pageSize = 12;
    try {
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            page = Integer.parseInt(pageParam);
        }
    } catch (NumberFormatException e) {
        page = 1; // Fallback to page 1 if parsing fails
    }

    // Retrieve filtered and searched course list with pagination
    List<KhoaHoc> khoaHocList = dao.getKhoaHocFiltered(keyword, idKhoi, page, pageSize);

    // Count total number of filtered courses for pagination calculation
    int totalKhoaHoc = dao.countKhoaHocFiltered(keyword, idKhoi);
    int totalPage = (int) Math.ceil((double) totalKhoaHoc / pageSize);

    // Set attributes to be used in the JSP view
    request.setAttribute("allCoursesForFilter", allCourses);
    request.setAttribute("keyword", keyword);         // For retaining the search box value
    request.setAttribute("ID_Khoi", idKhoi);          // For keeping the selected grade
    request.setAttribute("khoaHocList", khoaHocList); // Course list to be displayed
    request.setAttribute("currentPage", page);        // Current page number
    request.setAttribute("totalPage", totalPage);     // Total number of pages

    // Load all available grades (KhoiHoc) for filter dropdown
    request.setAttribute("allKhoi", khDAO.getAllKhoiHoc());

    // Count number of courses per subject for display in sidebar
    List<SubjectCategoryDTO> subjectCategories = dao.getCourseCategoriesWithCount();
    request.setAttribute("subjectCategories", subjectCategories);


    // Forward request to the JSP page for rendering
    request.getRequestDispatcher("views/Home-Course/Homepage-Course.jsp").forward(request, response);
}



    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
