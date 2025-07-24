// Author: trungdam
// Servlet: HomePageBlog
package controller;

import dal.BlogDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Blog;
import model.KeyTag;
import model.Keyword;

public class HomePageBlog extends HttpServlet {

    private final BlogDAO blogDAO;

    public HomePageBlog() {
        this.blogDAO = new BlogDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // --- 1. Get and validate parameters ---
        String keywordIdParam = request.getParameter("keywordId");
        String keytagIdParam = request.getParameter("keytagId");
        String pageParam = request.getParameter("page");

        int filterKeywordId = 0;
        try {
            if (keywordIdParam != null && !keywordIdParam.isEmpty()) {
                filterKeywordId = Integer.parseInt(keywordIdParam);
            }
        } catch (NumberFormatException e) {
            log("Invalid keyword ID parameter: " + keywordIdParam);
        }

        int filterKeytagId = 0;
        try {
            if (keytagIdParam != null && !keytagIdParam.isEmpty()) {
                filterKeytagId = Integer.parseInt(keytagIdParam);
            }
        } catch (NumberFormatException e) {
            log("Invalid keytag ID parameter: " + keytagIdParam);
        }
        
        int currentPage = 1;
        try {
            if (pageParam != null && !pageParam.isEmpty()) {
                currentPage = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            log("Invalid page parameter: " + pageParam);
        }
        final int pageSize = 4; // Number of blogs per page

        try {
            // --- 2. Fetch data from DAO ---
            List<Blog> blogs = blogDAO.getFilteredBlogs(filterKeywordId, filterKeytagId, currentPage, pageSize);
            int totalBlogs = blogDAO.countFilteredBlogs(filterKeywordId, filterKeytagId);
            int totalPages = (int) Math.ceil((double) totalBlogs / pageSize);

            // Get lists for dropdowns
            List<Keyword> allKeywords = blogDAO.getAllKeywords();
            List<KeyTag> allKeytags = blogDAO.getAllKeyTags();

            // --- 3. Set attributes for JSP ---
            request.setAttribute("blogs", blogs);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", currentPage);

            // Send lists for dropdowns
            request.setAttribute("allKeywords", allKeywords);
            request.setAttribute("allKeytags", allKeytags);
            
            // Send selected values to maintain form state
            request.setAttribute("selectedKeywordId", filterKeywordId);
            request.setAttribute("selectedKeytagId", filterKeytagId);

            // --- 4. Forward to JSP ---
            request.getRequestDispatcher("views/Home-Blog/Homepage-Blog.jsp").forward(request, response);

        } catch (Exception e) {
            log("Error fetching blog data", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Could not load blog data.");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for displaying and filtering blogs by Keyword and KeyTag.";
    }
}