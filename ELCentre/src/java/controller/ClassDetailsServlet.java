package controller;

import dal.LopHocDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.LopHoc;

@WebServlet(name = "ClassDetailsServlet", urlPatterns = {"/class-details"})
public class ClassDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int classId = Integer.parseInt(request.getParameter("classId"));
            LopHocDAO dao = new LopHocDAO();
            
            // Lấy thông tin chi tiết của lớp học
            LopHoc lopHoc = dao.getFullClassDetailsById(classId);

            if (lopHoc == null) {
                // Nếu không tìm thấy lớp học, quay về trang danh sách khóa học
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