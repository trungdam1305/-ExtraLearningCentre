// Author: trungdam
// Servlet: CourseDetailsServlet
package controller;

import dal.GiaoVienDAO;
import dal.KhoaHocDAO;
import dal.LopHocDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.GiaoVien;
import model.KhoaHoc;
import model.LopHoc;

public class CourseDetailsServlet extends HttpServlet {

    // Handles GET requests to display course details.
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get the course ID from the request parameter.
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            
            // Get the teacher ID from the request parameter, default to "0" if not present.
            String teacherIdParam = request.getParameter("teacherId") == null ? "0" : request.getParameter("teacherId");
            int teacherId = Integer.parseInt(teacherIdParam);

            // Initialize DAOs for interacting with the database.
            KhoaHocDAO khoaHocDAO = new KhoaHocDAO();
            LopHocDAO lopHocDAO = new LopHocDAO();
            GiaoVienDAO giaoVienDAO = new GiaoVienDAO();

            // Retrieve course details by ID.
            KhoaHoc course = khoaHocDAO.getKhoaHocById(courseId);
            
            // If the course is not found, redirect to the course home page.
            if (course == null) {
                response.sendRedirect("HomePageCourse");
                return;
            }

            // Get a list of classes associated with the course and selected teacher.
            List<LopHoc> classList = lopHocDAO.getClassesByCourseAndTeacher(courseId, teacherId);
            
            // Get a list of teachers associated with this course.
            List<GiaoVien> teacherList = giaoVienDAO.getTeachersByCourseId(courseId);

            // Set attributes to be used in the JSP page.
            request.setAttribute("course", course);
            request.setAttribute("classList", classList);
            request.setAttribute("teacherList", teacherList);
            request.setAttribute("selectedTeacherId", teacherId); // Keep track of the selected teacher

            // Forward the request to the JSP page to display course details.
            request.getRequestDispatcher("/views/Home-Course/CourseDetails-main.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            // If there's an issue with parsing numbers (e.g., invalid ID), redirect to the course home page.
            response.sendRedirect("HomePageCourse");
        }
    }
}