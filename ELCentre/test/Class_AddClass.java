/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */


import dal.LopHocDAO;
import model.LopHoc;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.time.LocalDateTime;

/**
 *
 * @author Vuh26
 */
@WebServlet(name = "AddClassServlet", urlPatterns = {"/Class_AddClass"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)      // 50MB
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
    private String uploadPath;

    @Override
    public void init() {
        // Thư mục lưu ảnh, bạn có thể thay đổi đường dẫn theo ý muốn
        uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
    }

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
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            String tenLopHoc = request.getParameter("TenLopHoc");
            String ghiChu = request.getParameter("GhiChu");
            String soTien = request.getParameter("SoTien");
            String thoiGianHoc = request.getParameter("ThoiGianHoc");

            int idKhoaHoc = Integer.parseInt(request.getParameter("ID_KhoaHoc"));

            // Handle image upload
            Part filePart = request.getPart("Image");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            // Create upload folder if not exists
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);

            // Lưu đường dẫn tương đối để lưu trong DB
            String imagePath = "uploads/" + fileName;

            // Gọi DAO
            LopHocDAO dao = new LopHocDAO();
            LopHoc newClass = dao.addLopHoc(tenLopHoc, idKhoaHoc, 0, thoiGianHoc, ghiChu, "Inactive", "0", imagePath);

            if (newClass != null) {
                request.setAttribute("suc", "Thêm lớp học thành công!");
            } else {
                request.setAttribute("err", "Thêm lớp học thất bại.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "Có lỗi xảy ra: " + e.getMessage());
        }

        // Trả lại trang AddClass.jsp cùng các message nếu có
        request.getRequestDispatcher("/AddClass.jsp").forward(request, response);
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
