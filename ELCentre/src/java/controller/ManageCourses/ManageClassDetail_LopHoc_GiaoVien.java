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
import dal.LopHocInfoDTODAO;
import dal.ThongBaoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.GiaoVien;
import model.HocSinh;
import model.KhoaHoc;
import model.LichHoc;
import model.LopHoc;
import model.LopHocInfoDTO;

/**
 *
 * @author Vuh26
 */
public class ManageClassDetail_LopHoc_GiaoVien extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManageClassDetail_LopHoc_GiaoVien</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageClassDetail_LopHoc_GiaoVien at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy tham số
            int idLopHoc = Integer.parseInt(request.getParameter("ID_LopHoc"));
            int idKhoaHoc = Integer.parseInt(request.getParameter("ID_KhoaHoc"));
            int idKhoi = Integer.parseInt(request.getParameter("ID_Khoi"));
            String idGiaoVien = request.getParameter("idGiaoVien"); // Lấy idGiaoVien từ request

            // Xây dựng backUrl để quay lại viewLopHoc_GiaoVien.jsp
            String backUrl;
            if (idGiaoVien != null && !idGiaoVien.isEmpty()) {
                backUrl = request.getContextPath() + "/adminActionWithTeacher?action=viewLopHocGiaoVien&id=" + idGiaoVien;
            } else {
                // URL mặc định nếu không có idGiaoVien
                backUrl = request.getContextPath() + "/adminGetFromDashboard?action=giaovien";
            }
            request.setAttribute("backUrl", backUrl);

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
                request.getRequestDispatcher("/views/admin/viewClass_LopHoc_GiaoVien.jsp").forward(request, response);
                return;
            }

            // Xử lý ClassCode từ tham số URL nếu cột ClassCode là null
            String classCodeFromUrl = request.getParameter("ClassCode");
            if (lopHoc.getClassCode() == null && classCodeFromUrl != null && !classCodeFromUrl.trim().isEmpty()) {
                lopHoc.setClassCode(classCodeFromUrl);
            }

            // Lấy danh sách lịch học
            List<LichHoc> lichHocList = lichHocDAO.getLichHocByLopHoc(idLopHoc);

            // Lấy giáo viên của lớp
            GiaoVien giaoVien = giaoVienDAO.getGiaoVienByLopHoc1(idLopHoc);

            // Lấy danh sách học sinh trong lớp
            List<HocSinh> hocSinhList = hocSinhDAO.getHocSinhByLopHoc1(idLopHoc);

            // Lấy danh sách tất cả học sinh
            List<HocSinh> allStudents = hocSinhDAO.adminGetAllHocSinh11();

            // Lấy danh sách giáo viên phù hợp với khóa học
            KhoaHoc khoaHoc = khoaHocDAO.getKhoaHocById(idKhoaHoc);
            List<GiaoVien> availableTeachers = new ArrayList<>();
            if (khoaHoc != null) {
                String tenKhoaHoc = khoaHoc.getTenKhoaHoc().toLowerCase();
                availableTeachers = giaoVienDAO.getTeachersBySpecialization1(tenKhoaHoc);
            } else {
            }

            // Lấy danh sách giáo viên và học sinh đã tham gia các buổi học trước
            List<GiaoVien> previousTeachers = giaoVienDAO.getPreviousTeachersByLopHoc1(idLopHoc);
            List<HocSinh> previousStudents = hocSinhDAO.getPreviousStudentsByLopHoc1(idLopHoc);

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
            request.setAttribute("idGiaoVien", idGiaoVien); // Đặt idGiaoVien để sử dụng trong JSP nếu cần

            // Chuyển tiếp đến JSP
            request.getRequestDispatcher("/views/admin/viewClass_LopHoc_GiaoVien.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("err", "Tham số không hợp lệ!");
            request.getRequestDispatcher("/views/admin/viewClass_LopHoc_GiaoVien.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "Lỗi khi tải thông tin lớp học: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/viewClass_LopHoc_GiaoVien.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        int idLopHoc;
        int idKhoaHoc;
        int idKhoi;
        String studentId = request.getParameter("idHocSinh"); // Đổi tên biến để tránh xung đột

        try {
            idLopHoc = Integer.parseInt(request.getParameter("ID_LopHoc"));
            idKhoaHoc = Integer.parseInt(request.getParameter("ID_KhoaHoc"));
            idKhoi = Integer.parseInt(request.getParameter("ID_Khoi"));
        } catch (NumberFormatException e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("err", "Tham số không hợp lệ!");
            response.sendRedirect("ManageClassDetail_LopHoc_GiaoVien?ID_LopHoc=" + request.getParameter("ID_LopHoc") 
                                + "&ID_KhoaHoc=" + request.getParameter("ID_KhoaHoc") 
                                + "&ID_Khoi=" + request.getParameter("ID_Khoi")
                                + (studentId != null ? "&idHocSinh=" + studentId : ""));
            return;
        }

        HttpSession session = request.getSession();
        try {
            // Khởi tạo DAO
            LopHocInfoDTODAO lopHocInfoDAO = new LopHocInfoDTODAO();
            LichHocDAO lichHocDAO = new LichHocDAO();
            GiaoVienDAO giaoVienDAO = new GiaoVienDAO();
            HocSinhDAO hocSinhDAO = new HocSinhDAO();
            KhoaHocDAO khoaHocDAO = new KhoaHocDAO();
            ThongBaoDAO thongBaoDAO = new ThongBaoDAO();

            // Lấy thông tin lớp học
            LopHocInfoDTO lopHoc = lopHocInfoDAO.getLopHocInfoById(idLopHoc);
            if (lopHoc == null) {
                session.setAttribute("err", "Không tìm thấy lớp học.");
                response.sendRedirect("ManageClassDetail_LopHoc_GiaoVien?ID_LopHoc=" + idLopHoc 
                                    + "&ID_KhoaHoc=" + idKhoaHoc + "&ID_Khoi=" + idKhoi
                                    + (studentId != null ? "&idHocSinh=" + studentId : ""));
                return;
            }

            // Lấy danh sách lịch học
            List<LichHoc> lichHocList = lichHocDAO.getLichHocByLopHoc(idLopHoc);

            if ("assignTeacher".equals(action)) {
                try {
                    int idGiaoVien = Integer.parseInt(request.getParameter("ID_GiaoVien"));
                    GiaoVien currentTeacher = giaoVienDAO.getGiaoVienByLopHoc1(idLopHoc);

                    if (currentTeacher != null && currentTeacher.getID_GiaoVien() == idGiaoVien) {
                        session.setAttribute("teacherErr", "Giáo viên này đã được phân công cho lớp!");
                    } else {
                        boolean success = giaoVienDAO.assignTeacherToClass1(idLopHoc, idGiaoVien);
                        if (success) {
                            // Gửi thông báo cho giáo viên mới
                            GiaoVien gv = giaoVienDAO.getGiaoVienById1(idGiaoVien);
                            if (gv != null) {
                                String idTK = String.valueOf(gv.getID_TaiKhoan());
                                String noiDung = "Bạn đã được thêm vào lớp " + lopHoc.getTenLopHoc();
                                thongBaoDAO.adminSendNotification(idTK, noiDung, "Unread");
                            }

                            session.setAttribute("teacherSuc", "Giáo viên đã được phân công thành công!");
                        } else {
                            session.setAttribute("teacherErr", "Không thể phân công giáo viên!");
                        }
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("teacherErr", "Vui lòng chọn một giáo viên hợp lệ!");
                    e.printStackTrace();
                } catch (SQLException e) {
                    session.setAttribute("teacherErr", "Lỗi khi phân công giáo viên: " + e.getMessage());
                    e.printStackTrace();
                }
            } else if ("addStudent".equals(action)) {
                String[] selectedStudents = request.getParameterValues("selectedStudents");
                if (selectedStudents == null || selectedStudents.length == 0) {
                    session.setAttribute("studentErr", "Chưa chọn học sinh nào!");
                } else {
                    int addedCount = 0;
                    List<String> errors = new ArrayList<>();
                    for (String idStr : selectedStudents) {
                        try {
                            int id = Integer.parseInt(idStr);
                            if (lopHoc.getSiSo() >= lopHoc.getSiSoToiDa()) {
                                errors.add("Lớp đã đạt sĩ số tối đa cho học sinh ID " + id);
                                continue;
                            }
                            if (hocSinhDAO.isStudentInClass1(id, idLopHoc)) {
                                errors.add("Học sinh ID " + id + " đã có trong lớp!");
                                continue;
                            }
                            if (hocSinhDAO.hasSchoolConflict1(id, idLopHoc)) {
                                errors.add("Không thể thêm học sinh ID " + id + " vì xung đột trường học!");
                                continue;
                            }
                            String tenLopTrung = lichHocDAO.hasScheduleConflictForStudent(id, idLopHoc);
                            if (tenLopTrung != null) {
                                errors.add("Không thể thêm học sinh ID " + id + " vì lịch học trùng với lớp " + tenLopTrung + "!");
                                continue;
                            }
                            boolean studentAdded = hocSinhDAO.addStudentToClass1(id, idLopHoc);
                            if (studentAdded) {
                                lopHoc.setSiSo(lopHoc.getSiSo() + 1);
                                boolean siSoUpdated = lopHocInfoDAO.updateSiSo(idLopHoc, lopHoc.getSiSo());
                                if (siSoUpdated) {
                                    addedCount++;
                                    // Gửi thông báo cho học sinh mới thêm
                                    HocSinh hs = hocSinhDAO.getHocSinhById1(id);
                                    if (hs != null) {
                                        String idTK = String.valueOf(hs.getID_TaiKhoan());
                                        String noiDung = "Bạn đã được thêm vào lớp " + lopHoc.getTenLopHoc();
                                        thongBaoDAO.adminSendNotification(idTK, noiDung, "Unread");
                                    }
                                } else {
                                    errors.add("Lỗi khi cập nhật sĩ số lớp cho học sinh ID " + id);
                                }
                            } else {
                                errors.add("Không thể thêm học sinh ID " + id + " vào lớp!");
                            }
                        } catch (NumberFormatException e) {
                            errors.add("ID học sinh không hợp lệ: " + idStr);
                        } catch (SQLException e) {
                            errors.add("Lỗi SQL khi thêm học sinh ID " + idStr + ": " + e.getMessage());
                        }
                    }
                    if (addedCount > 0) {
                        session.setAttribute("studentSuc", "Đã thêm " + addedCount + " học sinh thành công!");
                        // Kiểm tra nếu sĩ số đạt tối thiểu để gửi thông báo bắt đầu lớp
                        if (lopHoc.getSiSoToiThieu() != 0) {
                            int oldSiSo = lopHoc.getSiSo() - addedCount; // Tính sĩ số cũ
                            if (oldSiSo < lopHoc.getSiSoToiThieu() && lopHoc.getSiSo() >= lopHoc.getSiSoToiThieu()) {
                                LocalDate ngayGanNhat = lichHocDAO.getNearestFutureDate(idLopHoc);
                                if (ngayGanNhat != null) {
                                    String noiDung = "Lớp học " + lopHoc.getTenLopHoc() + " đủ sĩ số và sẽ bắt đầu vào ngày " + ngayGanNhat;
                                    // Gửi cho giáo viên
                                    String idGV = ThongBaoDAO.adminGetIdGiaoVienToSendNTF(String.valueOf(idLopHoc));
                                    if (idGV != null) {
                                        thongBaoDAO.adminSendNotification(idGV, noiDung, "Unread");
                                    }
                                    // Gửi cho tất cả học sinh trong lớp
                                    ArrayList<String> listHS = ThongBaoDAO.adminGetListIDHSbyID_LopHoc(String.valueOf(idLopHoc));
                                    if (!listHS.isEmpty()) {
                                        thongBaoDAO.adminSendClassNotification(listHS, noiDung, "Unread");
                                    }
                                }
                            }
                        }
                    }
                    if (!errors.isEmpty()) {
                        session.setAttribute("studentErr", String.join("<br>", errors));
                    }
                }
            } else if ("moveOutStudent".equalsIgnoreCase(action)) {
                try {
                    int idHocSinhRemove = Integer.parseInt(request.getParameter("ID_HocSinh"));
                    if (!hocSinhDAO.isStudentInClass1(idHocSinhRemove, idLopHoc)) {
                        session.setAttribute("studentErr", "Học sinh không thuộc lớp này!");
                    } else {
                        boolean removed = hocSinhDAO.removeStudentFromClass1(idHocSinhRemove, idLopHoc);
                        if (removed) {
                            int newSiSo = lopHoc.getSiSo() - 1;
                            if (newSiSo < 0) {
                                newSiSo = 0;
                            }
                            boolean siSoUpdated = lopHocInfoDAO.updateSiSo(idLopHoc, newSiSo);
                            if (siSoUpdated) {
                                // Gửi thông báo cho học sinh bị xóa
                                HocSinh hs = hocSinhDAO.getHocSinhById1(idHocSinhRemove);
                                if (hs != null) {
                                    String idTK = String.valueOf(hs.getID_TaiKhoan());
                                    String noiDung = "Bạn đã bị xóa khỏi lớp " + lopHoc.getTenLopHoc();
                                    thongBaoDAO.adminSendNotification(idTK, noiDung, "Unread");
                                }

                                session.setAttribute("studentSuc", "Xóa học sinh khỏi lớp thành công!");
                            } else {
                                session.setAttribute("studentErr", "Xóa học sinh thành công nhưng không thể cập nhật sĩ số!");
                            }
                        } else {
                            session.setAttribute("studentErr", "Không thể xóa học sinh khỏi lớp!");
                        }
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("studentErr", "Vui lòng chọn một học sinh hợp lệ!");
                    e.printStackTrace();
                } catch (SQLException e) {
                    session.setAttribute("studentErr", "Lỗi khi xóa học sinh: " + e.getMessage());
                    e.printStackTrace();
                }
            } else if ("removeSelectedStudents".equals(action)) {
                String[] selectedStudentsToRemove = request.getParameterValues("selectedStudentsToRemove");
                if (selectedStudentsToRemove == null || selectedStudentsToRemove.length == 0) {
                    // Chỉ đặt thông báo lỗi nếu hành động thực sự là xóa
                    if (request.getParameter("selectedStudentsToRemove") != null) {
                        session.setAttribute("studentErr", "Chưa chọn học sinh nào để xóa!");
                    }
                } else {
                    int removedCount = 0;
                    List<String> errors = new ArrayList<>();
                    for (String idStr : selectedStudentsToRemove) {
                        try {
                            int idHocSinh = Integer.parseInt(idStr);
                            if (!hocSinhDAO.isStudentInClass1(idHocSinh, idLopHoc)) {
                                errors.add("Học sinh ID " + idHocSinh + " không thuộc lớp này!");
                                continue;
                            }
                            boolean removed = hocSinhDAO.removeStudentFromClass1(idHocSinh, idLopHoc);
                            if (removed) {
                                removedCount++;
                                // Gửi thông báo cho học sinh bị xóa
                                HocSinh hs = hocSinhDAO.getHocSinhById1(idHocSinh);
                                if (hs != null) {
                                    String idTK = String.valueOf(hs.getID_TaiKhoan());
                                    String noiDung = "Bạn đã bị xóa khỏi lớp " + lopHoc.getTenLopHoc();
                                    thongBaoDAO.adminSendNotification(idTK, noiDung, "Unread");
                                }
                            } else {
                                errors.add("Không thể xóa học sinh ID " + idHocSinh + " khỏi lớp!");
                            }
                        } catch (NumberFormatException e) {
                            errors.add("ID học sinh không hợp lệ: " + idStr);
                        } catch (SQLException e) {
                            errors.add("Lỗi SQL khi xóa học sinh ID " + idStr + ": " + e.getMessage());
                        }
                    }
                    if (removedCount > 0) {
                        int newSiSo = lopHoc.getSiSo() - removedCount;
                        if (newSiSo < 0) newSiSo = 0;
                        boolean siSoUpdated = lopHocInfoDAO.updateSiSo(idLopHoc, newSiSo);
                        if (siSoUpdated) {
                            session.setAttribute("studentSuc", "Đã xóa " + removedCount + " học sinh thành công!");
                        } else {
                        }
                    }
                    if (!errors.isEmpty()) {
                        session.setAttribute("studentErr", String.join("<br>", errors));
                    }
                }
            } else if ("removeTeacher".equals(action)) {
                try {
                    int idGiaoVien = Integer.parseInt(request.getParameter("ID_GiaoVien"));
                    GiaoVien currentTeacher = giaoVienDAO.getGiaoVienByLopHoc1(idLopHoc);
                    if (currentTeacher == null || currentTeacher.getID_GiaoVien() != idGiaoVien) {
                        session.setAttribute("teacherErr", "Giáo viên không thuộc lớp này!");
                    } else {
                        boolean removed = giaoVienDAO.removeTeacherFromClass1(idLopHoc, idGiaoVien);
                        if (removed) {
                            // Gửi thông báo cho giáo viên bị xóa
                            GiaoVien gv = giaoVienDAO.getGiaoVienById1(idGiaoVien);
                            if (gv != null) {
                                String idTK = String.valueOf(gv.getID_TaiKhoan());
                                String noiDung = "Bạn đã bị xóa khỏi lớp " + lopHoc.getTenLopHoc();
                                thongBaoDAO.adminSendNotification(idTK, noiDung, "Unread");
                            }

                            session.setAttribute("teacherSuc", "Xóa giáo viên khỏi lớp thành công!");
                        } else {
                            session.setAttribute("teacherErr", "Không thể xóa giáo viên khỏi lớp!");
                        }
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("teacherErr", "Vui lòng chọn một giáo viên hợp lệ!");
                    e.printStackTrace();
                } catch (SQLException e) {
                    session.setAttribute("teacherErr", "Lỗi khi xóa giáo viên: " + e.getMessage());
                    e.printStackTrace();
                }
            }

            // Chuyển hướng với studentId (idHocSinh)
            response.sendRedirect("ManageClassDetail_LopHoc_GiaoVien?ID_LopHoc=" + idLopHoc 
                                + "&ID_KhoaHoc=" + idKhoaHoc + "&ID_Khoi=" + idKhoi
                                + (studentId != null ? "&idHocSinh=" + studentId : ""));
            return;
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("err", "Lỗi khi xử lý yêu cầu: " + e.getMessage());
            LopHocInfoDTODAO lopHocInfoDAO = new LopHocInfoDTODAO();
            LichHocDAO lichHocDAO = new LichHocDAO();
            request.setAttribute("lopHoc", lopHocInfoDAO.getLopHocInfoById(idLopHoc));
            request.setAttribute("lichHocList", lichHocDAO.getLichHocByLopHoc(idLopHoc));
            request.setAttribute("ID_KhoaHoc", idKhoaHoc);
            request.setAttribute("ID_Khoi", idKhoi);
            request.setAttribute("idHocSinh", studentId); // Đảm bảo idHocSinh được truyền vào JSP
            request.getRequestDispatcher("/views/admin/viewClass_LopHoc_GiaoVien.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}