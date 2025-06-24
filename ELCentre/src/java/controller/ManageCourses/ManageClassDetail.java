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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        int idLopHoc;
        int idKhoaHoc;
        int idKhoi;

        try {
            idLopHoc = Integer.parseInt(request.getParameter("ID_LopHoc"));
            idKhoaHoc = Integer.parseInt(request.getParameter("ID_KhoaHoc"));
            idKhoi = Integer.parseInt(request.getParameter("ID_Khoi"));
        } catch (NumberFormatException e) {
            System.out.println("Tham số không hợp lệ: " + e.getMessage());
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

            // Lấy thông tin lớp học
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
                    GiaoVien currentTeacher = giaoVienDAO.getGiaoVienByLopHoc(idLopHoc);
                    boolean success = false;

                    if (currentTeacher != null && currentTeacher.getID_GiaoVien() != idGiaoVien) {
                        // Cập nhật phân công
                        success = giaoVienDAO.updateTeacherAssignment(idLopHoc, idGiaoVien);
                        System.out.println("Kết quả cập nhật phân công giáo viên: " + success);
                    } else if (currentTeacher == null) {
                        // Thêm phân công mới
                        LichHoc lichHocCheck = lichHocDAO.getLichHocByLopHoc(idLopHoc);
                        if (lichHocCheck == null) {
                            request.setAttribute("teacherErr", "Không thể phân công giáo viên vì lớp học chưa có lịch học!");
                        } else if (giaoVienDAO.hasSlotConflict(idGiaoVien, idLopHoc, lichHocCheck.getID_SlotHoc(), lichHocCheck.getNgayHoc())) {
                            request.setAttribute("teacherErr", "Không thể phân công giáo viên do xung đột thời gian slot học!");
                        } else {
                            success = giaoVienDAO.assignTeacherToClass(idLopHoc, idGiaoVien);
                            System.out.println("Kết quả thêm phân công giáo viên: " + success);
                        }
                    } else {
                        // Giáo viên đã được phân công
                        request.setAttribute("teacherErr", "Giáo viên này đã được phân công cho lớp!");
                        System.out.println("Giáo viên ID " + idGiaoVien + " đã được phân công cho lớp học ID " + idLopHoc);
                        success = false;
                    }

                    if (success) {
                        request.setAttribute("teacherSuc", "Giáo viên đã được phân công thành công!");
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("teacherErr", "Vui lòng chọn một giáo viên hợp lệ!");
                    System.out.println("ID_GiaoVien không hợp lệ: " + e.getMessage());
                }
            } else if ("addStudent".equals(action)) {
                try {
                    int idHocSinh = Integer.parseInt(request.getParameter("ID_HocSinh"));
                    if (lopHoc.getSiSo() >= lopHoc.getSiSoToiDa()) {
                        request.setAttribute("studentErr", "Lớp đã đạt sĩ số tối đa!");
                    } else if (hocSinhDAO.isStudentInClass(idHocSinh, idLopHoc)) {
                        request.setAttribute("studentErr", "Học sinh đã có trong lớp này!");
                    } else if (hocSinhDAO.hasSchoolConflict(idHocSinh, idLopHoc)) {
                        request.setAttribute("studentErr", "Không thể thêm học sinh vì giáo viên của lớp học cùng trường với học sinh!");
                    } else {
                        boolean studentAdded = hocSinhDAO.addStudentToClass(idHocSinh, idLopHoc);
                        if (studentAdded) {
                            boolean siSoUpdated = lopHocDAO.updateSiSo(idLopHoc, lopHoc.getSiSo() + 1);
                            if (siSoUpdated) {
                                request.setAttribute("studentSuc", "Học sinh đã được thêm vào lớp thành công!");
                            } else {
                                request.setAttribute("studentErr", "Lỗi khi cập nhật sĩ số lớp!");
                            }
                        } else {
                            request.setAttribute("studentErr", "Không thể thêm học sinh vào lớp. Học sinh có thể không tồn tại!");
                        }
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("studentErr", "Vui lòng chọn một học sinh hợp lệ!");
                    System.out.println("ID_HocSinh không hợp lệ: " + e.getMessage());
                }
            } else if ("moveOutStudent".equalsIgnoreCase(action)) {
                try {
                    int idHocSinh = Integer.parseInt(request.getParameter("ID_HocSinh"));

                    // Kiểm tra học sinh có trong lớp
                    boolean isStudentInClass = hocSinhDAO.isStudentInClass(idHocSinh, idLopHoc);
                    if (!isStudentInClass) {
                        request.setAttribute("studentErr", "Học sinh không thuộc lớp này.");
                    } else {
                        // Xóa học sinh khỏi lớp
                        boolean removed = hocSinhDAO.removeStudentFromClass(idHocSinh, idLopHoc);
                        if (removed) {
                            // Cập nhật sĩ số
                            int newSiSo = lopHoc.getSiSo() - 1;
                            if (newSiSo < 0) {
                                newSiSo = 0;
                            }
                            boolean siSoUpdated = lopHocDAO.updateSiSo(idLopHoc, newSiSo);
                            if (siSoUpdated) {
                                request.setAttribute("studentSuc", "Xóa học sinh khỏi lớp thành công!");
                            } else {
                                request.setAttribute("studentErr", "Xóa học sinh thành công nhưng không thể cập nhật sĩ số.");
                            }
                        } else {
                            request.setAttribute("studentErr", "Không thể xóa học sinh khỏi lớp.");
                        }
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("studentErr", "Vui lòng chọn một học sinh hợp lệ!");
                    System.out.println("ID_HocSinh không hợp lệ: " + e.getMessage());
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
                System.out.println("Số lượng giáo viên khả dụng trong doPost: " + availableTeachers.size());
            } else {
                System.out.println("Không tìm thấy khóa học với ID: " + idKhoaHoc);
            }

            // Ghi log debug
            System.out.println("Giáo viên trong doPost: " + (giaoVien != null ? giaoVien.getHoTen() : "null"));
            System.out.println("Số học sinh trong lớp trong doPost: " + (hocSinhList != null ? hocSinhList.size() : "null"));

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
            System.out.println("Lỗi trong doPost: " + e.getMessage());
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
