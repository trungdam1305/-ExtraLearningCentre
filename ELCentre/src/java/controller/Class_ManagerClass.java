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

import model.LopHoc;
import dal.LopHocDAO;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.awt.image.BufferedImage;
import java.io.File;
import java.nio.file.Paths;
import javax.imageio.ImageIO;

/**
 *
 * @author Vuh26
 */
@MultipartConfig
public class Class_ManagerClass extends HttpServlet {

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
            out.println("<title>Servlet Class_ManagerClass</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Class_ManagerClass at " + request.getContextPath() + "</h1>");
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
        LopHocDAO kd = new LopHocDAO();
        String idKhoaStr = request.getParameter("ID_KhoaHoc");
        String idKhoiStr = request.getParameter("ID_Khoi");
        String str = "";

        String action = request.getParameter("action");
        if ("deleteClass".equals(action)) {
            int id = Integer.parseInt(request.getParameter("ID_LopHoc"));

            try {

                LopHoc lopHoc = kd.getLopHocById(id);

                if (lopHoc == null) {
                    response.sendRedirect(request.getContextPath() + "/views/ViewCourse.jsp?message=notFound");
                    return;
                }
                String trangThai = lopHoc.getTrangThai();

                // Cho phép xóa nếu:
                // - Trạng thái là Inactive
                // - hoặc trạng thái là Active nhưng đã kết thúc
                if ("Inactive".equalsIgnoreCase(trangThai)) {

                    LopHoc deleted = kd.deleteLopHoc(lopHoc);

                    if (deleted != null) {

                        response.sendRedirect("ManagerCourse?action=ViewCourse&ID_KhoaHoc=" + idKhoaStr + "&ID_Khoi=" + idKhoiStr + "&message=deleted");

                        return;
                    } else {
//                        request.setAttribute("err", "Xóa thất bại! Có thể do ràng buộc dữ liệu.");
//                        request.getRequestDispatcher("/views/ViewCourse.jsp").forward(request, response);

                        response.sendRedirect("ManagerCourse?action=ViewCourse&ID_KhoaHoc=" + idKhoaStr + "&ID_Khoi=" + idKhoiStr + "&message=Notdeleted");
                    }

                } else {
//                    request.setAttribute("err", "Không thể xóa khóa học vì trạng thái không phù hợp! (Chỉ được xóa khi Inactive hoặc đã kết thúc)");
//                    request.getRequestDispatcher("/views/ViewCourse.jsp").forward(request, response);

                    response.sendRedirect("ManagerCourse?action=ViewCourse&ID_KhoaHoc=" + idKhoaStr + "&ID_Khoi=" + idKhoiStr + "&message=Notdeleted");
                }

            } catch (NumberFormatException e) {
                request.setAttribute("err", "ID khóa học không hợp lệ!");
                request.getRequestDispatcher("/views/ViewCourse.jsp").forward(request, response);
                return;
            }
        } else if ("updateClass".equalsIgnoreCase(action)) {
            try {
                int idLopHoc = Integer.parseInt(request.getParameter("ID_LopHoc"));
                int idKhoaHoc = Integer.parseInt(request.getParameter("ID_KhoaHoc"));
                int idKhoi = Integer.parseInt(request.getParameter("ID_Khoi"));

                LopHocDAO dao = new LopHocDAO();
                LopHoc lopHoc = dao.getLopHocById(idLopHoc);

                String trangThai = lopHoc.getTrangThai();


                    request.setAttribute("lopHoc", lopHoc);
                    request.setAttribute("idKhoaHoc", idKhoaHoc);
                    request.setAttribute("idKhoi", idKhoi);
                    request.getRequestDispatcher("/views/UpdateClass.jsp").forward(request, response);

              

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("views/ViewCourse.jsp");
            }
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

        if ("submitUpdateClass".equalsIgnoreCase(action)) {
            System.out.println("=== Đang xử lý cập nhật lớp học ===");
            try {
                int idLopHoc = Integer.parseInt(request.getParameter("ID_LopHoc"));
                int idKhoaHoc = Integer.parseInt(request.getParameter("ID_KhoaHoc"));
                int idKhoi = Integer.parseInt(request.getParameter("ID_Khoi"));

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
                String trangThai = request.getParameter("TrangThai");
                int siSo = Integer.parseInt(request.getParameter("SiSo"));

                // Lấy thông tin lớp học hiện tại để giữ lại ảnh cũ nếu không upload ảnh mới
                LopHocDAO dao = new LopHocDAO();
                LopHoc oldData = dao.getLopHocById(idLopHoc);
                String imagePath = oldData.getImage();

                // Xử lý ảnh
                Part filePart = request.getPart("Image");

                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

                    // Đọc ảnh để kiểm tra định dạng
                    BufferedImage image = ImageIO.read(filePart.getInputStream());
                    if (image == null) {
                        request.setAttribute("err", "Tệp tải lên không phải là ảnh hợp lệ.");
                        request.setAttribute("lopHoc", oldData);
                        request.getRequestDispatcher("/views/UpdateClass.jsp").forward(request, response);
                        return;
                    }

                    int width = image.getWidth();
                    int height = image.getHeight();
                    double ratio = (double) height / width;

                    // Kiểm tra tỷ lệ ảnh (gần 3x4)
                    if (ratio < 1.25 || ratio > 1.40) {
                        request.setAttribute("err", "Ảnh phải có tỷ lệ gần 3x4 (VD: 300x400). Kích thước hiện tại: " + width + "x" + height);
                        request.setAttribute("lopHoc", oldData);
                        request.getRequestDispatcher("/views/UpdateClass.jsp").forward(request, response);
                        return;
                    }

                    // Lưu ảnh
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "img" + File.separator + "avatar";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }

                    String filePath = uploadPath + File.separator + fileName;
                    filePart.write(filePath);

                    imagePath = "img/avatar/" + fileName; // cập nhật đường dẫn ảnh mới
                }

                // Gọi DAO cập nhật
                LopHoc updated = dao.updateLopHoc(idLopHoc, tenLopHoc, idKhoaHoc, siSo, thoiGianHoc, ghiChu, trangThai, "0", imagePath);

                if (updated != null) {
                    request.setAttribute("suc", "Cập nhật thành công!");
                    request.setAttribute("lopHoc", updated);
                } else {
                    request.setAttribute("err", "Cập nhật thất bại.");
                    request.setAttribute("lopHoc", oldData);
                }

                request.setAttribute("ID_KhoaHoc", idKhoaHoc);
                request.setAttribute("ID_Khoi", idKhoi);
                request.setAttribute("ID_LopHoc", idLopHoc);
                request.getRequestDispatcher("/views/UpdateClass.jsp").forward(request, response);

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("err", "Lỗi hệ thống: " + e.getMessage());
                request.getRequestDispatcher("/views/UpdateClass.jsp").forward(request, response);
            }
        }
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String cd : contentDisp.split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf("=") + 2, cd.length() - 1);
            }
        }
        return null;
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
