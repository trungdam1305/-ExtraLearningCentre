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
import model.KhoaHoc;

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
                // Không tìm thấy khóa học
                response.sendRedirect(request.getContextPath() + "/views/ManagerCourses2.jsp?message=notFound");
                return;
            }

            String trangThai = khoaHoc.getTrangThai();

            // Chỉ cho phép xóa khi trạng thái là "chưa bắt đầu" hoặc "kết thúc"
            if ("chưa bắt đầu".equalsIgnoreCase(trangThai) || "đã kết thúc".equalsIgnoreCase(trangThai)) {
                KhoaHoc deleted = KhoaHocDAO.deleteKhoaHoc(khoaHoc);

                if (deleted != null) {
                    // Xóa thành công
                    response.sendRedirect(request.getContextPath() + "/views/ManagerCourses2.jsp?message=deleted");
                } else {
                    request.setAttribute("err", "Không thể xóa khóa học vì trạng thái không phù hợp! (Chỉ được xóa khi 'chưa bắt đầu' hoặc 'kết thúc')");
                    request.getRequestDispatcher("/views/ManagerCourses2.jsp").forward(request, response);
                    return;
                }
            } else {
                request.setAttribute("err", "Không thể xóa khóa học vì trạng thái không phù hợp! (Chỉ được xóa khi 'chưa bắt đầu' hoặc 'kết thúc')");
                request.getRequestDispatcher("/views/ManagerCourses2.jsp").forward(request, response);
                return;
            }

        } catch (NumberFormatException e) {
            request.setAttribute("err", "ID khóa học không hợp lệ!");
            request.getRequestDispatcher("/views/ManagerCourses2.jsp").forward(request, response);
            return;
        }
    } else if ("ViewCourse".equals(action)) {
        String id = request.getParameter("ID_KhoaHoc");
        int id_cou = Integer.parseInt(id);
        KhoaHoc khoaHoc = KhoaHocDAO.getKhoaHocById(id_cou);
        request.setAttribute("khoaHoc", khoaHoc);
        request.getRequestDispatcher("/views/ViewCourse.jsp").forward(request, response);
        
    } else if ("UpdateCourse".equals(action)) {
        try {
            int id = Integer.parseInt(request.getParameter("ID_KhoaHoc"));
            KhoaHoc khoaHoc = KhoaHocDAO.getKhoaHocById(id);

            if (khoaHoc == null) {
                response.sendRedirect(request.getContextPath() + "/views/ManagerCourses2.jsp?message=notFound");
                return;
            }

            String trangThai = khoaHoc.getTrangThai();

            // Chỉ cho phép update khi trạng thái là "chưa bắt đầu" hoặc "kết thúc"
            if ("chưa bắt đầu".equalsIgnoreCase(trangThai) || "đã kết thúc".equalsIgnoreCase(trangThai)) {
                // Cho phép vào trang cập nhật, gửi đối tượng khóa học để hiển thị form
                request.setAttribute("khoaHoc", khoaHoc);
                request.getRequestDispatcher("/views/UpdateCourse.jsp").forward(request, response);
            } else {
                // Không được phép cập nhật khóa học đang hoạt động hoặc trạng thái khác
                request.setAttribute("err", "Không thể cập nhật khóa học vì trạng thái không phù hợp! (Chỉ được cập nhật khi 'chưa bắt đầu' hoặc 'kết thúc')");
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

                // Lấy thông tin khóa học cũ
                KhoaHoc khoaHocCu = KhoaHocDAO.getKhoaHocById(id);

                // 🚫 Không cho phép cập nhật nếu trạng thái hiện tại là "Hoạt động"
                if ("Hoạt động".equalsIgnoreCase(khoaHocCu.getTrangThai())) {
                    request.setAttribute("err", "Không thể cập nhật khóa học đang hoạt động!");
                    request.setAttribute("khoaHoc", khoaHocCu);
                    request.getRequestDispatcher("/views/UpdateCourse.jsp").forward(request, response);
                    return;
                }

                // Kiểm tra trùng tên nếu tên bị thay đổi
                if (!ten.equalsIgnoreCase(khoaHocCu.getTenKhoaHoc()) && KhoaHocDAO.isTenKhoaHocDuplicate(ten)) {
                    request.setAttribute("err", "Tên khóa học đã tồn tại!");
                    request.setAttribute("khoaHoc", khoaHocCu);
                    request.getRequestDispatcher("/views/UpdateCourse.jsp").forward(request, response);
                    return;
                }
                
                if (!trangThai.equalsIgnoreCase("đã kết thúc") && !trangThai.equalsIgnoreCase("hoạt động") && !trangThai.equalsIgnoreCase("chưa bắt đầu")) {
                    request.setAttribute("err", "Nhập lại trạng thái của khóa học (Đã kết thúc - hoạt động - chưa bắt đầu) ");
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

                // Tạo đối tượng khóa học mới
                KhoaHoc khoaHoc = new KhoaHoc(id, ten, moTa, batDau, ketThuc, ghiChu, trangThai, LocalDateTime.now());

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
