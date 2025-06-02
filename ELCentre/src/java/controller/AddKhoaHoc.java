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

/**
 *
 * @author Vuh26
 */
public class AddKhoaHoc extends HttpServlet {

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
            out.println("<title>Servlet AddKhoaHoc</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddKhoaHoc at " + request.getContextPath() + "</h1>");
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

        String ten = request.getParameter("TenKhoaHoc");
        String moTa = request.getParameter("MoTa");
        String batDauStr = request.getParameter("ThoiGianBatDau");
        String ketThucStr = request.getParameter("ThoiGianKetThuc");
        String ghiChu = request.getParameter("GhiChu");
        String ID_Khoi = request.getParameter("ID_Khoi");

        // Kiểm tra ID_Khoi có nhập và đúng định dạng số hay không
        int id_khoi = -1;
        try {
            if (ID_Khoi == null || ID_Khoi.trim().isEmpty()) {
                request.setAttribute("err", "Vui lòng nhập ID khối học.");
                request.getRequestDispatcher("/views/AddCourse.jsp").forward(request, response);
                return;
            }
            id_khoi = Integer.parseInt(ID_Khoi.trim());
        } catch (NumberFormatException e) {
            request.setAttribute("err", "ID khối học phải là số nguyên hợp lệ.");
            request.getRequestDispatcher("/views/AddCourse.jsp").forward(request, response);
            return;
        }

        try {
            String trangThai = "Inactive";
            if (!isTenKhoaHocHopLe(ten)) {
                request.setAttribute("err", "Tên khóa học không hợp lệ. Vui lòng chọn tên môn học phổ thông Việt Nam.");
                request.getRequestDispatcher("/views/AddCourse.jsp").forward(request, response);
                return;
            }

            // Kiểm tra trùng tên + ID_Khoi
            if (KhoaHocDAO.isDuplicateTenKhoaHocAndIDKhoi(ten, id_khoi)) {
                request.setAttribute("err", "Tên khóa học đã tồn tại trong cùng khối học!");
                request.getRequestDispatcher("/views/AddCourse.jsp").forward(request, response);
                return;
            }

            LocalDate batDau = (batDauStr != null && !batDauStr.isEmpty()) ? LocalDate.parse(batDauStr) : null;
            LocalDate ketThuc = (ketThucStr != null && !ketThucStr.isEmpty()) ? LocalDate.parse(ketThucStr) : null;
            LocalDate today = LocalDate.now();

            if (batDau != null && batDau.isBefore(today)) {
                request.setAttribute("err", "Ngày bắt đầu không được ở trong quá khứ!");
                request.getRequestDispatcher("/views/AddCourse.jsp").forward(request, response);
                return;
            }

            if (batDau != null && ketThuc != null && !ketThuc.isAfter(batDau.plusDays(29))) {
                request.setAttribute("err", "Ngày kết thúc phải sau ngày bắt đầu ít nhất 30 ngày!");
                request.getRequestDispatcher("/views/AddCourse.jsp").forward(request, response);
                return;
            }

            // Tạo đối tượng KhoaHoc
            KhoaHoc khoaHoc = new KhoaHoc(null, ten, moTa, batDau, ketThuc, ghiChu, trangThai, LocalDateTime.now(), id_khoi);

            KhoaHoc result = KhoaHocDAO.addKhoaHoc(khoaHoc);

            if (result != null) {
                request.setAttribute("suc", "Thêm khóa học thành công!");
            } else {
                request.setAttribute("err", "Thêm khóa học thất bại! Lớp 6 ứng với ID là 1, tương tự: 7-2,8-3");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "Lỗi: " + e.getMessage());
        }

        request.getRequestDispatcher("/views/AddCourse.jsp").forward(request, response);
    }

    static final List<String> TEN_MON_HOC_HOP_LE = Arrays.asList(
            "Toán", "Ngữ văn", "Vật lý", "Hóa học", "Sinh học",
            "Tin học", "Lịch sử", "Địa lý", "Giáo dục công dân",
            "Tiếng Anh", "Công nghệ", "Thể dục", "Âm nhạc", "Mỹ thuật",
            "Quốc phòng và An ninh"
    );

    boolean isTenKhoaHocHopLe(String ten) {
        if (ten == null) {
            return false;
        }
        return TEN_MON_HOC_HOP_LE.stream()
                .anyMatch(mon -> mon.equalsIgnoreCase(ten.trim()));
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
        processRequest(request, response);
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
