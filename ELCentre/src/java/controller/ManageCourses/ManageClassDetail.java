package controller.ManageCourses;

import dal.GiaoVienDAO;
import dal.HocSinhDAO;
import dal.KhoaHocDAO;
import dal.LichHocDAO;
import dal.LopHocDAO;
import model.GiaoVien;
import model.HocSinh;
import model.KhoaHoc;
import model.LichHoc;
import model.LopHoc;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ManageClassDetail", urlPatterns = {"/ManageClassDetail"})
public class ManageClassDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy tham số
            int idLopHoc = Integer.parseInt(request.getParameter("ID_LopHoc"));
            int idKhoaHoc = Integer.parseInt(request.getParameter("ID_KhoaHoc"));
            int idKhoi = Integer.parseInt(request.getParameter("ID_Khoi"));

            // Khởi tạo DAO
            LopHocDAO lopHocDAO = new LopHocDAO();
            LichHocDAO lichHocDAO = new LichHocDAO();

            // Lấy thông tin lớp học và lịch học
            LopHoc lopHoc = lopHocDAO.getLopHocById(idLopHoc);
            LichHoc lichHoc = lichHocDAO.getLichHocByLopHoc(idLopHoc);

            // Đặt thuộc tính cho JSP
            request.setAttribute("lopHoc", lopHoc);
            request.setAttribute("lichHoc", lichHoc);
            request.setAttribute("ID_KhoaHoc", idKhoaHoc);
            request.setAttribute("ID_Khoi", idKhoi);

            // Chuyển tiếp đến JSP
            request.getRequestDispatcher("/viewClass.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("err", "Lỗi khi tải thông tin lớp học: " + e.getMessage());
            request.getRequestDispatcher("/viewClass.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int idLopHoc = Integer.parseInt(request.getParameter("ID_LopHoc"));
        int idKhoaHoc = Integer.parseInt(request.getParameter("ID_KhoaHoc"));
        int idKhoi = Integer.parseInt(request.getParameter("ID_Khoi"));
        LopHocDAO lopHocDAO = new LopHocDAO();
        LichHocDAO lichHocDAO = new LichHocDAO();
        LopHoc lopHoc = lopHocDAO.getLopHocById(idLopHoc);
        LichHoc lichHoc = lichHocDAO.getLichHocByLopHoc(idLopHoc);
        try {

            if ("assignTeacher".equals(action)) {
                int idGiaoVien = Integer.parseInt(request.getParameter("ID_GiaoVien"));
                GiaoVienDAO giaoVienDAO = new GiaoVienDAO();

                // Kiểm tra xem lớp đã có giáo viên chưa
                GiaoVien currentTeacher = giaoVienDAO.getGiaoVienByLopHoc(idLopHoc);
                if (currentTeacher != null) {
                    // Cập nhật phân công giáo viên
                    giaoVienDAO.updateTeacherAssignment(idLopHoc, idGiaoVien);
                } else {
                    // Phân công giáo viên mới
                    giaoVienDAO.assignTeacherToClass(idLopHoc, idGiaoVien);
                }

                request.setAttribute("suc", "Giáo viên đã được phân công thành công!");
            } else if ("addStudent".equals(action)) {
                int idHocSinh = Integer.parseInt(request.getParameter("ID_HocSinh"));
                HocSinhDAO hocSinhDAO = new HocSinhDAO();

                // Kiểm tra giới hạn sĩ số lớp
                if (lopHoc.getSiSo() >= lopHoc.getSiSoToiDa()) {
                    request.setAttribute("err", "Lớp học đã đạt sĩ số tối đa!");
                } else {
                    // Thêm học sinh vào lớp
                    hocSinhDAO.addStudentToClass(idHocSinh, idLopHoc);
                    // Cập nhật sĩ số
                    lopHocDAO.updateSiSo(idLopHoc, lopHoc.getSiSo() + 1);
                    request.setAttribute("suc", "Học sinh đã được thêm vào lớp thành công!");
                }
            }

            // Làm mới dữ liệu lớp học và lịch học
            lopHoc = lopHocDAO.getLopHocById(idLopHoc);
            lichHoc = lichHocDAO.getLichHocByLopHoc(idLopHoc);

            // Đặt thuộc tính cho JSP
            request.setAttribute("lopHoc", lopHoc);
            request.setAttribute("lichHoc", lichHoc);
            request.setAttribute("ID_KhoaHoc", idKhoaHoc);
            request.setAttribute("ID_Khoi", idKhoi);

            // Chuyển tiếp đến JSP
            request.getRequestDispatcher("/viewClass.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("err", "Lỗi khi xử lý yêu cầu: " + e.getMessage());
            request.setAttribute("lopHoc", lopHocDAO.getLopHocById(idLopHoc));
            request.setAttribute("lichHoc", lichHocDAO.getLichHocByLopHoc(idLopHoc));
            request.setAttribute("ID_KhoaHoc", idKhoaHoc);
            request.setAttribute("ID_Khoi", idKhoi);
            request.getRequestDispatcher("/viewClass.jsp").forward(request, response);
        }
    }
}
