/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.LopHocDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import model.LopHoc;
import jakarta.servlet.annotation.MultipartConfig;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;

/**
 *
 * @author Vuh26
 */
@MultipartConfig
public class Class_AddClass extends HttpServlet {

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
            out.println("<title>Servlet Class_AddClass</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Class_AddClass at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String tenLopHoc = request.getParameter("TenLopHoc");
        String[] thuTrongTuanArr = request.getParameterValues("ThuTrongTuan");
        String[] gioHocArr = request.getParameterValues("GioHoc");

        // Ghép thời gian học lại theo dạng: "Thứ 2 09:00;Thứ 4 14:00"
        StringBuilder thoiGianHocBuilder = new StringBuilder();
        if (thuTrongTuanArr != null && gioHocArr != null
                && thuTrongTuanArr.length == gioHocArr.length) {

            for (int i = 0; i < thuTrongTuanArr.length; i++) {
                if (!thuTrongTuanArr[i].isEmpty() && !gioHocArr[i].isEmpty()) {
                    thoiGianHocBuilder.append(thuTrongTuanArr[i])
                            .append(" ")
                            .append(gioHocArr[i]);
                    if (i < thuTrongTuanArr.length - 1) {
                        thoiGianHocBuilder.append(";");
                    }
                }
            }
        }

        String thoiGianHoc = thoiGianHocBuilder.toString();
        String ghiChu = request.getParameter("GhiChu");
        String idKhoaHoc = request.getParameter("ID_KhoaHoc");
        String idKhoi = request.getParameter("ID_Khoi");

        if (idKhoaHoc == null || idKhoaHoc.isEmpty()) {
            request.setAttribute("err", "Thiếu thông tin khóa học (ID_KhoaHoc)");
            request.getRequestDispatcher("/views/AddClass.jsp").forward(request, response);
            return;
        }

        try {
            int idKhoaHocInt = Integer.parseInt(idKhoaHoc);
            Part filePart = request.getPart("Image");
            String imagePath = "";

            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                BufferedImage image = ImageIO.read(filePart.getInputStream());

                if (image == null) {
                    request.setAttribute("err", "Tệp tải lên không phải là ảnh hợp lệ.");
                    request.getRequestDispatcher("/views/AddClass.jsp").forward(request, response);
                    return;
                }

                int width = image.getWidth();
                int height = image.getHeight();
                double ratio = (double) height / width;

                if (ratio < 1.25 || ratio > 1.40) {
                    request.setAttribute("err", "Ảnh phải có tỷ lệ gần 3x4 (VD: 300x400). Kích thước hiện tại: " + width + "x" + height);
                    request.getRequestDispatcher("/views/AddClass.jsp").forward(request, response);
                    return;
                }

                String uploadPath = getServletContext().getRealPath("") + File.separator + "img" + File.separator + "avatar";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);
                imagePath = "img/avatar/" + fileName;
            }

            // Kiểm tra trùng thời gian học và ghi chú (nếu cần)
            LopHocDAO dao = new LopHocDAO();
            

            // Thêm lớp học
            LopHoc newClass = dao.addLopHoc(tenLopHoc, idKhoaHocInt, 0, thoiGianHoc, ghiChu, "Inactive", "0", imagePath);

            if (newClass != null) {
                response.sendRedirect("views/AddClass.jsp?suc=1&ID_KhoaHoc=" + idKhoaHoc + (idKhoi != null ? "&ID_Khoi=" + idKhoi : ""));
            } else {
                request.setAttribute("err", "Thêm lớp học thất bại.");
                request.setAttribute("ID_KhoaHoc", idKhoaHoc);
                request.setAttribute("ID_Khoi", idKhoi);
                request.getRequestDispatcher("/views/AddClass.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "Có lỗi xảy ra: " + e.getMessage());
            request.setAttribute("ID_KhoaHoc", idKhoaHoc);
            request.setAttribute("ID_Khoi", idKhoi);
            request.getRequestDispatcher("/views/AddClass.jsp").forward(request, response);
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
