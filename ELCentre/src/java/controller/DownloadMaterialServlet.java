package controller;

import dal.DangTaiLieuDAO;
import model.DangTaiLieu;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

public class DownloadMaterialServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Lấy ID của tài liệu từ URL
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Yêu cầu ID của tài liệu.");
            return;
        }

        try {
            int materialId = Integer.parseInt(idParam);
            DangTaiLieuDAO dao = new DangTaiLieuDAO();
            
            // 2. Lấy thông tin tài liệu từ DB để có đường dẫn file
            DangTaiLieu material = dao.getMaterialById(materialId);

            if (material == null || material.getDuongDan() == null || material.getDuongDan().isEmpty()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy tài liệu hoặc đường dẫn file không hợp lệ.");
                return;
            }

            // 3. Xây dựng đường dẫn vật lý tuyệt đối của file trên server
            // material.getDuongDan() nên lưu đường dẫn tương đối, ví dụ: "uploads/tailieu.pdf"
            String relativePath = material.getDuongDan();
            String absolutePath = getServletContext().getRealPath("") + File.separator + relativePath;
            
            File downloadFile = new File(absolutePath);
            if (!downloadFile.exists()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "File không tồn tại trên server.");
                return;
            }

            // 4. Thiết lập các Header quan trọng cho việc download
            // Lấy MIME type của file (ví dụ: application/pdf)
            String mimeType = getServletContext().getMimeType(absolutePath);
            if (mimeType == null) {
                // Mặc định là binary nếu không xác định được
                mimeType = "application/octet-stream";
            }
            response.setContentType(mimeType);
            response.setContentLength((int) downloadFile.length());

            // Thiết lập header Content-Disposition để trình duyệt mở hộp thoại "Save As"
            String headerKey = "Content-Disposition";
            // Lấy tên file gốc từ đường dẫn
            String fileName = downloadFile.getName(); 
            String headerValue = String.format("attachment; filename=\"%s\"", fileName);
            response.setHeader(headerKey, headerValue);

            // 5. Đọc file và ghi vào response output stream
            try (FileInputStream inStream = new FileInputStream(downloadFile);
                 OutputStream outStream = response.getOutputStream()) {

                byte[] buffer = new byte[4096];
                int bytesRead = -1;
                while ((bytesRead = inStream.read(buffer)) != -1) {
                    outStream.write(buffer, 0, bytesRead);
                }
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID tài liệu không hợp lệ.");
        }
    }
}