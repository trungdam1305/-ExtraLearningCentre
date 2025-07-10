package controller;

import dal.KhoaHocDAO;
import dal.LopHocDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.KhoaHoc;
import model.LopHoc;

public class CourseDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            
            KhoaHocDAO khoaHocDAO = new KhoaHocDAO();
            LopHocDAO lopHocDAO = new LopHocDAO();

            // Lấy thông tin khóa học
            KhoaHoc course = khoaHocDAO.getKhoaHocById(courseId);
            
            // Lấy danh sách các lớp thuộc khóa học đó
            List<LopHoc> classList = lopHocDAO.getClassesByCourseId(courseId);

            if (course == null) {
                // Xử lý trường hợp không tìm thấy khóa học
                response.sendRedirect("HomePageCourse");
                return;
            }

            request.setAttribute("course", course);
            request.setAttribute("classList", classList);
            
            request.getRequestDispatcher("/views/Home-Course/courseDetails.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("HomePageCourse");
        }
    }
}