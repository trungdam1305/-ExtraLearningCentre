/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Vuh26
 */
public class ManageClassDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy tham số
            int idLopHoc = Integer.parseInt(request.getParameter("ID_LopHoc"));
            int idKhoaHoc = Integer.parseInt(request.getParameter("ID_KhoaHoc"));
            int idKhoi = Integer.parseInt(request.getParameter("ID_Khoi"));

            // Lấy URL referer từ header
            String referer = request.getHeader("Referer");
            System.out.println("Referer received: " + referer); // Thêm log
            if (referer == null || referer.isEmpty() || !referer.startsWith(request.getContextPath())) {
                referer = request.getContextPath() + "/ManageClass?action=refresh&ID_Khoi=" + idKhoi + "&ID_KhoaHoc=" + idKhoaHoc;
                System.out.println("Using default backUrl: " + referer); // Log URL mặc định
            }
            request.setAttribute("backUrl", referer);

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
                request.setAttribute("lichHocList", new ArrayList<LichHoc>());
                request.setAttribute("giaoVien", null);
                request.setAttribute("hocSinhList", new ArrayList<HocSinh>());
                request.setAttribute("allStudents", new ArrayList<HocSinh>());
                request.setAttribute("availableTeachers", new ArrayList<GiaoVien>());
                request.setAttribute("previousTeachers", new ArrayList<GiaoVien>());
                request.setAttribute("previousStudents", new ArrayList<HocSinh>());
                request.setAttribute("ID_KhoaHoc", idKhoaHoc);
                request.setAttribute("ID_Khoi", idKhoi);
                request.getRequestDispatcher("/views/admin/viewClass.jsp").forward(request, response);
                return;
            }

            // Xử lý ClassCode từ tham số URL nếu cột ClassCode là null
            String classCodeFromUrl = request.getParameter("ClassCode");
            if (lopHoc.getClassCode() == null && classCodeFromUrl != null && !classCodeFromUrl.trim().isEmpty()) {
                lopHoc.setClassCode(classCodeFromUrl);
                System.out.println("doGet: Set ClassCode from URL: " + classCodeFromUrl);
            }

            // Lấy danh sách lịch học
            List<LichHoc> lichHocList = lichHocDAO.getLichHocByLopHoc(idLopHoc);

            // Lấy giáo viên của lớp
            GiaoVien giaoVien = giaoVienDAO.getGiaoVienByLopHoc1(idLopHoc);
            System.out.printf("doGet: GiaoVien for ID_LopHoc=%d: %s%n", idLopHoc,
                    giaoVien != null ? giaoVien.getHoTen() : "null");

            // Lấy danh sách học sinh trong lớp
            List<HocSinh> hocSinhList = hocSinhDAO.getHocSinhByLopHoc1(idLopHoc);
            System.out.printf("doGet: HocSinhList size for ID_LopHoc=%d: %d%n", idLopHoc,
                    hocSinhList != null ? hocSinhList.size() : 0);

            // Lấy danh sách tất cả học sinh
            List<HocSinh> allStudents = hocSinhDAO.adminGetAllHocSinh11();

            // Lấy danh sách giáo viên phù hợp với khóa học
            KhoaHoc khoaHoc = khoaHocDAO.getKhoaHocById(idKhoaHoc);
            List<GiaoVien> availableTeachers = new ArrayList<>();
            if (khoaHoc != null) {
                String tenKhoaHoc = khoaHoc.getTenKhoaHoc().toLowerCase();
                availableTeachers = giaoVienDAO.getTeachersBySpecialization1(tenKhoaHoc);
                System.out.printf("doGet: AvailableTeachers size for ID_KhoaHoc=%d: %d%n",
                        idKhoaHoc, availableTeachers.size());
            } else {
                System.out.printf("doGet: KhoaHoc is null for ID_KhoaHoc=%d%n", idKhoaHoc);
            }

            // Lấy danh sách giáo viên và học sinh đã tham gia các buổi học trước
            List<GiaoVien> previousTeachers = giaoVienDAO.getPreviousTeachersByLopHoc1(idLopHoc);
            List<HocSinh> previousStudents = hocSinhDAO.getPreviousStudentsByLopHoc1(idLopHoc);
            System.out.printf("doGet: PreviousTeachers size for ID_LopHoc=%d: %d%n",
                    idLopHoc, previousTeachers != null ? previousTeachers.size() : 0);
            System.out.printf("doGet: PreviousStudents size for ID_LopHoc=%d: %d%n",
                    idLopHoc, previousStudents != null ? previousStudents.size() : 0);

            // Đặt thuộc tính cho JSP
            request.setAttribute("lopHoc", lopHoc);
            request.setAttribute("lichHocList", lichHocList);
            request.setAttribute("giaoVien", giaoVien);
            request.setAttribute("hocSinhList", hocSinhList);
            request.setAttribute("allStudents", allStudents);
            request.setAttribute("availableTeachers", availableTeachers);
            request.setAttribute("previousTeachers", previousTeachers);
            request.setAttribute("previousStudents", previousStudents);
            request.setAttribute("ID_KhoaHoc", idKhoaHoc);
            request.setAttribute("ID_Khoi", idKhoi);

            // Chuyển tiếp đến JSP
            request.getRequestDispatcher("/views/admin/viewClass.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            System.out.println("doGet: Invalid parameter: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("err", "Tham số không hợp lệ!");
            request.getRequestDispatcher("/views/admin/viewClass.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("doGet: Error: " + e.getMessage());
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
            System.out.println("doPost: Invalid parameter: " + e.getMessage());
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

            // Lấy thông tin lớp học
            LopHoc lopHoc = lopHocDAO.getLopHocById(idLopHoc);
            if (lopHoc == null) {
                request.setAttribute("err", "Không tìm thấy lớp học.");
                request.getRequestDispatcher("/views/admin/viewClass.jsp").forward(request, response);
                return;
            }

            // Lấy danh sách lịch học
            List<LichHoc> lichHocList = lichHocDAO.getLichHocByLopHoc(idLopHoc);

            if ("assignTeacher".equals(action)) {
                try {
                    int idGiaoVien = Integer.parseInt(request.getParameter("ID_GiaoVien"));
                    GiaoVien currentTeacher = giaoVienDAO.getGiaoVienByLopHoc1(idLopHoc);

                    if (currentTeacher != null && currentTeacher.getID_GiaoVien() == idGiaoVien) {
                        request.setAttribute("teacherErr", "Giáo viên này đã được phân công cho lớp!");
                        System.out.printf("doPost: Giáo viên ID=%d đã được phân công cho lớp ID=%d%n", idGiaoVien, idLopHoc);
                    } else {
                        boolean success = giaoVienDAO.assignTeacherToClass1(idLopHoc, idGiaoVien);
                        if (success) {
                            request.setAttribute("teacherSuc", "Giáo viên đã được phân công thành công!");
                            System.out.printf("doPost: Successfully assigned ID_GiaoVien=%d to ID_LopHoc=%d%n", idGiaoVien, idLopHoc);
                        } else {
                            request.setAttribute("teacherErr", "Không thể phân công giáo viên!");
                            System.out.printf("doPost: Failed to assign ID_GiaoVien=%d to ID_LopHoc=%d%n", idGiaoVien, idLopHoc);
                        }
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("teacherErr", "Vui lòng chọn một giáo viên hợp lệ!");
                    System.out.println("doPost: Invalid ID_GiaoVien: " + e.getMessage());
                    e.printStackTrace();
                } catch (SQLException e) {
                    request.setAttribute("teacherErr", "Lỗi khi phân công giáo viên: " + e.getMessage());
                    System.out.println("doPost: SQL Error in assignTeacher: " + e.getMessage());
                    e.printStackTrace();
                }
            } else if ("addStudent".equals(action)) {
                try {
                    int idHocSinh = Integer.parseInt(request.getParameter("ID_HocSinh"));
                    if (lopHoc.getSiSo() >= lopHoc.getSiSoToiDa()) {
                        request.setAttribute("studentErr", "Lớp đã đạt sĩ số tối đa!");
                        System.out.printf("doPost: Class ID=%d has reached maximum capacity (SiSo=%d, SiSoToiDa=%d)%n",
                                idLopHoc, lopHoc.getSiSo(), lopHoc.getSiSoToiDa());
                    } else if (hocSinhDAO.isStudentInClass1(idHocSinh, idLopHoc)) {
                        request.setAttribute("studentErr", "Học sinh đã có trong lớp này!");
                        System.out.printf("doPost: ID_HocSinh=%d already in class ID=%d%n", idHocSinh, idLopHoc);
                    } else if (hocSinhDAO.hasSchoolConflict1(idHocSinh, idLopHoc)) {
                        request.setAttribute("studentErr", "Không thể thêm học sinh vì học sinh và giáo viên cùng trường!");
                        System.out.printf("doPost: School conflict for ID_HocSinh=%d in class ID=%d%n", idHocSinh, idLopHoc);
                    } else {
                        boolean studentAdded = hocSinhDAO.addStudentToClass1(idHocSinh, idLopHoc);
                        if (studentAdded) {
                            boolean siSoUpdated = lopHocDAO.updateSiSo(idLopHoc, lopHoc.getSiSo() + 1);
                            if (siSoUpdated) {
                                request.setAttribute("studentSuc", "Học sinh đã được thêm vào lớp thành công!");
                                System.out.printf("doPost: Successfully added ID_HocSinh=%d to ID_LopHoc=%d, SiSo updated to %d%n",
                                        idHocSinh, idLopHoc, lopHoc.getSiSo() + 1);
                            } else {
                                request.setAttribute("studentErr", "Lỗi khi cập nhật sĩ số lớp!");
                                System.out.printf("doPost: Failed to update SiSo for ID_LopHoc=%d%n", idLopHoc);
                            }
                        } else {
                            request.setAttribute("studentErr", "Không thể thêm học sinh vào lớp!");
                            System.out.printf("doPost: Failed to add ID_HocSinh=%d to ID_LopHoc=%d%n", idHocSinh, idLopHoc);
                        }
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("studentErr", "Vui lòng chọn một học sinh hợp lệ!");
                    System.out.println("doPost: Invalid ID_HocSinh: " + e.getMessage());
                    e.printStackTrace();
                } catch (SQLException e) {
                    request.setAttribute("studentErr", "Lỗi khi thêm học sinh: " + e.getMessage());
                    System.out.println("doPost: SQL Error in addStudent: " + e.getMessage());
                    e.printStackTrace();
                }
            } else if ("moveOutStudent".equalsIgnoreCase(action)) {
                try {
                    int idHocSinh = Integer.parseInt(request.getParameter("ID_HocSinh"));
                    if (!hocSinhDAO.isStudentInClass1(idHocSinh, idLopHoc)) {
                        request.setAttribute("studentErr", "Học sinh không thuộc lớp này!");
                        System.out.printf("doPost: ID_HocSinh=%d not in class ID=%d%n", idHocSinh, idLopHoc);
                    } else {
                        boolean removed = hocSinhDAO.removeStudentFromClass1(idHocSinh, idLopHoc);
                        if (removed) {
                            int newSiSo = lopHoc.getSiSo() - 1;
                            if (newSiSo < 0) {
                                newSiSo = 0;
                            }
                            boolean siSoUpdated = lopHocDAO.updateSiSo(idLopHoc, newSiSo);
                            if (siSoUpdated) {
                                request.setAttribute("studentSuc", "Xóa học sinh khỏi lớp thành công!");
                                System.out.printf("doPost: Successfully removed ID_HocSinh=%d from ID_LopHoc=%d, SiSo updated to %d%n",
                                        idHocSinh, idLopHoc, newSiSo);
                            } else {
                                request.setAttribute("studentErr", "Xóa học sinh thành công nhưng không thể cập nhật sĩ số!");
                                System.out.printf("doPost: Failed to update SiSo for ID_LopHoc=%d after removing ID_HocSinh=%d%n",
                                        idLopHoc, idHocSinh);
                            }
                        } else {
                            request.setAttribute("studentErr", "Không thể xóa học sinh khỏi lớp!");
                            System.out.printf("doPost: Failed to remove ID_HocSinh=%d from ID_LopHoc=%d%n", idHocSinh, idLopHoc);
                        }
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("studentErr", "Vui lòng chọn một học sinh hợp lệ!");
                    System.out.println("doPost: Invalid ID_HocSinh: " + e.getMessage());
                    e.printStackTrace();
                } catch (SQLException e) {
                    request.setAttribute("studentErr", "Lỗi khi xóa học sinh: " + e.getMessage());
                    System.out.println("doPost: SQL Error in moveOutStudent: " + e.getMessage());
                    e.printStackTrace();
                }
            } else if ("removeTeacher".equals(action)) {
                try {
                    int idGiaoVien = Integer.parseInt(request.getParameter("ID_GiaoVien"));
                    GiaoVien currentTeacher = giaoVienDAO.getGiaoVienByLopHoc1(idLopHoc);
                    if (currentTeacher == null || currentTeacher.getID_GiaoVien() != idGiaoVien) {
                        request.setAttribute("teacherErr", "Giáo viên không thuộc lớp này!");
                        System.out.printf("doPost: ID_GiaoVien=%d not assigned to ID_LopHoc=%d%n", idGiaoVien, idLopHoc);
                    } else {
                        boolean removed = giaoVienDAO.removeTeacherFromClass1(idLopHoc, idGiaoVien);
                        if (removed) {
                            request.setAttribute("teacherSuc", "Xóa giáo viên khỏi lớp thành công!");
                            System.out.printf("doPost: Successfully removed ID_GiaoVien=%d from ID_LopHoc=%d%n", idGiaoVien, idLopHoc);
                        } else {
                            request.setAttribute("teacherErr", "Không thể xóa giáo viên khỏi lớp!");
                            System.out.printf("doPost: Failed to remove ID_GiaoVien=%d from ID_LopHoc=%d%n", idGiaoVien, idLopHoc);
                        }
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("teacherErr", "Vui lòng chọn một giáo viên hợp lệ!");
                    System.out.println("doPost: Invalid ID_GiaoVien: " + e.getMessage());
                    e.printStackTrace();
                }
            }

            // Làm mới dữ liệu
            lopHoc = lopHocDAO.getLopHocById(idLopHoc);
            lichHocList = lichHocDAO.getLichHocByLopHoc(idLopHoc);
            GiaoVien giaoVien = giaoVienDAO.getGiaoVienByLopHoc1(idLopHoc);
            List<HocSinh> hocSinhList = hocSinhDAO.getHocSinhByLopHoc1(idLopHoc);
            List<HocSinh> allStudents = hocSinhDAO.adminGetAllHocSinh11();
            KhoaHoc khoaHoc = khoaHocDAO.getKhoaHocById(idKhoaHoc);
            List<GiaoVien> availableTeachers = new ArrayList<>();
            List<GiaoVien> previousTeachers = giaoVienDAO.getPreviousTeachersByLopHoc1(idLopHoc);
            List<HocSinh> previousStudents = hocSinhDAO.getPreviousStudentsByLopHoc1(idLopHoc);
            if (khoaHoc != null) {
                String tenKhoaHoc = khoaHoc.getTenKhoaHoc().toLowerCase();
                availableTeachers = giaoVienDAO.getTeachersBySpecialization1(tenKhoaHoc);
                System.out.printf("doPost: AvailableTeachers size for ID_KhoaHoc=%d: %d%n",
                        idKhoaHoc, availableTeachers.size());
            } else {
                System.out.printf("doPost: KhoaHoc is null for ID_KhoaHoc=%d%n", idKhoaHoc);
            }

            // Ghi log debug
            System.out.printf("doPost: GiaoVien for ID_LopHoc=%d: %s%n", idLopHoc,
                    giaoVien != null ? giaoVien.getHoTen() : "null");
            System.out.printf("doPost: HocSinhList size for ID_LopHoc=%d: %d%n", idLopHoc,
                    hocSinhList != null ? hocSinhList.size() : 0);
            System.out.printf("doPost: PreviousTeachers size for ID_LopHoc=%d: %d%n", idLopHoc,
                    previousTeachers != null ? previousTeachers.size() : 0);
            System.out.printf("doPost: PreviousStudents size for ID_LopHoc=%d: %d%n", idLopHoc,
                    previousStudents != null ? previousStudents.size() : 0);

            // Đặt thuộc tính cho JSP
            request.setAttribute("lopHoc", lopHoc);
            request.setAttribute("lichHocList", lichHocList);
            request.setAttribute("giaoVien", giaoVien);
            request.setAttribute("hocSinhList", hocSinhList);
            request.setAttribute("allStudents", allStudents);
            request.setAttribute("availableTeachers", availableTeachers);
            request.setAttribute("previousTeachers", previousTeachers);
            request.setAttribute("previousStudents", previousStudents);
            request.setAttribute("ID_KhoaHoc", idKhoaHoc);
            request.setAttribute("ID_Khoi", idKhoi);

            // Chuyển tiếp đến JSP
            request.getRequestDispatcher("/views/admin/viewClass.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("doPost: Error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("err", "Lỗi khi xử lý yêu cầu: " + e.getMessage());
            LopHocDAO lopHocDAO = new LopHocDAO();
            LichHocDAO lichHocDAO = new LichHocDAO();
            request.setAttribute("lopHoc", lopHocDAO.getLopHocById(idLopHoc));
            request.setAttribute("lichHocList", lichHocDAO.getLichHocByLopHoc(idLopHoc));
            request.setAttribute("ID_KhoaHoc", idKhoaHoc);
            request.setAttribute("ID_Khoi", idKhoi);
            request.getRequestDispatcher("/views/admin/viewClass.jsp").forward(request, response);
        }
    }
}