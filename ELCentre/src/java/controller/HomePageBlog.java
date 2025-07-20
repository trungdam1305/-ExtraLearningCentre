package controller;

import dal.BlogDAO;
import dal.PhanLoaiBlogDAO; // Assuming this DAO exists for fetching categories
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet; // Annotation for servlet mapping
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.Blog;
import model.PhanLoaiBlog;
import model.KeyTag; // Import the KeyTag model

/**
 * Servlet for displaying the blog homepage with search, filter, and pagination.
 * It uses a single comprehensive method from BlogDAO to handle all filtering criteria.
 * @author admin
 */
public class HomePageBlog extends HttpServlet {

    private final BlogDAO blogDAO;
    private final PhanLoaiBlogDAO phanLoaiDAO;

    public HomePageBlog() {
        this.blogDAO = new BlogDAO();
        this.phanLoaiDAO = new PhanLoaiBlogDAO(); // Initialize your PhanLoaiBlogDAO
    }

    /**
     * Handles the HTTP <code>GET</code> method for displaying the blog list.
     * It retrieves and filters blog posts based on user parameters for keyword,
     * category ID, KeyTag ID, year, and pagination, then forwards to the JSP.
     * * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Ensure request and response use UTF-8 encoding for proper character handling
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // --- 1. Get and Validate Parameters ---
        String keyword = request.getParameter("keyword");
        String categoryIdParam = request.getParameter("category"); // For blog category (PhanLoaiBlog ID)
        String idKeyTagParam = request.getParameter("idKeyTag");   // For KeyTag filtering (KeyTag ID)
        String sort = request.getParameter("sort");
        String pageParam = request.getParameter("page");
        String yearParam = request.getParameter("year"); // Added for year filtering

        // Set default values and parse numeric parameters safely
        int currentPage = 1;
        try {
            if (pageParam != null && !pageParam.isEmpty()) {
                currentPage = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            log("Invalid page parameter: " + pageParam + ". Defaulting to page 1.", e);
        }
        final int pageSize = 4; // Number of blogs to display per page

        // categoryIdParam is passed as a String to the DAO, as per previous BlogDAO signature
        String filterCategoryId = (categoryIdParam != null && !categoryIdParam.isEmpty()) ? categoryIdParam : null;

        int filterKeyTagId = 0; // Default to 0, indicating no KeyTag filter
        try {
            if (idKeyTagParam != null && !idKeyTagParam.isEmpty()) {
                filterKeyTagId = Integer.parseInt(idKeyTagParam);
            }
        } catch (NumberFormatException e) {
            log("Invalid KeyTag ID parameter: " + idKeyTagParam + ". Ignoring KeyTag filter.", e);
        }

        Integer filterYear = null; // Use Integer to allow for null (no year filter)
        try {
            if (yearParam != null && !yearParam.isEmpty()) {
                filterYear = Integer.parseInt(yearParam);
            }
        } catch (NumberFormatException e) {
            log("Invalid year parameter: " + yearParam + ". Ignoring year filter.", e);
        }

        // Validate and set default sort order
        if (sort == null || (!sort.equalsIgnoreCase("asc") && !sort.equalsIgnoreCase("desc"))) {
            sort = "desc"; // Default sort order (newest first)
        }

        // --- 2. Fetch Data from DAOs ---
        List<Blog> blogs = new ArrayList<>();
        int totalBlogs = 0;

        try {
            // CALL THE COMPREHENSIVE SEARCH METHOD IN BLOGDAO
            // This method in BlogDAO should now accept: keyword, categoryId, idKeyTag, year, sort, page, pageSize
            blogs = blogDAO.searchBlogsAdvanced(keyword, filterCategoryId, filterKeyTagId, filterYear, sort, currentPage, pageSize);
            
            // CALL THE COMPREHENSIVE COUNT METHOD IN BLOGDAO
            // This method in BlogDAO should now accept: keyword, categoryId, idKeyTag, year
            totalBlogs = blogDAO.countBlogsAdvanced(keyword, filterCategoryId, filterKeyTagId, filterYear);

            int totalPages = (int) Math.ceil((double) totalBlogs / pageSize);

            // Get lists for dropdowns (Categories, KeyTags, Years)
            List<PhanLoaiBlog> danhMucList = phanLoaiDAO.getAllPhanLoai(); // All categories
            List<KeyTag> availableKeyTags = blogDAO.getAllKeyTags();     // All KeyTags
            List<Integer> availableYears = blogDAO.getDistinctBlogYears(); // All distinct years

            // --- 3. Set Attributes for JSP ---
            request.setAttribute("blogs", blogs);
            request.setAttribute("keyword", keyword == null ? "" : keyword); // Preserve search keyword
            request.setAttribute("selectedCategoryId", filterCategoryId == null ? "" : filterCategoryId); // Preserve selected category
            request.setAttribute("selectedKeyTagId", filterKeyTagId);     // Preserve selected KeyTag ID
            request.setAttribute("selectedYear", filterYear);             // Preserve selected year
            request.setAttribute("sort", sort);                           // Preserve sort order
            request.setAttribute("currentPage", currentPage);             // Current page for pagination
            request.setAttribute("totalPages", totalPages);               // Total pages for pagination

            request.setAttribute("danhMucList", danhMucList);           // List of categories for dropdown
            request.setAttribute("availableKeyTags", availableKeyTags); // List of KeyTag objects for dropdown
            request.setAttribute("availableYears", availableYears);       // List of years for dropdown

            // --- 4. Forward to JSP ---
            request.getRequestDispatcher("views/Home-Blog/Homepage-Blog.jsp").forward(request, response);

        } catch (Exception e) {
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * For a public blog homepage, POST requests typically handle form submissions
     * like comments, not filtering. In this case, it simply delegates to `doGet`
     * to display the filtered blog list based on request parameters.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        // Redirect POST requests to GET to follow Post/Redirect/Get pattern
        // This helps prevent duplicate form submissions if the user refreshes.
        response.sendRedirect(request.getContextPath() + "/blog?" + request.getQueryString());
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet for displaying the blog homepage and handling filters.";
    }
}