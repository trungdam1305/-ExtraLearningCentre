// Author: trungdam
// Servlet: BlogDetailServlet
package controller;

import dal.BlogDAO;
import model.Blog;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class BlogDetailServlet extends HttpServlet {

    // Handles requests to show a single blog post.
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Get the blog ID from the URL.
        String idParam = request.getParameter("id");
        
        // If no ID is given, show an error.
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Blog ID is missing.");
            return;
        }

        try {
            // Convert the ID to a number.
            int blogId = Integer.parseInt(idParam);
            
            // Get the blog from the database using the ID.
            BlogDAO dao = new BlogDAO();
            Blog blog = dao.getBlogById(blogId);

            // If the blog isn't found, show an error.
            if (blog == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Blog not found.");
                return;
            }

            // Put the blog data into the request.
            request.setAttribute("blog", blog);
            
            // Show the blog detail page.
            request.getRequestDispatcher("/views/Home-Blog/BlogDetails-main.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            // If the ID isn't a valid number, show an error.
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid blog ID.");
        }
    }
}