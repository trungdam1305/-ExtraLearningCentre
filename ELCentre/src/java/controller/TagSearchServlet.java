package controller;

import dal.BlogDAO;
import model.Blog;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet; // Import for @WebServlet annotation
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.KeyTag; // Import the KeyTag model to get tag name

/**
 * Servlet for searching and displaying blog posts by a specific KeyTag ID.
 */
public class TagSearchServlet extends HttpServlet {

    private static final int PAGE_SIZE = 10; // Number of blog posts per page
    private final BlogDAO blogDAO;

    public TagSearchServlet() {
        this.blogDAO = new BlogDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // --- 1. Get and Validate Parameters ---
        String idKeyTagParam = request.getParameter("id"); // Parameter should be "id" for ID_KeyTag
        String pageParam = request.getParameter("page");

        int idKeyTag = 0; // Default to 0 or an invalid ID if not provided
        try {
            if (idKeyTagParam != null && !idKeyTagParam.isEmpty()) {
                idKeyTag = Integer.parseInt(idKeyTagParam);
            }
        } catch (NumberFormatException e) {
            log("Invalid KeyTag ID parameter: " + idKeyTagParam + ". Defaulting to 0.", e);
            // If ID is invalid, it will effectively return no results unless 0 is a valid tag ID.
            // Consider redirecting to an error page or blog list if this is critical.
        }

        int currentPage = 1;
        try {
            if (pageParam != null && !pageParam.isEmpty()) {
                currentPage = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            log("Invalid page parameter: " + pageParam + ". Defaulting to page 1.", e);
        }
        
        // --- 2. Fetch Data from DAO ---
        List<Blog> blogList = null;
        int totalBlogs = 0;
        String selectedTagName = "Unknown Tag"; // To display the actual tag name in JSP

        try {
            if (idKeyTag > 0) { // Only search if a valid KeyTag ID is provided
                blogList = blogDAO.getBlogsByIDKeyTag(idKeyTag, currentPage, PAGE_SIZE);
                totalBlogs = blogDAO.countBlogsByIDKeyTag(idKeyTag);

                // Try to get the actual tag name for display in the JSP
                List<KeyTag> allKeyTags = blogDAO.getAllKeyTags();
                for (KeyTag tag : allKeyTags) {
                    if (tag.getID_KeyTag() == idKeyTag) {
                        selectedTagName = tag.getKeyTag();
                        break;
                    }
                }
            } else {
                // If idKeyTag is 0 or invalid, show no results or all results.
                // For a "tag search", showing no results is often more appropriate.
                blogList = new java.util.ArrayList<>(); // Empty list
                totalBlogs = 0;
                selectedTagName = "Không tìm thấy thẻ"; // Message for no valid tag ID
            }
            
            int totalPages = (int) Math.ceil((double) totalBlogs / PAGE_SIZE);

            // --- 3. Set Attributes for JSP ---
            request.setAttribute("blogs", blogList);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("selectedTagId", idKeyTag);      // Pass the ID
            request.setAttribute("selectedTagName", selectedTagName); // Pass the actual name for display

            // --- 4. Forward to JSP ---
            request.getRequestDispatcher("/views/Home-Blog/tag-search-results.jsp").forward(request, response);

        } catch (Exception e) {
            log("An error occurred in TagSearchServlet doGet: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi tìm kiếm blog theo thẻ. Vui lòng thử lại sau.");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Typically, tag searches are done via GET requests.
        // If a form submits here via POST, it's often best to redirect to GET.
        response.sendRedirect(request.getContextPath() + "/tag-search?" + request.getQueryString());
    }

    @Override
    public String getServletInfo() {
        return "Servlet for searching blog posts by KeyTag ID.";
    }
}