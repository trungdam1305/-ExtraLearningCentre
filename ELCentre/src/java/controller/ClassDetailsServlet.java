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
            int classId = Integer.parseInt(request.getParameter("classId"));
            LopHocDAO dao = new LopHocDAO();
            
            // Get Class from DB
            LopHoc lopHoc = dao.getFullClassDetailsById(classId);

            if (lopHoc == null) {
                // not found => HomePageCourse
                response.sendRedirect("HomePageCourse");
                return;
            }

            request.setAttribute("lopHoc", lopHoc);
            request.getRequestDispatcher("/views/Home-Course/ClassDetails-main.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("HomePageCourse");
        }
    }
}