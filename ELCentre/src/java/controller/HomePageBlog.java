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

        // --- 1. Lấy và xác thực tham số ---
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
        final int pageSize = 4; // Số blog trên mỗi trang

        try {
            // --- 2. Lấy dữ liệu từ DAO ---
            List<Blog> blogs = blogDAO.getFilteredBlogs(filterKeywordId, filterKeytagId, currentPage, pageSize);
            int totalBlogs = blogDAO.countFilteredBlogs(filterKeywordId, filterKeytagId);
            int totalPages = (int) Math.ceil((double) totalBlogs / pageSize);

            // Lấy danh sách cho các dropdown
            List<Keyword> allKeywords = blogDAO.getAllKeywords();
            List<KeyTag> allKeytags = blogDAO.getAllKeyTags();

            // --- 3. Đặt các thuộc tính cho JSP ---
            request.setAttribute("blogs", blogs);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", currentPage);

            // Gửi danh sách cho các dropdown
            request.setAttribute("allKeywords", allKeywords);
            request.setAttribute("allKeytags", allKeytags);
            
            // Gửi các giá trị đã chọn để giữ trạng thái của form
            request.setAttribute("selectedKeywordId", filterKeywordId);
            request.setAttribute("selectedKeytagId", filterKeytagId);

            // --- 4. Chuyển tiếp đến JSP ---
            request.getRequestDispatcher("views/Home-Blog/Homepage-Blog.jsp").forward(request, response);

        } catch (Exception e) {
            log("Error fetching blog data", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể tải dữ liệu bài viết.");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for displaying and filtering blogs by Keyword and KeyTag.";
    }
}