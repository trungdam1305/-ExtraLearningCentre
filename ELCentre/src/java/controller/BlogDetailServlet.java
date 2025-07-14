package controller;

import dal.BlogDAO; // Nhớ import BlogDAO của bạn
import model.Blog;   // Nhớ import model Blog

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class BlogDetailServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Yêu cầu ID của bài viết.");
            return;
        }

        try {
            int blogId = Integer.parseInt(idParam);
            BlogDAO dao = new BlogDAO();
            Blog blog = dao.getBlogById(blogId);

            if (blog == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy bài viết.");
                return;
            }

            request.setAttribute("blog", blog);
            request.getRequestDispatcher("/views/Home-Blog/BlogDetails-main.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID bài viết không hợp lệ.");
        }
    }
}