/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.BlogDAO;
import dal.PhanLoaiBlogDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Blog;
import model.PhanLoaiBlog;

/**
 *
 * @author admin
 */
public class HomePageBlog extends HttpServlet {
   
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
            out.println("<title>Servlet HomePageBlog</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomePageBlog at " + request.getContextPath () + "</h1>");
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

    // Ensure request and response use UTF-8 encoding for Vietnamese or special characters
    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html;charset=UTF-8");

    // Initialize DAO classes for blog and category (classification)
    BlogDAO dao = new BlogDAO();
    PhanLoaiBlogDAO phanLoaiDAO = new PhanLoaiBlogDAO();

    // Get parameters from the request
    String keyword = request.getParameter("keyword"); // keyword for searching
    String category = request.getParameter("category"); // category ID for filtering
    String sort = request.getParameter("sort"); // sort by date (asc or desc)

    // Default sort is DESC if invalid or null
    if (sort == null || (!sort.equalsIgnoreCase("asc") && !sort.equalsIgnoreCase("desc"))) {
        sort = "desc";
    }

    // Define pagination: how many items per page
    int pageSize = 4;
    int page = 1;
    try {
        page = Integer.parseInt(request.getParameter("page")); // get current page number
    } catch (NumberFormatException ignored) {
        // If parsing fails or page is missing, use page = 1
    }

    // Get the list of blogs based on search/filter/sort/pagination
    List<Blog> blogs = dao.searchBlogsAdvanced(keyword, category, sort, page, pageSize);

    // Get the total number of matched blogs (used to calculate number of pages)
    int totalBlogs = dao.countBlogsAdvanced(keyword, category);
    int totalPages = (int) Math.ceil((double) totalBlogs / pageSize);

    // Get the list of all available categories (for dropdown)
    List<PhanLoaiBlog> danhMucList = phanLoaiDAO.getAllPhanLoai();

    // Set attributes for JSP page to access and render
    request.setAttribute("blogs", blogs); // list of blog items to show
    request.setAttribute("keyword", keyword == null ? "" : keyword); // search keyword (preserve value)
    request.setAttribute("category", category == null ? "" : category); // selected category (preserve value)
    request.setAttribute("sort", sort); // current sort order
    request.setAttribute("currentPage", page); // current page number
    request.setAttribute("totalPages", totalPages); // total number of pages
    request.setAttribute("danhMucList", danhMucList); // list of all categories

    // Forward the request to the JSP page to render the content
    request.getRequestDispatcher("views/Home-Blog/Homepage-Blog.jsp").forward(request, response);
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
