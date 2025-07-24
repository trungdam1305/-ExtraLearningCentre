// Author: trungdam
// Servlet: ClassDetailsServlet
package controller;

import dal.LopHocDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.LopHoc;


public class ClassDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get the class ID from the request parameter and convert it to an integer.
            int classId = Integer.parseInt(request.getParameter("classId"));
            
            // Create a new LopHocDAO instance to interact with the database.
            LopHocDAO dao = new LopHocDAO();
            
            // Get full class details from the database using the class ID.
            LopHoc lopHoc = dao.getFullClassDetailsById(classId);

            // If the class is not found, redirect to the HomePageCourse.
            if (lopHoc == null) {
                response.sendRedirect("HomePageCourse");
                return;
            }

            // Set the retrieved class details as an attribute in the request.
            request.setAttribute("lopHoc", lopHoc);
            
            // Forward the request to the JSP page for displaying class details.
            request.getRequestDispatcher("/views/Home-Course/ClassDetails-main.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            // If the class ID is not a valid number, redirect to the HomePageCourse.
            response.sendRedirect("HomePageCourse");
        }
    }
}