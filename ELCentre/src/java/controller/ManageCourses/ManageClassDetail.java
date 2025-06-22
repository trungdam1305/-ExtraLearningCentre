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
import java.util.ArrayList;
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
            GiaoVienDAO giaoVienDAO = new GiaoVienDAO();
            HocSinhDAO hocSinhDAO = new HocSinhDAO();
            KhoaHocDAO khoaHocDAO = new KhoaHocDAO();

            // Lấy thông tin lớp học
            LopHoc lopHoc = lopHocDAO.getLopHocById(idLopHoc);
            if (lopHoc == null) {
                request.setAttribute("err", "Không tìm thấy lớp học.");
                request.getRequestDispatcher("/views/admin/viewClass.jsp").forward(request, response);
                return;
            }

            // Lấy lịch học
            LichHoc lichHoc = lichHocDAO.getLichHocByLopHoc(idLopHoc);

            // Lấy giáo viên của lớp
            GiaoVien giaoVien = giaoVienDAO.getGiaoVienByLopHoc(idLopHoc);
            System.out.println("GiaoVien in doGet: " + (giaoVien != null ? giaoVien.getHoTen() : "null"));

            // Lấy danh sách học sinh trong lớp
            List<HocSinh> hocSinhList = hocSinhDAO.getHocSinhByLopHoc(idLopHoc);
            System.out.println("HocSinhList size in doGet: " + (hocSinhList != null ? hocSinhList.size() : "null"));

            // Lấy danh sách tất cả học sinh
            List<HocSinh> allStudents = hocSinhDAO.adminGetAllHocSinh();

            // Lấy danh sách giáo viên phù hợp với khóa học
            KhoaHoc khoaHoc = khoaHocDAO.getKhoaHocById(idKhoaHoc);
            List<GiaoVien> availableTeachers = new ArrayList<>();
            if (khoaHoc != null) {
                String tenKhoaHoc = khoaHoc.getTenKhoaHoc().toLowerCase();
                availableTeachers = giaoVienDAO.getTeachersBySpecialization(tenKhoaHoc);
                System.out.println("AvailableTeachers size in doGet: " + availableTeachers.size());
            } else {
                System.out.println("KhoaHoc is null for ID: " + idKhoaHoc);
            }

            // Đặt thuộc tính cho JSP
            request.setAttribute("lopHoc", lopHoc);
            request.setAttribute("lichHoc", lichHoc);
            request.setAttribute("giaoVien", giaoVien);
            request.setAttribute("hocSinhList", hocSinhList);
            request.setAttribute("allStudents", allStudents);
            request.setAttribute("availableTeachers", availableTeachers);
            request.setAttribute("ID_KhoaHoc", idKhoaHoc);
            request.setAttribute("ID_Khoi", idKhoi);

            // Chuyển tiếp đến JSP
            request.getRequestDispatcher("/views/admin/viewClass.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Error in doGet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("err", "Lỗi khi tải thông tin lớp học: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/viewClass.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int idLopHoc;
        int idKhoaHoc;
        int idKhoi;

        try {
            idLopHoc = Integer.parseInt(request.getParameter("ID_LopHoc"));
            idKhoaHoc = Integer.parseInt(request.getParameter("ID_KhoaHoc"));
            idKhoi = Integer.parseInt(request.getParameter("ID_Khoi"));
        } catch (NumberFormatException e) {
            System.out.println("Invalid parameters: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("err", "Tham số không hợp lệ!");
            request.getRequestDispatcher("/views/admin/viewClass.jsp").forward(request, response);
            return;
        }

        try {
            // Khởi tạo DAO
            LopHocDAO lopHocDAO = new LopHocDAO();
            LichHocDAO lichHocDAO = new LichHocDAO();
            GiaoVienDAO giaoVienDAO = new GiaoVienDAO();
            HocSinhDAO hocSinhDAO = new HocSinhDAO();
            KhoaHocDAO khoaHocDAO = new KhoaHocDAO();

            // Lấy thông tin lớp học và lịch học
            LopHoc lopHoc = lopHocDAO.getLopHocById(idLopHoc);
            if (lopHoc == null) {
                request.setAttribute("err", "Không tìm thấy lớp học.");
                request.getRequestDispatcher("/views/admin/viewClass.jsp").forward(request, response);
                return;
            }
            LichHoc lichHoc = lichHocDAO.getLichHocByLopHoc(idLopHoc);

            if ("assignTeacher".equals(action)) {
                try {
                    int idGiaoVien = Integer.parseInt(request.getParameter("ID_GiaoVien"));
                    // Kiểm tra xem lớp đã có giáo viên chưa
                    GiaoVien currentTeacher = giaoVienDAO.getGiaoVienByLopHoc(idLopHoc);
                    boolean success;
                    if (currentTeacher != null && currentTeacher.getID_GiaoVien() != idGiaoVien) {
                        // Cập nhật phân công giáo viên nếu giáo viên khác
                        success = giaoVienDAO.updateTeacherAssignment(idLopHoc, idGiaoVien);
                        System.out.println("Update teacher assignment result: " + success);
                    } else if (currentTeacher == null) {
                        // Phân công giáo viên mới
                        success = giaoVienDAO.assignTeacherToClass(idLopHoc, idGiaoVien);
                        System.out.println("Assign teacher result: " + success);
                    } else {
                        // Giáo viên đã được phân công
                        success = false;
                        request.setAttribute("teacherErr", "Giáo viên này đã được phân công cho lớp!");
                        System.out.println("GiaoVien ID " + idGiaoVien + " already assigned to LopHoc ID " + idLopHoc);
                    }
                    if (success) {
                        request.setAttribute("teacherSuc", "Giáo viên đã được phân công thành công!");
                    } else if (request.getAttribute("teacherErr") == null) {
                        request.setAttribute("teacherErr", "Không thể phân công giáo viên. Vui lòng kiểm tra lại!");
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("teacherErr", "Vui lòng chọn một giáo viên hợp lệ!");
                    System.out.println("Invalid ID_GiaoVien: " + e.getMessage());
                }
            } else if ("addStudent".equals(action)) {
                try {
                    int idHocSinh = Integer.parseInt(request.getParameter("ID_HocSinh"));
                    // Kiểm tra giới hạn sĩ số lớp
                    if (lopHoc.getSiSo() >= lopHoc.getSiSoToiDa()) {
                        request.setAttribute("studentErr", "Lớp đã đạt sĩ số tối đa!");
                    } else {
                        // Thêm học sinh vào lớp
                        boolean studentAdded = hocSinhDAO.addStudentToClass(idHocSinh, idLopHoc);
                        if (studentAdded) {
                            // Cập nhật sĩ số
                            boolean siSoUpdated = lopHocDAO.updateSiSo(idLopHoc, lopHoc.getSiSo() + 1);
                            if (siSoUpdated) {
                                request.setAttribute("studentSuc", "Học sinh đã được thêm vào lớp thành công!");
                            } else {
                                request.setAttribute("studentErr", "Lỗi khi cập nhật sĩ số lớp!");
                            }
                        } else {
                            request.setAttribute("studentErr", "Không thể thêm học sinh vào lớp. Học sinh có thể đã trong lớp hoặc không tồn tại!");
                        }
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("studentErr", "Vui lòng chọn một học sinh hợp lệ!");
                    System.out.println("Invalid ID_HocSinh: " + e.getMessage());
                }
            }

            // Làm mới dữ liệu
            lopHoc = lopHocDAO.getLopHocById(idLopHoc);
            lichHoc = lichHocDAO.getLichHocByLopHoc(idLopHoc);
            GiaoVien giaoVien = giaoVienDAO.getGiaoVienByLopHoc(idLopHoc);
            List<HocSinh> hocSinhList = hocSinhDAO.getHocSinhByLopHoc(idLopHoc);
            List<HocSinh> allStudents = hocSinhDAO.adminGetAllHocSinh();
            KhoaHoc khoaHoc = khoaHocDAO.getKhoaHocById(idKhoaHoc);
            List<GiaoVien> availableTeachers = new ArrayList<>();
            if (khoaHoc != null) {
                String tenKhoaHoc = khoaHoc.getTenKhoaHoc().toLowerCase();
                availableTeachers = giaoVienDAO.getTeachersBySpecialization(tenKhoaHoc);
                System.out.println("AvailableTeachers size in doPost: " + availableTeachers.size());
            } else {
                System.out.println("KhoaHoc is null for ID: " + idKhoaHoc);
            }

            // Log debug
            System.out.println("GiaoVien in doPost: " + (giaoVien != null ? giaoVien.getHoTen() : "null"));
            System.out.println("HocSinhList size in doPost: " + (hocSinhList != null ? hocSinhList.size() : "null"));

            // Đặt thuộc tính cho JSP
            request.setAttribute("lopHoc", lopHoc);
            request.setAttribute("lichHoc", lichHoc);
            request.setAttribute("giaoVien", giaoVien);
            request.setAttribute("hocSinhList", hocSinhList);
            request.setAttribute("allStudents", allStudents);
            request.setAttribute("availableTeachers", availableTeachers);
            request.setAttribute("ID_KhoaHoc", idKhoaHoc);
            request.setAttribute("ID_Khoi", idKhoi);

            // Chuyển tiếp đến JSP
            request.getRequestDispatcher("/views/admin/viewClass.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Error in doPost: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("err", "Lỗi khi xử lý yêu cầu: " + e.getMessage());
            LopHocDAO lopHocDAO = new LopHocDAO();
            LichHocDAO lichHocDAO = new LichHocDAO();
            request.setAttribute("lopHoc", lopHocDAO.getLopHocById(idLopHoc));
            request.setAttribute("lichHoc", lichHocDAO.getLichHocByLopHoc(idLopHoc));
            request.setAttribute("ID_KhoaHoc", idKhoaHoc);
            request.setAttribute("ID_Khoi", idKhoi);
            request.getRequestDispatcher("/views/admin/viewClass.jsp").forward(request, response);
        }
    }
}