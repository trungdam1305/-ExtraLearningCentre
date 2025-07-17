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

    // File: controller/CourseDetailsServlet.java
@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        // Lấy tham số teacherId từ bộ lọc, mặc định là 0 (tất cả)
        String teacherIdParam = request.getParameter("teacherId") == null ? "0" : request.getParameter("teacherId");
        int teacherId = Integer.parseInt(teacherIdParam);

        KhoaHocDAO khoaHocDAO = new KhoaHocDAO();
        LopHocDAO lopHocDAO = new LopHocDAO();
        GiaoVienDAO giaoVienDAO = new GiaoVienDAO();

        KhoaHoc course = khoaHocDAO.getKhoaHocById(courseId);
        if (course == null) {
            response.sendRedirect("HomePageCourse");
            return;
        }

        // Gọi phương thức DAO đã được cập nhật
        List<LopHoc> classList = lopHocDAO.getClassesByCourseAndTeacher(courseId, teacherId);
        
        // Lấy danh sách giáo viên để hiển thị trong dropdown
         List<GiaoVien> teacherList = giaoVienDAO.getTeachersByCourseId(courseId);

        request.setAttribute("course", course);
        request.setAttribute("classList", classList);
        request.setAttribute("teacherList", teacherList);
        request.setAttribute("selectedTeacherId", teacherId); // Giữ lại giá trị đã chọn

        request.getRequestDispatcher("/views/Home-Course/CourseDetails-main.jsp").forward(request, response);

    } catch (NumberFormatException e) {
        response.sendRedirect("HomePageCourse");
    }
}
}