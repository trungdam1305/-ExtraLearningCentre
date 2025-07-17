package controller;

import dal.BlogDAO;
import model.Blog;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class TagSearchServlet extends HttpServlet {
    private static final int PAGE_SIZE = 10; // 10 bài viết mỗi trang

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyTag = request.getParameter("tag");
        String pageParam = request.getParameter("page");
        int page = (pageParam == null) ? 1 : Integer.parseInt(pageParam);

        BlogDAO dao = new BlogDAO();
        List<Blog> blogList = dao.getBlogsByKeyTag(keyTag, page, PAGE_SIZE);
        int totalBlogs = dao.countBlogsByKeyTag(keyTag);
        int totalPages = (int) Math.ceil((double) totalBlogs / PAGE_SIZE);

        request.setAttribute("blogs", blogList);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("selectedTag", keyTag); // Để hiển thị tiêu đề

        request.getRequestDispatcher("/views/Home-Blog/tag-search-results.jsp").forward(request, response);
    }
}