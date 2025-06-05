/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.KhoaHocDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import model.KhoaHoc;
import model.LopHoc;
import dal.LopHocDAO;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 *
 * @author Vuh26
 */
public class ManagerCourse extends HttpServlet {

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
            out.println("<title>Servlet ManagerCourse</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerCourse at " + request.getContextPath() + "</h1>");
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
        KhoaHocDAO kd = new KhoaHocDAO();
        String action = request.getParameter("action");

        if ("deleteCourse".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("ID_KhoaHoc"));

                // Lấy khóa học từ DB
                KhoaHoc khoaHoc = KhoaHocDAO.getKhoaHocById(id);

                if (khoaHoc == null) {
                    response.sendRedirect(request.getContextPath() + "/views/ManagerCourses2.jsp?message=notFound");
                    return;
                }
//protected static final String PAGE_MANAGER_COURSES = "/views/ManagerCourses2.jsp";
                String trangThai = khoaHoc.getTrangThai();
                LocalDate ketThuc = khoaHoc.getThoiGianKetThuc();
                LocalDate today = LocalDate.now();

                // Cho phép xóa nếu:
                // - Trạng thái là Inactive
                // - hoặc trạng thái là Active nhưng đã kết thúc
                if ("Inactive".equalsIgnoreCase(trangThai)
                        || ("Active".equalsIgnoreCase(trangThai) && ketThuc != null && ketThuc.isBefore(today))) {

                    KhoaHoc deleted = KhoaHocDAO.deleteKhoaHoc(khoaHoc);

                    if (deleted != null) {
                        response.sendRedirect(request.getContextPath() + "/views/ManagerCourses2.jsp?message=deleted");
                    } else {
                        request.setAttribute("err", "Xóa thất bại! Có thể do ràng buộc dữ liệu.");
                        request.getRequestDispatcher("/views/ManagerCourses2.jsp").forward(request, response);
                    }

                } else {
                    request.setAttribute("err", "Không thể xóa khóa học vì trạng thái không phù hợp! (Chỉ được xóa khi Inactive hoặc đã kết thúc)");
                    request.getRequestDispatcher("/views/ManagerCourses2.jsp").forward(request, response);
                }

            } catch (NumberFormatException e) {
                request.setAttribute("err", "ID khóa học không hợp lệ!");
                request.getRequestDispatcher("/views/ManagerCourses2.jsp").forward(request, response);
            }
        } else if ("ViewCourse".equals(action)) {
            try {
                String id = request.getParameter("ID_Khoi");
                int id_khoi = Integer.parseInt(id);

                List<LopHoc> danhSachLopHoc;
                danhSachLopHoc = LopHocDAO.getLopHocByIdKhoa(id_khoi);
                request.setAttribute("danhSachLopHoc", danhSachLopHoc);
                request.getRequestDispatcher("/views/ViewCourse.jsp").forward(request, response);

            } catch (NumberFormatException e) {
                request.setAttribute("err", "ID khối học không hợp lệ!");
                request.getRequestDispatcher("/views/ManagerCourses2.jsp").forward(request, response);
            }
        } else if ("UpdateCourse".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("ID_KhoaHoc"));
                KhoaHoc khoaHoc = KhoaHocDAO.getKhoaHocById(id);

                if (khoaHoc == null) {
                    response.sendRedirect(request.getContextPath() + "/views/ManagerCourses2.jsp?message=notFound");
                    return;
                }

                String trangThai = khoaHoc.getTrangThai();
                LocalDate ketThuc = khoaHoc.getThoiGianKetThuc();
                LocalDate today = LocalDate.now();

                // Cho phép cập nhật nếu:
                // - Trạng thái là Inactive
                // - hoặc trạng thái là Active nhưng khóa học đã kết thúc
                if ("Inactive".equalsIgnoreCase(trangThai)
                        || ("Active".equalsIgnoreCase(trangThai) && ketThuc != null && ketThuc.isBefore(today))) {

                    request.setAttribute("khoaHoc", khoaHoc);
                    request.getRequestDispatcher("/views/UpdateCourse.jsp").forward(request, response);

                } else {
                    request.setAttribute("err", "Không thể cập nhật khóa học vì trạng thái không phù hợp! (Chỉ được cập nhật khi khóa học ở trạng thái Inactive hoặc đã kết thúc!)");
                    request.getRequestDispatcher("/views/ManagerCourses2.jsp").forward(request, response);
                }

            } catch (NumberFormatException e) {
                request.setAttribute("err", "ID khóa học không hợp lệ!");
                request.getRequestDispatcher("/views/ManagerCourses2.jsp").forward(request, response);
            }
        } else {
            // Nếu action không hợp lệ hoặc null
            response.sendRedirect(request.getContextPath() + "/views/ManagerCourses2.jsp");
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

        String action = request.getParameter("action");

        if ("submitUpdateCourse".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("ID_KhoaHoc"));
                String ten = request.getParameter("TenKhoaHoc");
                String moTa = request.getParameter("MoTa");

                String batDauStr = request.getParameter("ThoiGianBatDau");
                String ketThucStr = request.getParameter("ThoiGianKetThuc");

                LocalDate batDau = (batDauStr != null && !batDauStr.isEmpty()) ? LocalDate.parse(batDauStr) : null;
                LocalDate ketThuc = (ketThucStr != null && !ketThucStr.isEmpty()) ? LocalDate.parse(ketThucStr) : null;

                String ghiChu = request.getParameter("GhiChu");
                String trangThai = request.getParameter("TrangThai");
                String ID_Khoi = request.getParameter("ID_Khoi");
                int id_khoi = Integer.parseInt(ID_Khoi);
                // Lấy thông tin khóa học cũ
                KhoaHoc khoaHocCu = KhoaHocDAO.getKhoaHocById(id);

                if (!isTenKhoaHocHopLe(ten)) {
                    request.setAttribute("err", "Tên khóa học không hợp lệ. Vui lòng chọn tên môn học phổ thông Việt Nam.");
                    request.getRequestDispatcher("/views/UpdateCourse.jsp").forward(request, response);
                    return;
                }
                // Nếu là khóa tổng ôn thì ID_Khoi bắt buộc phải là 8
                if (ten != null && ten.startsWith("Khóa tổng ôn ") && id_khoi != 8) {
                    request.setAttribute("err", "Khóa tổng ôn chỉ áp dụng cho khối 8!");
                    request.getRequestDispatcher("/views/UpdateCourse.jsp").forward(request, response);
                    return;
                }

                // Kiểm tra trùng tên và ID_Khoi nếu bị thay đổi
                if ((!ten.equalsIgnoreCase(khoaHocCu.getTenKhoaHoc()) || id_khoi != khoaHocCu.getID_Khoi())
                        && KhoaHocDAO.isDuplicateTenKhoaHocAndIDKhoi(ten, id_khoi)) {
                    request.setAttribute("err", "Tên khóa học đã tồn tại với Khối học này!");
                    request.setAttribute("khoaHoc", khoaHocCu);
                    request.getRequestDispatcher("/views/UpdateCourse.jsp").forward(request, response);
                    return;
                }

                if (!trangThai.equalsIgnoreCase("Active") && !trangThai.equalsIgnoreCase("Inactive")) {
                    request.setAttribute("err", "Nhập lại trạng thái của khóa học (Active - Inactive) ");
                    request.setAttribute("khoaHoc", khoaHocCu);
                    request.getRequestDispatcher("/views/UpdateCourse.jsp").forward(request, response);
                    return;
                }

                // Kiểm tra ngày kết thúc
                if (batDau != null && ketThuc != null && !ketThuc.isAfter(batDau.plusDays(29))) {
                    request.setAttribute("err", "Ngày kết thúc phải sau ngày bắt đầu ít nhất 30 ngày!");
                    request.setAttribute("khoaHoc", khoaHocCu);
                    request.getRequestDispatcher("/views/UpdateCourse.jsp").forward(request, response);
                    return;
                }

                if (!ten.matches("^[\\p{L}0-9\\s\\-]+$")) { // Cho phép chữ, số, dấu cách, dấu gạch
                    request.setAttribute("err", "Tên khóa học chỉ được chứa chữ, số và khoảng trắng.");
                }

                // Tạo đối tượng khóa học mới
                KhoaHoc khoaHoc = new KhoaHoc(id, ten, moTa, batDau, ketThuc, ghiChu, trangThai, LocalDateTime.MAX, id_khoi);

                // Cập nhật vào DB
                KhoaHoc khoaHocUpdated = KhoaHocDAO.updateKhoaHoc(khoaHoc);

                if (khoaHocUpdated != null) {
                    request.setAttribute("suc", "Cập nhật thành công");
                    request.setAttribute("khoaHoc", khoaHocUpdated);
                } else {
                    request.setAttribute("err", "Cập nhật thất bại");
                    request.setAttribute("khoaHoc", khoaHoc);
                }

                request.getRequestDispatcher("/views/UpdateCourse.jsp").forward(request, response);

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("err", "Có lỗi xảy ra: " + e.getMessage());
                request.getRequestDispatcher("/views/UpdateCourse.jsp").forward(request, response);
            }
        }
    }

    private void handleDeleteCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    static final List<String> TEN_MON_HOC_HOP_LE = Arrays.asList(
            "Toán", "Ngữ văn", "Vật lý", "Hóa học", "Sinh học",
            "Tin học", "Lịch sử", "Địa lý", "Giáo dục công dân",
            "Tiếng Anh", "Công nghệ", "Thể dục", "Âm nhạc", "Mỹ thuật",
            "Quốc phòng và An ninh"
    ).stream()
            .flatMap(tenMon -> Stream.of("Khóa " + tenMon, "Khóa tổng ôn " + tenMon))
            .collect(Collectors.toList());

    boolean isTenKhoaHocHopLe(String ten) {
        if (ten == null) {
            return false;
        }
        return TEN_MON_HOC_HOP_LE.stream()
                .anyMatch(mon -> mon.equalsIgnoreCase(ten.trim()));
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

    public static void main(String[] args) {
        KhoaHoc kd = KhoaHocDAO.getKhoaHocById(2);
        System.out.println(kd);
    }
}
